#!/usr/bin/env bash

main() {
    pushd "${0%/*}" || exit 1
    source ./git.sh
    guard_master_branch ../
    pushd ../ || exit 1
    brew bundle dump --force
    commit 'Brewfile'
    popd && popd || exit 1
}

main
