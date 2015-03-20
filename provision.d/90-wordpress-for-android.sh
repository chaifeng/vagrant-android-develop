#!/bin/bash
set -e

echo 'Configure WordPress for Android project ...'
su -lc /bin/bash vagrant <<EOF
  set -ex
  cd \$HOME/src/WordPress-Android
  if [[ -e .git ]] && [[ -f WordPress/gradle.properties-example ]]; then
    [[ -f WordPress/gradle.properties ]] || cp -f WordPress/gradle.properties-example WordPress/gradle.properties
    [[ -f local.properties ]] || echo "sdk.dir=\$ANDROID_HOME" > local.properties
  else
    echo "You maybe forgot to execute the below command:"
    echo "    git submodule update --init --recursive"
    exit 1
  fi
EOF
