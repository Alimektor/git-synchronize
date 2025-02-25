BINDIR=$(DESTDIR)/usr/bin
MANDIR=$(DESTDIR)/usr/share/man
LOCAL=false

# Executables
EXEC_FILES=git-synchronize

# Man pages
README_1_FILE=README.md
MAN_1_FILE=git-synchronize.1

.PHONY: all install uninstall test clean local check docker help

all: install clean

## Set variables to install / uninstall to ~/.local
ifeq ($(LOCAL), true)
BINDIR=$(HOME)/.local/bin
MANDIR=$(HOME)/.local/share/man
endif

ifeq (, $(shell which pandoc))
$(error "No pandoc in $(PATH), consider installing pandoc")
endif

install: ## Install git-synchronize (Set LOCAL=true to install to ~/.local)
	@echo "Installing $(EXEC_FILES) to $(BINDIR)"
	mkdir -p man
	pandoc -s -t man $(README_1_FILE) -o man/$(MAN_1_FILE)
	mkdir -p $(BINDIR)
	mkdir -p $(MANDIR)/man1
	install -m 755 bin/$(EXEC_FILES) $(BINDIR)
	install -m 644 man/$(MAN_1_FILE) $(MANDIR)/man1/$(MAN_1_FILE)
	@echo "Installed $(EXEC_FILES) to $(BINDIR) and $(MAN_1_FILE) to $(MANDIR)/man1"

uninstall: ## Uninstall git-synchronize (Set LOCAL=true to install to ~/.local)
	@echo "Uninstalling $(EXEC_FILES) from $(BINDIR)"
	rm -f $(BINDIR)/$(EXEC_FILES)
	# rm -f $(MANDIR)/man1/$(MAN_FILES)
	@echo "Uninstalled $(EXEC_FILES) from $(BINDIR)"

clean: ## Remove generated files
	@echo "Removing generated files"
	rm -rf man
	@echo "Removed generated files"

check: ## Check git-synchronize
	@echo "Checking git-synchronize..."
	pre-commit install
	pre-commit run --all-files
	@echo "Checked git-synchronize successfully..."

docker: ## Build docker image
	@echo "Building docker image..."
	docker build -t git-synchronize .
	@echo "Built docker image..."

docker-client: ## Build docker image for client
	@echo "Building docker image for client..."
	cd tests/client && docker build -t git-synchronize-client .
	@echo "Built docker image for client..."

docker-server: ## Build docker image for server
	@echo "Building docker image for server..."
	cd tests/server && docker build -t git-synchronize-server .
	@echo "Built docker image for server..."

test: docker docker-client docker-server ## Run tests
	@echo "Running tests..."
	cd tests && bats -r .
	@echo "Tests passed successfully..."

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[1;32m%-15s \033[1;33m%s\033[0m\n", $$1, $$2}'
