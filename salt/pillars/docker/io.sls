include:
  - docker

docker:
  use_upstream_repo: false
  pkgs:
    - containerd
  pkg:
    name: docker.io
    allow_updates: true

