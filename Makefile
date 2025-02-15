BINDIR=$(DESTDIR)/usr/bin
MANDIR=$(DESTDIR)/usr/share/man
LOCAL=false

# Executables
EXEC_FILES=git-synchronize

# Man pages
README_1_FILE=README.md
MAN_1_FILE=git-synchronize.1

.PHONY: all install uninstall man local install-local uninstall-local help

all: install clean

## Set variables to install / uninstall to ~/.local
ifeq ($(LOCAL), true)
BINDIR=~/.local/bin
MANDIR=~/.local/share/man
endif

install: ## Install git-synchronize (Set LOCAL=true to install to ~/.local)
	@echo "Installing $(EXEC_FILES) to $(BINDIR)"
	mkdir -p man
	pandoc -s -t man $(README_1_FILE) -o man/$(MAN_1_FILE)
	install -m 755 bin/$(EXEC_FILES) $(BINDIR)
	install -m 644 man/$(MAN_1_FILE) $(MANDIR)/man1/$(MAN_1_FILE)

uninstall: ## Uninstall git-synchronize (Set LOCAL=true to install to ~/.local)
	@echo "Uninstalling $(EXEC_FILES) from $(BINDIR)"
	rm -f $(BINDIR)/$(EXEC_FILES)
	# rm -f $(MANDIR)/man1/$(MAN_FILES)

clean: ## Remove generated files
	rm -rf man

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[1;32m%-15s \033[1;33m%s\033[0m\n", $$1, $$2}'
