{% if pillar.get("repos") %}

/etc/apt/sources.list:
  file.managed:
    - source: salt://common/files/{{ grains['os'] | lower }}.list
    - template: jinja

{% endif %}

