{% for site in pillar['sites'] %}
/srv/{{ site.id }}:
  file.directory: []

/srv/{{ site.id }}/www:
  file.symlink:
    - target: /shared/{{ site.id }}/www
    - force: True
    - require:
      - file: /shared/{{ site.id }}/www

/shared/{{ site.id }}:
  file.directory: []

/shared/{{ site.id }}/www:
  file.directory:
    - user: www-data
    - mode: 755
    - require:
      - file: /shared/{{ site.id }}
{% endfor %}
