clean() {
    rm -rf ./*
}

clone() {
    mkdir -p ./Support
    cp -r ~/Library/Application\ Support/Many\ Tricks/ ./Support
    mkdir -p ./Preferences
    cp ~/Library/Preferences/com.manytricks.Moom.plist ./Preferences
}

main() {
    pushd "${0%/*}" || exit 1
    source ./git.sh
    pushd ../Moom || exit 1
    guard_master_branch ../
    clean
    clone
    commit 'Moom'
    popd && popd || exit 1
}

main