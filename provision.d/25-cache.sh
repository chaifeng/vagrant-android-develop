#!/bin/bash
set -e

cd /vagrant/cache

CACHE_SERVER_URL="http://chaifeng.com/vagrant-cache"
function download_cache() {
    FILE="$1"

    if [[ ! -f "$FILE" ]]; then
        wget -O "$FILE" "${CACHE_SERVER_URL}/$FILE"
    fi
}

function verify_cache() {
    FILE_SHA1SUM="${1}.sha1sum"
    download_cache "$FILE_SHA1SUM"
    sha1sum --check "$FILE_SHA1SUM"
    RETVAL=$?
    [[ $RETVAL -eq 0 ]] || rm "$FILE_SHA1SUM"
    return $RETVAL
}

function download_and_verify() {
    FILE="$1"

    [[ -f "$FILE" ]] && verify_cache "$FILE" && return 0
    rm -f "$FILE"
    download_cache "$FILE"
    verify_cache "$FILE"
}

download_and_verify android-sdk-packages.tgz
download_and_verify android-sdk_r23.0.2-linux.tgz
download_and_verify apache-ant-1.9.4-bin.tar.gz
download_and_verify apache-maven-3.2.3-bin.tar.gz
download_and_verify gradle-2.2.1-bin.zip
download_and_verify gradle-cache.tgz
download_and_verify jdk-8u25-linux-x64.tar.gz
download_and_verify latest.tar.gz
download_and_verify maven-repository-cache.tgz

tar zxf gradle-cache.tgz
tar zxf maven-repository-cache.tgz
