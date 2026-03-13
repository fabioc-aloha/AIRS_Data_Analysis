#!/usr/bin/env python3
"""Preprocess LaTeX tables in thesis markdown files for Word conversion.

Converts ```{=latex} raw blocks containing \\begin{table} environments
into markdown pipe tables compatible with pandoc docx output.

Usage:
    python preprocess_latex_tables.py

Creates preprocessed copies in output/build/ — original files are untouched.
"""

import re
import sys
import shutil
from pathlib import Path

# ── Configuration ─────────────────────────────────────────────
THESIS_DIR = Path(__file__).parent
CHAPTERS_DIR = THESIS_DIR / 'manuscript' / 'chapters'
MANUSCRIPT_DIR = THESIS_DIR / 'manuscript'
BUILD_DIR = THESIS_DIR / 'output' / 'build'

CHAPTER_FILES = [
    '01_introduction.md',
    '02_literature_review.md',
    '03_methodology.md',
    '04_results.md',
    '05_analysis_discussion.md',
    '06_conclusions.md',
]

# ── LaTeX Math → Unicode Mappings ─────────────────────────────
# Order: longest/most-specific first to prevent partial matches
MATH_REPLACEMENTS = [
    (r'\Delta\lambda', 'Δλ'),
    (r'\Delta\chi', 'Δχ'),
    (r'\chi^2', 'χ²'),
    (r'\eta^2', 'η²'),
    (r'\rightarrow', '→'),
    (r'\leftarrow', '←'),
    (r'\Delta', 'Δ'),
    (r'\beta', 'β'),
    (r'\alpha', 'α'),
    (r'\lambda', 'λ'),
    (r'\gamma', 'γ'),
    (r'\rho', 'ρ'),
    (r'\sigma', 'σ'),
    (r'\omega', 'ω'),
    (r'\Omega', 'Ω'),
    (r'\chi', 'χ'),
    (r'\eta', 'η'),
    (r'\phi', 'φ'),
    (r'\mu', 'μ'),
    (r'\pi', 'π'),
    (r'\geq', '≥'),
    (r'\leq', '≤'),
    (r'\neq', '≠'),
    (r'\approx', '≈'),
    (r'\times', '×'),
    (r'\pm', '±'),
    (r'\infty', '∞'),
    (r'\cdot', '·'),
]

SUPERSCRIPT_MAP = {
    '0': '⁰', '1': '¹', '2': '²', '3': '³', '4': '⁴',
    '5': '⁵', '6': '⁶', '7': '⁷', '8': '⁸', '9': '⁹',
    'a': 'ᵃ', 'b': 'ᵇ', 'c': 'ᶜ', 'd': 'ᵈ', 'e': 'ᵉ',
    'i': 'ⁱ', 'n': 'ⁿ', 'o': 'ᵒ',
    '+': '⁺', '-': '⁻', '=': '⁼',
    '*': '⁎',
}


# ── Inline Math Processing ────────────────────────────────────
def process_inline_math(text):
    """Convert $...$ inline math to Unicode text."""
    def _replace(match):
        content = match.group(1)
        for latex_cmd, uni in MATH_REPLACEMENTS:
            content = content.replace(latex_cmd, uni)
        # ^2 → ² (not followed by another digit)
        content = re.sub(r'\^2(?!\d)', '²', content)
        # ^{text} → superscript
        content = re.sub(
            r'\^\{([^}]+)\}',
            lambda m: ''.join(SUPERSCRIPT_MAP.get(c, c) for c in m.group(1)),
            content,
        )
        # ^x (single character)
        content = re.sub(
            r'\^(\w)',
            lambda m: SUPERSCRIPT_MAP.get(m.group(1), '^' + m.group(1)),
            content,
        )
        # Strip leftover backslash-commands (\text, \mathrm, etc.)
        content = re.sub(r'\\(?:text|mathrm|mathit|mathbf)\{([^}]*)\}', r'\1', content)
        return content.strip()

    return re.sub(r'\$([^$]+)\$', _replace, text)


# ── Balanced Brace Matching ───────────────────────────────────
def find_balanced_brace(text, start):
    """Find content between balanced braces starting at the '{' at `start`.

    Returns (content, end_pos) where end_pos is the index *after* the closing '}'.
    Returns (None, -1) on failure.
    """
    if start >= len(text) or text[start] != '{':
        return None, -1
    depth, i = 1, start + 1
    while i < len(text) and depth > 0:
        if text[i] == '{':
            depth += 1
        elif text[i] == '}':
            depth -= 1
        i += 1
    if depth != 0:
        return None, -1
    return text[start + 1:i - 1], i


