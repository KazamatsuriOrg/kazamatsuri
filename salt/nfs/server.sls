nfs-server:
  pkg.installed:
    - name: nfs-kernel-server
  service.running:
    - name: nfs-kernel-server
    - enable: True
    - require:
      - pkg: nfs-server
      - file: /srv/shared
      - file: /etc/exports
    - require_in:
      - mount: /shared
    - watch:
      - file: /etc/exports

/srv/shared:
  file.directory:
    - user: root
    - group: root
    - mode: 775

/etc/exports:
  file.managed:
    - source: salt://nfs/exports
    - user: root
    - group: root
    - mode: 644
