base:
  '*':
    - common
    - packages.common

  'roles:desktop':
    - match: pillar
    - packages.desktop

  'roles:dev':
    - match: pillar
    - packages.dev
    - sbuild
    - unbound
    - docker.io
    - vagrant
    - traefik

  'roles:server':
    - match: pillar
    - firewalld
    - fail2ban
