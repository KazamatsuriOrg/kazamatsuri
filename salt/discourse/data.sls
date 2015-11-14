include:
  - discourse._common

/srv/discourse/containers/data.yml:
  file.managed:
    - source: salt://discourse/data.yml
    - template: jinja
    - require:
      - git: /srv/discourse/

bootstrap_discourse_data:
  cmd.script:
    - source: salt://discourse/bootstrap.sh
    - args: data
    - cwd: /srv/discourse
    - creates: /srv/discourse/shared/data
    - require:
      - file: /srv/discourse/containers/data.yml

discourse@data:
  service.running:
    - enable: True
    - require:
      - file: /srv/discourse/containers/data.yml
      - file: /etc/systemd/system/discourse@.service
      - cmd: bootstrap_discourse_data
