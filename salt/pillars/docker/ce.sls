include:
  - docker

docker:
  use_upstream_repo: true

  {% if grains['os'] == 'Ubuntu' %}
  repo:
    version: disco
  {% endif %}

  pkg:
    name: docker-ce
    allow_updates: true
