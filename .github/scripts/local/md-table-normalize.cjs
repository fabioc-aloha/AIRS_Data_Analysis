#!/usr/bin/env node
/**
 * md-table-normalize.cjs
 *
 * Normalizes markdown tables to markdownlint's "aligned" style (MD060).
 * Also handles MD012/MD022/MD032/MD058 (blank-line discipline).
 *
 * Usage: node md-table-normalize.cjs <file1.md> [file2.md ...]
 *
 * Idempotent. Preserves CRLF/LF line endings. Operates in place.
 *
 * Why this exists:
 * - markdownlint's "aligned" style requires monospace-padded cells
 * - VS Code's markdownlint extension is strict about cell-pipe alignment
 * - Manual padding is tedious; off-the-shelf normalizers misjudge unicode width
 *
 * Tricky bits (battle-tested 2026-06-01 on AIRS post-defense docs):
 * 1. CRLF: `$` in JS regex matches before `\n`, but CRLF files have `\r\n`.
 *    Always use `(\r?)$` to capture optional CR.
 * 2. Unicode width: NOT all 0x2600-0x27BF codepoints are wide.
 *    - Text-presentation defaults (✓ ✗ ★ ☆ etc.) are narrow
 *    - Emoji-presentation defaults (✅ ❌ ⚠ ✨ etc.) are wide
 *    - VS-16 (U+FE0F) promotes preceding char to wide presentation
 *    - Em-dash (U+2014), en-dash (U+2013), smart quotes are narrow
 * 3. VS Code lint cache: after writing, touch file mtime to force re-scan
 *    (PowerShell: `(Get-Item file).LastWriteTime = Get-Date`)
 */

const fs = require('fs');

// Codepoints in 0x2600-0x27BF that default to EMOJI presentation (wide).
// Per Unicode 15 emoji-data.txt. Anything else in this range is text-presentation.
const EMOJI_DEFAULT_IN_2600 = new Set([
  0x2614, 0x2615,
  0x2648, 0x2649, 0x264A, 0x264B, 0x264C, 0x264D, 0x264E, 0x264F,
  0x2650, 0x2651, 0x2652, 0x2653,
  0x267F, 0x2693, 0x26A1,
  0x26AA, 0x26AB, 0x26BD, 0x26BE, 0x26C4, 0x26C5, 0x26CE, 0x26D4,
  0x26EA, 0x26F2, 0x26F3, 0x26F5, 0x26FA, 0x26FD,
  0x2705, 0x270A, 0x270B, 0x2728, 0x274C, 0x274E,
  0x2753, 0x2754, 0x2755, 0x2757,
  0x2795, 0x2796, 0x2797, 0x27B0, 0x27BF,
]);

function isWide(cp) {
  if (cp >= 0x1F000) return true;                       // SMP emoji planes (always wide)
  if (cp >= 0x2600 && cp <= 0x27BF) return EMOJI_DEFAULT_IN_2600.has(cp);
  if (cp >= 0x3000 && cp <= 0x9FFF) return true;        // CJK punctuation, kana, ideographs
  if (cp >= 0xAC00 && cp <= 0xD7AF) return true;        // Hangul
  if (cp >= 0xFF00 && cp <= 0xFF60) return true;        // Fullwidth forms
  return false;
}

function visualWidth(s) {
  // Iterate codepoints; treat U+FE0F as a width-promotion of the previous char.
  const cps = [...s].map(ch => ch.codePointAt(0));
  let w = 0;
  for (let i = 0; i < cps.length; i++) {
    const cp = cps[i];
    if (cp === 0x200D) continue;                                  // ZWJ
    if (cp >= 0x0300 && cp <= 0x036F) continue;                   // combining diacriticals
    if (cp >= 0xFE00 && cp <= 0xFE0F) {
      if (cp === 0xFE0F && i > 0) {
        const prev = cps[i - 1];
        if (!isWide(prev)) w += 1;                                // VS-16 promotes narrow to wide
      }
      continue;
    }
    w += isWide(cp) ? 2 : 1;
  }
  return w;
}

function padRight(s, target) {
  const diff = target - visualWidth(s);
  return s + (diff > 0 ? ' '.repeat(diff) : '');
}

function isTableRow(line) {
  const t = line.trimEnd();
  return t.startsWith('|') && t.endsWith('|') && t.length > 2;
}

function isSeparatorRow(line) {
  if (!isTableRow(line)) return false;
  const cells = splitRow(line);
  return cells.every(c => /^:?-+:?$/.test(c.trim()));
}

