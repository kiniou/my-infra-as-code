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

  'I@roles:dev':
    - match: compound
    - unbound
    - docker
    - docker.compose
    - vagrant
