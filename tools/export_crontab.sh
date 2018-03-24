#!/usr/bin/env bash

main() {
    # Run from root dir
    source ./tools/git.sh
    guard_master_branch ./
    crontab -l > ./.crontab
    commit 'crontab'
}

main
