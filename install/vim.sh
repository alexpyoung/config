#!/usr/bin/env bash

set -e

main() {
    pushd "${0%/*}"
    cp -r ../vim/* ~
    popd
}

main

