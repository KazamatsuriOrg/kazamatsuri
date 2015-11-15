/shared/ghost/content/:
  file.directory:
    - makedirs: True
    - mode: 755

/shared/ghost/content/images/:
  file.directory:
    - mode: 777
    - require:
      - file: /shared/ghost/content/

/srv/ghost/content/images/:
  cmd.script:
    - source: salt://nfs/make_shared.sh
    - args: /srv/ghost/content/images /shared/ghost/content/images
    - stateful: True
    - require:
      - archive: ghost_source
      - file: /shared/ghost/content/images/
    - require_in:
      - service: /etc/systemd/system/ghost.service
