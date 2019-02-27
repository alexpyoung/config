#!/usr/bin/env bash

set -e

install_vim_plug() {
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install_dotfiles() {
    pushd "${0%/*}"
    cp -r ../vim ~
    popd
}

main() {
    install_vim_plug
    install_dotfiles
}

main

