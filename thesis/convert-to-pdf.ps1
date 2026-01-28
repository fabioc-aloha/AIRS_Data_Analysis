<#
.SYNOPSIS
    Converts standalone Markdown files to PDF with APA 7th edition formatting.
#>

param(
    [string]$File,
    [double]$LineSpacing = 1.5,
    [switch]$Draft,
    [switch]$Confidential,
    [switch]$LineNumbers,
    [switch]$TwoColumn,
    [string]$RunningTitle,
    [switch]$OpenAfterBuild
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$FiguresDir = Join-Path $ScriptDir ".standalone-figures"
$BibFile = Join-Path $ScriptDir "references\bibliography.bib"
$CslFile = Join-Path $ScriptDir "references\apa-7th-edition.csl"

$mmdcPath = Get-Command mmdc -ErrorAction SilentlyContinue
$hasMermaid = $null -ne $mmdcPath

$xelatexPath = Get-Command xelatex -ErrorAction SilentlyContinue
$pdfEngine = if ($xelatexPath) { "xelatex" } else { "pdflatex" }

$hasBibliography = (Test-Path $BibFile) -and (Test-Path $CslFile)

$StandaloneFiles = @(
    "DEFENSE_QUESTIONS.md",
    "EXECUTIVE_SUMMARY.md",
    "PRACTITIONER_BRIEF.md",
    "THESIS_SUMMARY.md",
    "PRESENTATION_SLIDES.md",
    "PRESENTATION_SLIDES_20.md"
)

function Process-MermaidDiagrams {
    param(
        [string]$Content,
        [string]$BaseName
    )
    
    if (-not $hasMermaid) {
        return @{ Content = $Content; DiagramCount = 0 }
    }
    
    $mermaidPattern = '(?s)```mermaid\r?\n(.+?)```'
    $mermaidMatches = [regex]::Matches($Content, $mermaidPattern)
    
    if ($mermaidMatches.Count -eq 0) {
        return @{ Content = $Content; DiagramCount = 0 }
    }
    
    if (-not (Test-Path $FiguresDir)) {
        New-Item -ItemType Directory -Path $FiguresDir -Force | Out-Null
    }
    
    $diagramCount = 0
    $figureIndex = 1
    $processedContent = $Content
    
    foreach ($match in $mermaidMatches) {
        $mermaidCode = $match.Groups[1].Value
        $figName = "$BaseName" + "_fig" + "$figureIndex"
        $mmdFile = Join-Path $FiguresDir "$figName.mmd"
        $pngFile = Join-Path $FiguresDir "$figName.png"
        
        [System.IO.File]::WriteAllText($mmdFile, $mermaidCode, [System.Text.UTF8Encoding]::new($false))
        
        $mmdcArgs = @("-i", $mmdFile, "-o", $pngFile, "-b", "white", "-s", "5")
        $null = & mmdc @mmdcArgs 2>&1
        
        if (Test-Path $pngFile) {
            # Get image dimensions to calculate needed space
            Add-Type -AssemblyName System.Drawing
            $img = [System.Drawing.Image]::FromFile($pngFile)
            $imgWidth = $img.Width
            $imgHeight = $img.Height
            $img.Dispose()
            
            # Calculate aspect ratio and estimate page space needed
            # Page text width ~6.5in at 72dpi = 468px, text height ~9in = 648px
            # Scale factor: image will be scaled to fit width at 100%
            $scaleFactor = 468.0 / $imgWidth
            $scaledHeight = $imgHeight * $scaleFactor
            # Convert to approximate line count (12pt font ~ 18px with spacing)
            $linesNeeded = [math]::Ceiling($scaledHeight / 18) + 4  # +4 for caption/margins
            
            # Max lines available on a page ~50 lines
            $maxPageLines = 50
            
            # Calculate width percentage to fit if needed (prefer squeezing over page break)
            if ($linesNeeded -gt $maxPageLines) {
                # Too tall even for full page - scale to fit page
                $widthPercent = [math]::Floor(($maxPageLines / $linesNeeded) * 100)
                $widthPercent = [math]::Max($widthPercent, 70)  # Don't go below 70%
                Write-Host "    - Rendered diagram $figureIndex ($imgWidth x $imgHeight px, ~$linesNeeded lines -> scaled to $widthPercent%)" -ForegroundColor Gray
            } elseif ($linesNeeded -gt 35) {
                # Large - squeeze to 75% to fit with content above
                $widthPercent = 75
                $adjustedLines = [math]::Ceiling($linesNeeded * 0.75)
                Write-Host "    - Rendered diagram $figureIndex ($imgWidth x $imgHeight px, ~$linesNeeded lines -> $widthPercent% = ~$adjustedLines lines)" -ForegroundColor Gray
            } elseif ($linesNeeded -gt 25) {
                # Medium-large - squeeze to 85% to fit with some content
                $widthPercent = 85
                $adjustedLines = [math]::Ceiling($linesNeeded * 0.85)
                Write-Host "    - Rendered diagram $figureIndex ($imgWidth x $imgHeight px, ~$linesNeeded lines -> $widthPercent% = ~$adjustedLines lines)" -ForegroundColor Gray
            } else {
                $widthPercent = 100
                Write-Host "    - Rendered diagram $figureIndex ($imgWidth x $imgHeight px, ~$linesNeeded lines)" -ForegroundColor Gray
            }
            
            $diagramCount++
            $escapedPngPath = $pngFile.Replace('\', '/')
            
            # Center the image using raw LaTeX blocks
            $imgRef = "``````{=latex}`n\begin{center}`n```````n`n![]($escapedPngPath){ width=$widthPercent% }`n`n``````{=latex}`n\end{center}`n``````"
            
            $processedContent = $processedContent.Replace($match.Value, $imgRef)
        } else {
            Write-Warning "    - Failed to render diagram $figureIndex"
        }
        
        Remove-Item $mmdFile -Force -ErrorAction SilentlyContinue
        $figureIndex++
    }
    
    return @{ Content = $processedContent; DiagramCount = $diagramCount }
}

function Process-MarkdownExtensions {
    param([string]$Content)
    
    # Remove --- (horizontal rules) adjacent to [pagebreak] markers
    $Content = $Content -replace '---\s*\r?\n\s*\[pagebreak\]', '[pagebreak]'
    $Content = $Content -replace '\[pagebreak\]\s*\r?\n\s*---', '[pagebreak]'
    
    # Remove --- only when immediately followed by a section heading (## )
    # This prevents orphaned rules at the bottom of pages before new sections
    $Content = $Content -replace '(?m)^---\s*\r?\n\s*\r?\n##\s', '## '
    $Content = $Content -replace '(?m)^---\s*\r?\n##\s', '## '
    
    # Remove --- at the very end of document
    $Content = $Content -replace '\r?\n---\s*$', ''
    
    # Process [pagebreak] markers
    $Content = $Content -replace '\[pagebreak\]', "``````{=latex}`n\newpage`n``````"
    
    # Process callout boxes: > [!NOTE], > [!WARNING], > [!TIP], > [!IMPORTANT], > [!CAUTION]
    $calloutTypes = @{
        'NOTE' = @{ color = 'blue!10'; border = 'blue!50'; icon = '\textbf{📝 Note:}' }
        'TIP' = @{ color = 'green!10'; border = 'green!50'; icon = '\textbf{💡 Tip:}' }
        'WARNING' = @{ color = 'yellow!15'; border = 'orange!50'; icon = '\textbf{⚠️ Warning:}' }
        'IMPORTANT' = @{ color = 'purple!10'; border = 'purple!50'; icon = '\textbf{❗ Important:}' }
        'CAUTION' = @{ color = 'red!10'; border = 'red!50'; icon = '\textbf{🔴 Caution:}' }
    }
    
    foreach ($type in $calloutTypes.Keys) {
        $style = $calloutTypes[$type]
        # Match > [!TYPE] followed by content lines starting with >
        $pattern = "(?m)^>\s*\[!$type\]\s*\r?\n((?:^>.*\r?\n?)+)"
        $Content = [regex]::Replace($Content, $pattern, {
            param($m)
            $calloutContent = $m.Groups[1].Value -replace '(?m)^>\s?', ''
            $calloutContent = $calloutContent.Trim() -replace '&', '\&' -replace '%', '\%'
            "``````{=latex}`n\begin{tcolorbox}[colback=$($style.color),colframe=$($style.border),left=2mm,right=2mm,top=1mm,bottom=1mm]`n$($style.icon) $calloutContent`n\end{tcolorbox}`n``````"
        })
    }
    
    # Process figure captions: ![Caption](image.png)
    # Convert to proper LaTeX figure with caption for TOC
    $Content = [regex]::Replace($Content, '!\[([^\]]+)\]\(([^)]+)\)(\{[^}]*\})?', {
        param($m)
        $caption = $m.Groups[1].Value
        $path = $m.Groups[2].Value
        $attrs = $m.Groups[3].Value
        if ($caption -and $caption -ne '') {
            # Has caption - use figure environment
            $width = "width=\textwidth"
            if ($attrs -match 'width=(\d+)%') {
                $widthPct = [int]$Matches[1] / 100
                $width = "width=$widthPct\textwidth"
            }
            "``````{=latex}`n\begin{figure}[H]`n\centering`n\includegraphics[$width]{$path}`n\caption{$caption}`n\end{figure}`n``````"
        } else {
            # No caption - keep simple
            $m.Value
        }
    })
    
    # Process table captions: Table: Caption text (before or after table)
    $Content = $Content -replace '(?m)^Table:\s*(.+)$', "``````{=latex}`n\captionof{table}{`$1}`n``````"
    
    return $Content
}

function Parse-DocumentStructure {
    param([string]$Content)
    
    $result = @{
        HasTitle = $false
        HasToc = $false
        TitleContent = ""
        MainTitle = ""
        Authors = ""
        Date = ""
        BodyContent = $Content
    }
    
    # Look for [title]...[/title] markers
    if ($Content -match '(?s)\[title\]\s*\r?\n(.+?)\[/title\]') {
        $titleSection = $Matches[1].Trim()
        $result.HasTitle = $true
        
        # Extract the main title (first # heading)
        if ($titleSection -match '^#\s+(.+?)(\r?\n|$)') {
            $result.MainTitle = $Matches[1].Trim()
            # Remove the # heading from title content (we'll render it separately)
            $titleSection = $titleSection -replace '^#\s+.+?(\r?\n|$)', ''
        }
        
        # Extract authors (look for **Authors**: or lines with & between names)
        if ($titleSection -match '\*\*Authors?\*\*:?\s*(.+?)(\r?\n|$)') {
            $result.Authors = $Matches[1].Trim()
        } elseif ($titleSection -match '([A-Z][a-z]+ [A-Z][a-z]+)\s*[&]\s*([A-Z][a-z]+ [A-Z][a-z]+)') {
            $result.Authors = $Matches[0].Trim()
        }
        
        # Extract date (look for month/year patterns)
        if ($titleSection -match '(January|February|March|April|May|June|July|August|September|October|November|December)\s+\d{1,2},?\s+\d{4}') {
            $result.Date = $Matches[0].Trim()
        } elseif ($titleSection -match '\d{4}-\d{2}-\d{2}') {
            $result.Date = $Matches[0].Trim()
        }
        
        # Clean up HTML tags
        $titleSection = $titleSection -replace '<div[^>]*>', ''
        $titleSection = $titleSection -replace '</div>', ''
        $result.TitleContent = $titleSection.Trim()
        
        # Remove [title]...[/title] block from content
        $Content = $Content -replace '(?s)\[title\]\s*\r?\n.+?\[/title\]\s*\r?\n?', ''
    }
    
    # Look for [toc] marker - can include optional flags like [toc:figures] or [toc:tables] or [toc:all]
    if ($Content -match '\[toc(:[\w,]+)?\]') {
        $tocFlags = $Matches[1]
        $result.HasToc = $true
        # Replace [toc] with raw LaTeX TOC command followed by newpage and repeated title
        $titleRepeat = ""
        if ($result.MainTitle) {
            $titleRepeat = "`n`n# " + $result.MainTitle + "`n"
        }
        # Build TOC content based on flags
        $tocContent = "\tableofcontents"
        if ($tocFlags -match 'figures|all') {
            $tocContent += "`n\listoffigures"
        }
        if ($tocFlags -match 'tables|all') {
            $tocContent += "`n\listoftables"
        }
        # Use pandoc raw latex block syntax
        $tocReplacement = "``````{=latex}`n$tocContent`n\newpage`n``````" + $titleRepeat
        # Remove [toc] and optional trailing --- (would be first element on new page)
        $Content = $Content -replace '\[toc(:[\w,]+)?\]\s*(\r?\n---\s*)?(\r?\n)?', $tocReplacement
    }
    
    $result.BodyContent = $Content
    return $result
}

function Convert-MarkdownToPdf {
    param(
        [string]$InputFile,
        [double]$Spacing = 1.5
    )
    
    if (-not (Test-Path $InputFile)) {
        Write-Warning "File not found: $InputFile"
        return $false
    }
    
    $OutputFile = [System.IO.Path]::ChangeExtension($InputFile, ".pdf")
    $FileName = Split-Path -Leaf $InputFile
    $BaseName = [System.IO.Path]::GetFileNameWithoutExtension($InputFile)
    
    if (Test-Path $OutputFile) {
        Remove-Item $OutputFile -Force
    }
    
    Write-Host "  Converting: $FileName" -ForegroundColor Cyan
    
    $originalContent = Get-Content $InputFile -Raw -Encoding UTF8
    $docStructure = Parse-DocumentStructure -Content $originalContent
    
    if ($docStructure.HasTitle) {
        Write-Host "    - Found [title] marker: $($docStructure.MainTitle)" -ForegroundColor Gray
    }
    if ($docStructure.HasToc) {
        Write-Host "    - Found [toc] marker" -ForegroundColor Gray
    }
    
    $processResult = Process-MermaidDiagrams -Content $docStructure.BodyContent -BaseName $BaseName
    $bodyContent = $processResult.Content
    $diagramCount = $processResult.DiagramCount
    
    if ($diagramCount -gt 0) {
        Write-Host "    - Processed $diagramCount diagram(s)" -ForegroundColor Gray
    }
    
    # Process markdown extensions (callouts, page breaks, captions)
    $bodyContent = Process-MarkdownExtensions -Content $bodyContent
    
    # Build YAML header (no automatic toc - we use [toc] marker)
    $yamlHeader = "---`n"
    $yamlHeader += "documentclass: article`n"
    $yamlHeader += "geometry: `"margin=1in`"`n"
    $yamlHeader += "fontsize: 12pt`n"
    $yamlHeader += "linestretch: $Spacing`n"
    $yamlHeader += "link-citations: true`n"
    
    # Store metadata for hyperref (don't use pandoc title/author/date - creates extra page)
    $pdfTitle = ""
    $pdfAuthor = ""
    $pdfDate = ""
    if ($docStructure.MainTitle) {
        $pdfTitle = $docStructure.MainTitle -replace '"', "'" -replace '\\', ''
    }
    if ($docStructure.Authors) {
        $pdfAuthor = $docStructure.Authors -replace '"', "'" -replace '\\', ''
    }
    if ($docStructure.Date) {
        $pdfDate = $docStructure.Date
    }
    
    $yamlHeader += "header-includes:`n"
    $yamlHeader += "  - \usepackage{setspace}`n"
    $yamlHeader += "  - \usepackage{fancyhdr}`n"
    $yamlHeader += "  - \usepackage{lastpage}`n"
    $yamlHeader += "  - \pagestyle{fancy}`n"
    $yamlHeader += "  - \fancyhf{}`n"
    # Running title on left (use custom override if provided), page number on right
    $displayRunningTitle = if ($script:RunningTitle) { $script:RunningTitle } elseif ($pdfTitle) { $pdfTitle } else { "" }
    $yamlHeader += "  - \fancyhead[L]{\small\textit{$displayRunningTitle}}`n"
    $yamlHeader += "  - \fancyhead[R]{\small\thepage\ of \pageref{LastPage}}`n"
    # Confidential footer
    if ($script:Confidential) {
        $yamlHeader += "  - \fancyfoot[C]{\small\textbf{CONFIDENTIAL}}`n"
    } else {
        $yamlHeader += "  - \fancyfoot[C]{}`n"
    }
    $yamlHeader += "  - \renewcommand{\headrulewidth}{0.4pt}`n"
    # Confidential also adds footer rule
    if ($script:Confidential) {
        $yamlHeader += "  - \renewcommand{\footrulewidth}{0.4pt}`n"
    }
    # Draft watermark
    if ($script:Draft) {
        $yamlHeader += "  - \usepackage{draftwatermark}`n"
        $yamlHeader += "  - \SetWatermarkText{DRAFT}`n"
        $yamlHeader += "  - \SetWatermarkScale{1}`n"
        $yamlHeader += "  - \SetWatermarkColor[gray]{0.9}`n"
    }
    # Two-column layout - we use classoption=twocolumn in pandoc args instead of multicol
    $yamlHeader += "  - \usepackage{float}`n"
    $yamlHeader += "  - \floatplacement{figure}{H}`n"
    $yamlHeader += "  - \floatplacement{table}{H}`n"
    $yamlHeader += "  - \usepackage{longtable}`n"
    $yamlHeader += "  - \usepackage{booktabs}`n"
    # Table formatting: smaller font, single spacing, prevent page breaks
    $yamlHeader += "  - \usepackage{etoolbox}`n"
    $yamlHeader += "  - \AtBeginEnvironment{longtable}{\small\setstretch{1.0}}`n"
    $yamlHeader += "  - \AtBeginEnvironment{tabular}{\small\setstretch{1.0}}`n"
    # Ensure tables have bottom border by patching longtable end
    $yamlHeader += "  - \AtEndEnvironment{longtable}{\bottomrule}`n"
    # Prevent tables from breaking across pages using minipage wrapper
    $yamlHeader += "  - \let\oldlongtable\longtable`n"
    $yamlHeader += "  - \def\longtable{\begin{minipage}{\textwidth}\vspace{0.5em}\oldlongtable}`n"
    $yamlHeader += "  - \let\oldendlongtable\endlongtable`n"
    $yamlHeader += "  - \def\endlongtable{\oldendlongtable\end{minipage}}`n"
    $yamlHeader += "  - \usepackage{graphicx}`n"
    $yamlHeader += "  - \usepackage{grffile}`n"
    $yamlHeader += "  - \usepackage{caption}`n"
    $yamlHeader += "  - \captionsetup[figure]{labelfont=bf}`n"
    $yamlHeader += "  - \captionsetup[table]{labelfont=bf}`n"
    $yamlHeader += "  - \AtBeginDocument{\thispagestyle{empty}}`n"
    $yamlHeader += "  - \usepackage{fontspec}`n"
    $yamlHeader += "  - \setmainfont{Times New Roman}`n"
    $yamlHeader += "  - \usepackage{titlesec}`n"
    $yamlHeader += "  - \usepackage{needspace}`n"
    $yamlHeader += "  - \titleformat{\section}{\normalfont\Large\bfseries}{}{0em}{}`n"
    $yamlHeader += "  - \titleformat{\subsection}{\normalfont\large\bfseries}{}{0em}{}`n"
    $yamlHeader += "  - \titleformat{\subsubsection}{\normalfont\normalsize\bfseries}{}{0em}{}`n"
    # Callout boxes
    $yamlHeader += "  - \usepackage[most]{tcolorbox}`n"
    # Add hyperref with PDF metadata
    $hyperrefOptions = "colorlinks=true,linkcolor=blue,urlcolor=blue,citecolor=blue"
    if ($pdfTitle) { $hyperrefOptions += ",pdftitle={$pdfTitle}" }
    if ($pdfAuthor) { $hyperrefOptions += ",pdfauthor={$pdfAuthor}" }
    $yamlHeader += "  - \usepackage[$hyperrefOptions]{hyperref}`n"
    $yamlHeader += "  - \widowpenalty=10000`n"
    $yamlHeader += "  - \clubpenalty=10000`n"
    # Disable word hyphenation
    $yamlHeader += "  - \hyphenpenalty=10000`n"
    $yamlHeader += "  - \exhyphenpenalty=10000`n"
    # Tighter list spacing
    $yamlHeader += "  - \usepackage{enumitem}`n"
    $yamlHeader += "  - \setlist{nosep,leftmargin=*}`n"
    # Code block styling with light gray background
    $yamlHeader += "  - \usepackage{xcolor}`n"
    $yamlHeader += "  - \definecolor{codebg}{gray}{0.95}`n"
    $yamlHeader += "  - \let\oldtexttt\texttt`n"
    $yamlHeader += "  - \renewcommand{\texttt}[1]{\colorbox{codebg}{\oldtexttt{#1}}}`n"
    # Line numbers for code review mode
    if ($script:LineNumbers) {
        $yamlHeader += "  - \usepackage{fvextra}`n"
        $yamlHeader += "  - \DefineVerbatimEnvironment{Highlighting}{Verbatim}{numbers=left,numbersep=5pt,frame=lines,framesep=2mm,commandchars=\\\{\}}`n"
    }
    $yamlHeader += "---`n`n"

    # Build title page if [title] marker was found
    if ($docStructure.HasTitle) {
        $titleLines = $docStructure.TitleContent -split '\r?\n'
        
        $titleLatex = "\begin{titlepage}`n\thispagestyle{empty}`n\centering`n\vspace*{2cm}`n`n"
        $titleLatex += "{\Huge\bfseries $($docStructure.MainTitle)\par}`n`n\vspace{2cm}`n`n"
        
        foreach ($line in $titleLines) {
            $trimmedLine = $line.Trim()
            # Preserve blank lines as vertical space
            if ([string]::IsNullOrWhiteSpace($trimmedLine)) { 
                $titleLatex += "\vspace{0.5cm}`n"
                continue 
            }
            # Escape LaTeX special characters
            $trimmedLine = $trimmedLine -replace '&', '\&'
            $trimmedLine = $trimmedLine -replace '%', '\%'
            $trimmedLine = $trimmedLine -replace '\$', '\$'
            $trimmedLine = $trimmedLine -replace '#', '\#'
            $trimmedLine = $trimmedLine -replace '_', '\_'
            # Convert markdown formatting
            $trimmedLine = $trimmedLine -replace '\*\*([^*]+)\*\*', '\textbf{$1}'
            $trimmedLine = $trimmedLine -replace '\*([^*]+)\*', '\textit{$1}'
            $titleLatex += "$trimmedLine" + "\\[0.3cm]`n"
        }
        
        $titleLatex += "`n\vfill`n\end{titlepage}`n`n\newpage`n`n"
        
        $finalContent = $yamlHeader + $titleLatex + $bodyContent
    } else {
        $finalContent = $yamlHeader + $bodyContent
    }
    
    $TempMarkdown = Join-Path $ScriptDir "_temp_$BaseName.md"
    [System.IO.File]::WriteAllText($TempMarkdown, $finalContent, [System.Text.UTF8Encoding]::new($false))
    
    try {
        # Build markdown format string
        $markdownFormat = "markdown+raw_tex+implicit_figures"
        
        # Disable tables for two-column mode (longtable incompatible with twocolumn)
        if ($script:TwoColumn) {
            $markdownFormat = "markdown+raw_tex+implicit_figures-pipe_tables-simple_tables-multiline_tables-grid_tables"
        }
        
        $pandocArgs = @(
            $TempMarkdown,
            "-o", $OutputFile,
            "--pdf-engine=$pdfEngine",
            "-f", $markdownFormat,
            "--standalone"
        )
        
        # Two-column document class option
        if ($script:TwoColumn) {
            $pandocArgs += @("-V", "classoption=twocolumn")
        }
        
        if ($hasBibliography) {
            $pandocArgs += @("--citeproc", "--bibliography=$BibFile", "--csl=$CslFile")
        }
        
        Write-Host "    - Running pandoc..." -ForegroundColor Gray
        $output = & pandoc @pandocArgs 2>&1
        
        if (Test-Path $OutputFile) {
            $Size = [math]::Round((Get-Item $OutputFile).Length / 1KB, 1)
            Write-Host "    - Generated: $(Split-Path -Leaf $OutputFile) ($Size KB)" -ForegroundColor Green
            return $true
        } else {
            Write-Host "    - Failed to generate PDF" -ForegroundColor Red
            Write-Host "    Output: $output" -ForegroundColor Yellow
            return $false
        }
    }
    catch {
        Write-Host "    - Error: $_" -ForegroundColor Red
        return $false
    }
    finally {
        if (Test-Path $TempMarkdown) {
            Remove-Item $TempMarkdown -Force -ErrorAction SilentlyContinue
        }
        if (Test-Path $FiguresDir) {
            Remove-Item $FiguresDir -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Yellow
Write-Host "  Markdown to PDF Converter (APA 7)" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
Write-Host ""

if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
    Write-Host "Error: Pandoc not found." -ForegroundColor Red
    exit 1
}

Write-Host "  Dependencies:" -ForegroundColor White
Write-Host "    - Pandoc: Available" -ForegroundColor Green
Write-Host "    - PDF Engine: $pdfEngine" -ForegroundColor Green
if ($hasMermaid) {
    Write-Host "    - Mermaid CLI: Available" -ForegroundColor Green
} else {
    Write-Host "    - Mermaid CLI: Not found" -ForegroundColor DarkYellow
}
if ($hasBibliography) {
    Write-Host "    - Bibliography: Available" -ForegroundColor Green
}
Write-Host ""

Push-Location $ScriptDir

$Success = 0
$Failed = 0
$LastOutputFile = $null

if ($File) {
    $FilePath = if ([System.IO.Path]::IsPathRooted($File)) { $File } else { Join-Path $ScriptDir $File }
    if (Convert-MarkdownToPdf -InputFile $FilePath -Spacing $LineSpacing) {
        $Success++
        $LastOutputFile = [System.IO.Path]::ChangeExtension($FilePath, ".pdf")
    } else {
        $Failed++
    }
} else {
    Write-Host "Converting standalone documents..." -ForegroundColor White
    Write-Host ""
    
    foreach ($mdFile in $StandaloneFiles) {
        $FilePath = Join-Path $ScriptDir $mdFile
        if (Convert-MarkdownToPdf -InputFile $FilePath -Spacing $LineSpacing) {
            $Success++
            $LastOutputFile = [System.IO.Path]::ChangeExtension($FilePath, ".pdf")
        } else {
            $Failed++
        }
    }
}

Pop-Location

Write-Host ""
Write-Host "========================================" -ForegroundColor Yellow
Write-Host "  Complete: $Success success, $Failed failed" -ForegroundColor $(if ($Failed -eq 0) { "Green" } else { "Yellow" })
Write-Host "========================================" -ForegroundColor Yellow

if ($OpenAfterBuild -and $LastOutputFile -and (Test-Path $LastOutputFile)) {
    Write-Host ""
    Write-Host "Opening PDF..." -ForegroundColor Cyan
    Start-Process $LastOutputFile
}
