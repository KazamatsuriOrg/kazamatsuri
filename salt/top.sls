base:
  '*':
    - common
    - dotdeb

  'roles:web':
    - match: grain
    - web_directories
    - nginx
    - ghost

  'roles:database':
    - match: grain
    - postgresql
