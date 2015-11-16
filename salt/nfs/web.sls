/shared/www/:
  file.directory:
    - makedirs: True
    - mode: 755

share_/srv/www/:
  cmd.script:
    - source: salt://nfs/make_shared.sh
    - args: /srv/www /shared/www
    - stateful: True
    - require:
      - cmd: discourse_web
      - file: /shared/www/
    - require_in:
      - service: /etc/systemd/system/ghost.service
