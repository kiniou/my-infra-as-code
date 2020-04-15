{% from "traefik/map.jinja" import traefik with context %}

{% set traefik_certs_dir = "/etc/traefik/certs" %}
{% set traefik_certs_subjects = traefik.certs | map('quote') | join(' ') %}
{{ traefik_certs_dir }}:
  file.directory:
    - makedirs: True

traefik-certs:
  cmd.run:
    - unless: "test -f {{ traefik_certs_dir }}/localhost.crt"
    - env:
        - CAROOT: {{ traefik_certs_dir }}
    - name: |
        mkcert \
          -cert-file {{ traefik_certs_dir }}/localhost.crt \
          -key-file  {{ traefik_certs_dir }}/localhost.key \
          {{ traefik_certs_subjects }}
    - creates:
        - {{ traefik_certs_dir }}/localhost.crt
        - {{ traefik_certs_dir }}/localhost.key
    - require:
        - file: {{ traefik_certs_dir }}

