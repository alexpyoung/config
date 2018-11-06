#!/usr/bin/env bash

clean() {
    rm ./*
}

clone() {
    cp -r ~/Library/Application\ Support/Sublime\ Text\ 3/Packages ./
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

