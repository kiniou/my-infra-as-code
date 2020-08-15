{% from "letsencrypt/map.jinja" import letsencrypt with context %}
{% if letsencrypt.domainsets %}
include:
  - nginx.servers
  - letsencrypt

{% for setname, domainlist in letsencrypt.domainsets.items() %}
{% set common_name = domainlist[0] %}

symlink letsencrypt certificate for {{ domainlist | join(',') }}:
  file.symlink:
    - name: /etc/nginx/ssl/live/{{ setname }}/fullchain.pem
    - target: /etc/letsencrypt/live/{{ setname }}/fullchain.pem
    - force: True
    - require:
        - create-initial-cert-{{ setname }}-{{ domainlist | join('+') }}
        - create-fullchain-privkey-pem-for-{{ setname }}
    - onchanges:
        - create-initial-cert-{{ setname }}-{{ domainlist | join('+') }}
    - watch_in:
        - nginx_service_reload

symlink letsencrypt private key for {{ domainlist | join(',') }}:
  file.symlink:
    - name: /etc/nginx/ssl/live/{{ setname }}/privkey.pem
    - target: /etc/letsencrypt/live/{{ setname }}/privkey.pem
    - force: True
    - require:
        - create-initial-cert-{{ setname }}-{{ domainlist | join('+') }}
        - create-fullchain-privkey-pem-for-{{ setname }}
    - onchanges:
        - create-initial-cert-{{ setname }}-{{ domainlist | join('+') }}
    - watch_in:
        - nginx_service_reload
{% endfor %}

{% endif %}
