#!/bin/bash
set -e

echo 'Downloading caches ...'

#LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get --force-yes -y install axel

CACHE_DIR=/vagrant/cache
cd $CACHE_DIR

CACHE_SERVER_URL="http://chaifeng.com/vagrant-cache"
function download_cache() {
    FILE_CACHE="$1"

    if [[ ! -f "$FILE_CACHE" ]]; then
        wget -O "${FILE_CACHE}" "${CACHE_SERVER_URL}/$FILE_CACHE" || true
        #axel -n 10 -o "${FILE_CACHE}" "${CACHE_SERVER_URL}/$FILE_CACHE" || true
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
    [[ -f "$FILE" ]] && verify_cache "$FILE"
}

download_and_verify android-sdk-packages-20150419082513.tgz
download_and_verify android-sdk_r24.1.2-linux.tgz
download_and_verify apache-ant-1.9.4-bin.tar.gz
download_and_verify apache-maven-3.2.3-bin.tar.gz
download_and_verify gradle-2.2.1-bin.zip
download_and_verify jdk-8u25-linux-x64.tar.gz
download_and_verify latest.tar.gz

function change_owner_to_vagrant() {
    if [[ -e $1 ]] && [[ 'vagrant' != "$(stat --format=%U $1)" ]]; then
        chown -R vagrant $1
    fi
}

change_owner_to_vagrant /home/vagrant/.m2
change_owner_to_vagrant /home/vagrant/.gradle

function extract_cache() {
    CACHE_ARCHIVE_FILE="$1"
    CACHE_ROOT="$2"
    su -lc /bin/bash vagrant <<EOF
        set -e
        cd \$HOME

        if [[ ! -f ${CACHE_ROOT}/${CACHE_TIMESTAMP} ]]; then
            echo 'Extracting ${CACHE_ROOT} ...'
            tar zxf $CACHE_DIR/${CACHE_ARCHIVE_FILE}
        fi
EOF
}

CACHE_TIMESTAMP=cache-201503192105
download_and_verify gradle-${CACHE_TIMESTAMP}.tgz
download_and_verify maven-${CACHE_TIMESTAMP}.tgz
download_and_verify rvm-${CACHE_TIMESTAMP}.tgz

extract_cache gradle-${CACHE_TIMESTAMP}.tgz .gradle
extract_cache maven-${CACHE_TIMESTAMP}.tgz  .m2
extract_cache rvm-${CACHE_TIMESTAMP}.tgz    .rvm
