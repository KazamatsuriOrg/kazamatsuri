/etc/postgresql/9.4/main/pg_hba.conf:
  file.managed:
    - source: salt://postgresql/pg_hba.conf
    - user: postgres
    - group: postgres
    - mode: 640
    - require:
      - pkg: postgresql

/etc/postgresql/9.4/main/postgresql.conf:
  file.managed:
    - source: salt://postgresql/postgresql.conf
    - user: postgres
    - group: postgres
    - mode: 644
    - require:
      - pkg: postgresql

/etc/security/limits.d/postgresql.conf:
  file.managed:
    - source: salt://postgresql/limits.conf

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
      - file: /etc/security/limits.d/postgresql.conf

vm.swappiness:
  sysctl.present:
    - value: 0

fs.file-max:
  sysctl.present:
    - value: 65535
