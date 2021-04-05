packages-up-to-date:
  pkg.uptodate:
    - refresh: True
    - pkgs: {{ pillar.get('uptodate', {}).get('pkgs', None) | json}}
