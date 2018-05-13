#!/usr/bin/env bash

main() {
    pushd "${0%/*}" || exit 1
    ./export_alfred.sh
    sleep 5
    ./export_brewfile.sh
    sleep 5
    ./export_crontab.sh
    sleep 5
    ./export_dotfile.sh tmux.conf
    sleep 5
    ./export_dotfile.sh vimrc
    sleep 5
    ./export_dotfile.sh zshrc
    sleep 5
    ./export_sublime.sh
    sleep 5
    popd || exit 1
}

main

