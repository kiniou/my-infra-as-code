base:
  '*':
    - salt
    - common.env

  'files:*':
    - match: pillar
    - files

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

  'nginx:*':
    - match: pillar
    - extends.nginx.certs
    - nginx

  'letsencrypt:*':
    - match: pillar
    - letsencrypt.install
    - letsencrypt.config
    - letsencrypt.service

  'docker:*':
    - match: pillar
    - docker
    - docker.compose

  'I@docker-containers:*':
    - docker.containers

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

  'features:google-chrome':
    - match: pillar
    - chrome

manual:
  'I@letsencrypt:*':
    - letsencrypt.domains
    - extends.letsencrypt.nginx
