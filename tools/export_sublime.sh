#!/usr/bin/env bash

clean() {
    local -r DESTINATION=$1
    pushd "$DESTINATION" || exit 1
    rm ./*.sublime-settings
    rm ./*.sublime-keymap
    popd || exit 1
}

clone() {
    pushd "$1" || exit 1
    local -r DESTINATION=$(pwd)
    popd || exit 1
    pushd "$HOME"/Library/Application\ Support/Sublime\ Text\ 3/Packages/User || exit 1
    cp ./*.sublime-settings "$DESTINATION"
    cp ./*.sublime-keymap "$DESTINATION"
    popd || exit 1
}

source ./tools/git.sh
guard_master_branch ./
WD=./Sublime
clean "$WD"
clone "$WD"
commit 'Sublime'

