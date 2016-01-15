include:
  - discourse._common

/srv/discourse/containers/data.yml:
  file.managed:
    - source: salt://discourse/data.yml
    - template: jinja
    - require:
      - git: /srv/discourse

discourse_data:
  cmd.run:
    - name: ./launcher rebuild data
    - cwd: /srv/discourse
    - creates: /srv/discourse/shared/data
    - require:
      - file: /srv/discourse/containers/data.yml
      - mount: /var/swap
