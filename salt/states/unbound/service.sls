{% from slspath ~ "/map.jinja" import unbound with context %}
{% if unbound.enabled %}
unbound.service:
  service.running:
    - reload: true
{% endif %}
