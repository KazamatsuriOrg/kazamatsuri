/shared/www:
  file.absent: []

/srv/www:
  mount.unmounted:
    - device: /shared/www
    - persist: True