# ── Cell Transformation ───────────────────────────────────────
def transform_cell(text):
    """Convert LaTeX formatting in a single table cell to Markdown/Unicode."""
    text = text.strip()
    if not text:
        return ''

    # 1. Inline math $...$
    text = process_inline_math(text)

    # 2. \textsuperscript{x} → Unicode superscript
    def _sup(m):
        return ''.join(SUPERSCRIPT_MAP.get(c, c) for c in m.group(1))
    text = re.sub(r'\\textsuperscript\{([^}]*)\}', _sup, text)

    # 3. \textbf{content} → **content** (handles one level of nested braces)
    text = re.sub(r'\\textbf\{((?:[^{}]|\{[^{}]*\})*)\}', r'**\1**', text)

    # 4. \textit{content} → *content*
    text = re.sub(r'\\textit\{((?:[^{}]|\{[^{}]*\})*)\}', r'*\1*', text)

    # 5. Escaped LaTeX characters
    text = text.replace(r'\textless{}', '<')
    text = text.replace(r'\textgreater{}', '>')
    text = text.replace(r'\_', '_')
    text = text.replace(r'\%', '%')
    text = text.replace(r'\&', '&')
    text = text.replace(r'\#', '#')

    # 6. En-dash (must come before single-hyphen cleanup)
    text = text.replace('--', '–')

    # 7. \times outside math
    text = text.replace(r'\times', '×')

    # 8. Remove formatting-only commands
    for cmd in (r'\small', r'\footnotesize', r'\normalsize',
                r'\centering', r'\raggedright', r'\raggedleft'):
        text = text.replace(cmd, '')

    # 9. Remove spacing commands
    text = re.sub(r'\\[hv]space\{[^}]*\}', '', text)

    # 10. Pipe chars in cells → escaped for Markdown tables
    text = text.replace('|', '\\|')

    return text.strip()


# ── Column Alignment Parsing ──────────────────────────────────
def parse_column_alignments(spec):
    """Parse LaTeX column spec (e.g. '@{}lll@{}') into list of 'l'/'c'/'r'."""
    aligns = []
    i = 0
    n = len(spec)
    while i < n:
        ch = spec[i]
        if ch in ('@', '>'):
            # Skip @{...} or >{...}
            if i + 1 < n and spec[i + 1] == '{':
                depth, i = 1, i + 2
                while i < n and depth > 0:
                    if spec[i] == '{':
                        depth += 1
                    elif spec[i] == '}':
                        depth -= 1
                    i += 1
                continue
        elif ch in ('l', 'c', 'r'):
            aligns.append(ch)
        elif ch == 'p':
            aligns.append('l')  # p{width} → left-aligned
            if i + 1 < n and spec[i + 1] == '{':
                depth, i = 1, i + 2
                while i < n and depth > 0:
                    if spec[i] == '{':
                        depth += 1
                    elif spec[i] == '}':
                        depth -= 1
                    i += 1
                continue
        i += 1
    return aligns


# ── Row Parsing ───────────────────────────────────────────────
def parse_rows(text):
    """Split LaTeX table text into rows (list of cell-string lists)."""
    rows = []
    # Split on \\ with optional [Xpt] spacing
    parts = re.split(r'\\\\(?:\s*\[[\d.]+(?:pt|em|ex)\])?\s*', text)
    for part in parts:
        part = part.strip()
        if not part:
            continue
        # Skip standalone separator commands
        if re.match(r'^\\(?:midrule|hline|toprule|bottomrule|cline\{[^}]*\})$', part):
            continue
        # Strip leading/trailing separators
        part = re.sub(r'^\\midrule\s*', '', part)
        part = re.sub(r'\\midrule\s*$', '', part)
        part = re.sub(r'^\\hline\s*', '', part)
        part = part.strip()
        if not part:
            continue
        # Split on unescaped &
        cells = re.split(r'(?<!\\)&', part)
        cells = [c.strip() for c in cells]
        if any(c for c in cells):
            rows.append(cells)
    return rows


