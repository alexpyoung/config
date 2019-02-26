#!/usr/bin/env bash

install_homebrew() {
    pushd /usr/local || exit 1
    sudo mkdir homebrew
    sudo chown -R $(id -un):admin ./homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    popd || exit 1
}

install_dotfiles() {
    cp ./.* ~
}

install_vim() {
    cp -r ./vim/*. ~
}

install_brews() {
    brew bundle exec -- bundle install
    # Thanks virtualbox
    brew install --force virtualbox
    brew cask install dusty
}

install_crontab() {
    pbcopy < crontab
    echo 'crontab has been loaded into clipboard.'
}

install_alfred() {
    local -r TARGET=~/Library/Application\ Support/Alfred\ 3/
    mkdir -p "$TARGET"
    cp -r ./Alfred/*.alfredpreferences "$TARGET"
    cp ./Alfred/Preferences/* ~/Library/Preferences/
}

install_moom() {
    local -r TARGET=~/Library/Application\ Support/Many\ Tricks/
    mkdir -p "$TARGET"
    cp -r ./Moom/Support "$TARGET"
    cp ./Moom/Preferences/* ~/Library/Preferences
}

install_zsh() {
    pushd ./zsh || exit 1
    cp ./.zshrc ~/
    cp ./.zshenv ~/
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    source ~/.zshrc
    sleep 15
    cp -R ./plugins "$ZSH_CUSTOM/plugins/"
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
    popd || exit 1
    echo 'Execute chsh -s /bin/zsh to change your default shell'
}

install_iterm() {
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/config/iTerm"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
}

