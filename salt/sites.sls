{% for site in pillar['sites'] %}
/srv/{{ site.id }}:
  file.directory: []
{% endfor %}
