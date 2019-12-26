base:
  'packages:*':
    - match: pillar
    - packages

  'packages:golang:*':
    - match: pillar
    - packages.golang

  'not I@salt:minion:standalone':
    - match: compound
    - salt.minion

  'I@salt:minion:standalone':
    - match: compound
    - salt.standalone

  'unbound:*':
    - match: pillar
    - unbound

  'docker:*':
    - match: pillar
    - docker
    - docker.compose

  'vagrant:*':
    - match: pillar
    - vagrant

  'nginx:*':
    - match: pillar
    - nginx

  'firewalld:*':
    - match: pillar
    - firewalld

  'debootstrap:*':
    - match: pillar
    - debootstrap

  'systemd-sleep:*':
    - match: pillar
    - systemd-sleep
