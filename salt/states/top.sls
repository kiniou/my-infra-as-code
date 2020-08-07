base:
  '*':
    - salt
    - common.env

  'apt:repositories:*':
    - match: pillar
    - apt.repositories

  'apt:preferences:*':
    - match: pillar
    - apt.preferences

  'apt:*':
    - match: pillar
    - common.uptodate

  'packages:*':
    - match: pillar
    - packages

  'packages:golang:*':
    - match: pillar
    - packages.golang

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

  'fail2ban:*':
    - match: pillar
    - fail2ban


  'sbuild:*':
    - match: pillar
    # sbuild is quite long to state.apply so it needs to be called manually with `salt-call state.apply sbuild`
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

  'features:google-chrome':
    - match: pillar
    - chrome
