{% from slspath ~ "/map.jinja" import unbound with context %}
{% if unbound.enabled %}
include:
  - .install
  - .python
  - .configs
  - .apparmor
  - .service
{% endif %}
