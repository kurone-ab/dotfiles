#!/bin/bash
set -euo pipefail

TPM_DIR="$HOME/.tmux/plugins/tpm"

# Check if TPM is already installed
if [ -d "$TPM_DIR" ]; then
    echo "TPM already installed, skipping."
    exit 0
fi

echo "Installing TPM (Tmux Plugin Manager)..."
git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"

echo "TPM installation complete."
echo "Run 'prefix + I' inside tmux to install plugins."
