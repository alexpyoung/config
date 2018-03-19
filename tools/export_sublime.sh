#!/usr/bin/env bash

clean() {
    rm *.sublime-settings
    rm *.sublime-keymap
}

clone() {
    if [ $# -eq 0 ]
    then target_path=$HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
    else target_path=$1
    fi
    root_path=$(pwd)
    cd $target_path
    cp *.sublime-settings $root_path
    cp *.sublime-keymap $root_path
    cd $root_path
}

source ./tools/git.sh
guard_master_branch ./
cwd=$(pwd)
# Run from root dir
cd ./Sublime
clean
clone
commit 'Sublime'
cd $cwd
