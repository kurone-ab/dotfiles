#!/bin/bash
# Configure macOS system defaults for optimal development environment
# This script sets Dock, Finder, keyboard, screenshot, and UI preferences
# Safe to run multiple times (idempotent)

set -euo pipefail

# Dock: auto-hide
defaults write com.apple.dock autohide -bool true

# Dock: reduce auto-hide delay
defaults write com.apple.dock autohide-delay -float 0

# Dock: reduce auto-hide animation
defaults write com.apple.dock autohide-time-modifier -float 0.5

# Dock: hide recent apps
defaults write com.apple.dock show-recents -bool false

# Finder: show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: use list view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Finder: keep folders on top when sorting
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Finder: search in current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Finder: disable warning on file extension change
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Keyboard: set fast key repeat rate (2 = fastest)
defaults write NSGlobalDomain KeyRepeat -int 2

# Keyboard: reduce initial delay before repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Screenshots: save to ~/Desktop/Screenshots
mkdir -p "$HOME/Desktop/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Desktop/Screenshots"

# Screenshots: save as PNG
defaults write com.apple.screencapture type -string "png"

# Screenshots: disable shadow
defaults write com.apple.screencapture disable-shadow -bool true

# UI: always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# UI: expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# UI: expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Restart affected apps to apply changes
killall Dock Finder SystemUIServer 2>/dev/null || true
echo "macOS defaults applied. Some settings may require logout/restart."
