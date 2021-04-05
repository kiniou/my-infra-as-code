{%- set tplroot = tpldir.split('/')[0] %}
{% from tplroot ~ "/map.jinja" import terraform with context %}


{{ terraform.cachedir }}:
  file.directory

{{ terraform.cachedir }}/{{ terraform.sha256sums_file}}:
  cmd.run:
    - name: |
        curl -sSL -o {{terraform.sha256sums_file }} {{ terraform.sha256sums_url }}
    - cwd: {{ terraform.cachedir }}
    - creates:
        - {{ terraform.cachedir }}/{{ terraform.sha256sums_file }}
    - require:
        - file: {{ terraform.cachedir }}

terraform-download:
  cmd.run:
    - name: |
        curl -sSL -o {{ terraform.pkgfile }} {{ terraform.url }} && sha256sum --ignore-missing -c {{ terraform.sha256sums_file }}
    - cwd: {{ terraform.cachedir }}
    - unless:
        - cd {{ terraform.cachedir }} && test -f {{ terraform.pkgfile }}
        - cd {{ terraform.cachedir }} && sha256sum --ignore-missing -c {{ terraform.sha256sums_file }}
    - require:
        - id: {{ terraform.cachedir }}/{{ terraform.sha256sums_file }}
        - file: {{ terraform.cachedir }}


terraform-install:
  cmd.run:
    - name: |
        unzip -o {{ terraform.pkgfile }} terraform -d /usr/local/bin
    - cwd: {{ terraform.cachedir }}
    - onchanges:
        - id: terraform-download
