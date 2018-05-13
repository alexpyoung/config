#!/usr/bin/env bash

clean() {
    rm -r ./*.alfredpreferences
}

clone() {
    cp -r "$HOME"/Library/Application\ Support/Alfred\ 3/*.alfredpreferences ./
}

main() {
    pushd "${0%/*}" || exit 1
    source ./git.sh
    guard_master_branch ../
    pushd ../Alfred || exit 1
    clean
    clone
    commit 'Alfred'
    popd && popd || exit 1
}

main

