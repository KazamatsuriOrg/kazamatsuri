/srv/discourse:
  file.directory:
    - makedirs: True
  git.latest:
    - name: https://github.com/discourse/discourse_docker
    - target: /srv/discourse
    - require:
      - file: /srv/discourse

/srv/discourse/templates/syslog.papertrail.template.yml:
  file.managed:
    - source: salt://discourse/templates/syslog.papertrail.template.yml
    - template: jinja
    - require:
      - git: /srv/discourse
