{% for site in pillar['sites'] %}
/srv/{{ site.id }}:
  file.directory: []

/srv/{{ site.id }}/www:
  file.directory:
    - user: www-data
    - mode: 755
    - require:
      - file: /srv/{{ site.id }}
{% endfor %}
