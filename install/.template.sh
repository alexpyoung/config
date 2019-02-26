#!/usr/bin/env bash

set -e

main() {
    pushd "${0%/*}" && pushd ..

    popd && popd
}

main

