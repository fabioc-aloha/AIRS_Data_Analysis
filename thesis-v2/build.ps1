<#
.SYNOPSIS
    Build the AIRS thesis from markdown sources.

.DESCRIPTION
    Modern, modular thesis build system. Combines chapters, processes
    Mermaid diagrams, and generates APA-style PDF using pandoc.

.PARAMETER Target
    Build target: 'all' (default), 'draft', 'figures', 'validate', 'clean', 'watch'

.PARAMETER Open
    Open the PDF after successful build.

.PARAMETER Clean
    Shortcut for -Target clean

.EXAMPLE
    .\build.ps1
    Build the thesis PDF.

.EXAMPLE
    .\build.ps1 -Target draft -Open
    Build draft version and open it.

.EXAMPLE
    .\build.ps1 -Clean
    Remove all generated files.

.EXAMPLE
    .\build.ps1 -Target watch
    Watch for changes and auto-rebuild.
#>

param(
    [ValidateSet('all', 'draft', 'figures', 'validate', 'clean', 'watch')]
    [string]$Target = 'all',
    [switch]$Open,
    [switch]$Clean
)

# Handle -Clean shortcut
if ($Clean) { $Target = 'clean' }

# ============================================================
# CONFIGURATION
# ============================================================
$ErrorActionPreference = 'Stop'
$RootDir = $PSScriptRoot

$Config = @{
    # Directories
    Manuscript   = Join-Path $RootDir 'manuscript'
    ChaptersDir  = Join-Path $RootDir 'manuscript/chapters'
    FrontMatter  = Join-Path $RootDir 'manuscript/front-matter'
    BackMatter   = Join-Path $RootDir 'manuscript/back-matter'
    Assets       = Join-Path $RootDir 'assets'
    Figures      = Join-Path $RootDir 'assets/figures'
    Tables       = Join-Path $RootDir 'assets/tables'
    Templates    = Join-Path $RootDir 'templates'
    References   = Join-Path $RootDir 'references'
    Output       = Join-Path $RootDir 'output'
    
    # Files
    MetaFile     = Join-Path $RootDir 'meta.yaml'
    Template     = Join-Path $RootDir 'templates/apa7-thesis.tex'
    BibFile      = Join-Path $RootDir 'references/bibliography.bib'
    CslFile      = Join-Path $RootDir 'references/apa-7th-edition.csl'
    OutputPdf    = Join-Path $RootDir 'output/AIRS_Dissertation.pdf'
    
    # Chapter order
    ChapterFiles = @(
        '01_introduction.md',
        '02_literature_review.md',
        '03_methodology.md',
        '04_results.md',
        '05_analysis_discussion.md',
        '06_conclusions.md'
    )
}

# ============================================================
# HELPERS
# ============================================================
function Write-Step {
    param([string]$Message, [string]$Color = 'Cyan')
    Write-Host "`n[$((Get-Date).ToString('HH:mm:ss'))] $Message" -ForegroundColor $Color
}

function Write-Success {
    param([string]$Message)
    Write-Host "  ✓ $Message" -ForegroundColor Green
}

function Write-Info {
    param([string]$Message)
    Write-Host "  • $Message" -ForegroundColor Gray
}

function Test-Dependency {
    param([string]$Command, [string]$Name)
    $cmd = Get-Command $Command -ErrorAction SilentlyContinue
    if ($cmd) {
        Write-Success "$Name found: $($cmd.Source)"
        return $true
    }
    Write-Host "  ⚠ $Name not found" -ForegroundColor Yellow
    return $false
}

# ============================================================
# BUILD FUNCTIONS
# ============================================================
function Test-Dependencies {
    Write-Step "Checking dependencies..."
    
    $hasPandoc = Test-Dependency 'pandoc' 'Pandoc'
    if (-not $hasPandoc) {
        throw "Pandoc is required. Install from https://pandoc.org"
    }
    
    $hasXelatex = Test-Dependency 'xelatex' 'XeLaTeX'
    $script:PdfEngine = if ($hasXelatex) { 'xelatex' } else { 'pdflatex' }
    
    $hasMermaid = Test-Dependency 'mmdc' 'Mermaid CLI'
    $script:HasMermaid = $hasMermaid
}

