newrelic:
  pkgrepo.managed:
    - name: deb http://apt.newrelic.com/debian/ newrelic non-free
    - key_url: https://download.newrelic.com/548C16BF.gpg
  pkg.installed:
    - name: newrelic-sysmond
    - require:
      - pkgrepo: newrelic
  {% if pillar['newrelic']['license_key'] %}
  service.running:
    - name: newrelic-sysmond
    - enable: True
    - watch:
      - group: newrelic_docker
  {% else %}
  service.dead:
    - name: newrelic-sysmond
    - enable: False
  {% endif %}
    - require:
      - pkg: newrelic
      - file: /etc/newrelic/nrsysmond.cfg

newrelic_docker:
  group.present:
    - name: docker
    - addusers:
      - newrelic

/etc/newrelic/nrsysmond.cfg:
  file.managed:
    - source: salt://newrelic/nrsysmond.cfg
    - template: jinja
    - user: newrelic
    - group: newrelic
    - mode: 640
