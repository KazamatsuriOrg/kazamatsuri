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

/usr/local/nvm:
  git.latest:
    - name: https://github.com/creationix/nvm.git
    - target: /usr/local/nvm
    - rev: v{{ pillar['node']['nvm_version'] }}

{% for version in pillar['node']['versions'] %}
nodejs-{{ version }}:
  cmd.run:
    - name: ". /usr/local/nvm/nvm.sh && nvm install {{ version }}"
    - shell: /bin/bash
    - creates: /usr/local/nvm/versions/node/v{{ version }}
    - require:
      - git: /usr/local/nvm
    - watch_in:
      - cmd: nvm-use
{% endfor %}

nvm-use:
  cmd.watch:
    - name: ". /usr/local/nvm/nvm.sh && nvm use {{ pillar['node']['use_version'] }}"
    - shell: /bin/bash
    - require:
      - cmd: nodejs-{{ pillar['node']['use_version'] }}
