docker:
  install_pypi_pip: false
  install_docker_py: true
  use_upstream_repo: false

  pkgs:
    - containerd
  pkg:
    name: docker.io
    allow_updates: true

  daemon_config:
    init: true
    live-restore: true

  compose_version: '1.25.2'
