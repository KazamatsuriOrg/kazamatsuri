kazokuco/disco:
  dockerng.image_present:
    - force: True

{% for site in pillar['sites'] %}
{% if 'disco' in pillar[site]['use'] %}

{% if pillar[site].get('disco', {}) %}
/srv/{{ site }}/disco:
  file.directory:
    - user: www-data
    - group: www-data

/srv/{{ site }}/disco/bot.yml:
  file.managed:
    - source: salt://disco/config/{{ site }}.yml
    - template: jinja
    - user: www-data
    - group: www-data

disco_{{ site }}:
  dockerng.running:
    - image: kazokuco/disco
    - cmd: run /data/bot.yml
    - user: www-data
    - binds: /srv/{{ site }}/disco:/data
    - environment:
      {% if 'discord' in pillar[site]['disco'] %}
      - DISCORD_USERNAME: {{ pillar[site]['disco']['discord']['username'] }}
      - DISCORD_PASSWORD: {{ pillar[site]['disco']['discord']['password'] }}
      {% endif %}
    - watch:
      - dockerng: kazokuco/disco
      - file: /srv/{{ site }}/disco/bot.yml
{% endif %}

{% endif %}
{% endfor %}
