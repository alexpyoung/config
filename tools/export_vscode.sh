#!/usr/bin/env bash

clean() {
    rm ./*
}

clone() {
    cp ~/Library/Application\ Support/Code/User/*.json ./
    cp -r ~/.vscode ./
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

