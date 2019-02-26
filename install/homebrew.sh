#!/usr/bin/env bash

set -e

install_homebrew() {
    # https://github.com/Homebrew/brew/issues/3228
    pushd /usr/local
    sudo mkdir homebrew
    sudo chown -R $(whoami):admin homebrew
    popd
    # https://brew.sh/#install
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

install_packages() {
    pushd "${0%/*}" && pushd .. 
    brew bundle
    popd && popd
}

main() {
    install_homebrew
    install_packages
}

main

