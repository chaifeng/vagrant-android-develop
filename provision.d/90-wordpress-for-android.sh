#!/bin/bash
set -e

echo 'Configure WordPress for Android project ...'
su -lc /bin/bash vagrant <<EOF
  set -e
  WORDPRESS_ANDROID_DIR=\$HOME/src/WordPress-Android
  if [[ -d \$WORDPRESS_ANDROID_DIR/.git ]] && [[ -f \$WORDPRESS_ANDROID_DIR/WordPress/gradle.properties-example ]]; then
    [[ -f \$WORDPRESS_ANDROID_DIR/WordPress/gradle.properties ]] || cp -f \$WORDPRESS_ANDROID_DIR/WordPress/gradle.properties-example \$WORDPRESS_ANDROID_DIR/WordPress/gradle.properties
    [[ -f \$WORDPRESS_ANDROID_DIR/local.properties ]] || echo "sdk.dir=\$ANDROID_HOME" > \$WORDPRESS_ANDROID_DIR/local.properties
  fi
EOF
