base:
  '*':
    - common
    - dotdeb
    - sshd
    - nfs.client
    - swap
    - newrelic
    - firewall
    - fail2ban
    - logging
    - docker
    - docker.gc

  'roles:web':
    - match: grain
    - sites
    - node
    - node.utils
    - postgresql.client
    - nginx
    - nginx.kazamatsuri
    - nginx.rokkenjima
    - ghost.web
    - discourse.web

  'roles:database':
    - match: grain
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
    - dovecot
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
  
  'roles:hubot':
    - match: grain
    - node
    - sites
    - yumemi
