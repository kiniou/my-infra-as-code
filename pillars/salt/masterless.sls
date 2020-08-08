salt:
  minion:
    standalone: True
    master_type: 'disable'
    file_client: local
    file_roots:
      base:
        - /srv/salt/states
    pillar_roots:
      base:
        - /srv/salt/pillars
    ext_pillar_first: True
    ext_pillar:
      - stack: /srv/salt/stack/top.cfg
      - stack: /srv/salt/stack/fixup.cfg
      - stack: /srv/salt/private/stack.cfg

    top_file_merging_strategy: same

    default_top: base

    pillar_merge_lists: false
