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

/srv/ghost/content/images:
  mount.unmounted:
    - name: /srv/ghost/content/images
    - device: /shared/ghost/content/images
    - persist: True
  file.symlink:
    - target: /shared/ghost/content/images
    - force: True
    - require:
      - cmd: ghost_source
      - user: ghost_user
      - file: /shared/ghost/content/images/
      - mount: /srv/ghost/content/images/
    - require_in:
      - service: /etc/systemd/system/ghost.service
