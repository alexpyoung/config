#!/usr/bin/env bash

# Run from root dir
source ./tools/git.sh
guard_master_branch ./
rm ./Brewfile
brew bundle dump
commit 'Brewfile'
