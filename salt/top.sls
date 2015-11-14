base:
  '*':
    - common
    - dotdeb

  'roles:web':
    - match: grain
    - postgresql.client
    - node
    - nginx
    - web_directories
    - ghost.web
    - ghost.nginx

  'roles:database':
    - match: grain
    - postgresql.server
    - ghost.database
