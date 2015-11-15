salt-cloud:
  pkg.installed

/etc/salt/cloud.profiles.d/digital_ocean.conf:
  file.managed:
    - source: salt://cloud/profiles/digital_ocean.conf
    - template: jinja
    - require:
      - pkg: salt-cloud

/etc/salt/cloud.providers.d/digital_ocean.conf:
  file.managed:
    - source: salt://cloud/providers/digital_ocean.conf
    - template: jinja
    - require:
      - pkg: salt-cloud
