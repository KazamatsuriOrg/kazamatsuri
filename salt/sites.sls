{% for site in pillar['sites'] %}
/srv/{{ site }}:
  file.directory: []

/srv/{{ site }}/www:
  file.symlink:
    - target: /shared/{{ site }}/www
    - force: True
    - require:
      - file: /shared/{{ site }}/www

/shared/{{ site }}:
  file.directory: []

/shared/{{ site }}/www:
  file.directory:
    - user: www-data
    - mode: 755
    - require:
      - file: /shared/{{ site }}
{% endfor %}
