base:
  '*':
    - common

  'I@roles:www-dev':
    - match: compound
    - nginx
    - traefik
