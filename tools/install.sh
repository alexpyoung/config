#!/usr/bin/env bash

install_homebrew() {
    pushd /usr/local || exit 1
    mkdir homebrew
    curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
    popd || exit 1
}

main() {
    install_homebrew
    pushd "${0%/*}" || exit 1
    pushd .. || exit 1
    cp ./.* ~
    brew bundle exec -- bundle install
    pbcopy < crontab
    echo 'crontab has been loaded into clipboard.'
    popd || exit 1
    cp ../Sublime/* ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
    cp ../Alfred/* ~/Library/Application\ Support/Alfred\ 3/
    echo 'Install successful!'
    popd || exit 1
}

main
