{% from "traefik/map.jinja" import traefik with context %}

{% set traefik_certs_dir = "/etc/traefik/certs" %}
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
          localhost "*.localhost" d.test "*.d.test" 127.0.0.1 ::1
    - creates:
        - {{ traefik_certs_dir }}/localhost.crt
        - {{ traefik_certs_dir }}/localhost.key
    - require:
        - file: {{ traefik_certs_dir }}

