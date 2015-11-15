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
  cmd.run:
    - name: 'bash -c "mkdir -p ghost; cd ghost; unzip /srv/ghost-{{ pillar['ghost']['version'] }}.zip"'
    - cwd: /srv
    - creates: /srv/ghost/
  # archive.extracted:
  #   - name: /srv/ghost/
  #   - source: /srv/ghost-{{ pillar['ghost']['version'] }}.zip
  #   - archive_format: zip
  #   - require:
  #     - file: ghost_source
  #     - user: ghost_user

/srv/ghost/config.js:
  file.managed:
    - source: salt://ghost/config.js
    - user: ghost
    - group: ghost
    - template: jinja
    - require:
      - cmd: ghost_source
      - user: ghost_user

/srv/ghost/:
  # npm.bootstrap:
  #   - user: ghost
  #   - require:
  #     - pkg: nodejs
  #     - cmd: ghost_source
  #     - user: ghost_user
  cmd.run:
    - name: npm install --production
    - cwd: /srv/ghost/
    - creates: /srv/ghost/node_modules

/srv/ghost/content/themes/monologue/:
  git.latest:
    - name: https://github.com/KazamatsuriOrg/monologue.git
    - target: /srv/ghost/content/themes/monologue
    - require:
      - cmd: ghost_source

/etc/systemd/system/ghost.service:
  file.managed:
    - source: salt://ghost/ghost.service
    - require:
      - npm: /srv/ghost/
      - git: /srv/ghost/content/themes/monologue/
      - file: /srv/ghost/config.js

ghost:
  service.running:
    - enable: True
    - require:
      - file: /etc/systemd/system/ghost.service
      - npm: /srv/ghost/
    - watch:
      - file: /etc/systemd/system/ghost.service
      - file: /srv/ghost/config.js
