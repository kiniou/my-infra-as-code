include:
  - docker

docker:
  use_upstream_repo: true

  repo:
    version: disco

  pkgs:
    - containerd
  pkg:
    name: docker-ce
    allow_updates: true
