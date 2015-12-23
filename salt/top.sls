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
    - docker
    - node
    - postgresql.client
    - nginx
    - ghost.web
    - ghost.nginx
    - discourse.web
    - nfs.ghost_content
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
    # - firewall.minecraft
