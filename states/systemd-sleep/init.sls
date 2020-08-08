{% set systemd_sleep = pillar.get('systemd-sleep', []) %}
{% if systemd_sleep %}
/lib/systemd/system-sleep:
  file.directory

{% for script in pillar.get('systemd-sleep', []) %}
{{ script }}:
  file.managed:
    - name: /lib/systemd/system-sleep/{{script}}
    - mode: 755
    - source: salt://systemd-sleep/scripts/{{script}}
    - require:
        - file: /lib/systemd/system-sleep
{% endfor %}
{% endif %}
