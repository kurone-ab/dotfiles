#!/bin/bash
set -euo pipefail

CC_FILTER_LOCATION="$HOME/.local/bin/cc-filter"

# Check if cc-filter is already installed
if [ -f "$CC_FILTER_LOCATION" ]; then
    echo "cc-filter already installed, skipping."
    exit 0
fi

echo "Installing cc-filter (Claude Code Sensitive Information Filter)..."
curl -L -o ~/.local/bin/cc-filter https://github.com/wissem/cc-filter/releases/latest/download/cc-filter-darwin-arm64
chmod +x ~/.local/bin/cc-filter

echo "cc-filter installation complete."
