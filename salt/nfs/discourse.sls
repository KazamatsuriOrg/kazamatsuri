/srv/discourse/shared/web/uploads:
  mount.unmounted:
    - device: /shared/discourse/shared/web/uploads
    - persist: True

/srv/discourse/shared/web/backups:
  mount.unmounted:
    - device: /shared/discourse/shared/web/backups
    - persist: True
