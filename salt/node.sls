apt-transport-https:
  pkg.installed

nodesource:
  pkgrepo.managed:
    - name: deb https://deb.nodesource.com/iojs_3.x jessie main
    - keyid: 9FD3B784BC1C6FC31A8A0A1C1655A0AB68576280
    - keyserver: pgp.mit.edu
    - require:
      - pkg: apt-transport-https

iojs:
  pkg.installed:
    - require:
      - pkgrepo: nodesource
