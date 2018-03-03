#!/bin/bash

if [ $# -eq 0 ]
then rootPath=~/Library/Application Support/Sublime Text 3/Packages/User
else rootPath=$1
fi

cd rootPath
cp *.sublime-settings ./
cp *.sublime-keymap ./

guardMasterBranch() {
    currentBranch=$(git branch | sed -n '/\* /s///p')
    if [ "$currentBranch" != "master" ]
    then
        echo "$1 is not on master. $1 needs to be on master to run this script."
        exit 1
    fi
}

guardMasterBranch ./

git stash
git fetch origin
git rebase origin master
git stash pop
git commit -am "Update Sublime config"
git push origin master