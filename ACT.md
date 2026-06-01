# ACT Recommendations for AIRS_Data_Analysis

## Your Brain

Edition v3.2.1 is installed with the v1 brain (34 instructions, 17 skills, 20 prompts, 3 worker agents).

## First Steps

1. **Fill in your identity**: Edit `.github/copilot-instructions.local.md` with your project context, domain vocabulary, preferences, and constraints. This is heir-owned and survives Edition upgrades.
2. **Browse the Plugin Mall**: Run `/mall search <keyword>` to find plugins relevant to your project.
3. **Install a plugin**: Run `/mall install <name>` to add capabilities from the Mall.

## Recommended Plugins

Based on your project structure:

| Plugin | Category | Why |
| --- | --- | --- |
| `data-analysis` | data-analytics | Data exploration and analysis patterns |
| `data-visualization` | data-analytics | Chart and dashboard design |
| `doc-hygiene` | documentation | Prevent documentation drift and broken links |
| `literature-review` | academic-research | Systematic review methodology |

## Commands to Try

```text
/mall search data
/convert to word
/meditate
```

## Upgrade

To pull future Edition releases:

```bash
node .github/scripts/upgrade-self.cjs --apply
```
