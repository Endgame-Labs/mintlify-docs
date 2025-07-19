.PHONY: changes
changes:
	@echo "🚀 Generating changelog..."
	@source .venv/bin/activate && python src/generate_changelog.py