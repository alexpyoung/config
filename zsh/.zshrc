# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.gem/ruby/2.6.0/bin:$PATH

export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools/
export ZSH=$HOME/.oh-my-zsh

eval "$(pyenv init -)"

export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh" --no-use

export PAPERTRAIL_API_TOKEN=EcJHRCpMs2WJ5C5gKYq

export FZF_DEFAULT_COMMAND='rg --files' # Use ripgrep instead of find to respect gitignore

export LC_ALL=en_US.UTF-8

ZSH_THEME='spaceship'

plugins=(
  colored-man-pages
  git
  zsh_reload
  gamechanger
  apy-tools
  mbq
  zsh-syntax-highlighting
)

SPACESHIP_PROMPT_ORDER=(
  time
  dir
  git
  user
  node
  swift
  ruby
  docker
  line_sep
  char
)

SPACESHIP_PROMPT_SEPARATE_LINE=true
SPACESHIP_CHAR_SYMBOL="$"
SPACESHIP_CHAR_SUFFIX=' '

SPACESHIP_USER_SHOW=needed
SPACESHIP_USER_PREFIX=''
SPACESHIP_USER_SUFFIX=' | '
SPACESHIP_USER_COLOR_ROOT=057

SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_PREFIX=''
SPACESHIP_TIME_SUFFIX=' | '
SPACESHIP_TIME_COLOR=white
SPACESHIP_TIME_12HR=true

SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_DIR_PREFIX=''
SPACESHIP_DIR_SUFFIX=''
SPACESHIP_DIR_COLOR=039
SPACESHIP_DIR_TRUNC=0

SPACESHIP_GIT_BRANCH_COLOR=208
SPACESHIP_GIT_STATUS_COLOR=226
SPACESHIP_GIT_STATUS_STASHED='' # there is always something stashed...
SPACESHIP_GIT_SYMBOL=''
SPACESHIP_GIT_BRANCH_PREFIX=''
SPACESHIP_GIT_PREFIX=' | git:'
SPACESHIP_GIT_SUFFIX=''
SPACESHIP_GIT_BRANCH_SUFFIX=''
SPACESHIP_GIT_STATUS_PREFIX=''
SPACESHIP_GIT_STATUS_SUFFIX=''

SPACESHIP_NODE_PREFIX=' | node:'
SPACESHIP_NODE_SUFFIX=''
SPACESHIP_NODE_SYMBOL=''

SPACESHIP_RUBY_PREFIX=' | ruby:'
SPACESHIP_RUBY_SUFFIX=''
SPACESHIP_RUBY_SYMBOL=''
SPACESHIP_RUBY_COLOR=160

SPACESHIP_SWIFT_PREFIX=' | swift:'
SPACESHIP_SWIFT_SUFFIX=''
SPACESHIP_SWIFT_SYMBOL=''
SPACESHIP_SWIFT_COLOR=226

SPACESHIP_DOCKER_PREFIX=' | docker:'
SPACESHIP_DOCKER_SUFFIX=''
SPACESHIP_DOCKER_SYMBOL=''
SPACESHIP_DOCKER_COLOR=cyan

# added by travis gem
[ -f /Users/alex/.travis/travis.sh ] && source /Users/alex/.travis/travis.sh

source $ZSH/oh-my-zsh.sh


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
