base:
  '*':
    - common
    - dotdeb

  'roles:web':
    - match: grain
    - docker
    - node
    - postgresql.client
    - nginx
    - web_directories
    - ghost.web
    - ghost.nginx

  'roles:database':
    - match: grain
    - docker
    - postgresql.server
    - ghost.database
