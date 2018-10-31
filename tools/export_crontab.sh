#!/usr/bin/env bash

main() {
    pushd "${0%/*}" || exit 1    
    source ./git.sh
    pushd .. || exit 1
    guard_master_branch ./
    crontab -l > ./crontab
    commit 'crontab'
    popd && popd || exit 1
}

main
