#!/bin/bash

clean() {
    rm *.sublime-settings
    rm *.sublime-keymap
}

clone() {
    if [ $# -eq 0 ]
    then targetPath=$HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
    else targetPath=$1
    fi
    rootPath=$(pwd)
    cd "${targetPath}"
    cp *.sublime-settings "${rootPath}"
    cp *.sublime-keymap "${rootPath}"
    cd "${rootPath}"
}

guard_master() {
    currentBranch=$(git branch | sed -n '/\* /s///p')
    if [ "$currentBranch" != "master" ]
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
    git commit -m "feat(Sublime): update config"
    git push origin master
}

guard_master ./
clean
clone
commit
