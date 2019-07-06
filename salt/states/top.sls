base:
  '*':
    - common

  'I@roles:desktop':
    - match: compound
    - common.desktop

  'I@roles:www-dev':
    - match: compound
    - nginx
    - traefik
