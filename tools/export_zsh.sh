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
cwd=$(pwd)
# Run from root dir
cd ./zsh
clean
clone
commit 'zsh'
cd $cwd