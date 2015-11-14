haproxy:
  pkg.installed:
    - name: haproxy
  service.running:
    - enable: True
    - require:
      - pkg: haproxy
    - watch:
      - file: /etc/haproxy/haproxy.cfg

/etc/haproxy/haproxy.cfg:
  file.managed:
    - source: salt://haproxy/haproxy.cfg
    - template: jinja
    - require:
      - pkg: haproxy
