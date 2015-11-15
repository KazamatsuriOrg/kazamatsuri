include:
  - discourse._common

/srv/discourse/containers/data.yml:
  file.managed:
    - source: salt://discourse/data.yml
    - template: jinja
    - require:
      - git: /srv/discourse/

./launcher start data:
  cmd.run:
    - cwd: /srv/discourse
    - creates: /srv/discourse/shared/data
    - require:
      - file: /srv/discourse/containers/data.yml
