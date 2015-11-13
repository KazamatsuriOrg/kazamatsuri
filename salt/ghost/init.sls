ghost_user:
  user.present:
    - name: ghost
    - gid_from_name: True
    - system: True
    - home: /var/lib/ghost

ghost_source:
  file.managed:
    - name: /srv/kazamatsuri.org/apps/ghost-{{ pillar['ghost_version'] }}.zip
    - source: https://ghost.org/zip/ghost-{{ pillar['ghost_version'] }}.zip
    - source_hash: sha1=1a62318a9bbac3a69f34dfb24f2a8e4c577db02a
    - user: ghost
    - require:
      - user: ghost_user
  archive.extracted:
    - name: /srv/kazamatsuri.org/apps/ghost/
    - source: /srv/kazamatsuri.org/apps/ghost-{{ pillar['ghost_version'] }}.zip
    - archive_format: zip
    - user: ghost
    - require:
      - file: ghost_source
      - file: /srv/kazamatsuri.org/apps/
      - user: ghost_user

/srv/kazamatsuri.org/apps/ghost/config.js:
  file.managed:
    - source: salt://ghost/config.js
    - user: ghost
    - require:
      - archive: ghost_source
      - user: ghost_user

/srv/kazamatsuri.org/apps/ghost/:
  npm.bootstrap:
    - user: ghost
    - require:
      - pkg: nodejs
      - archive: ghost_source
      - user: ghost_user
