base:
  '*':
    - common

  'roles:dev':
    - match: pillar
    - docker.base
