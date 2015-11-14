base:
  '*':
    - common
    - dotdeb

  'roles:web':
    - match: grain
    - web_directories
    - node
    - nginx
    - ghost.web

  'roles:database':
    - match: grain
    - postgresql
    - ghost.database
