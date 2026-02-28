#!/bin/bash
set -euo pipefail

# Source asdf (installed via homebrew)
if [ -f "$(brew --prefix)/opt/asdf/libexec/asdf.sh" ]; then
    # shellcheck disable=SC1091
    . "$(brew --prefix)/opt/asdf/libexec/asdf.sh"
fi

# List of plugins to register
PLUGINS=(
    "1password-cli"
    "bun"
    "java"
    "just"
    "nodejs"
    "python"
    "rust"
    "zig"
)

# Add each plugin (idempotent with || true)
for plugin in "${PLUGINS[@]}"; do
    echo "Adding asdf plugin: $plugin"
    asdf plugin add "$plugin" 2>/dev/null || true
done

echo "asdf plugins setup complete"
