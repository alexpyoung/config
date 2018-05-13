#!/usr/bin/env bash

clean() {
    rm ./*.sublime-settings
    rm ./*.sublime-keymap
}

clone() {
    local -r DESTINATION=$(pwd)
    local -r TARGET=~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
    cp "$TARGET"/*.sublime-settings "$DESTINATION"
    cp "$TARGET"/*.sublime-keymap "$DESTINATION"
}


main() {
    pushd "${0%/*}" || exit 1
    source ./git.sh
    guard_master_branch ../
    pushd ../Sublime || exit 1
    clean
    clone
    commit 'Sublime'
    popd && popd || exit 1
}

main

