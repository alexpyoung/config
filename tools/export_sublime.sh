#!/bin/bash

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
    cd "$target_path"
    cp *.sublime-settings "$root_path"
    cp *.sublime-keymap "$root_path"
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
    git commit -m "feat(sublime): update config"
    git push origin master
}

guard_master ./
pwd=$(pwd)
# Run from root dir
cd ./Sublime
clean
clone
commit
cd "$pwd"
