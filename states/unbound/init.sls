{%- set tplroot = tpldir.split('/')[0] %}
{% from tplroot ~ "/map.jinja" import unbound with context %}
{% if unbound.enabled %}
include:
  - .install
  - .python
  - .configs
  - .apparmor
  - .service
{% endif %}
