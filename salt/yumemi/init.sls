# Note: We don't want this running on the dev server as well, until I have a
# separate test account on Discord, or we'll start getting duplicate replies
yumemi:
  {% if not grains.get('vagrant', False) %}
  service.running:
    - enable: True
  {% else %}
  service.stopped:
  {% endif %}
    - require:
      - git: /srv/kazamatsuri/yumemi
      - file: /etc/systemd/system/yumemi.service
    - watch:
      - git: /srv/kazamatsuri/yumemi
      - file: /etc/systemd/system/yumemi.service

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
    - require_in:
      - git: /srv/kazamatsuri/yumemi
  {% endif %}
  git.latest:
    - name: "https://github.com/KazamatsuriOrg/Yumemi.git"
    - target: /srv/kazamatsuri/yumemi
    - require:
      - file: /srv/kazamatsuri
  cmd.watch:
    - name: "npm install"
    - cwd: /srv/kazamatsuri/yumemi
    - require:
      - git: /srv/kazamatsuri/yumemi
    - watch:
      - git: /srv/kazamatsuri/yumemi
