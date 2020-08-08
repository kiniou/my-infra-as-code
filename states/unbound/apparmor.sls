include:
  - .service

{% set apparmor_pillar = 'apparmor:usr.sbin.unbound' %}
{% set apparmor = salt['pillar.get'](apparmor_pillar, None) %}
{% set apparmor_activated = salt.cmd.run('aa-enabled')|to_bool%}
{% do salt.log.info("unbound.apparmor: apparmor_activated=%s" % apparmor_activated) %}
{% if apparmor is not none and apparmor_activated %}
unbound-set-apparmor:
  file.managed:
    - name: /etc/apparmor.d/local/usr.sbin.unbound
    - onlyif: test -d /etc/apparmor.d/local
    - makedirs: true
    - contents_pillar: {{ apparmor_pillar }}

unbound-reload-apparmor:
  service.running:
    - name: apparmor
    - reload: true
    - force: true
    - watch:
        - unbound-set-apparmor
    - require_in:
        - service: unbound.service
{% endif %}
