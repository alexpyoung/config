#!/usr/bin/env bash

guard_master_branch() {
    local -r WORKING_DIR=$1
    local -r CURRENT_BRANCH=$(git branch | sed -n '/\* /s///p')
    if [ "$CURRENT_BRANCH" != 'master' ]
    then
        echo "$WORKING_DIR is not on master. $WORKING_DIR needs to be on master to run this script."
        exit 1
    fi
}

commit() {
    local -r GROUP_NAME=$1
    git fetch origin
    DIFF_OUTPUT="$(git --no-pager diff --stat)"
    if [ -n "$DIFF_OUTPUT" ]; then
        git stash
        git rebase origin master
        git stash pop
    else
        git rebase origin master
    fi
    git add .
    git commit -m "feat($GROUP_NAME): update config"
    git push origin master
}

