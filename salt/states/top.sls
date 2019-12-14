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
    - unbound
    - docker
    - docker.compose
    - vagrant
