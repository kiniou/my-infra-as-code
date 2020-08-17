#!/bin/bash

set -e
set -x

export DEBCONF_FRONTEND=noninteractive

cat > /etc/apt/sources.list <<-EOF
deb http://deb.debian.org/debian unstable main contrib non-free
EOF

apt-get update
apt-get --yes upgrade
apt-get --yes dist-upgrade
apt-get --yes autoremove
apt-get --yes clean
reboot
