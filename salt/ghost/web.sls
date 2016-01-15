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

/srv/ghost/config.js:
  file.managed:
    - source: salt://ghost/config.js
    - user: ghost
    - group: ghost
    - template: jinja
    - require:
      - cmd: ghost_source
      - user: ghost_user

/srv/ghost:
  cmd.watch:
    - name: npm install --production
    - cwd: /srv/ghost
    - watch:
      - cmd: ghost_source

/srv/ghost/content:
  file.directory:
    - user: ghost
    - group: ghost
    - mode: 775
    - require:
      - cmd: ghost_source

{% for dir in ['data', 'apps', 'themes'] %}
/srv/ghost/content/{{ dir }}:
  {% if not grains.get('vagrant', False) %}
  file.directory:
    - user: ghost
    - group: ghost
    - mode: 775
  {% else %}
  file.symlink:
    - name: /srv/ghost/content/{{ dir }}
    - target: /vagrant/vagrant/srv/ghost/content/{{ dir }}
    - force: True
    - require:
      - file: /vagrant/vagrant/srv/ghost/content/{{ dir }}
  {% endif %}
    - require:
      - file: /srv/ghost/content

{% if grains.get('vagrant', False) %}
/vagrant/vagrant/srv/ghost/content/{{ dir }}:
  file.directory:
    - user: vagrant
    - group: vagrant
{% endif %}

{% endfor %}

/srv/ghost/content/themes/monologue:
  git.latest:
    - name: https://github.com/KazamatsuriOrg/monologue.git
    - target: /srv/ghost/content/themes/monologue
    - require:
      - file: /srv/ghost/content/themes

/srv/ghost/content/storage/ghost-s3/index.js:
  file.managed:
    - contents: |
        'use strict';
        module.exports = require('ghost-s3-storage');
    - makedirs: True

ghost-s3-storage:
  npm.installed:
    - dir: /srv/ghost
    - require:
      - cmd: ghost_source

/etc/systemd/system/ghost.service:
  file.managed:
    - source: salt://ghost/ghost.service
    - require:
      - cmd: /srv/ghost
      - git: /srv/ghost/content/themes/monologue
      - file: /srv/ghost/config.js
      - file: /srv/ghost/content/themes
      - file: /srv/ghost/content/data
      - file: /srv/ghost/content/apps

ghost:
  service.running:
    - enable: True
    - require:
      - file: /etc/systemd/system/ghost.service
      - cmd: /srv/ghost
    - watch:
      - file: /etc/systemd/system/ghost.service
      - file: /srv/ghost/config.js
      - cmd: /srv/ghost
