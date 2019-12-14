docker:
  install_pypi_pip: false
  install_docker_py: true

  daemon_config:
    init: true
    live-restore: true
    # debug: true

  compose_version: '1.25.0'
  pkg:
    allow_updates: true

