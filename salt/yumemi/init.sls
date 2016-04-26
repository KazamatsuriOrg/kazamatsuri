yumemi:
  service.dead:
    - enable: False

/etc/systemd/system/yumemi.service:
  file.absent

/srv/kazamatsuri/yumemi:
  file.absent
