ghost:
  user.present:
    - gid_from_name: True
    - system: True
    - home: /var/lib/ghost
  service.running:
    - enable: True
    - require:
      - file: /etc/systemd/system/ghost.service
      - git: /srv/ghost
      - npm: /srv/ghost
      - cmd: /srv/ghost
      - git: /srv/ghost/content/themes/monologue
      - file: /srv/ghost/content/storage/ghost-s3/index.js
    - watch:
      - file: /etc/systemd/system/ghost.service
      - git: /srv/ghost
      - npm: /srv/ghost
      - cmd: /srv/ghost
      - git: /srv/ghost/content/themes/monologue
      - file: /srv/ghost/config.js

/srv/ghost:
  git.latest:
    - name: https://github.com/TryGhost/Ghost.git
    - target: /srv/ghost
    - branch: stable
    - rev: {{ pillar['ghost']['version'] }}
    - force_clone: True
  cmd.wait:
    - name: |
        git clean -ffdx core
        rm -rf node_modules
        npm install --no-optional
        grunt init
        grunt prod
    - cwd: /srv/ghost
    - require:
      - npm: grunt-cli
    - watch:
      - git: /srv/ghost
  npm.installed:
    - pkgs:
      - ghost-s3-storage
      - pg
    - dir: /srv/ghost
    - require:
      - git: /srv/ghost

/srv/ghost/config.js:
  file.managed:
    - source: salt://ghost/config.js
    - template: jinja
    - require:
      - git: /srv/ghost



/srv/ghost/content:
  file.directory:
    - force: True
    - require:
      - git: /srv/ghost

/srv/ghost/content/storage/ghost-s3/index.js:
  file.managed:
    - contents: |
        'use strict';
        module.exports = require('ghost-s3-storage');
    - makedirs: True
    - require:
      - file: /srv/ghost/content

/srv/ghost/content/themes/monologue:
  git.latest:
    - name: https://github.com/KazamatsuriOrg/monologue.git
    - target: /srv/ghost/content/themes/monologue
    - require:
      - file: /srv/ghost/content

/etc/systemd/system/ghost.service:
  file.managed:
    - source: salt://ghost/ghost.service



{% for dir in ['apps', 'data', 'images', 'themes'] %}
/srv/ghost/content/{{ dir }}:
  file.directory:
    - user: ghost
    - require:
      - file: /srv/ghost/content
    - require_in:
      - service: ghost
{% endfor %}
