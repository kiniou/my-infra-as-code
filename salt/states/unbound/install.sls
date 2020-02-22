{%- set tplroot = tpldir.split('/')[0] %}
{% from tplroot ~ "/map.jinja" import unbound with context %}
unbound-pkgs:
  pkg.installed:
    - pkgs:
        - unbound
