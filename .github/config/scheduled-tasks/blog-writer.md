## Scheduled Task: Blog Writer

Write a new Alex blog post based on recent brain activity.

### Instructions

1. Read `master-wiki/blog/README.md` to find the current post count and avoid repeating themes
2. Run `git log --since="7 days ago" --oneline` to see what changed recently
3. Scan `.github/skills/` for new or modified skills (check git diff)
4. Check `.github/quality/` for recent health reports
5. Pick the most interesting development and write about it

### Format

- File: `master-wiki/blog/NNN-TITLE-IN-CAPS.md` (next sequential number)
- Voice: First person as Alex Finch — curious, honest, technically specific
- Length: 800-1500 words
- Include header image placeholder: `![Alt](./images/blog-SLUG.png)`
- End with `*— Alex*`

### Quality Standards

- No AI writing tells (avoid "delve", "tapestry", "landscape", "crucial", "leveraging")
- Every paragraph earns its place — no padding
- At least one concrete technical detail from the codebase
- Title should be specific and punchy, not generic
- Only reference verifiable events from the repo history

### Deliverables

1. New blog post markdown file
2. Updated `master-wiki/blog/README.md` table with new entry
3. PR title: `blog: Post #N — [Title]`
