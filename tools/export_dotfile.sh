#!/usr/bin/env bash

clean() {
    rm "./.$1"
}

clone() {
    root_path=$(pwd)
    cp $HOME/".$1" $root_path
}

main() {
    source ./tools/git.sh
    guard_master_branch ./
    # Run from root dir
    clean $1
    clone $1
    commit "$1"
}

main $1
