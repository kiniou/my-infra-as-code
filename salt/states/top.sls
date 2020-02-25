base:
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

  'unbound:*':
    - match: pillar
    - unbound

  'docker:*':
    - match: pillar
    - docker
    - docker.compose

  'traefik:*':
    - match: pillar
    - docker
    - docker.compose
    - traefik

  'vagrant:*':
    - match: pillar
    - vagrant

  'nginx:*':
    - match: pillar
    - nginx

  'firewalld:*':
    - match: pillar
    - firewalld

  'sbuild:*':
    - match: pillar
    - sbuild

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
