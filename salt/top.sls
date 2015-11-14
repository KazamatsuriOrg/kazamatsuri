base:
  '*':
    - common
    - dotdeb

  'roles:web':
    - match: grain
    - node
    - postgresql.client
    - nginx
    - web_directories
    - ghost.web
    - ghost.nginx

  'roles:database':
    - match: grain
    - postgresql.server
    - ghost.database
