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

  'roles:database':
    - match: grain
    - postgresql.server
    - ghost.database
