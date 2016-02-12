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

/etc/cron.daily/discourse-cleanup:
  file.managed:
    - source: salt://discourse/cron/discourse-cleanup.sh
    - mode: 755

/shared/discourse:
  file.directory: []

/shared/discourse/shared:
  file.directory:
    - require:
      - file: /shared/discourse
