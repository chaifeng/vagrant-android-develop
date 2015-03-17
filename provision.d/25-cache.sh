#!/bin/bash
set -e

function download_cache() {
    cd /vagrant/cache
    if [[ ! -f "$1" ]]; then
        wget http://chaifeng.com/vagrant-cache/$1
    fi
}

download_cache android-sdk-packages.tgz
download_cache android-sdk_r23.0.2-linux.tgz
download_cache apache-ant-1.9.4-bin.tar.gz
download_cache apache-maven-3.2.3-bin.tar.gz
download_cache gradle-2.2.1-bin.zip
download_cache gradle-cache.tgz
download_cache jdk-8u25-linux-x64.tar.gz
download_cache latest.tar.gz
download_cache maven-repository-cache.tgz
