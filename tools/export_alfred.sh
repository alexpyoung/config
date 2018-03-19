#!/usr/bin/env bash

clean() {
    rm -r *.alfredpreferences
}

clone() {
    if [ $# -eq 0 ]
    then targetPath=$HOME/Library/Application\ Support/Alfred\ 3/
    else targetPath=$1
    fi
    rootPath=$(pwd)
    cd $targetPath
    cp -R *.alfredpreferences $rootPath
    cd $rootPath
}

source ./tools/git.sh
guard_master_branch ./
cwd=$(pwd)
# Run from root dir
cd ./Alfred
clean
clone
commit 'Alfred'
cd $cwd
