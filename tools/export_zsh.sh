#!/usr/bin/env bash

clean() {
    rm ./.zshrc
}

clone() {
    root_path=$(pwd)
    cp $HOME/.zshrc $root_path
}

source ./tools/git.sh
guard_master_branch ./
# Run from root dir
clean
clone
commit 'zshrc'
