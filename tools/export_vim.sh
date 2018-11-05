#!/usr/bin/env bash

setup() {
    pushd "${0%/*}" || exit 1
    source ./git.sh
    pushd ../vim || exit 1
    guard_master_branch ./
}

teardown() {
    popd && popd || exit 1
}

main() {
    setup

    cp ~/.vimrc ./.vimrc
    cp -R ~/.vim ./.vim/
    commit 'vim'

    teardown
}

main
