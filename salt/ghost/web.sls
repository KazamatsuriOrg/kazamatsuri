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
  {% if grains.get('vagrant', False) %}
  file.symlink:
    - target: /vagrant/vagrant/shared/monologue
    - force: True
    - require:
      - file: /srv/kazamatsuri/ghost/content
    - require_in:
      - git: /srv/kazamatsuri/ghost/content/themes/monologue
  {% endif %}
  # git.latest:
  #   - name: https://github.com/KazamatsuriOrg/monologue.git
  #   - target: /srv/kazamatsuri/ghost/content/themes/monologue
  #   - require:
  #     - file: /srv/kazamatsuri/ghost/content
  #   - require_in:
  #     - service: ghost@kazamatsuri
  #   - watch_in:
  #     - service: ghost@kazamatsuri
  cmd.run:
    - name: 'npm install && rm -rf assets && broccoli build assets'
    - cwd: /srv/kazamatsuri/ghost/content/themes/monologue
    - user: ghost
    # - watch:
    #   - git: /srv/kazamatsuri/ghost/content/themes/monologue



{% for site in pillar['sites'] %}

ghost@{{ site }}:
  service.running:
    - enable: True
    - require:
      - file: /etc/systemd/system/ghost@.service
      - git: /srv/{{ site }}/ghost
      - npm: /srv/{{ site }}/ghost
      - cmd: /srv/{{ site }}/ghost
      - file: /srv/{{ site }}/ghost/content/storage/ghost-s3/index.js
    - watch:
      - file: /etc/systemd/system/ghost@.service
      - git: /srv/{{ site }}/ghost
      - npm: /srv/{{ site }}/ghost
      - cmd: /srv/{{ site }}/ghost
      - file: /srv/{{ site }}/ghost/config.js

/srv/{{ site }}/ghost:
  git.latest:
    - name: https://github.com/TryGhost/Ghost.git
    - target: /srv/{{ site }}/ghost
    - branch: stable
    - rev: {{ pillar['ghost']['version'] }}
    - force_clone: True
    - require:
      - file: /srv/{{ site }}
  cmd.wait:
    - name: |
        git clean -ffdx core
        git checkout core
        rm -rf node_modules
        npm install --no-optional
        grunt init
        grunt prod
        rm -rf core/built/**/test-* core/client core/test
    - cwd: /srv/{{ site }}/ghost
    - require:
      - npm: grunt-cli
    - watch:
      - git: /srv/{{ site }}/ghost
  npm.installed:
    - pkgs:
      - ghost-s3-storage
      - pg
    - dir: /srv/{{ site }}/ghost
    - require:
      - git: /srv/{{ site }}/ghost
      - cmd: /srv/{{ site }}/ghost

/srv/{{ site }}/ghost/config.js:
  file.managed:
    - source: salt://ghost/config.js
    - template: jinja
    - context:
        site: {{ site }}
    - require:
      - git: /srv/{{ site }}/ghost

/srv/{{ site }}/ghost/content:
  file.directory:
    - force: True
    - require:
      - git: /srv/{{ site }}/ghost

/srv/{{ site }}/ghost/content/storage/ghost-s3/index.js:
  file.managed:
    - contents: |
        'use strict';
        module.exports = require('ghost-s3-storage');
    - makedirs: True
    - require:
      - file: /srv/{{ site }}/ghost/content



{% for dir in ['apps', 'data', 'images', 'themes'] %}
/srv/{{ site }}/ghost/content/{{ dir }}:
  file.directory:
    - user: ghost
    - require:
      - file: /srv/{{ site }}/ghost/content
    - require_in:
      - service: ghost@{{ site }}
{% endfor %}

{% endfor %}
