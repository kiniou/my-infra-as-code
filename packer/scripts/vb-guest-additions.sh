#!/bin/sh
echo "installing virtualbox guest additions"
sed -i 's/main$/main contrib/' /etc/apt/sources.list
apt-get update

# install virtualbox additions build dependancies
apt-get --yes install --no-install-recommends build-essential linux-headers-amd64

mkdir /tmp/isomount
mount -t iso9660 -o loop /tmp/VBoxGuestAdditions.iso /tmp/isomount

# Install the drivers
/tmp/isomount/VBoxLinuxAdditions.run

# Cleanup
umount /tmp/isomount
rm -rf /tmp/isomount /tmp/VBoxGuestAdditions.iso

# cleanup virtualbox stuff
apt-get --yes remove linux-headers-amd64 build-essential
apt-get --yes autoremove
apt-get --yes clean
