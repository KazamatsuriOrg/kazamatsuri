mumble-server:
  pkg.installed: []
  service.running:
    - enable: True
    - require:
      - pkg: mumble-server

/etc/mumble-server.ini:
  file.managed:
    - source: salt://murmur/mumble-server.ini
    - template: jinja
    - require:
      - pkg: mumble-server
