unbound:
  enabled: True
  configs:
    00_main: |
      server:
        verbosity: 1
        domain-insecure: "vagrant"
        domain-insecure: "test"
      remote-control:
        control-enable: yes
    10_python: |
      server:
        chroot: ""
        module-config: "python validator iterator"
      python:
        python-script: "/usr/local/share/unbound/resolve.py"
    20_test_zone: |
      server:
        local-zone: "d.test" redirect
        local-data: "d.test. 10 IN CNAME traefik.docker."
  python_scripts:
    - /usr/local/share/unbound/resolve.py: salt://unbound/scripts/resolve.py

apparmor:
  usr.sbin.unbound: |
    /usr/local/lib/python3.7/dist-packages/** lr,
    /tmp/hosts.vagrant lr,
    /usr/local/share/unbound/** lr,
