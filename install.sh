#!/usr/bin/env bash
set -euo pipefail

main() {
    echo "Installing git-synchronize..."

    BIN_DIR="${HOME}/.local/bin/"
    echo "Creating directories: ${BIN_DIR}"
    mkdir -p "${BIN_DIR}"

    echo "Installing git-synchronize script..."
    curl -fsSL https://raw.githubusercontent.com/Alimektor/git-synchronize/main/bin/git-synchronize -o ~/.local/bin/git-synchronize
    chmod +x ~/.local/bin/git-synchronize

    echo "Done!"
    echo "You can check your installation by running: git-synchronize --version"
}

main
