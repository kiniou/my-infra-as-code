base:
  '*':
    - common

  'I@roles:desktop':
    - match: compound
    - common.desktop

  'I@roles:dev':
    - match: compound
    - docker
    - vagrant
