/shared/www:
  file.absent:
    - require:
      - mount: /srv/www

/srv/www:
  mount.unmounted:
    - device: /shared/www
    - persist: True
