# Thesis Build System - Makefile
# Provides clean build targets for the thesis document
#
# Usage:
#   make          - Build the full thesis PDF
#   make draft    - Build with draft watermark
#   make clean    - Remove generated files
#   make watch    - Watch for changes and rebuild
#   make validate - Validate all source files

# Configuration
SHELL := /bin/bash
.PHONY: all draft clean watch validate help figures

# Directories
SRC_DIR      := manuscript
CHAPTERS_DIR := $(SRC_DIR)/chapters
FRONT_DIR    := $(SRC_DIR)/front-matter
BACK_DIR     := $(SRC_DIR)/back-matter
ASSETS_DIR   := assets
FIGURES_DIR  := $(ASSETS_DIR)/figures
TABLES_DIR   := $(ASSETS_DIR)/tables
TEMPLATES    := templates
REFS_DIR     := references
OUTPUT_DIR   := output

# Files
META         := meta.yaml
TEMPLATE     := $(TEMPLATES)/apa7-thesis.tex
BIB_FILE     := $(REFS_DIR)/bibliography.bib
CSL_FILE     := $(REFS_DIR)/apa-7th-edition.csl
OUTPUT_PDF   := $(OUTPUT_DIR)/AIRS_Dissertation.pdf

# Source files
CHAPTERS     := $(wildcard $(CHAPTERS_DIR)/*.md)
FRONT_MATTER := $(wildcard $(FRONT_DIR)/*.md)
BACK_MATTER  := $(wildcard $(BACK_DIR)/*.md)
ALL_SOURCES  := $(CHAPTERS) $(FRONT_MATTER) $(BACK_MATTER) $(META)

# Tools
PANDOC       := pandoc
PDF_ENGINE   := xelatex
MERMAID      := mmdc

# Pandoc flags
PANDOC_FLAGS := \
	--from=markdown+raw_tex+table_captions+implicit_figures+yaml_metadata_block \
	--pdf-engine=$(PDF_ENGINE) \
	--template=$(TEMPLATE) \
	--metadata-file=$(META) \
	--citeproc \
	--bibliography=$(BIB_FILE) \
	--csl=$(CSL_FILE) \
	--toc \
	--toc-depth=3 \
	--number-sections

# Default target
all: $(OUTPUT_PDF)

# Main PDF build
$(OUTPUT_PDF): $(ALL_SOURCES) $(TEMPLATE) $(BIB_FILE) | $(OUTPUT_DIR)
	@echo "Building thesis PDF..."
	@$(PANDOC) $(PANDOC_FLAGS) \
		$(FRONT_MATTER) \
		$(sort $(CHAPTERS)) \
		$(BACK_MATTER) \
		-o $@
	@echo "✓ Generated: $@"

# Create output directory
$(OUTPUT_DIR):
	@mkdir -p $(OUTPUT_DIR)

# Draft build with watermark
draft: PANDOC_FLAGS += -V draft=true
draft: $(OUTPUT_PDF)

# Generate Mermaid diagrams
figures:
	@echo "Generating Mermaid diagrams..."
	@for mmd in $(FIGURES_DIR)/*.mmd; do \
		if [ -f "$$mmd" ]; then \
			$(MERMAID) -i "$$mmd" -o "$${mmd%.mmd}.png" -b white -s 5; \
			echo "  ✓ $${mmd%.mmd}.png"; \
		fi \
	done

# Validate sources
validate:
	@echo "Validating thesis sources..."
	@echo "  Checking YAML metadata..."
	@python3 -c "import yaml; yaml.safe_load(open('$(META)'))" && echo "    ✓ $(META)"
	@echo "  Checking chapter files..."
	@for ch in $(CHAPTERS); do test -s "$$ch" && echo "    ✓ $$ch"; done
	@echo "  Checking bibliography..."
	@test -s $(BIB_FILE) && echo "    ✓ $(BIB_FILE)"
	@echo "✓ All validations passed"

# Watch for changes
watch:
	@echo "Watching for changes (Ctrl+C to stop)..."
	@while true; do \
		inotifywait -q -e modify $(ALL_SOURCES); \
		make all; \
	done

# Clean generated files
clean:
	@echo "Cleaning generated files..."
	@rm -rf $(OUTPUT_DIR)
	@echo "✓ Cleaned"

# Help
help:
	@echo "Thesis Build System"
	@echo ""
	@echo "Targets:"
	@echo "  all      - Build the full thesis PDF (default)"
	@echo "  draft    - Build with draft watermark"
	@echo "  figures  - Generate Mermaid diagrams"
	@echo "  validate - Validate all source files"
	@echo "  watch    - Watch for changes and rebuild"
	@echo "  clean    - Remove generated files"
	@echo "  help     - Show this help"
