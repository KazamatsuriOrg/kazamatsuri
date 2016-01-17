{% for site in pillar['sites'] %}
ghost@{{ site['id'] }}_db:
  postgres_user.present:
    - name: {{ pillar[site['id']]['ghost']['db_user'] }}
    - login: True
    - password: {{ pillar[site['id']]['ghost']['db_password'] }}
    - require:
      - pkg: postgresql
  postgres_database.present:
    - name: {{ pillar[site['id']]['ghost']['db_name'] }}
    - owner: {{ pillar[site['id']]['ghost']['db_user'] }}
    - require:
      - postgres_user: ghost@{{ site['id'] }}_db
{% endfor %}
