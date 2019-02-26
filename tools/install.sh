#!/usr/bin/env bash

install_dotfiles() {
    cp ./.tmux.conf ~
}

install_alfred() {
    local -r TARGET=~/Library/Application\ Support/Alfred\ 3/
    mkdir -p "$TARGET"
    cp -r ./Alfred/*.alfredpreferences "$TARGET"
    cp ./Alfred/Preferences/* ~/Library/Preferences/
}

install_moom() {
    local -r TARGET=~/Library/Application\ Support/Many\ Tricks/
    mkdir -p "$TARGET"
    cp -r ./Moom/Support "$TARGET"
    cp ./Moom/Preferences/* ~/Library/Preferences
}

