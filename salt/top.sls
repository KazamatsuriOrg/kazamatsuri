base:
  '*':
    - common
    - dotdeb

  'roles:web':
    - match: grain
    - nginx

  'roles:database':
    - match: grain
    - postgresql
