{%- set tplroot = tpldir.split('/')[0] %}
{% from tplroot ~ "/map.jinja" import vagrant with context %}


{{ vagrant.cachedir }}:
  file.directory

{{ vagrant.cachedir }}/{{ vagrant.sha256sums_file}}:
  cmd.run:
    - name: |
        curl -sSL -o {{vagrant.sha256sums_file }} {{ vagrant.sha256sums_url }}
    - cwd: {{ vagrant.cachedir }}
    - creates:
        - {{ vagrant.cachedir }}/{{ vagrant.sha256sums_file }}
    - require:
        - file: {{ vagrant.cachedir }}

vagrant-download:
  cmd.run:
    - name: |
        curl -sSL -o {{ vagrant.pkgfile }} {{ vagrant.url }} && sha256sum --ignore-missing -c {{ vagrant.sha256sums_file }}
    - cwd: {{ vagrant.cachedir }}
    - unless:
        - cd {{ vagrant.cachedir }} && test -f {{ vagrant.pkgfile }}
        - cd {{ vagrant.cachedir }} && sha256sum --ignore-missing -c {{ vagrant.sha256sums_file }}
    - require:
        - id: {{ vagrant.cachedir }}/{{ vagrant.sha256sums_file }}
        - file: {{ vagrant.cachedir }}

vagrant-install:
  cmd.run:
    - name: |
        {{ vagrant.install_cmd | format(vagrant.pkgfile)}}
    - cwd: {{ vagrant.cachedir }}
    - onchanges:
        - id: vagrant-download
