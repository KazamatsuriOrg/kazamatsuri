base:
  '*':
    - common
    - dotdeb
    - nfs.client
    - swap
    - newrelic
    - firewall
    - logging

  'roles:web':
    - match: grain
    - sites
    - docker
    - node
    - node.grunt-cli
    - postgresql.client
    - nginx
    - nginx.kazamatsuri
    - nginx.rokkenjima
    - ghost.web
    - ghost._nginx_old
    - discourse.web
    - nfs.web

  'roles:database':
    - match: grain
    - docker
    - postgresql.server
    - ghost.database
    - discourse.data

  'roles:balancer':
    - match: grain
    - haproxy
    - firewall.http

  'roles:storage':
    - match: grain
    - nfs.server

  'roles:master':
    - match: grain
    - cloud
    - openvpn
    - firewall.openvpn

  'roles:mail':
    - match: grain
    - postfix
    - firewall.smtp

  'roles:voice':
    - match: grain
    - murmur
    - firewall.murmur

  'roles:minecraft':
    - match: grain
    - java
    - minecraft
    - firewall.minecraft