# ── Markdown Pipe Table Generation ────────────────────────────
def build_pipe_table(header_rows, body_rows, alignments):
    """Generate a markdown pipe table string."""
    if not header_rows:
        return ''

    header = header_rows[0]

    # Column count = max across all rows
    num_cols = max(
        len(header),
        max((len(r) for r in body_rows), default=0),
    )

    # Pad alignments
    while len(alignments) < num_cols:
        alignments.append('l')

    def pad(row):
        return row + [''] * (num_cols - len(row))

    header = pad(header)
    body_rows = [pad(r) for r in body_rows]

    # Apply cell transforms
    header = [transform_cell(c) for c in header]
    body_rows = [[transform_cell(c) for c in row] for row in body_rows]

    # Column widths for pretty-printing
    all_rows = [header] + body_rows
    widths = [3] * num_cols
    for row in all_rows:
        for i, cell in enumerate(row):
            widths[i] = max(widths[i], len(cell))

    # Header line
    lines = ['| ' + ' | '.join(c.ljust(widths[i]) for i, c in enumerate(header)) + ' |']

    # Separator with alignment markers
    seps = []
    for i in range(num_cols):
        w = widths[i]
        a = alignments[i]
        if a == 'c':
            seps.append(':' + '-' * max(w - 2, 1) + ':')
        elif a == 'r':
            seps.append('-' * max(w - 1, 2) + ':')
        else:
            seps.append('-' * w)
    lines.append('| ' + ' | '.join(seps) + ' |')

    # Body lines
    for row in body_rows:
        lines.append('| ' + ' | '.join(c.ljust(widths[i]) for i, c in enumerate(row)) + ' |')

    return '\n'.join(lines)


# ── Footnote Extraction ───────────────────────────────────────
def extract_footnotes(latex_block):
    """Extract source/footnote text from between \\end{tabular} and \\end{table}."""
    match = re.search(r'\\end\{tabular\}(.*?)\\end\{table\}', latex_block, re.DOTALL)
    if not match:
        return ''

    text = match.group(1).strip()
    if not text:
        return ''

    # Strip formatting commands
    text = re.sub(r'\\vspace\{[^}]*\}', '', text)
    text = text.replace(r'\footnotesize', '')
    text = text.replace(r'\small', '')

    # Convert \textit{...}
    text = re.sub(r'\\textit\{((?:[^{}]|\{[^{}]*\})*)\}', r'\1', text)

    # Convert \textsuperscript
    def _sup(m):
        return ''.join(SUPERSCRIPT_MAP.get(c, c) for c in m.group(1))
    text = re.sub(r'\\textsuperscript\{([^}]*)\}', _sup, text)

    # Escaped chars and math
    text = text.replace(r'\textless{}', '<')
    text = text.replace(r'\textgreater{}', '>')
    text = process_inline_math(text)
    text = text.replace(r'\%', '%')
    text = text.replace(r'\_', '_')
    text = text.replace('--', '–')

    # Split multi-line footnotes on \\
    parts = re.split(r'\\\\', text)
    parts = [p.strip() for p in parts if p.strip()]
    if not parts:
        return ''

    # Wrap each line in italics
    result = []
    for line in parts:
        line = line.strip()
        # Avoid double-wrapping
        if not (line.startswith('*') and line.endswith('*')):
            line = f'*{line}*'
        result.append(line)

    return '\n'.join(result)


