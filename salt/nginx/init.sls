/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx/nginx.conf
    - require:
      - pkg: nginx

/etc/nginx/sites-available/ghost:
  file.managed:
    - source: salt://nginx/ghost
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/ghost:
  file.symlink:
    - target: ../sites-available/ghost
    - require:
      - file: /etc/nginx/sites-available/ghost

/etc/nginx/sites-enabled/default:
  file.absent:
    - require:
      - pkg: nginx

nginx:
  pkg.installed:
    - require:
      - pkgrepo: dotdeb
  service.running:
    - enable: True
    - require:
      - pkg: nginx
    - watch:
      - file: /etc/nginx/nginx.conf
      - file: /etc/nginx/sites-available/ghost
