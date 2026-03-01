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

# Trackpad: enable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Trackpad: enable three finger drag
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# Keyboard: disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Keyboard: disable web auto-correct
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false

# Keyboard: disable auto-capitalize
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Keyboard: disable press-and-hold for accents (enable key repeat)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Keyboard: use F1, F2, etc. as standard function keys
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

# Keyboard: full keyboard access for all controls (Tab navigates all UI)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2

# Dock: set icon size to 64px
defaults write com.apple.dock tilesize -int 64

# Dock: enable magnification
defaults write com.apple.dock magnification -bool true

# Dock: set magnification icon size to 80px
defaults write com.apple.dock largesize -int 80

# Dock: disable launch animation
defaults write com.apple.dock launchanim -bool false

# Mission Control: do not auto-rearrange Spaces based on recent use
defaults write com.apple.dock mru-spaces -bool false

# Hot corners: disable bottom-right (disables Quick Note on Sonoma+)
defaults write com.apple.dock wvous-br-corner -int 1
defaults write com.apple.dock wvous-br-modifier -int 0

# Desktop: disable click wallpaper to show desktop (Sonoma+)
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

# Desktop: disable tiled window margins (Sequoia+)
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false

# Menu bar: use analog clock
defaults write com.apple.menuextra.clock IsAnalog -bool true

# Activity Monitor: show only my processes
defaults write com.apple.ActivityMonitor ShowCategory -int 102

# Restart affected apps to apply changes
killall Dock Finder SystemUIServer 2>/dev/null || true
echo "macOS defaults applied. Some settings may require logout/restart."
