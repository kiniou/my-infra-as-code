base:
  '*':
    - common
    - packages.common
    - salt.common
    - salt.minion

  'I@roles:salt-masterless':
    - salt.masterless

  'I@roles:desktop':
    - packages.desktop

  'I@roles:dev':
    - packages.dev
    - sbuild
    - unbound
    - docker.io
    - vagrant
    - traefik

  'I@roles:server':
    - firewalld
    - fail2ban