function splitRow(line) {
  const inner = line.trim().replace(/^\|/, '').replace(/\|$/, '');
  return inner.split('|').map(c => c.trim());
}

function normalizeTable(rows) {
  const sepIdx = rows.findIndex(isSeparatorRow);
  if (sepIdx <= 0) return rows;

  const parsed = rows.map(splitRow);
  const numCols = Math.max(...parsed.map(r => r.length));

  const aligns = parsed[sepIdx].map(cell => {
    const left = cell.startsWith(':');
    const right = cell.endsWith(':');
    if (left && right) return 'center';
    if (right) return 'right';
    return 'left';
  });

  for (const r of parsed) {
    while (r.length < numCols) r.push('');
  }

  const widths = new Array(numCols).fill(0);
  for (let i = 0; i < parsed.length; i++) {
    if (i === sepIdx) continue;
    for (let c = 0; c < numCols; c++) {
      const w = visualWidth(parsed[i][c]);
      if (w > widths[c]) widths[c] = w;
    }
  }
  for (let c = 0; c < numCols; c++) {
    if (widths[c] < 3) widths[c] = 3;
  }

  return parsed.map((row, i) => {
    if (i === sepIdx) {
      const sep = row.map((_, c) => {
        const w = widths[c];
        const a = aligns[c];
        if (a === 'center') return ':' + '-'.repeat(w - 2) + ':';
        if (a === 'right') return '-'.repeat(w - 1) + ':';
        return '-'.repeat(w);
      });
      return '| ' + sep.join(' | ') + ' |';
    }
    const cells = row.map((cell, c) => padRight(cell, widths[c]));
    return '| ' + cells.join(' | ') + ' |';
  });
}

function processFile(path) {
  const text = fs.readFileSync(path, 'utf8');
  const eol = text.includes('\r\n') ? '\r\n' : '\n';
  const lines = text.split(/\r?\n/);

  const out = [];
  let i = 0;
  while (i < lines.length) {
    if (isTableRow(lines[i])) {
      const block = [];
      while (i < lines.length && isTableRow(lines[i])) {
        block.push(lines[i]);
        i++;
      }
      if (block.some(isSeparatorRow)) {
        out.push(...normalizeTable(block));
      } else {
        out.push(...block);
      }
    } else {
      out.push(lines[i]);
      i++;
    }
  }

  // MD012: collapse 2+ consecutive blank lines to 1
  const collapsed = [];
  let blankCount = 0;
  for (const line of out) {
    if (line.trim() === '') {
      blankCount++;
      if (blankCount <= 1) collapsed.push('');
    } else {
      blankCount = 0;
      collapsed.push(line);
    }
  }

  // MD022/MD032/MD058: pad blanks around headings, lists, tables
  const isHeading = (l) => /^#{1,6}\s/.test(l);
  const isListItem = (l) => /^\s*([-*+]|\d+\.)\s/.test(l);
  const isTable = (l) => /^\s*\|/.test(l);
  const isBlank = (l) => l.trim() === '';

  const padded = [];
  for (let k = 0; k < collapsed.length; k++) {
    const cur = collapsed[k];
    const prev = padded[padded.length - 1];

    const needsBlankBefore =
      (isHeading(cur) || isListItem(cur) || isTable(cur)) &&
      prev !== undefined && !isBlank(prev) &&
      !(isListItem(prev) && isListItem(cur)) &&
      !(isTable(prev) && isTable(cur));

    if (needsBlankBefore) padded.push('');
    padded.push(cur);

    if (isHeading(cur) && k + 1 < collapsed.length && !isBlank(collapsed[k + 1])) {
      padded.push('');
    }
  }

  // Re-collapse and finalize
  const final = [];
  let bc = 0;
  for (const line of padded) {
    if (line.trim() === '') {
      bc++;
      if (bc <= 1) final.push('');
    } else {
      bc = 0;
      final.push(line);
    }
  }

  while (final.length > 0 && final[final.length - 1] === '') {
    final.pop();
  }
  final.push('');

  fs.writeFileSync(path, final.join(eol), 'utf8');
}

const files = process.argv.slice(2);
if (files.length === 0) {
  console.error('Usage: node md-table-normalize.cjs <file.md> [file2.md ...]');
  process.exit(1);
}
for (const f of files) {
  processFile(f);
  console.log(`Normalized: ${f}`);
}
