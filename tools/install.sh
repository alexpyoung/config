#!/usr/bin/env bash

install_homebrew() {
    pushd /usr/local || exit 1
    mkdir homebrew
    curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
    popd || exit 1
}

install_dotfiles() {
    cp ./.* ~
}

install_vim() {
    cp -R ./vim/* ~
}

install_brews() {
    brew bundle exec -- bundle install
}

install_crontab() {
    pbcopy < crontab
    echo 'crontab has been loaded into clipboard.'
}

install_sublime() {
    cp ./Sublime/* ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
}

install_alfred() {
    cp ./Alfred/* ~/Library/Application\ Support/Alfred\ 3/
}

install_zsh() {
    chsh -s /bin/zsh
    pushd ./zsh || exit 1
    cp ./.zshrc ~/
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    source ~/.zshrc
    sleep 15
    cp -R ./plugins "$ZSH_CUSTOM/plugins/"
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
    popd || exit 1
}

install_all() {
    install_homebrew
    pushd "${0%/*}" || exit 1
    pushd .. || exit 1
    install_dotfiles
    install_brews
    install_crontab
    install_sublime
    install_alfred
    install_zsh
    install_vim
    echo 'Install successful!'
    popd && popd || exit 1
}

