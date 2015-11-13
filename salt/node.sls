apt-transport-https:
  pkg.installed

nodesource:
  pkgrepo.managed:
    - name: deb https://deb.nodesource.com/node_0.12 jessie main
    - keyid: 9FD3B784BC1C6FC31A8A0A1C1655A0AB68576280
    - keyserver: pgp.mit.edu
    - require:
      - pkg: apt-transport-https

nodejs:
  pkg.installed:
    - require:
      - pkgrepo: nodesource
