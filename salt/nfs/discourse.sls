/shared/discourse/shared/web/:
  file.directory:
    - makedirs: True
    - mode: 755

/shared/discourse/shared/web/backups/:
  file.directory:
    - mode: 777
    - require:
      - file: /shared/discourse/shared/web/

/shared/discourse/shared/web/uploads/:
  file.directory:
    - mode: 777
    - require:
      - file: /shared/discourse/shared/web/

/srv/discourse/shared/web/uploads/:
  cmd.script:
    - source: salt://nfs/make_shared.sh
    - args: /srv/discourse/shared/web/uploads /shared/discourse/shared/web/uploads
    - stateful: True
    - require:
      - cmd: discourse_web
      - file: /shared/discourse/shared/web/uploads/
    - require_in:
      - service: /etc/systemd/system/ghost.service

/srv/discourse/shared/web/backups/:
  cmd.script:
    - source: salt://nfs/make_shared.sh
    - args: /srv/discourse/shared/web/backups /shared/discourse/shared/web/backups
    - stateful: True
    - require:
      - cmd: discourse_web
      - file: /shared/discourse/shared/web/backups/
    - require_in:
      - service: /etc/systemd/system/ghost.service
