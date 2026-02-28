#!/bin/bash
set -euo pipefail

# Check if Homebrew is already installed
if command -v brew >/dev/null 2>&1; then
  echo "Homebrew already installed, skipping."
  exit 0
fi

# Install Homebrew non-interactively
echo "Installing Homebrew..."
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Evaluate brew shellenv for Apple Silicon (if it exists)
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  echo "Evaluating Homebrew shellenv for Apple Silicon..."
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Homebrew installation complete."
exit 0
