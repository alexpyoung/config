#!/usr/bin/env bash

clone() {
    cp "$HOME"/.zshrc ./
    local -r PLUGINS_DIR="$HOME"/.oh-my-zsh/custom/plugins
    cp "$PLUGINS_DIR"/apy-tools/apy-tools.plugin.zsh ./
    cp "$PLUGINS_DIR"/gamechanger/gamechanger.plugin.zsh ./
}

main() {
    pushd "${0%/*}" || exit 1
    source ./git.sh
    guard_master_branch ../
    pushd ../zsh || exit 1
    clone
    commit 'zsh'
    popd && popd || exit 1
}

main

