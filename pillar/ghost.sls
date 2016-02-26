ghost:
  # v0.7.5 (tag notation is broken)
  # version: 248c3da667ee4f347629188e8dc680808e863b39
  version: 0.7.5

kazamatsuri:
  ghost:
    db_user: ghost
    db_name: ghost
    {% if grains.get('vagrant', False) %}
    binds:
      - /vagrant/shared/monologue:/srv/ghost/content/themes/monologue
    {% endif %}

rokkenjima:
  ghost:
    db_user: rokkenjima_ghost
    db_name: rokkenjima_ghost
