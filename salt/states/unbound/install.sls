{% from slspath ~ "/map.jinja" import unbound with context %}
unbound-pkgs:
  pkg.installed:
    - pkgs:
        - unbound
