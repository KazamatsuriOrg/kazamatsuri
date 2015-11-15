/srv/discourse/:
  file.directory:
    - makedirs: True
  git.latest:
    - name: https://github.com/discourse/discourse_docker
    - target: /srv/discourse
    - require:
      - file: /srv/discourse/
