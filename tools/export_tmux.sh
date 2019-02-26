#!/usr/bin/env bash

main() {
    pushd "${0%/*}" || exit 1
    source ./git.sh
    pushd .. || exit 1
    guard_master_branch ./
    local -r FILENAME=tmux.conf
    rm ./"$FILENAME"
    cp ~/."$FILENAME" ./
    commit "$FILENAME"
    popd && popd || exit 1
}

main

