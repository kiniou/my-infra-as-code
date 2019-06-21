nginx:
  install_from_repo: false
  lookup:
    package: nginx-extras
  service:
    enable: True
  server:
    config:
      include: /etc/nginx/modules-enabled/*
      stream:
        server:
          listen: '443'
          proxy_pass: traefik.localhost:8443

  servers:
    managed:
      default:
        enabled: False
      traefik-proxy:
        enabled: True
        config:
          - server:
              - server_name: "*.ods.localhost *.docker.localhost"
              - listen:
                  - '80'
              - location /:
                  - proxy_pass: http://localhost:8000
                  - proxy_set_header: Host $host
      traefik-dashboard:
        enabled: True
        config:
          - server:
              - server_name: traefik.localhost
              - listen:
                  - '80'
              # Need some trusted ssl certificate before continuing
              # - listen:
              #     - '443 ssl'
              - location /:
                  - return: 301 /dashboard
              - location /dashboard/:
                  - proxy_pass: http://localhost:8080/dashboard/
                  - proxy_set_header: Host $host
              - location /api/:
                  - proxy_pass: http://localhost:8080/api/
                  - proxy_set_header: Host $host
