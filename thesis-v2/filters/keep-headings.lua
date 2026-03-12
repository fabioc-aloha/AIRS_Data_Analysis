-- keep-headings.lua
-- Prevent orphaned section/subsection headings by injecting LaTeX spacing
-- commands in the document flow (vertical mode).
--
-- Why: \needspace inside \titleformat's format argument executes in horizontal
-- mode where \vskip and \penalty have no effect. This filter places the
-- commands between blocks where they work correctly.
--
-- Also injects List of Tables and List of Figures before the first chapter
-- heading so they appear after the TOC in the correct order (LoT then LoF).

local first_chapter = true

function Header(el)
  if not FORMAT:match('latex') then return end

  local result = pandoc.List()

  if el.level == 1 then
    -- Inject LoT and LoF before the very first chapter
    if first_chapter then
      first_chapter = false
      result:insert(pandoc.RawBlock('latex', '\\listoftables'))
      result:insert(pandoc.RawBlock('latex', '\\clearpage'))
      result:insert(pandoc.RawBlock('latex', '\\listoffigures'))
      result:insert(pandoc.RawBlock('latex', '\\clearpage'))
    end
    -- Chapter: start on a new page
    result:insert(pandoc.RawBlock('latex', '\\clearpage'))
  elseif el.level == 2 then
    -- Subsection: require heading + ~8 lines of body text to fit
    result:insert(pandoc.RawBlock('latex', '\\Needspace{8\\baselineskip}'))
  elseif el.level == 3 then
    -- Subsubsection: require heading + ~6 lines of body text to fit
    result:insert(pandoc.RawBlock('latex', '\\Needspace{6\\baselineskip}'))
  end

  result:insert(el)
  return result
end
