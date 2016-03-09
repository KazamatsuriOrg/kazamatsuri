include:
  - discourse._common

discourse_data:
  cmd.run:
    - name: ./launcher rebuild data
    - cwd: /srv/discourse
    - creates: /srv/discourse/shared/data
    - require:
      - file: /srv/discourse/containers/data.yml
      - mount: /var/swap
