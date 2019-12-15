base:
  '*':
    - packages.common

  'roles:desktop':
    - match: pillar
    - packages.desktop

  'roles:dev':
    - match: pillar
    - packages.dev
    - unbound
    - docker
