#!/usr/bin/env bash

set -e

main() {
    pushd "${0%/*}" && pushd ../zsh
    cp ./.zshrc ~/
    cp ./.zshenv ~/
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    source ~/.zshrc
    sleep 15
    cp -R ./plugins "$ZSH_CUSTOM/plugins/"
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
    popd && popd
    chsh -s /bin/zsh
}

main

