sites:
  - kazamatsuri
  - rokkenjima
  - kazoku

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

kazoku:
  use:
    - jekyll
  jekyll:
    repo: https://github.com/jekyll/example.git
  haproxy:
    check_url: '/'
  domain: kazoku.co
  domain_local: kazoku.local
