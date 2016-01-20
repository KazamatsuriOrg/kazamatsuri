dovecot:
  pkg.installed:
    - pkgs:
      - dovecot-core
      - dovecot-pop3d
  service.running:
    - enable: True
    - require:
      - pkg: dovecot

/etc/dovecot/dovecot.conf:
  file.managed:
    - source: salt://dovecot/dovecot.conf
    - require:
      - pkg: dovecot

/etc/dovecot/conf.d:
  file.directory:
    - source: salt://dovecot/conf.d
    - require:
      - pkg: dovecot