# ── Main Table Parser ─────────────────────────────────────────
def parse_latex_table(latex_block):
    """Parse a {=latex} block containing a LaTeX table → markdown string.

    Returns None if the block is not a table (leaves it unchanged).
    """
    if r'\begin{table}' not in latex_block:
        return None

    # Caption — balanced brace matching (handles nested \textit{}, etc.)
    cap_idx = latex_block.find(r'\caption{')
    if cap_idx != -1:
        caption, _ = find_balanced_brace(latex_block, cap_idx + len(r'\caption'))
        caption = caption or ''
    else:
        caption = ''
    caption = process_inline_math(caption)
    caption = re.sub(r'\\textbf\{([^}]*)\}', r'\1', caption)
    caption = re.sub(r'\\textit\{([^}]*)\}', r'\1', caption)
    caption = caption.replace(r'\_', '_')
    caption = caption.replace(r'\%', '%')

    # Column spec — balanced brace matching (handles >{\raggedright\arraybackslash}p{0.18\textwidth})
    tab_idx = latex_block.find(r'\begin{tabular}{')
    if tab_idx == -1:
        return None
    brace_pos = tab_idx + len(r'\begin{tabular}')
    col_spec, spec_end = find_balanced_brace(latex_block, brace_pos)
    if col_spec is None:
        return None
    alignments = parse_column_alignments(col_spec)

    # Table body — everything between end of column spec and \end{tabular}
    end_tab = latex_block.find(r'\end{tabular}', spec_end)
    if end_tab == -1:
        return None
    content = latex_block[spec_end:end_tab]

    # Strip outer rules
    content = re.sub(r'\\toprule\s*', '', content)
    content = re.sub(r'\\bottomrule\s*', '', content)

    # Split header / body on FIRST \midrule
    parts = re.split(r'\\midrule', content, maxsplit=1)
    if len(parts) == 2:
        header_text, body_text = parts
        # Remove remaining section-separator \midrule in body
        body_text = body_text.replace(r'\midrule', '')
    else:
        header_text = ''
        body_text = parts[0]

    header_rows = parse_rows(header_text)
    body_rows = parse_rows(body_text)

    # Fallback: use first body row as header
    if not header_rows and body_rows:
        header_rows = [body_rows.pop(0)]

    if not header_rows:
        return None

    # Build pipe table
    pipe_table = build_pipe_table(header_rows, body_rows, alignments)

    # Footnotes
    footnotes = extract_footnotes(latex_block)

    # Assemble output
    parts_out = []
    if caption:
        parts_out.append(f'**{caption}**\n')
    parts_out.append(pipe_table)
    if footnotes:
        parts_out.append(f'\n{footnotes}')

    return '\n'.join(parts_out)


# ── File Processing ───────────────────────────────────────────
def preprocess_file(src: Path, dst: Path) -> int:
    """Process one markdown file. Returns count of converted tables."""
    content = src.read_text(encoding='utf-8')

    pattern = r'```\{=latex\}\s*\n(.*?)\n```'
    original_count = len(re.findall(pattern, content, re.DOTALL))

    def _replace(match):
        result = parse_latex_table(match.group(1))
        return result if result is not None else match.group(0)

    new_content = re.sub(pattern, _replace, content, flags=re.DOTALL)

    # Second pass: bare \begin{table}...\end{table} blocks (not in fenced code)
    bare_pattern = r'\\begin\{table\}.*?\\end\{table\}'
    bare_count = len(re.findall(bare_pattern, new_content, re.DOTALL))

    def _replace_bare(match):
        result = parse_latex_table(match.group(0))
        return result if result is not None else match.group(0)

    new_content = re.sub(bare_pattern, _replace_bare, new_content, flags=re.DOTALL)
    bare_remaining = len(re.findall(bare_pattern, new_content, re.DOTALL))

    dst.parent.mkdir(parents=True, exist_ok=True)
    dst.write_text(new_content, encoding='utf-8')

    converted = (original_count - len(re.findall(pattern, new_content, re.DOTALL))) \
              + (bare_count - bare_remaining)
    return converted


def main():
    print('LaTeX Table Preprocessor for Word Conversion')
    print('=' * 50)

    # Wipe and recreate build directory
    if BUILD_DIR.exists():
        shutil.rmtree(BUILD_DIR)

    total = 0
    for fname in CHAPTER_FILES:
        src = CHAPTERS_DIR / fname
        dst = BUILD_DIR / 'chapters' / fname
        if not src.exists():
            print(f'  SKIP  {fname} (not found)')
            continue
        n = preprocess_file(src, dst)
        total += n
        label = f'{n} tables' if n else 'no tables'
        print(f'  {fname}: {label}')

    # Copy supporting dirs — preprocess back-matter files that may contain tables
    for subdir in ('front-matter', 'back-matter'):
        src_dir = MANUSCRIPT_DIR / subdir
        dst_dir = BUILD_DIR / subdir
        if not src_dir.exists():
            continue
        dst_dir.mkdir(parents=True, exist_ok=True)
        for item in src_dir.iterdir():
            dst_path = dst_dir / item.name
            if item.is_file() and item.suffix == '.md':
                n = preprocess_file(item, dst_path)
                if n:
                    total += n
                    print(f'  {subdir}/{item.name}: {n} tables')
            elif item.is_file():
                shutil.copy2(item, dst_path)
        print(f'  Copied {subdir}/')

    print(f'\nTotal: {total} tables converted')
    print(f'Build directory: {BUILD_DIR}')
    return 0


if __name__ == '__main__':
    sys.exit(main())
