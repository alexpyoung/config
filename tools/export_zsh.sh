#!/bin/bash

clean() {
    rm ./.zshrc
}

clone() {
    root_path=$(pwd)
    cp $HOME/.zshrc "$root_path"
}

commit() {
    git stash
    git fetch origin
    git rebase origin master
    git stash pop
    git add .
    git commit -m "feat(zsh): update config"
    git push origin master
}

guard_master() {
    current_branch=$(git branch | sed -n '/\* /s///p')
    if [ "$current_branch" != "master" ]
    then
        echo "$1 is not on master. $1 needs to be on master to run this script."
        exit 1
    fi
}

guard_master ./
pwd=$(pwd)
# Run from root dir
cd ./zsh
clean
clone
commit
cd "$pwd"