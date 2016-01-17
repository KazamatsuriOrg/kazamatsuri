ghost:
  user.present:
    - gid_from_name: True
    - system: True
    - home: /var/lib/ghost
  service.dead:
    - enable: False

/etc/systemd/system/ghost.service:
  file.absent:
    - require:
      - service: ghost

/srv/ghost:
  file.absent: []

/etc/systemd/system/ghost@.service:
  file.managed:
    - source: salt://ghost/ghost@.service



/srv/kazamatsuri/ghost/content/themes/monologue:
  git.latest:
    - name: https://github.com/KazamatsuriOrg/monologue.git
    - target: /srv/kazamatsuri/ghost/content/themes/monologue
    - require:
      - file: /srv/kazamatsuri/ghost/content
    - require_in:
      - service: ghost@kazamatsuri
    - watch_in:
      - service: ghost@kazamatsuri



{% for site in pillar['sites'] %}

ghost@{{ site['id'] }}:
  service.running:
    - enable: True
    - require:
      - file: /etc/systemd/system/ghost@.service
      - git: /srv/{{ site['id'] }}/ghost
      - npm: /srv/{{ site['id'] }}/ghost
      - cmd: /srv/{{ site['id'] }}/ghost
      - file: /srv/{{ site['id'] }}/ghost/content/storage/ghost-s3/index.js
    - watch:
      - file: /etc/systemd/system/ghost@.service
      - git: /srv/{{ site['id'] }}/ghost
      - npm: /srv/{{ site['id'] }}/ghost
      - cmd: /srv/{{ site['id'] }}/ghost
      - file: /srv/{{ site['id'] }}/ghost/config.js

/srv/{{ site['id'] }}/ghost:
  git.latest:
    - name: https://github.com/TryGhost/Ghost.git
    - target: /srv/{{ site['id'] }}/ghost
    - branch: stable
    - rev: {{ pillar['ghost']['version'] }}
    - force_clone: True
    - require:
      - file: /srv/{{ site['id'] }}
  cmd.wait:
    - name: |
        git clean -ffdx core
        rm -rf node_modules
        npm install --no-optional
        grunt init
        grunt prod
    - cwd: /srv/{{ site['id'] }}/ghost
    - require:
      - npm: grunt-cli
    - watch:
      - git: /srv/{{ site['id'] }}/ghost
  npm.installed:
    - pkgs:
      - ghost-s3-storage
      - pg
    - dir: /srv/{{ site['id'] }}/ghost
    - require:
      - git: /srv/{{ site['id'] }}/ghost
      - cmd: /srv/{{ site['id'] }}/ghost

/srv/{{ site['id'] }}/ghost/config.js:
  file.managed:
    - source: salt://ghost/config.js
    - template: jinja
    - context:
        site: {{ site['id'] }}
        domain: {{ site['domain_local'] if grains.get('vagrant', False) else site['domain'] }}
    - require:
      - git: /srv/{{ site['id'] }}/ghost

/srv/{{ site['id'] }}/ghost/content:
  file.directory:
    - force: True
    - require:
      - git: /srv/{{ site['id'] }}/ghost

/srv/{{ site['id'] }}/ghost/content/storage/ghost-s3/index.js:
  file.managed:
    - contents: |
        'use strict';
        module.exports = require('ghost-s3-storage');
    - makedirs: True
    - require:
      - file: /srv/{{ site['id'] }}/ghost/content



{% for dir in ['apps', 'data', 'images', 'themes'] %}
/srv/{{ site['id'] }}/ghost/content/{{ dir }}:
  file.directory:
    - user: ghost
    - require:
      - file: /srv/{{ site['id'] }}/ghost/content
    - require_in:
      - service: ghost@{{ site['id'] }}
{% endfor %}

{% endfor %}
