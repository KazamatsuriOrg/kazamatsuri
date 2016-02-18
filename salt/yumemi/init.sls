yumemi:
  {% if pillar['yumemi']['discord']['email'] %}
  service.running:
    - enable: True
  {% else %}
  service.dead:
    - enable: False
  {% endif %}
    - require:
      - git: /srv/kazamatsuri/yumemi
      - file: /etc/systemd/system/yumemi.service
      - file: /srv/kazamatsuri/yumemi/env
    - watch:
      - git: /srv/kazamatsuri/yumemi
      - file: /etc/systemd/system/yumemi.service
      - file: /srv/kazamatsuri/yumemi/env

/etc/systemd/system/yumemi.service:
  file.managed:
    - source: salt://yumemi/yumemi.service
    - template: jinja

/srv/kazamatsuri/yumemi:
  {% if grains.get('vagrant', False) %}
  file.symlink:
    - target: /vagrant/vagrant/shared/yumemi
    - force: True
    - require:
      - file: /srv/kazamatsuri
  {% else %}
  file.directory:
    - user: www-data
    - group: www-data
    - require:
      - file: /srv/kazamatsuri
  {% endif %}
  git.latest:
    - name: "https://github.com/KazamatsuriOrg/Yumemi.git"
    - target: /srv/kazamatsuri/yumemi
    - user: www-data
    - require:
      - file: /srv/kazamatsuri/yumemi
  cmd.watch:
    - name: "npm install"
    - cwd: /srv/kazamatsuri/yumemi
    - watch:
      - git: /srv/kazamatsuri/yumemi

/srv/kazamatsuri/yumemi/env:
  file.managed:
    - source: salt://yumemi/env
    - template: jinja
    - require:
      - git: /srv/kazamatsuri/yumemi
