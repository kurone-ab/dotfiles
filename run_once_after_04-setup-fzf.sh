#!/bin/bash
set -euo pipefail

# Setup fzf for zsh
# This script is idempotent and safe to run multiple times

# Check if fzf is installed
if ! command -v fzf >/dev/null 2>&1; then
    echo "fzf not found. Skipping fzf setup."
    exit 0
fi

echo "Setting up fzf..."

# Run fzf installer with zsh-only flags
# --no-update-rc: prevent modifying .zshrc (chezmoi manages it)
# --no-bash --no-fish: only set up for zsh
"$(brew --prefix)/opt/fzf/install" \
    --key-bindings \
    --completion \
    --no-update-rc \
    --no-bash \
    --no-fish

echo "Downloading fzf-git.sh..."

# Download fzf-git.sh to home directory
curl -fsSL https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh \
    -o "$HOME/.fzf-git.sh"

echo "fzf setup complete."
