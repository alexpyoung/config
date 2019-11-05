alias mbqlog='open https://papertrailapp.com/systems/`curl -s -H "X-Papertrail-Token: $PAPERTRAIL_API_TOKEN" https://papertrailapp.com/api/v1/groups.json | jq -r ".[0].systems | map(.name) | .[]" | fzf`/events'
alias mbqtail='curl -s -H "X-Papertrail-Token: $PAPERTRAIL_API_TOKEN" https://papertrailapp.com/api/v1/groups.json | jq -r ".[0].systems | map(.name) | .[]" | fzf | xargs papertrail -f -s'
alias cpnpm='cat ~/.npmrc | cut -d= -f2'

mbqssh() {
    local -r RACK=$(convox racks | tail -n +2 | grep running | cut -d/ -f2 | cut -d" " -f1 | fzf)
    local -r APP=$(convox apps -r $RACK | tail -n +2 | grep running | cut -d" " -f1 | fzf)
    local -r SERVICE=$(convox services -r $RACK -a $APP | tail -n +2 | cut -d" " -f1 | fzf)
    printf "%s\n" "SSHing into $APP $SERVICE..."
    convox run $SERVICE bash -r $RACK -a $APP
}

mbq_dir_decorator() {
    cd ~/q/$1
    echo 'Fetching origin...' && gfo
    gst 
    g --no-pager diff --stat origin/master
}

mbqid() {
    open "https://api.managedbyq.com/admin/identity/person/$1"
}

pkgr() {
    pkill -f "launchPackager"
    ./node_modules/.bin/react-native run-ios --configuration Debug --scheme Development
}

# Directory Aliases
alias hivy='mbq_dir_decoratory hivy'
alias iris='mbq_dir_decorator iris'
alias mobile='mbq_dir_decorator mobile-dashboard'
alias messaging='mbq_dir_decorator messaging'
alias notifications='mbq_dir_decorator notifications'
alias clid='mbq_dir_decorator client-dashboard'
alias oscore='mbq_dir_decorator os-core'
alias ptrd='mbq_dir_decorator partner-dashboard'

hivyup() {
    cd ~/q/hivy
    grbm
    mbq op sync
    dkc build
    dkc up -d hivy_api
    mbq npm migrate
    mbq npm reset-db
    dkc logs -f hivy_api
}

oscup() {
    cd ~/q/os-core
    grbm
    mbq op sync
    dkc build
    dkc up -d api
    mbq resetdb
    dkc restart api
    dkc logs -f api
}

cdup() {
    cd ~/q/client-dashboard
    grbm
    mbq op sync
    dkc build
    dkc up -d
    dkc logs -f bff
}

irisup() {
    cd ~/q/iris
    grbm
    mbq op sync
    dkc build
    mbq manage migrate
    dkc up -d iris-api
    dkc logs -f iris-api
}

