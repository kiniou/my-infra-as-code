{% from "traefik/map.jinja" import traefik with context %}
include:
  - docker
  - docker.compose
  - traefik.certs

traefik-etc:
  file.recurse:
    - name: /etc/traefik
    - source: salt://traefik/files
    - clean: true
    - file_mode: keep
    - exclude_pat: "E@(.env.dist)|(.env)|(.git)|(certs)"

traefik-env:
  file.managed:
    - name: /etc/traefik/.env
    - template: jinja
    - contents: |
        COMPOSE_FILE={{ traefik.compose_files | join(':') }}
        NETWORK_NAME={{ traefik.network.name }}
        TRAEFIK_PORT_HTTP={{ traefik.ports.http }}
        TRAEFIK_PORT_HTTPS={{ traefik.ports.https }}
        TRAEFIK_PORT_DASHBOARD={{ traefik.ports.dashboard }}
        PEBBLE_PORT={{ traefik.ports.pebble }}
        PEBBLE_MGMT_PORT={{ traefik.ports.pebble_mgmt }}
    - require:
        - traefik-etc


traefik-service-install:
  file.symlink:
    - name: /etc/systemd/system/traefik.service
    - target: /etc/traefik/traefik.service
    - require:
        - traefik-env

traefik.service:
  service.running:
    - enable: true
    - require:
        - traefik-service-install
    - watch:
        - traefik-etc
        - traefik-env
        - traefik-certs
