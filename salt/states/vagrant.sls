{% if "vagrant" in pillar.get("features", []) %}
virtualbox-repo:
  pkgrepo.managed:
    - name: deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian {{ grains['oscodename'] | lower }} contrib
    - key_url: https://www.virtualbox.org/download/oracle_vbox_2016.asc
    - file: /etc/apt/sources.list.d/virtualbox.list
    - clean_file: True
    - refresh: True

vagrant-deps:
  pkg.installed:
    - pkgs:
        - vagrant
        - packer
        - virtualbox-6.0
{% endif %}
