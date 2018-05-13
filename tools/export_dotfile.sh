#!/usr/bin/env bash

clean() {
    local -r FILENAME="$1"
    rm ./."$FILENAME"
}

clone() {
    cp "$HOME"/."$1" ./
}

main() {
    source ./tools/git.sh
    guard_master_branch ./
    local -r FILENAME="$1"
    # Run from root dir
    clean "$FILENAME"
    clone "$FILENAME"
    commit "$FILENAME"
}

main "$1"
