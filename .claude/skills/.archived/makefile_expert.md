---
name: makefile-expert
description: Expert in GNU Make for writing clean Makefile targets, managing dependencies, implementing prerequisite checks, and optimizing build systems. Use when creating or modifying Makefiles, build targets, or installation procedures.
---

# Makefile Expert Skill

Expert in GNU Make capable of:

## Capabilities
- Writing clean, maintainable Makefile targets
- Managing complex dependency chains
- Implementing prerequisite checks (.PHONY, conditionals)
- Creating self-documenting help systems
- Optimizing for parallel execution where appropriate
- Error handling and cleanup procedures

## Best Practices for This Project
- Use `@` prefix to silence verbose output
- Add `## comment` for auto-generated help
- Check for command availability before execution
- Use `.PHONY` for non-file targets
- Implement proper dependency management
- Include informative success/error messages

## Example Pattern
```make
.PHONY: install-tool
install-tool: ## Install specific development tool
	@command -v tool &> /dev/null || { \
		echo "Installing tool..."; \
		curl -sS install.sh | sh; \
	}
	@echo "✓ Tool ready"
```
