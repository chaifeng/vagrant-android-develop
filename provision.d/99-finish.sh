#!/bin/bash
set -e

date > /.vagrant-shell-provision.DONE
cat <<EOF

  ___                        _        _      _   _             _
 / __|___ _ _  __ _ _ _ __ _| |_ _  _| |__ _| |_(_)___ _ _  __| |
| (__/ _ \ ' \/ _\` | '_/ _\` |  _| || | / _\` |  _| / _ \ ' \(_-<_|
 \___\___/_||_\__, |_| \__,_|\__|\_,_|_\__,_|\__|_\___/_||_/__(_)
              |___/

Congratulations, the VM is ready!

EOF
