/srv/kazamatsuri.org/apps/ghost-{{ pillar['ghost_version'] }}.zip:
  file.managed:
    - source: https://ghost.org/zip/ghost-{{ pillar['ghost_version'] }}.zip
    - source_hash: sha1=1a62318a9bbac3a69f34dfb24f2a8e4c577db02a
    - user: www-data
  archive.extracted:
    - name: /srv/kazamatsuri.org/apps/ghost/
    - source: /srv/kazamatsuri.org/apps/ghost-{{ pillar['ghost_version'] }}.zip
    - archive_format: zip
    - user: www-data
    - require:
      - file: /srv/kazamatsuri.org/apps/ghost-{{ pillar['ghost_version'] }}.zip
      - file: /srv/kazamatsuri.org/apps/

/srv/kazamatsuri.org/apps/ghost/config.js:
  file.managed:
    - source: salt://ghost/config.js
    - require:
      - archive: /srv/kazamatsuri.org/apps/ghost
