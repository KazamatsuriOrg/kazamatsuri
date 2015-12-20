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
    - source_hash: sha1={{ pillar['ghost']['zip_sha1']}}
    - user: ghost
    - require:
      - user: ghost_user
  cmd.watch:
    - name: 'bash -c "mkdir -p ghost; cd ghost; rm -rf core node_modules; unzip -o /srv/ghost-{{ pillar['ghost']['version'] }}.zip"'
    - cwd: /srv
    - watch:
      - file: ghost_source
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
  cmd.watch:
    - name: npm install --production
    - cwd: /srv/ghost/
    - watch:
      - cmd: ghost_source

/srv/ghost/content/:
  {% if grains.get('vagrant', False) %}
  file.symlink:
    - name: /srv/ghost/content
    - target: /vagrant/vagrant/srv/ghost/content
    - force: True
  {% else %}
  file.directory:
    - user: ghost
    - group: ghost
  {% endif %}
    - mode: 775
    - require:
      - cmd: ghost_source

/srv/ghost/content/data/:
  file.directory:
    {% if not grains.get('vagrant', False) %}
    - user: ghost
    - group: ghost
    {% endif %}
    - mode: 775
    - require:
      - file: /srv/ghost/content/

/srv/ghost/content/apps/:
  file.directory:
    {% if not grains.get('vagrant', False) %}
    - user: ghost
    - group: ghost
    {% endif %}
    - mode: 775
    - require:
      - file: /srv/ghost/content/

/srv/ghost/content/themes/:
  file.directory:
    {% if not grains.get('vagrant', False) %}
    - user: ghost
    - group: ghost
    {% endif %}
    - mode: 775
    - require:
      - file: /srv/ghost/content/

/srv/ghost/content/themes/monologue/:
  git.latest:
    - name: https://github.com/KazamatsuriOrg/monologue.git
    - target: /srv/ghost/content/themes/monologue
    - require:
      - file: /srv/ghost/content/themes/

/etc/systemd/system/ghost.service:
  file.managed:
    - source: salt://ghost/ghost.service
    - require:
      - cmd: /srv/ghost/
      - git: /srv/ghost/content/themes/monologue/
      - file: /srv/ghost/config.js
      - file: /srv/ghost/content/themes/
      - file: /srv/ghost/content/data/
      - file: /srv/ghost/content/apps/

ghost:
  service.running:
    - enable: True
    - require:
      - file: /etc/systemd/system/ghost.service
      - cmd: /srv/ghost/
    - watch:
      - file: /etc/systemd/system/ghost.service
      - file: /srv/ghost/config.js
      - cmd: /srv/ghost/
