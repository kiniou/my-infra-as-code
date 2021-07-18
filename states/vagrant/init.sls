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

vagrant-installed:
  cmd.run:
    - name: |
        echo "changed=yes comment='vagrant does not seems to be installed'"
    - stateful:
        - test_name: echo "changed=yes comment='vagrant does not seems to be installed'"
    - unless:
        - test "$(vagrant --version 2>/dev/null| grep -oE '[0-9.]+')" '=' "{{ vagrant.version }}"
        - /usr/bin/dpkg -l vagrant
        - /usr/bin/which vagrant

vagrant-install:
  cmd.run:
    - name: |
        {{ vagrant.install_cmd | format(vagrant.pkgfile)}}
    - cwd: {{ vagrant.cachedir }}
    - onchanges_any:
        - id: vagrant-installed
        - id: vagrant-download
