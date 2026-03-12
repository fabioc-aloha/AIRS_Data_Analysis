---
mode: "agent"
description: "Build, validate, or rebuild the AIRS DBA dissertation PDF from Markdown sources"
tools: ["run_in_terminal", "read_file", "replace_string_in_file", "get_errors"]
---

# Build AIRS Thesis

Build or validate the AIRS dissertation using the thesis-v2 build pipeline.

## Context

Read `.github/instructions/airs-thesis-build.instructions.md` for the full build system reference.

## Steps

1. **Check dependencies**: Run `cd thesis-v2; .\build.ps1 -Target validate` to verify pandoc, xelatex, and mmdc are available
2. **Build PDF**: Run `cd thesis-v2; .\build.ps1` for full build, or `.\build.ps1 -Target draft` for quick draft
3. **If build fails**: Check the error output. Common issues:
   - Missing LaTeX packages → install via MiKTeX Console
   - Citation warnings → ensure `@key` format (not narrative `(Author, Year)`)
   - Mermaid errors → verify `mmdc` is on PATH
4. **Validate output**: Check `thesis-v2/output/` for the generated PDF

## Available Targets

| Target | Purpose |
|--------|---------|
| `all` | Full build with Mermaid diagrams |
| `draft` | Quick build without diagram regeneration |
| `figures` | Regenerate Mermaid diagrams only |
| `validate` | Check dependencies and structure |
| `clean` | Remove build artifacts |
| `watch` | Auto-rebuild on file changes |