function Build-MermaidDiagrams {
    Write-Step "Processing Mermaid diagrams..."
    
    if (-not $script:HasMermaid) {
        Write-Info "Skipping (mmdc not installed)"
        return
    }
    
    # Create build directory for processed files
    $script:BuildDir = Join-Path $Config.Output 'build'
    $mermaidDir = Join-Path $script:BuildDir 'mermaid'
    
    # Clean and recreate build directory
    if (Test-Path $script:BuildDir) { Remove-Item $script:BuildDir -Recurse -Force }
    Copy-Item $Config.Manuscript $script:BuildDir -Recurse
    
    if (-not (Test-Path $mermaidDir)) {
        New-Item -ItemType Directory -Path $mermaidDir -Force | Out-Null
    }
    
    # Find all markdown files with mermaid blocks in build copy
    $mdFiles = Get-ChildItem -Path $script:BuildDir -Filter '*.md' -Recurse
    $diagramCount = 0
    
    foreach ($mdFile in $mdFiles) {
        $content = Get-Content $mdFile.FullName -Raw -Encoding UTF8
        
        # Match mermaid code blocks
        $pattern = '(?s)```mermaid\r?\n(.*?)```'
        $regexMatches = [regex]::Matches($content, $pattern)
        
        if ($regexMatches.Count -eq 0) { continue }
        
        $fileIndex = 0
        foreach ($match in $regexMatches) {
            $mermaidCode = $match.Groups[1].Value
            $diagramName = "$($mdFile.BaseName)_diagram_$fileIndex"
            $mmdFile = Join-Path $mermaidDir "$diagramName.mmd"
            $pngFile = Join-Path $mermaidDir "$diagramName.png"
            
            # Write mermaid code to temp file
            Set-Content $mmdFile -Value $mermaidCode -NoNewline -Encoding UTF8
            
            # Render to PNG
            & mmdc -i $mmdFile -o $pngFile -b white -s 3 -w 1200 2>$null
            
            if (Test-Path $pngFile) {
                # Use absolute path with forward slashes for LaTeX compatibility
                $absolutePath = (Resolve-Path $pngFile).Path -replace '\\', '/'
                # Replace mermaid block with LaTeX figure that constrains size
                # maxwidth=\textwidth, maxheight=0.45\textheight (45% of page height)
                $imageRef = @"

\begin{figure}[H]
\centering
\includegraphics[width=\textwidth,height=0.45\textheight,keepaspectratio]{$absolutePath}
\end{figure}

"@
                $content = $content.Replace($match.Value, $imageRef)
                Write-Success "Rendered: $diagramName.png"
                $diagramCount++
            }
            $fileIndex++
        }
        
        # Write modified content to build copy only
        Set-Content $mdFile.FullName -Value $content -NoNewline -Encoding UTF8
    }
    
    if ($diagramCount -eq 0) {
        Write-Info "No mermaid blocks found"
        $script:BuildDir = $null  # Use original sources
    }
    else {
        Write-Info "Rendered $diagramCount diagrams"
    }
}

