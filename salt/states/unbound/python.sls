{%- set tplroot = tpldir.split('/')[0] %}
{% from tplroot ~ "/map.jinja" import unbound with context %}
{% if unbound.python_scripts %}
include:
  - .install

extend:
  unbound-pkgs:
    pkg.installed:
      - pkgs:
          - python3-unbound


{% for script in unbound.python_scripts %}
{% for script_file, script_source_path in script.items() %}
{% set script_dir = salt.file.dirname(script_file) %}
script_dir_{{loop.index}}:
  file.directory:
    - name: {{ script_dir }}
    - makedirs: True

{{ script_file }}:
  file.managed:
    - source: {{script_source_path}}
    - require:
        - file: script_dir_{{ loop.index }}
{% endfor %}
{% endfor %}
{% endif %}
