#!/usr/bin/env bash

main() {
    pushd /usr/local
    mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
    popd
    # Run from config root dir
    cp ./.* $HOME/
    brew bundle exec -- bundle install
    cat ./.crontab | pbcopy
    echo 'crontab has been loaded into clipboard.'
    cp ./Sublime/* $HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
    cp ./Alfred/* $HOME/Library/Application\ Support/Alfred\ 3/
    echo 'Install successful!'
    cd ../
    rm -rf ./config
}

main
