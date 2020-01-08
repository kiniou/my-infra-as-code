debootstrap:
  basedir: /var/lib/schroot
  vendor:
    debian:
      repositories:
        default: http://deb.debian.org/debian
        security: http://security.debian.org

    ubuntu:
      repositories:
        default: http://archive.ubuntu.com/ubuntu

sbuild:
  basedir: /var/lib/schroot
  chroots:
    sid:
      vendor: debian
      dist: sid
      architectures:
        - amd64
      components:
        - main
        - contrib
        - non-free
      extra_dists:
        - experimental

    stretch:
      vendor: debian
      dist: stretch
      architectures:
        - amd64
      components:
        - main
        - contrib
        - non-free

    buster:
      vendor: debian
      dist: buster
      architectures:
        - amd64
      components:
        - main
        - contrib
        - non-free

    disco:
      vendor: ubuntu
      dist: disco
      architectures:
        - amd64
      components:
        - main
        - restricted
        - universe
        - multiverse

    eoan:
      vendor: ubuntu
      dist: eoan
      architectures:
        - amd64
      components:
        - main
        - restricted
        - universe
        - multiverse
