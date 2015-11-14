/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx/nginx.conf
    - require:
      - pkg: nginx

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
      - file: /etc/nginx/sites-enabled/default
