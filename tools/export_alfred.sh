#!/usr/bin/env bash

clean() {
    rm -r ./*
}

clone() {
    cp -r ~/Library/Application\ Support/Alfred\ 3/*.alfredpreferences ./
    mkdir -p ./Preferences
    cp -r ~/Library/Preferences/com.runningwithcrayons.Alfred* ./Preferences/
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

