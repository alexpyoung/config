sshotgun() {
    dusty scripts sshotgun sshotgun -r $1 -e $2
}

# SSH Aliases
gcssh() {
    ssh $(awsprey list $1:$2 | head -n1) 
}

alias ssh-cron='ssh $(awsprey list cron:production)'

# Dusty Aliases
alias gruntweb='dusty scripts gcweb grunt'
alias ds='dusty scripts'
alias dl='dusty logs'
alias du='dusty up'
alias dr='dusty restart'
alias dt='dusty test'
alias dsu='dusty shutdown && dusty up'
alias d='dusty'
alias dquerysh='dusty scripts querysh querysh'
alias dsshotgun=sshotgun

# Docker Aliases
alias evald='eval $(docker-machine env dusty)'

# Redshift Aliases
alias redshift='docker-machine env dusty > /tmp/denv && source /tmp/denv && docker run -ti --rm postgres psql -h 10.0.0.81 -p 5439 -U alex_young -d insights'
alias redshift-staging='docker-machine env dusty > /tmp/denv && source /tmp/denv && docker run -ti --rm postgres psql -h 10.0.96.9 -p 5439 -U alex_young -d insights'

# PAPI Aliases
alias papi='psql -h papi-prod.crzmm8cpdhmt.us-east-1.rds.amazonaws.com -U gamechanger papi'
export PGPASSWORD=0Ltli9BFuvROxbgU8AqDyrJtLIDCyvOFRrpLjEHWUtfjh0ZgTt

# Directory Aliases
gc_dir_decorator() {
    cd $HOME/gc/$1
    echo 'Fetching origin...' && gfo
    gst 
    g --no-pager diff --stat origin/master
}

alias eden='gc_dir_decorator eden'
alias odyssey='gc_dir_decorator odyssey'
alias gclib='gc_dir_decorator gclib'
alias gcweb='gc_dir_decorator gcweb'
alias gcios='gc_dir_decorator gcios'
alias gcapi='gc_dir_decorator gcapi'
alias gcapi2='gc_dir_decorator gcapi2'
alias gcsystems='gc_dir_decorator gcsystems'
alias sabertooth='gc_dir_decorator sabertooth'
alias sabertoothios='gc_dir_decorator SabertoothIOS'
alias servertooth='gc_dir_decorator servertooth'
alias dusty-specs='gc_dir_decorator dusty-specs'
alias gcuikit='gc_dir_decorator GCUIKit'
alias androidbats='gc_dir_decorator AndroidBats'
alias chakra='gc_dir_decorator chakra'
alias gc='cd $HOME/gc/'
alias sgc='sublime $HOME/gc'

