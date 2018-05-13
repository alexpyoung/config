ssh-add -K ~/.ssh/id_rsa

# Github
alias grbm='gfo && grb origin/master'
alias ga='git add .'
alias grbmi='gfo && grb -i origin/master'
alias gast='ga && git stash'
alias gdsg='gd --staged'
alias gdst='echo $(gd --stat) && echo $(gd --numstat)'
alias ggui='github ./'
alias xc='open *.xcworkspace([1])'
alias l='ls -alF'
alias h='history'

# Tmux
alias ta='tmux attach -t'
alias tn='tmux new-session -s'
alias tls='tmux list-sessions'
alias tk9='tmux kill-server'
alias tks='tmux kill-session -t'

alias spd='speedtest-cli'

# Misc
touch_and_sublime() {
    touch $1 && st $1
}
sublime_fallthrough() {
    if [ $# -eq 0 ]; then
        st
    else
        st $1
    fi
}
alias tsbl=touch_and_sublime
alias sbl=sublime_fallthrough

# fzf helpers

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
    local EDITOR
    local QUERY
    if [ $# -eq 1 ]; then
        EDITOR=$1
        QUERY=$2
    else
        EDITOR=open
        QUERY=$1
    fi
    local FILES
    IFS=$'\n' FILES=($(fzf-tmux --query="$QUERY" --multi --select-1 --exit-0))
    [[ -n $FILES ]] && ${EDITOR:-$EDITOR} "${FILES[@]}"
}
# fd - cd to selected directory
fd() {
    local DIRECTORY
    DIRECTORY=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) &&
    cd $DIRECTORY
}
