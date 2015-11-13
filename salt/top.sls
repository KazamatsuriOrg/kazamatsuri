base:
  '*':
    - common
    - dotdeb

  'roles:web':
    - match: grain
    - web_directories
    - node
    - nginx
    - ghost

  'roles:database':
    - match: grain
    - postgresql
