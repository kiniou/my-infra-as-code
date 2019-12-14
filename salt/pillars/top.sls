base:
  '*':
    - common

  'roles:dev':
    - match: pillar
    - unbound
    - docker.base
