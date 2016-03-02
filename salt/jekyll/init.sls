jekyll:
  gem.installed:
    - require:
      - pkg: ruby

{% for site in pillar['sites'] %}
{% if 'jekyll' in pillar[site]['use'] %}

/srv/{{ site }}/jekyll:
  git.latest:
    - name: {{ pillar[site]['jekyll']['repo'] }}
    - target: /srv/{{ site }}/jekyll
  cmd.watch:
    - name: jekyll build
    - cwd: /srv/{{ site }}/jekyll
    - require:
      - gem: jekyll
    - watch:
      - git: /srv/{{ site }}/jekyll

{% endif %}
{% endfor %}
