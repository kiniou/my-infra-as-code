{%- set tplroot = tpldir.split('/')[0] %}
{% from tplroot ~ "/map.jinja" import virtualbox with context %}

{% if virtualbox.use_upstream_repo %}
{% set dist = virtualbox.dist or grains.get('oscodename') %}
virtualbox-repo:
  pkgrepo.managed:
    - name: deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian {{ dist | lower }} contrib
    - key_url: https://www.virtualbox.org/download/oracle_vbox_2016.asc
    - file: /etc/apt/sources.list.d/virtualbox.list
    - clean_file: True
    - refresh: True

virtualbox:
  pkg.installed:
    - name: virtualbox-{{ virtualbox.version }}

{% else %}

virtualbox:
  pkg.installed

{% endif %}
