{% for pkg in ['grunt-cli', 'broccoli-cli', 'bower'] %}
{{ pkg }}:
  npm.installed:
    - require:
      - pkg: nodejs
{% endfor %}
