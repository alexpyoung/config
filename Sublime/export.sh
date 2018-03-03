#!/bin/bash

if [ $# -eq 0 ]
then targetPath=$HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
else targetPath=$1
fi

rootPath=$(pwd)

cd "${targetPath}"
cp *.sublime-settings "${rootPath}"
cp *.sublime-keymap "${rootPath}"

guardMasterBranch() {
    currentBranch=$(git branch | sed -n '/\* /s///p')
    if [ "$currentBranch" != "master" ]
    then
        echo "$1 is not on master. $1 needs to be on master to run this script."
        exit 1
    fi
}

cd "${rootPath}"
guardMasterBranch ./

git stash
git fetch origin
git rebase origin master
git stash pop
git add .
git commit -m "Update Sublime config"
git push origin master