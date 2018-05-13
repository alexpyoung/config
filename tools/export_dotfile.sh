#!/usr/bin/env bash

clean() {
    local -r FILENAME="$1"
    rm ./."$FILENAME"
}

clone() {
    local -r FILENAME="$1"
    cp "$HOME"/."$FILENAME" ./
}

main() {
    pushd "${0%/*}" || exit 1
    source ./git.sh
    pushd .. || exit 1
    guard_master_branch ./
    local -r FILENAME="$1"
    clean "$FILENAME"
    clone "$FILENAME"
    commit "$FILENAME"
    popd && popd || exit 1
}

if [ $# -eq 0 ]; then
    echo 'File name is required. E.g. zshrc, vimrc'
    exit 1
fi
main "$1"
