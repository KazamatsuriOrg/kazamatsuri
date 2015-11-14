ghost_db_user:
  postgres_user.present:
    - name: ghost
    - login: True
    - password: {{ pillar['ghost']['db_password'] }}
    - require:
      - pkg: postgresql

ghost_db:
  postgres_database.present:
    - name: ghost
    - owner: ghost
    - require:
      - postgres_user: ghost_db_user
