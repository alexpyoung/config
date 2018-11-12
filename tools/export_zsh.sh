#!/usr/bin/env bash

clone() {
    cp ~/.zshrc ./
    cp ~/.zshenv ./
    local -r PLUGINS_DIR=
    cp -R ~/.oh-my-zsh/custom/plugins/ ./
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

