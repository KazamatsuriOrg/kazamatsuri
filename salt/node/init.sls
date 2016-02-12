nodesource-0.12:
  pkgrepo.absent:
    - name: deb https://deb.nodesource.com/node_0.12 jessie main

nodesource:
  pkgrepo.managed:
    - name: deb https://deb.nodesource.com/node_4.x jessie main
    - key_url: https://deb.nodesource.com/gpgkey/nodesource.gpg.key
    - require:
      - pkgrepo: nodesource-0.12
      - pkg: apt-transport-https

nodejs:
  pkg.installed:
    - require:
      - pkgrepo: nodesource
