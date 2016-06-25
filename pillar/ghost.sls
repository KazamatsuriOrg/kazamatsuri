ghost:
  version: 0.8.0

kazamatsuri:
  ghost:
    db_user: ghost
    db_name: ghost
    {% if grains.get('vagrant', False) %}
    binds:
      - /vagrant/vagrant/shared/monologue:/srv/ghost/content/themes/monologue
    {% endif %}

rokkenjima:
  ghost:
    db_user: rokkenjima_ghost
    db_name: rokkenjima_ghost
    {% if grains.get('vagrant', False) %}
    binds:
      - /vagrant/vagrant/shared/monologue_rokkenjima:/srv/ghost/content/themes/monologue
    {% endif %}
