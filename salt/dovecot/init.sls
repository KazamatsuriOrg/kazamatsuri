dovecot:
  pkg.installed:
    - pkgs:
      - dovecot-core
      - dovecot-pop3d
  service.running:
    - enable: True
    - require:
      - pkg: dovecot
    - watch:
      - file: /etc/dovecot/dovecot.conf
      - file: /etc/dovecot/conf.d

/etc/dovecot/dovecot.conf:
  file.managed:
    - source: salt://dovecot/dovecot.conf
    - require:
      - pkg: dovecot

/etc/dovecot/conf.d:
  file.recurse:
    - source: salt://dovecot/conf.d
    - require:
      - pkg: dovecot
