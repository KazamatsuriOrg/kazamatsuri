/etc/nginx/sites-available/ghost:
  file.absent:
    - watch_in:
      - service: nginx

/etc/nginx/sites-enabled/ghost:
  file.absent:
    - watch_in:
      - service: nginx
