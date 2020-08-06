base:
  '*':
    - common.env
    - common.repo
    - common.pkgs

  'apt:preferences:*':
    - match: pillar
    - apt.preferences
    - common.uptodate

  'packages:*':
    - match: pillar
    - packages

  'packages:golang:*':
    - match: pillar
    - packages.golang

  'not I@salt:minion:standalone':
    - match: compound
    - salt.pkgrepo
    - salt.minion

  'I@salt:minion:standalone':
    - match: compound
    - salt.pkgrepo
    - salt.standalone

  'features:unbound':
    - match: pillar
    - unbound

  'docker:*':
    - match: pillar
    - docker
    - docker.compose

  'features:traefik':
    - match: pillar
    - traefik

  'features:vagrant':
    - match: pillar
    - vagrant

  'features:virtualbox':
    - match: pillar
    - virtualbox

  'features:packer':
    - match: pillar
    - packer

  'nginx:*':
    - match: pillar
    - nginx

  'firewalld:*':
    - match: pillar
    - firewalld

  'sbuild:*':
    - match: pillar
    # sbuild is quite long to state.apply so it needs to be called manually
    - sbuild.prereq

  'systemd-sleep:*':
    - match: pillar
    - systemd-sleep

  'apache:*':
    - match: pillar
    - apache
    - apache.config

  'letsencrypt:*':
    - match: pillar
    - letsencrypt

  'fail2ban:*':
    - match: pillar
    - fail2ban

  'features:google-chrome':
    - match: pillar
    - chrome
