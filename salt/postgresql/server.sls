/etc/postgresql/9.4/main/pg_hba.conf:
  file.managed:
    - source: salt://postgresql/pg_hba.conf
    - user: postgres
    - group: postgres
    - mode: 640

/etc/postgresql/9.4/main/postgresql.conf:
  file.managed:
    - source: salt://postgresql/postgresql.conf
    - user: postgres
    - group: postgres
    - mode: 644

postgresql:
  pkg.installed:
    - pkgs:
      - postgresql-9.4
      - libpq-dev
  service:
    - running
    - enable: true
    - require:
      - pkg: postgresql
    - watch:
      - file: /etc/postgresql/9.4/main/postgresql.conf
      - file: /etc/postgresql/9.4/main/pg_hba.conf
