/etc/rsyslog.conf:
  file.managed:
    - source: salt://logging/rsyslog.conf
    - template: jinja

rsyslog:
  service.running:
    - enable: True
    - watch:
      - file: /etc/rsyslog.conf
