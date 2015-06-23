#!/bin/bash

error_hook() {
    cat <<EOF


      ______   _____    _____     ____    _____    _   _   _
     |  ____| |  __ \  |  __ \   / __ \  |  __ \  | | | | | |
     | |__    | |__) | | |__) | | |  | | | |__) | | | | | | |
     |  __|   |  _  /  |  _  /  | |  | | |  _  /  | | | | | |
     | |____  | | \ \  | | \ \  | |__| | | | \ \  |_| |_| |_|
     |______| |_|  \_\ |_|  \_\  \____/  |_|  \_\ (_) (_) (_)


  Please run this command again!


EOF
}

trap error_hook INT TERM ERR

set -eo pipefail

command -V git
command -V vagrant
command -V ssh

if [[ "quick_start.sh" == "$(basename "$0")" ]]; then
    cd "$(dirname "$0")/.."
fi

[[ -d vagrant-android-develop/.git ]] && cd vagrant-android-develop

if [[ -d .git ]]; then
    git pull https://github.com/chaifeng/vagrant-android-develop.git || true
else
    git clone https://github.com/chaifeng/vagrant-android-develop.git
    cd vagrant-android-develop
fi
git submodule update --init --recursive || true

if ( vagrant status | grep '^default' | grep -E '(aborted|running)' ); then
    vagrant reload --provision
else
    vagrant up --provision
fi

vagrant ssh -c "test -f /.vagrant-shell-provision.DONE"