function Build-Pdf {
    param([bool]$IsDraft = $false)
    
    Write-Step "Building PDF..."
    
    # Ensure output directory exists
    if (-not (Test-Path $Config.Output)) {
        New-Item -ItemType Directory -Path $Config.Output -Force | Out-Null
    }
    
    # Use build directory if mermaid processing created one, otherwise use originals
    $chaptersDir = if ($script:BuildDir) { Join-Path $script:BuildDir 'chapters' } else { $Config.ChaptersDir }
    $backMatterDir = if ($script:BuildDir) { Join-Path $script:BuildDir 'back-matter' } else { $Config.BackMatter }
    $frontMatterDir = if ($script:BuildDir) { Join-Path $script:BuildDir 'front-matter' } else { $Config.FrontMatter }
    
    # Collect source files in order
    $sources = @()
    
    # Front matter files - will be added via --include-before-body to appear BEFORE TOC
    $frontMatterFiles = @(
        '00_title.md',
        '01_approval.md',
        '02_copyright.md',
        '03_abstract.md',
        '04_acknowledgments.md',
        '05_dedication.md',
        '06_toc_setup.md'
    )
    
    # Chapters
    foreach ($chapter in $Config.ChapterFiles) {
        $chapterPath = Join-Path $chaptersDir $chapter
        if (Test-Path $chapterPath) {
            $sources += $chapterPath
            Write-Info "Chapter: $chapter"
        }
    }
    
    # Back matter
    foreach ($backFile in @('references.md', 'appendices.md')) {
        $backPath = Join-Path $backMatterDir $backFile
        if (Test-Path $backPath) {
            $sources += $backPath
            Write-Info "Back matter: $backFile"
        }
    }
    
    # Build pandoc arguments
    $headerIncludes = @(
        # === Core packages ===
        '\usepackage{float}',
        '\usepackage{booktabs}',
        '\usepackage{longtable}',
        '\usepackage{pdfpages}',
        '\usepackage{etoolbox}',
        '\usepackage{needspace}',
        '\usepackage{placeins}',
        '\usepackage{fancyhdr}',
        '\usepackage{setspace}',
        '\usepackage{tocloft}',
        '\usepackage[font=normalsize,labelfont=bf,justification=raggedright,singlelinecheck=false]{caption}',
        
        # === Code block formatting ===
        '\usepackage{fancyvrb}',
        '\usepackage{framed}',
        '\definecolor{shadecolor}{RGB}{245,245,245}',
        '\renewenvironment{Shaded}{\begin{snugshade}\small\singlespacing}{\end{snugshade}}',
        
        # === APA 7 Double Spacing ===
        '\doublespacing',
        
        # === TOC spacing: 1.25 line spacing ===
        '\setlength{\cftbeforesecskip}{0.5em}',
        '\setlength{\cftbeforesubsecskip}{0.3em}',
        '\setlength{\cftbeforesubsubsecskip}{0.2em}',
        '\renewcommand{\cftsecafterpnum}{\vskip 3pt}',
        '\renewcommand{\cftsubsecafterpnum}{\vskip 2pt}',
        '\AtBeginDocument{\addtocontents{toc}{\protect\setstretch{1.25}}}',
        
        # === Front matter uses roman numerals ===
        '\pagenumbering{roman}',
        
        # === Plain style for TOC: roman numerals, bottom center ===
        '\fancypagestyle{plain}{\fancyhf{}\fancyfoot[C]{\thepage}\renewcommand{\headrulewidth}{0pt}}',
        
        # === Fancy style for body: running header + page number (set at Chapter 1) ===
        '\fancypagestyle{fancy}{\fancyhf{}\fancyhead[L]{\small\MakeUppercase{AI Readiness Scale}}\fancyhead[R]{\thepage}\renewcommand{\headrulewidth}{0pt}}',
        '\setlength{\headheight}{14pt}',
        
        # === APA 7 Figure Captions (below figure) ===
        # Format: "Figure X." bold, title italic
        '\captionsetup[figure]{labelsep=period,position=below,skip=10pt,font={normalsize},labelfont={bf},textfont={it}}',
        
        # === APA 7 Table Captions (above table) ===
        # Format: "Table X." bold, title italic
        '\captionsetup[table]{labelsep=period,position=above,skip=10pt,font={normalsize},labelfont={bf},textfont={it}}',
        
        # === APA 7 Heading Styles ===
        '\usepackage{titlesec}',
        # Level 1: Centered, Bold (Chapter)
        '\titleformat{\section}{\normalfont\Large\bfseries\centering}{Chapter \thesection:}{0.5em}{}',
        # Level 2: Left-aligned, Bold
        '\titleformat{\subsection}{\normalfont\large\bfseries}{\thesubsection}{1em}{}',
        # Level 3: Left-aligned, Bold, Italic
        '\titleformat{\subsubsection}{\normalfont\normalsize\bfseries\itshape}{\thesubsubsection}{1em}{}',
        
        # === Table formatting ===
        '\AtBeginEnvironment{longtable}{\footnotesize\singlespacing}',
        '\AtBeginEnvironment{tabular}{\footnotesize\singlespacing}',
        
        # === Prevent widows and orphans ===
        '\widowpenalty=10000',
        '\clubpenalty=10000',
        '\displaywidowpenalty=10000',
        
        # === Page break controls ===
        '\raggedbottom',
        '\AtBeginEnvironment{longtable}{\FloatBarrier}',
        '\AtEndEnvironment{longtable}{\FloatBarrier}',
        
        # === Smart pagination: keep headings with following content ===
        # Use titlesec for proper heading pagination control
        '\usepackage{titlesec}',
        '\titlespacing*{\section}{0pt}{12pt plus 4pt minus 2pt}{6pt plus 2pt minus 2pt}',
        '\titlespacing*{\subsection}{0pt}{10pt plus 4pt minus 2pt}{4pt plus 2pt minus 2pt}',
        '\titlespacing*{\subsubsection}{0pt}{8pt plus 4pt minus 2pt}{4pt plus 2pt minus 2pt}',
        # Set penalties to strongly discourage breaks after headings
        '\makeatletter',
        '\renewcommand{\@afterheading}{\@nobreaktrue\everypar{\@nobreakfalse\everypar{}}}',
        '\makeatother',
        # Require minimum space for heading + at least 2 lines of content
        '\pretocmd{\section}{\needspace{4\baselineskip}}{}{}',
        '\pretocmd{\subsection}{\needspace{3\baselineskip}}{}{}',
        '\pretocmd{\subsubsection}{\needspace{3\baselineskip}}{}{}',
        
        # === Keep lists with preceding paragraph (for inline bold headings) ===
        '\AtBeginEnvironment{itemize}{\needspace{2\baselineskip}}',
        '\AtBeginEnvironment{enumerate}{\needspace{2\baselineskip}}',
        
        # === Prevent breaks right after paragraph start ===
        '\interlinepenalty=150'
    ) -join ''
    
    $pandocArgs = @(
        '--from=markdown+raw_tex+table_captions+implicit_figures+yaml_metadata_block'
        "--pdf-engine=$script:PdfEngine"
        "--metadata-file=$($Config.MetaFile)"
        '--toc'
        '--toc-depth=3'
        '-V', 'toc-own-page=true'
        '-V', 'geometry:margin=1in'
        '-V', 'fontsize=12pt'
        '-V', 'mainfont=Times New Roman'
        '-V', 'linestretch=2'
        '-V', "header-includes=$headerIncludes"
        '-o', $Config.OutputPdf
    )
    
    # Add front matter files BEFORE TOC (in order)
    foreach ($fmFile in $frontMatterFiles) {
        $fmPath = Join-Path $frontMatterDir $fmFile
        if (Test-Path $fmPath) {
            $pandocArgs += @('--include-before-body', $fmPath)
            Write-Info "Front matter: $fmFile"
        }
    }
    
    # Add bibliography if exists
    if (Test-Path $Config.BibFile) {
        $pandocArgs += @(
            '--citeproc'
            "--bibliography=$($Config.BibFile)"
            "--csl=$($Config.CslFile)"
        )
        Write-Info "Bibliography: enabled with APA 7th"
    }
    
    # Add draft watermark if requested
    if ($IsDraft) {
        $pandocArgs += @('-V', 'draft=true')
        Write-Info "Mode: DRAFT"
    }
    
    # Add source files
    $pandocArgs += $sources
    
    # Execute pandoc
    Write-Step "Running pandoc..." 'Yellow'
    & pandoc @pandocArgs 2>&1 | ForEach-Object {
        if ($_ -notmatch 'Missing character|major issue') {
            Write-Host "  $_" -ForegroundColor DarkGray
        }
    }
    
    if ($LASTEXITCODE -ne 0) {
        throw "Pandoc failed with exit code $LASTEXITCODE"
    }
    
    # Verify output
    if (Test-Path $Config.OutputPdf) {
        $pdf = Get-Item $Config.OutputPdf
        Write-Success "Generated: $($pdf.Name) ($([math]::Round($pdf.Length/1KB)) KB)"
    }
    else {
        throw "PDF was not created"
    }
}

