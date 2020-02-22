{%- set tplroot = tpldir.split('/')[0] %}
{% from tplroot ~ "/map.jinja" import unbound with context %}
{% if unbound.enabled %}
unbound.service:
  service.running:
    - reload: true
{% endif %}
