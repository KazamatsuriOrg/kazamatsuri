postgresql:
  pkg.installed:
    - pkgs:
      - postgresql
      - libpq-dev
  service:
    - running
    - enable: true
    - require:
      - pkg: postgresql
