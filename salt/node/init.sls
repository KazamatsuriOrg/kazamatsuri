nodesource-0.12:
  pkgrepo.absent:
    - name: deb https://deb.nodesource.com/node_0.12 jessie main

nodesource:
  pkgrepo.managed:
    - name: deb https://deb.nodesource.com/node_4.x jessie main
    - keyid: 9FD3B784BC1C6FC31A8A0A1C1655A0AB68576280
    - keyserver: pgp.mit.edu
    - require:
      - pkgrepo: nodesource-0.12
      - pkg: apt-transport-https

nodejs:
  pkg.installed:
    - require:
      - pkgrepo: nodesource
