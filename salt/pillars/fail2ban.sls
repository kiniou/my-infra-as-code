fail2ban:
  lookup:
    loglevel: ERROR
    bantime: 600
    maxretry: 3
    backend: auto
  config:
    loglevel: ERROR
  jails:
    DEFAULT:
      ignoreip: 127.0.0.1
      bantime: 600
    ssh:
      action: firewallcmd-ipset
      filter: sshd
      logpath: /var/log/auth.log
      maxretry: 5
      port: ssh
      ignoreip: 127.0.0.1/8
