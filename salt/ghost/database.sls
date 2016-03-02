{% for site in pillar['sites'] %}
{% if 'ghost' in pillar[site]['use'] %}
ghost@{{ site }}_db:
  postgres_user.present:
    - name: {{ pillar[site]['ghost']['db_user'] }}
    - login: True
    - password: {{ pillar[site]['ghost']['db_password'] }}
    - require:
      - pkg: postgresql
  postgres_database.present:
    - name: {{ pillar[site]['ghost']['db_name'] }}
    - owner: {{ pillar[site]['ghost']['db_user'] }}
    - require:
      - postgres_user: ghost@{{ site }}_db
{% endif %}
{% endfor %}
