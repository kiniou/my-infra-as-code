{% set variables = salt['pillar.get']("environment",[]) %}

/etc/environment:
  file.managed:
    - contents: |
        {%- for variable in variables %}
        {{ variable | indent(width=8) }}
        {%- endfor -%}
