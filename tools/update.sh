#!/usr/bin/env bash

main() {
    pushd "${0%/*}" || exit 1
    ./export_alfred.sh
    sleep 5
    ./export_brewfile.sh
    sleep 5
    ./export_crontab.sh
    sleep 5
    ./export_tmux.sh
    sleep 5
    ./export_moom.sh
    sleep 5
    ./export_vim.sh
    sleep 5
    ./export_zsh.sh
    sleep 5
    popd || exit 1
}

main

