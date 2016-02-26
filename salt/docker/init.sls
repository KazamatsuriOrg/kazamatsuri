docker:
  group.present:
    - system: True
    {% if grains.get('vagrant', False) %}
    - addusers:
      - vagrant
    {% endif %}
  pkgrepo.managed:
    - name: deb https://apt.dockerproject.org/repo debian-jessie main
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - keyid: 58118E89F3A912897C070ADBF76221572C52609D
    - require:
      - pkg: apt-transport-https
  pkg.installed:
    - name: docker-engine
    - require:
      - pkgrepo: docker
  service.running:
    - enable: True
    - require:
      - pkg: docker
      - file: /etc/default/docker
      - file: /etc/docker/daemon.json
    - watch:
      - file: /etc/default/docker
      - file: /etc/docker/daemon.json

/etc/default/docker:
  file.managed:
    - source: salt://docker/docker
    - template: jinja
    - require:
      - pkg: docker

/etc/docker/daemon.json:
  file.managed:
    - source: salt://docker/daemon.json
    - template: jinja
    - require:
      - pkg: docker

docker-py:
  pip.installed:
    - require:
      - pkg: python-pip
