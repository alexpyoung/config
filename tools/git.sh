#!/usr/bin/env bash

guard_master_branch() {
    currentBranch=$(git branch | sed -n '/\* /s///p')
    if [ $currentBranch != 'master' ]
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
    git commit -m "feat($1): update config"
    git push origin master
}
