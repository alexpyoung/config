#!/usr/bin/env bash

clean() {
    rm ./*.json
}

clone() {
    local -r DESTINATION=$(pwd)
    local -r TARGET=~/Library/Application\ Support/Code/User
    cp "$TARGET"/*.json "$DESTINATION"
}


main() {
    pushd "${0%/*}" || exit 1
    source ./git.sh
    guard_master_branch ../
    pushd ../VSCode || exit 1
    clean
    clone
    commit 'VSCode'
    popd && popd || exit 1
}

main

