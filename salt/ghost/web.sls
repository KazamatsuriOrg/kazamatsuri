ghost:
  user.present:
    - gid_from_name: True
    - system: True
    - home: /var/lib/ghost

/etc/systemd/system/ghost@.service:
  file.absent

/srv/ghost:
  file.directory: []

/srv/ghost/Dockerfile:
  file.managed:
    - source: salt://ghost/Dockerfile
    - template: jinja
    - require:
      - file: /srv/ghost

/var/run/ghost:
  file.directory:
    - user: www-data
    - group: www-data
    - mode: 775

local/ghost:{{ pillar['ghost']['version'] }}:
  # Bugged: https://github.com/saltstack/salt/issues/31513
  # dockerng.image_present:
    # - build: /srv/ghost
    # - force: True
  cmd.run:
    - name: "[[ -z $(docker images -q local/ghost:{{ pillar['ghost']['version'] }}) ]] && docker build -t local/ghost:{{ pillar['ghost']['version'] }} . && echo && echo 'changed=yes comment=\"Image built\"'; true"
    - cwd: /srv/ghost
    - shell: /bin/bash
    - stateful: True
    - require:
      - pip: docker-py
    - watch:
      - file: /srv/ghost/Dockerfile

/srv/kazamatsuri/ghost/content/themes/monologue:
  git.latest:
    - name: https://github.com/KazamatsuriOrg/monologue.git
    {% if grains.get('vagrant', False) %}
    - target: /vagrant/vagrant/shared/monologue
    {% else %}
    - target: /srv/kazamatsuri/ghost/content/themes/monologue
    {% endif %}
    - require:
      - file: /srv/kazamatsuri/ghost/content
    - require_in:
      - dockerng: ghost_kazamatsuri
    - watch_in:
      - dockerng: ghost_kazamatsuri
  cmd.watch:
    - name: 'npm install && bower install --allow-root && broccoli build assets_new && mv assets assets_old; mv assets_new assets && rm -rf assets_old'
    {% if grains.get('vagrant', False) %}
    - cwd: /vagrant/vagrant/shared/monologue
    - user: vagrant
    {% else %}
    - cwd: /srv/kazamatsuri/ghost/content/themes/monologue
    {% endif %}
    - watch:
      - git: /srv/kazamatsuri/ghost/content/themes/monologue
    - watch_in:
      - dockerng: ghost_kazamatsuri

/srv/rokkenjima/ghost/content/themes/monologue:
  git.latest:
    - name: https://github.com/KazokuCo/monologue_rokkenima.git
    {% if grains.get('vagrant', False) %}
    - target: /vagrant/vagrant/shared/monologue_rokkenjima
    {% else %}
    - target: /srv/rokkenjima/ghost/content/themes/monologue
    {% endif %}
    - require:
      - file: /srv/rokkenjima/ghost/content
    - require_in:
      - dockerng: ghost_rokkenjima
    - watch_in:
      - dockerng: ghost_rokkenjima
  cmd.watch:
    - name: 'npm install && bower install --allow-root && broccoli build assets_new && mv assets assets_old; mv assets_new assets && rm -rf assets_old'
    {% if grains.get('vagrant', False) %}
    - cwd: /vagrant/vagrant/shared/monologue_rokkenjima
    - user: vagrant
    {% else %}
    - cwd: /srv/rokkenjima/ghost/content/themes/monologue
    {% endif %}
    - watch:
      - git: /srv/rokkenjima/ghost/content/themes/monologue
    - watch_in:
      - dockerng: ghost_rokkenjima



{% for site in pillar['sites'] %}
{% if 'ghost' in pillar[site]['use'] %}

ghost_{{ site }}:
  dockerng.running:
    - image: local/ghost:{{ pillar['ghost']['version'] }}
    - restart_policy: always
    - binds:
      - /srv/{{ site }}/ghost/content:/srv/ghost/content
      - /srv/{{ site }}/ghost/config.js:/srv/ghost/config.js
      - /var/run/ghost:/var/run/ghost
      {% for mount in pillar[site]['ghost'].get('binds', []) -%}
      - {{ mount }}
      {% endfor %}
    - require:
      - cmd: local/ghost:{{ pillar['ghost']['version'] }}
      - file: /srv/{{ site }}/ghost/content
      - file: /srv/{{ site }}/ghost/config.js
      - file: /var/run/ghost
      - git: /srv/{{ site }}/ghost/content/themes/casper
    - watch:
      - cmd: local/ghost:{{ pillar['ghost']['version'] }}
      - file: /srv/{{ site }}/ghost/config.js

/srv/{{ site }}/ghost:
  file.directory: []

/srv/{{ site }}/ghost/config.js:
  file.managed:
    - source: salt://ghost/config.js
    - template: jinja
    - context:
        site: {{ site }}
    - require:
      - file: /srv/{{ site }}/ghost

/srv/{{ site }}/ghost/content:
  file.directory:
    - force: True
    - require:
      - file: /srv/{{ site }}/ghost

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
      - dockerng: ghost_{{ site }}
{% endfor %}

/srv/{{ site }}/ghost/content/themes/casper:
  git.latest:
    - name: https://github.com/TryGhost/Casper.git
    - target: /srv/{{ site }}/ghost/content/themes/casper
    - force_clone: True
    - require:
      - file: /srv/{{ site }}/ghost/content/themes

{% endif %}
{% endfor %}
