ghost_user:
  user.present:
    - name: ghost
    - gid_from_name: True
    - system: True
    - home: /var/lib/ghost

ghost_source:
  file.managed:
    - name: /srv/ghost-{{ pillar['ghost']['version'] }}.zip
    - source: https://ghost.org/zip/ghost-{{ pillar['ghost']['version'] }}.zip
    - source_hash: sha1=1a62318a9bbac3a69f34dfb24f2a8e4c577db02a
    - user: ghost
    - require:
      - user: ghost_user
  archive.extracted:
    - name: /srv/ghost/
    - source: /srv/ghost-{{ pillar['ghost']['version'] }}.zip
    - archive_format: zip
    - user: ghost
    - require:
      - file: ghost_source
      - user: ghost_user

/srv/ghost/config.js:
  file.managed:
    - source: salt://ghost/config.js
    - user: ghost
    - group: ghost
    - template: jinja
    - require:
      - archive: ghost_source
      - user: ghost_user

/srv/ghost/:
  npm.bootstrap:
    - user: ghost
    - require:
      - pkg: nodejs
      - archive: ghost_source
      - user: ghost_user

/etc/systemd/system/ghost.service:
  file.managed:
    - source: salt://ghost/ghost.service

ghost:
  service.running:
    - enable: True
    - require:
      - file: /etc/systemd/system/ghost.service
      - npm: /srv/ghost/
    - watch:
      - file: /etc/systemd/system/ghost.service
      - file: /srv/ghost/config.js