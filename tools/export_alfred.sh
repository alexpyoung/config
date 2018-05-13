#!/usr/bin/env bash

clean() {
    local -r DESTINATION=$1
    rm -r "$DESTINATION"/*.alfredpreferences
}

clone() {
    local -r DESTINATION=$1
    cp -r "$HOME"/Library/Application\ Support/Alfred\ 3/*.alfredpreferences "$DESTINATION"
}

source ./tools/git.sh
guard_master_branch ./
WD=./Alfred
clean $WD
clone $WD
commit 'Alfred'

