#!/usr/bin/env bash

set -e

main() {
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$HOME/config/iTerm"
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
}

main

