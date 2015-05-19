#!/bin/bash
set -e

rm -f /.vagrant-shell-provision.DONE

cat > /etc/profile.d/00-default_vagrant.sh <<EOF
export VAGRANT_PROJECT_NAME="Android Development"
EOF
