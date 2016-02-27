sites:
  - kazamatsuri
  - rokkenjima

kazamatsuri:
  use:
    - ghost
    - discourse
  discourse:
    db_id: 1
  haproxy:
    check_url: '/ghost/'
  domain: kazamatsuri.org
  domain_local: kazamatsuri.local

rokkenjima:
  use:
    - ghost
    - discourse
  discourse:
    db_id: 2
  haproxy:
    check_url: '/ghost/'
  domain: rokkenjima.org
  domain_local: rokkenjima.local
