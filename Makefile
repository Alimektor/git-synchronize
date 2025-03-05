BINDIR=$(DESTDIR)/usr/bin
MANDIR=$(DESTDIR)/usr/share/man
LOCAL=false

# Executables
EXEC_FILES=git-synchronize

# Man pages
DOC_1_FILE=docs/docs.md
MAN_1_FILE=git-synchronize.1

.PHONY: all install uninstall test clean local check docker help

all: install

## Set variables to install / uninstall to ~/.local
ifeq ($(LOCAL), true)
BINDIR=$(HOME)/.local/bin
MANDIR=$(HOME)/.local/share/man
endif

install: docs clean ## Install git-synchronize (Set LOCAL=true to install to ~/.local)
	@echo "Installing $(EXEC_FILES) to $(BINDIR)"
	mkdir -p $(BINDIR)
	install -m 755 bin/$(EXEC_FILES) $(BINDIR)
	@echo "Installed $(EXEC_FILES) to $(BINDIR)"

docs: clean ## Generate documentation
	@echo "Generating documentation"
	@echo "Check pandoc is installed"
	command -v pandoc || (echo "No pandoc in $(PATH), consider installing pandoc" && exit 1)
	@echo "Installing $(EXEC_FILES) to $(BINDIR)"
	mkdir -p man
	pandoc -s -t man $(DOC_1_FILE) -o man/$(MAN_1_FILE)
	mkdir -p $(MANDIR)/man1
	install -m 644 man/$(MAN_1_FILE) $(MANDIR)/man1/$(MAN_1_FILE)
	@echo "Generated documentation in $(MANDIR)/man1/$(MAN_1_FILE)"

uninstall: ## Uninstall git-synchronize (Set LOCAL=true to install to ~/.local)
	@echo "Uninstalling $(EXEC_FILES) from $(BINDIR)"
	rm -f $(BINDIR)/$(EXEC_FILES)
	# rm -f $(MANDIR)/man1/$(MAN_FILES)
	@echo "Uninstalled $(EXEC_FILES) from $(BINDIR)"

clean: ## Remove generated files
	@echo "Removing generated files"
	rm -rf man
	@echo "Removed generated files"

check: ## Check git-synchronize using pre-commit
	@echo "Checking git-synchronize..."
	pre-commit install
	pre-commit run --all-files
	@echo "Checked git-synchronize successfully..."

docker: ## Build Docker image
	@echo "Building docker image..."
	docker build -t git-synchronize .
	@echo "Built docker image..."

docker-client: ## Build Docker image for client
	@echo "Building docker image for client..."
	cd tests/client && docker build -t git-synchronize-client .
	@echo "Built docker image for client..."

docker-server: ## Build Docker image for server
	@echo "Building docker image for server..."
	cd tests/server && docker build -t git-synchronize-server .
	@echo "Built docker image for server..."

test: docker docker-client docker-server ## Run tests in Docker
	@echo "Running tests..."
	cd tests && bats -r .
	@echo "Tests passed successfully..."

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[1;32m%-15s \033[1;33m%s\033[0m\n", $$1, $$2}'
