include:
  - discourse._common

/srv/discourse/containers/web.yml:
  file.managed:
    - source: salt://discourse/web.yml
    - template: jinja
    - require:
      - git: /srv/discourse/

./launcher start web:
  cmd.run:
    - cwd: /srv/discourse
    - creates: /srv/discourse/shared/web
    - require:
      - file: /srv/discourse/containers/web.yml
