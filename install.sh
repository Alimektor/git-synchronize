#!/usr/bin/env bash
set -euo pipefail

main() {
    echo "Installing git-synchronize..."

    BIN_DIR="${HOME}/.local/bin/"
    MAN_DIR="${HOME}/.local/share/man/"
    echo "Creating directories: ${BIN_DIR} ${MAN_DIR}/man1"
    mkdir -p "${BIN_DIR}"
    mkdir -p "${MAN_DIR}/man1"

    echo "Installing git-synchronize script..."
    curl -fsSL https://raw.githubusercontent.com/Alimektor/git-synchronize/main/bin/install.sh -o ~/.local/bin/git-synchronize
    chmod +x ~/.local/bin/git-synchronize

    echo "Done!"
    echo "You can check your installation by running: git-synchronize --version"
}
