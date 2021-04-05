{%- set tplroot = tpldir.split('/')[0] %}
{% from tplroot ~ "/map.jinja" import packer with context %}


{{ packer.cachedir }}:
  file.directory

{{ packer.cachedir }}/{{ packer.sha256sums_file}}:
  cmd.run:
    - name: |
        curl -sSL -o {{packer.sha256sums_file }} {{ packer.sha256sums_url }}
    - cwd: {{ packer.cachedir }}
    - creates:
        - {{ packer.cachedir }}/{{ packer.sha256sums_file }}
    - require:
        - file: {{ packer.cachedir }}

packer-download:
  cmd.run:
    - name: |
        curl -sSL -o {{ packer.pkgfile }} {{ packer.url }} && sha256sum --ignore-missing -c {{ packer.sha256sums_file }}
    - cwd: {{ packer.cachedir }}
    - unless:
        - cd {{ packer.cachedir }} && test -f {{ packer.pkgfile }}
        - cd {{ packer.cachedir }} && sha256sum --ignore-missing -c {{ packer.sha256sums_file }}
    - require:
        - id: {{ packer.cachedir }}/{{ packer.sha256sums_file }}
        - file: {{ packer.cachedir }}


packer-install:
  cmd.run:
    - name: |
        unzip -o {{ packer.pkgfile }} packer -d /usr/local/bin
    - cwd: {{ packer.cachedir }}
    - onchanges:
        - id: packer-download
