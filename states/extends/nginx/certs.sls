{% from "letsencrypt/map.jinja" import letsencrypt with context %}
{% if letsencrypt.domainsets %}
include:
  - nginx

/etc/nginx/ssl/live:
  file.directory:
    - mode: 700
    - user: root
    - group: root
    - require:
        - prepare_certificates_path_dir

{% for setname, domainlist in letsencrypt.domainsets.items() %}
{% set common_name = domainlist[0] %}
/etc/nginx/ssl/live/{{ setname }}:
  file.directory:
    - mode: 700
    - user: root
    - group: root
    - require:
        - /etc/nginx/ssl/live


create certificate for {{ domainlist | join(',') }}:
  cmd.run:
    - name: |
          openssl req -x509 -newkey rsa:4096 -days 365 -nodes \
            -keyout /etc/nginx/ssl/live/{{ setname }}/privkey.pem \
            -out /etc/nginx/ssl/live/{{ setname }}/fullchain.pem \
            -subj '/O=My Infra (temporary self-signed certificate for {{ setname }})/CN={{ common_name }}' \
            -addext "subjectAltName = {{ domainlist | map('regex_replace', '^(.*)$', 'DNS:\\1') | join(',') }}"
    - unless:
        - test -e /etc/nginx/ssl/live/{{ setname }}/fullchain.pem
        - test -e /etc/nginx/ssl/live/{{ setname }}/privkey.pem
    - require:
        - /etc/nginx/ssl/live/{{ setname }}
    - watch_in:
        - nginx_service_reload
{% endfor %}

{% endif %}
