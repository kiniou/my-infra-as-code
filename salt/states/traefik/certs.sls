{% from "traefik/map.jinja" import traefik with context %}

{% set traefik_certs_dir = "/etc/traefik/certs" %}
{% set traefik_certs_subjects = traefik.certs | map('quote') | join(' ') %}

{{ traefik_certs_dir }}:
  file.directory:
    - makedirs: True

traefik-certs:
  cmd.run:
    - unless:
        - test -f {{ traefik_certs_dir }}/localhost.crt
        - test -f {{ traefik_certs_dir }}/localhost.key
        {% for dns in traefik.certs %}
        - openssl x509 -in {{ traefik_certs_dir }}/localhost.crt -text | grep -woE "(IP Address|DNS):{{ dns | regex_replace('([.*])', '\\\\\\1') }}"
        {% endfor %}
    - env:
        - CAROOT: {{ traefik_certs_dir }}
    - name: |
        mkcert \
          -cert-file {{ traefik_certs_dir }}/localhost.crt \
          -key-file  {{ traefik_certs_dir }}/localhost.key \
          {{ traefik_certs_subjects }}
    - require:
        - file: {{ traefik_certs_dir }}

