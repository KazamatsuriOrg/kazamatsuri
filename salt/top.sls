base:
  '*':
    - common
    - dotdeb
    - nfs.client
    - swap

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
    - nfs.discourse
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

  'roles:storage':
    - match: grain
    - nfs.server

  'roles:master':
    - match: grain
    - cloud