function Invoke-Validate {
    Write-Step "Validating sources..."
    
    # Check meta.yaml
    if (Test-Path $Config.MetaFile) {
        Write-Success "meta.yaml exists"
    }
    else {
        throw "meta.yaml not found"
    }
    
    # Check chapters
    foreach ($chapter in $Config.ChapterFiles) {
        $path = Join-Path $Config.ChaptersDir $chapter
        if (Test-Path $path) {
            Write-Success $chapter
        }
        else {
            Write-Host "  ⚠ Missing: $chapter" -ForegroundColor Yellow
        }
    }
    
    # Check bibliography
    if (Test-Path $Config.BibFile) {
        $refs = (Get-Content $Config.BibFile -Raw) -split '@' | Where-Object { $_ -match '^\w+\{' }
        Write-Success "bibliography.bib ($($refs.Count) references)"
    }
}

function Invoke-Clean {
    Write-Step "Cleaning output..."
    
    if (Test-Path $Config.Output) {
        Remove-Item -Path $Config.Output -Recurse -Force
        Write-Success "Removed output directory"
    }
    else {
        Write-Info "Nothing to clean"
    }
}

function Invoke-Watch {
    Write-Step "Watching for changes (Ctrl+C to stop)..."
    
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = $Config.Manuscript
    $watcher.Filter = "*.md"
    $watcher.IncludeSubdirectories = $true
    $watcher.EnableRaisingEvents = $true
    
    $action = {
        $path = $Event.SourceEventArgs.FullPath
        $name = $Event.SourceEventArgs.Name
        Write-Host "`n  Changed: $name" -ForegroundColor Yellow
        
        # Small delay to let file system settle
        Start-Sleep -Milliseconds 500
        
        # Rebuild
        try {
            Build-MermaidDiagrams
            Build-Pdf
        }
        catch {
            Write-Host "  Build error: $_" -ForegroundColor Red
        }
    }
    
    Register-ObjectEvent $watcher "Changed" -Action $action | Out-Null
    Register-ObjectEvent $watcher "Created" -Action $action | Out-Null
    
    Write-Info "Watching $($Config.Manuscript) for .md changes..."
    Write-Info "Press Ctrl+C to stop"
    
    # Initial build
    Test-Dependencies
    Build-MermaidDiagrams
    Build-Pdf
    
    # Keep running
    try {
        while ($true) { Start-Sleep -Seconds 1 }
    }
    finally {
        Get-EventSubscriber | Unregister-Event
        $watcher.Dispose()
    }
}

# ============================================================
# MAIN
# ============================================================
try {
    Write-Host "`n----------------------------------------" -ForegroundColor Cyan
    Write-Host "  AIRS Thesis Build System v2          " -ForegroundColor Cyan
    Write-Host "----------------------------------------" -ForegroundColor Cyan
    
    switch ($Target) {
        'all' {
            Test-Dependencies
            Build-MermaidDiagrams
            Build-Pdf
        }
        'draft' {
            Test-Dependencies
            Build-MermaidDiagrams
            Build-Pdf -IsDraft $true
        }
        'figures' {
            Test-Dependencies
            Build-MermaidDiagrams
        }
        'validate' {
            Invoke-Validate
        }
        'clean' {
            Invoke-Clean
        }
        'watch' {
            Invoke-Watch
        }
    }
    
    Write-Host "`n----------------------------------------" -ForegroundColor Green
    Write-Host "  Build Complete!                      " -ForegroundColor Green
    Write-Host "----------------------------------------`n" -ForegroundColor Green
    
    if ($Open -and (Test-Path $Config.OutputPdf)) {
        Start-Process $Config.OutputPdf
    }
    
}
catch {
    Write-Host "`n✗ Build failed: $_" -ForegroundColor Red
    exit 1
}
