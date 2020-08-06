packages-up-to-date:
  pkg.latest:
    - refresh: True
    - pkgs: {{ pillar.get('uptodate', {}).get('pkgs', None) | json}}
