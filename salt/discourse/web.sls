include:
  - discourse._common

/srv/discourse/containers/web.yml:
  file.managed:
    - source: salt://discourse/web.yml
    - template: jinja
    - require:
      - git: /srv/discourse/

discourse_web:
  cmd.run:
    - name: ./launcher rebuild web
    - cwd: /srv/discourse
    - creates: /srv/discourse/shared/web
    - require:
      - file: /srv/discourse/containers/web.yml
