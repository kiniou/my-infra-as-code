#!/bin/sh
set -xe

apt-get update
apt-get install locales
echo "locales locales/locales_to_be_generated multiselect en_US.UTF-8 UTF-8" | debconf-set-selections
echo "locales locales/default_environment_locale select en_US.UTF-8" | debconf-set-selections
rm -f /etc/locale.gen
dpkg-reconfigure --frontend=noninteractive locales

echo "Activating systemd-resolved"
# This service is usefull to resolve the special gateway hostname in order to
# use services on the host
apt-get install -y libnss-resolve
systemctl enable --now systemd-resolved

# Workaround-ing vagrant trying to restart EVERY network interfaces (even docker
# ones) it can found on the guest with legacy ifupdown commands 😬 (networking
# does not need to be complicated so we just replace it with simple
# systemd-networkd)
echo "Removing legacy ifupdown"
(
    dpkg-query -f '${Status}:${Package}\n' -W ifupdown | grep -vF "not-installed"
) && apt-get purge -y ifupdown

cat <<EOF> /etc/systemd/network/ethX.network
[Match]
Name=eth*

[Network]
DHCP=yes
EOF
systemctl enable --now systemd-networkd

# autosign every vagrant minion
mkdir -p /etc/salt/
cat <<EOF> /etc/salt/autosign_file
# match everything
*
EOF
chmod u=rw,g=,o= /etc/salt/autosign_file
