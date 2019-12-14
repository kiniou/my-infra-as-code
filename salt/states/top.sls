base:
  '*':
    - common
    - salt.minion

  'I@roles:desktop':
    - match: compound
    - common.desktop

  'I@roles:dev':
    - match: compound
    - salt.standalone
    - docker
    - docker.compose
    - vagrant
