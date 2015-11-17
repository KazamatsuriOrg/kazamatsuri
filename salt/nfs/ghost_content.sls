/shared/ghost/content/:
  file.directory:
    - makedirs: True
    - mode: 755

/shared/ghost/content/images/:
  file.directory:
    - mode: 777
    - recurse:
      - mode
    - require:
      - file: /shared/ghost/content/

/srv/ghost/content/images/:
  mount.mounted:
    - fstype: none
    - opts: bind,uid=ghost,gid=ghost
    - mkmnt: True
    - device: /shared/ghost/content/images
    - require:
      - cmd: ghost_source
      - user: ghost_user
      - file: /shared/ghost/content/images/
    - require_in:
      - service: /etc/systemd/system/ghost.service
