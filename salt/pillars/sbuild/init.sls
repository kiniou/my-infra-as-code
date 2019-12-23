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

  chroots:
    sid-amd64:
      vendor: debian
      dist: sid
      arch: amd64
      components:
        - main
        - contrib
        - non-free
      extra_dists:
        - experimental

    buster-amd64:
      vendor: debian
      dist: buster
      arch: amd64
      components:
        - main
        - contrib
        - non-free

    disco-amd64:
      vendor: ubuntu
      dist: disco
      arch: amd64
      components:
        - main
        - restricted
        - universe
        - multiverse

    eoan-amd64:
      vendor: ubuntu
      dist: eoan
      arch: amd64
      components:
        - main
        - restricted
        - universe
        - multiverse
