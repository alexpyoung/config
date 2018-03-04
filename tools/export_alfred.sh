#!/bin/bash

clean() {
    rm -r *.alfredpreferences
}

clone() {
    if [ $# -eq 0 ]
    then target_path=$HOME/Library/Application\ Support/Alfred\ 3/
    else target_path=$1
    fi
    root_path=$(pwd)
    cd "$target_path"
    cp -R *.alfredpreferences "$root_path"
    cd "$root_path"
}

guard_master() {
    current_branch=$(git branch | sed -n '/\* /s///p')
    if [ "$current_branch" != "master" ]
    then
        echo "$1 is not on master. $1 needs to be on master to run this script."
        exit 1
    fi
}

commit() {
    git stash
    git fetch origin
    git rebase origin master
    git stash pop
    git add .
    git commit -m "feat(Alfred): update config"
    git push origin master
}

guard_master ./
pwd=$(pwd)
# Run from root dir
cd ./Alfred
clean
clone
commit
cd "$pwd"
