base:
  '*':
    - common
    - dotdeb
    - nfs.client

  'roles:web':
    - match: grain
    - docker
    - node
    - postgresql.client
    - nginx
    - web_directories
    - ghost.web
    - ghost.nginx
    - discourse.web
    - nfs.ghost_content
    - nfs.discourse

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
