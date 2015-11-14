/etc/nginx/sites-available/ghost:
  file.managed:
    - source: salt://ghost/nginx
    - require:
      - pkg: nginx
      - file: /etc/nginx/sites-enabled/ghost
    - watch_in:
      - service: nginx

/etc/nginx/sites-enabled/ghost:
  file.symlink:
    - target: ../sites-available/ghost
    - watch_in:
      - service: nginx
