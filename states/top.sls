base:
  '*':
    - salt
    - common.env

  'files:*':
    - match: pillar
    - files

  # Packaging setup
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

  # Security components configuration
  'firewalld:*':
    - match: pillar
    - firewalld

  'fail2ban:*':
    - match: pillar
    - fail2ban

  # Background services configuration
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

  # Tooling install and configuration
  'features:vagrant':
    - match: pillar
    - vagrant

  'features:virtualbox':
    - match: pillar
    - virtualbox

  'features:packer':
    - match: pillar
    - packer

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
