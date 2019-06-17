#!/bin/sh
set -e

CHANGEDIR="/vagrant/tools/vagrant"

apt-get update
apt-get install locales
echo "locales locales/locales_to_be_generated multiselect en_US.UTF-8 UTF-8" | debconf-set-selections
echo "locales locales/default_environment_locale select en_US.UTF-8" | debconf-set-selections
rm -f /etc/locale.gen
dpkg-reconfigure --frontend=noninteractive locales

echo "Disable salt-minion service"
systemctl disable --now salt-minion.service

echo "Provisioning .bash_profile"
touch /home/vagrant/.bash_profile
sed -i -e '\:^cd ${CHANGEDIR}:d' /home/vagrant/.bash_profile && \
    echo "cd ${CHANGEDIR}" >> /home/vagrant/.bash_profile

echo "Provisioning .bashrc"
touch /home/vagrant/.bashrc
sed -i -e '\:^cd ${CHANGEDIR}:d' /home/vagrant/.bashrc && \
    echo "cd ${CHANGEDIR}" >> /home/vagrant/.bashrc

echo "Create some directories"
mkdir -p /srv/private
