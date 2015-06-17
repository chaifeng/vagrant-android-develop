#!/bin/bash
set -e

if [[ "$(id -u)" == "0" ]]; then
    echo Sorry, you are root!
    exit 1
fi

[[ "Darwin" == "$(uname -o)" ]] && if ! brew config; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [[ ! -f "$HOME/.rvm/scripts/rvm" ]]; then
    \curl -sSL https://get.rvm.io | bash -s stable
fi
[ -f "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"

rvm requirements
rvm install 2.2.2 || true
rvm use 2.2.2 --default
gem sources --remove https://rubygems.org/
gem sources -a https://ruby.taobao.org/
gem sources --list
gem install --verbose calabash-android --version 0.5.5

cat <<EOF
  ___                        _        _      _   _             _
 / __|___ _ _  __ _ _ _ __ _| |_ _  _| |__ _| |_(_)___ _ _  __| |
| (__/ _ \ ' \/ _\` | '_/ _\` |  _| || | / _\` |  _| / _ \ ' \(_-<_|
 \___\___/_||_\__, |_| \__,_|\__|\_,_|_\__,_|\__|_\___/_||_/__(_)
              |___/


EOF
