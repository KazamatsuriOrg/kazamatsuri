/etc/nginx/sites-available/kazoku.conf:
  file.managed:
    - source: salt://nginx/kazoku/nginx.conf
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx

/etc/nginx/sites-enabled/kazoku.conf:
  file.symlink:
    - target: ../sites-available/kazoku.conf
    - require:
      - file: /etc/nginx/sites-available/kazoku.conf
    - watch_in:
      - service: nginx
