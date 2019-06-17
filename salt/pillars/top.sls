base:

  '*':
    - common

  'roles:www-dev':
    - match: pillar
    - nginx.traefik-proxy
