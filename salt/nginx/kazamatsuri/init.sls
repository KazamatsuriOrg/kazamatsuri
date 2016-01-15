/etc/nginx/sites-available/kazamatsuri.conf:
  file.managed:
    - source: salt://nginx/kazamatsuri/nginx.conf
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx

/etc/nginx/sites-enabled/kazamatsuri.conf:
  file.symlink:
    - target: ../sites-available/kazamatsuri.conf
    - require:
      - file: /etc/nginx/sites-available/kazamatsuri.conf
    - watch_in:
      - service: nginx
