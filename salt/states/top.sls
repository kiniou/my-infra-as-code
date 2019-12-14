base:
  '*':
    - common

  'not I@salt:minion:standalone':
    - match: compound
    - salt.minion

  'I@salt:minion:standalone':
    - match: compound
    - salt.standalone

  'I@roles:desktop':
    - match: compound
    - common.desktop

  'I@roles:dev':
    - match: compound
    - unbound
    - docker
    - docker.compose
    - vagrant
