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
  mount.mounted:
    - fstype: none
    - opts: bind
    - mkmnt: True
    - device: /shared/discourse/shared/web/uploads
    - require:
      - cmd: discourse_web
      - file: /shared/discourse/shared/web/uploads/
    - require_in:
      - service: /etc/systemd/system/ghost.service

/srv/discourse/shared/web/backups/:
  mount.mounted:
    - fstype: none
    - opts: bind
    - mkmnt: True
    - device: /shared/discourse/shared/web/backups
    - require:
      - cmd: discourse_web
      - file: /shared/discourse/shared/web/backups/
    - require_in:
      - service: /etc/systemd/system/ghost.service
