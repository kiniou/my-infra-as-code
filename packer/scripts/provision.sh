#!/bin/sh
set -e

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
mkdir -p /etc/systemd/resolved.conf.d
cat <<EOF> /etc/systemd/resolved.conf.d/custom.conf
[Resolve]
# Use LLMNR to discover neighborhood
LLMNR=yes
# Only make systemd-resolve dns stub (127.0.0.53) listen on udp
DNSStubListener=udp
EOF
systemctl enable --now systemd-resolved
ln -nsf /lib/systemd/resolv.conf /etc/resolv.conf

cat <<EOF> /etc/systemd/network/00-ethX.network
[Match]
Name=eth*

[Network]
DHCP=yes

# disable link local 169.* addresses (this adds another resolution with LLMNR)
LinkLocalAddressing=no

# don't accept ipv6 router advertisement
IPv6AcceptRA=no
EOF
systemctl enable systemd-networkd

# Workaround-ing vagrant trying to restart EVERY network interfaces (even docker
# ones) it can found on the guest with legacy ifupdown commands 😬 (networking
# does not need to be complicated so we just replace it with simple
# systemd-networkd)
echo "Removing legacy ifupdown"
(
    systemctl mask networking.service
)

