/etc/nginx/sites-available/rokkenjima.conf:
  file.managed:
    - source: salt://nginx/rokkenjima/nginx.conf
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx

/etc/nginx/sites-enabled/rokkenjima.conf:
  file.symlink:
    - target: ../sites-available/rokkenjima.conf
    - require:
      - file: /etc/nginx/sites-available/rokkenjima.conf
    - watch_in:
      - service: nginx
