include:
  - discourse._common

/srv/discourse/containers/web.yml:
  file.managed:
    - source: salt://discourse/web.yml
    - template: jinja
    - require:
      - git: /srv/discourse/

bootstrap_discourse_web:
  cmd.script:
    - source: salt://discourse/bootstrap.sh
    - args: web
    - cwd: /srv/discourse
    - creates: /srv/discourse/shared/web
    - require:
      - file: /srv/discourse/containers/web.yml

discourse@web:
  service.running:
    - enable: True
    - require:
      - file: /srv/discourse/containers/web.yml
      - file: /etc/systemd/system/discourse@.service
      - cmd: bootstrap_discourse_web
