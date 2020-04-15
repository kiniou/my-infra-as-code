common-pkgs:
  pkg.latest:
    - fromrepo: {{grains['oscodename']}}-backports
    - pkgs:
        - golang-go
