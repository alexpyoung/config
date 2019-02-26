#!/usr/bin/env bash

set -e

main() {
    pushd "${0%/*}" && pushd ..
    cat crontab > pbcopy
    echo 'crontab has been loaded into clipboard. Use crontab -e.'
    popd && popd
}

main

