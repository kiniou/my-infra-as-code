{%- set tplroot = tpldir.split('/')[0] %}
{% from tplroot ~ "/map.jinja" import unbound with context %}
{% if unbound.configs %}
include:
  - .service

/etc/unbound/unbound.conf.d:
  file.directory:
    - makedirs: True

{% for config_file,config_data in unbound.configs.items() %}
/etc/unbound/unbound.conf.d/{{ config_file }}.conf:
  file.managed:
    - contents_pillar: unbound:configs:{{ config_file }}
    - require:
        - file: /etc/unbound/unbound.conf.d
    - watch_in:
        - service: unbound.service
{% endfor %}

{% endif %}
