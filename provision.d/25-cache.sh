#!/bin/bash
set -e

echo 'Downloading caches ...'

#LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get --force-yes -y install axel

CACHE_DIR=/vagrant/cache
cd $CACHE_DIR

CACHE_SERVER_URL="http://chaifeng.com/vagrant-cache"
function download_cache() {
    FILE="$1"

    if [[ ! -f "$FILE" ]]; then
        wget -O "${FILE}" "${CACHE_SERVER_URL}/$FILE"
        #axel -n 10 -o "${FILE}" "${CACHE_SERVER_URL}/$FILE"
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
download_and_verify jdk-8u25-linux-x64.tar.gz
download_and_verify latest.tar.gz

function change_owner_to_vagrant() {
    if [[ -e $1 ]] && [[ 'vagrant' != "$(stat --format=%U $1)" ]]; then
        chown -R vagrant $1
    fi
}

change_owner_to_vagrant /home/vagrant/.m2
change_owner_to_vagrant /home/vagrant/.gradle

CACHE_TIMESTAMP=cache-201503192105
download_and_verify gradle-${CACHE_TIMESTAMP}.tgz
download_and_verify maven-${CACHE_TIMESTAMP}.tgz

su -lc /bin/bash vagrant <<EOF
  set -e
  cd \$HOME

  if [[ ! -f .gradle/${CACHE_TIMESTAMP} ]]; then
    echo 'Extracting Gradle cache ...'
    tar zxf $CACHE_DIR/gradle-${CACHE_TIMESTAMP}.tgz
  fi

  if [[ ! -f .m2/${CACHE_TIMESTAMP} ]]; then
    echo 'Extracting Maven cache ...'
    tar zxf $CACHE_DIR/maven-${CACHE_TIMESTAMP}.tgz
  fi

EOF
