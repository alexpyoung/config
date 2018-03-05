# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="spaceship"

plugins=(
  colored-man-pages
  gamechanger
  git
  ssh
  zsh_reload
)

source $ZSH/oh-my-zsh.sh

# ORDER
SPACESHIP_PROMPT_ORDER=(
  char
  time
  battery
  dir
  node
  swift
  ruby
  line_sep
  char
  git
)

#PROMPT
SPACESHIP_PROMPT_SEPARATE_LINE=true
SPACESHIP_CHAR_SYMBOL="$"
SPACESHIP_CHAR_SUFFIX=" "

# TIME
SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_PREFIX=""
SPACESHIP_TIME_COLOR=white
SPACESHIP_TIME_12HR=true

# DIR
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_DIR_COLOR=039
SPACESHIP_DIR_TRUNC=0

# GIT
SPACESHIP_GIT_BRANCH_COLOR=208
SPACESHIP_GIT_STATUS_COLOR=226
SPACESHIP_GIT_STATUS_STASHED="" # there is always something stashed...
# Disable git symbol
SPACESHIP_GIT_SYMBOL="" # disable git prefix
SPACESHIP_GIT_BRANCH_PREFIX="" # disable branch prefix too
# Wrap git in `git:(...)`
SPACESHIP_GIT_PREFIX='git:('
SPACESHIP_GIT_SUFFIX=") "
SPACESHIP_GIT_BRANCH_SUFFIX="" # remove space after branch name
# Unwrap git status from `[...]`
SPACESHIP_GIT_STATUS_PREFIX=""
SPACESHIP_GIT_STATUS_SUFFIX=""

# NODE
SPACESHIP_NODE_PREFIX="node:("
SPACESHIP_NODE_SUFFIX=") "
SPACESHIP_NODE_SYMBOL=""

# RUBY
SPACESHIP_RUBY_PREFIX="ruby:("
SPACESHIP_RUBY_SUFFIX=") "
SPACESHIP_RUBY_SYMBOL=""
SPACESHIP_RUBY_COLOR=196

# SWIFT
SPACESHIP_SWIFT_PREFIX="swift:("
SPACESHIP_SWIFT_SUFFIX=") "
SPACESHIP_SWIFT_SYMBOL=""
