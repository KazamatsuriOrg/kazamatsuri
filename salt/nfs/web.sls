/shared/www:
  file.directory:
    - makedirs: True
    - mode: 755

/srv/www:
  mount.mounted:
    - fstype: none
    - opts: bind
    - mkmnt: True
    - device: /shared/www
    - require:
      - file: /shared/www
    - require_in:
      - service: /etc/systemd/system/ghost.service
