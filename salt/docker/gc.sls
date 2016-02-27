/usr/local/src/docker-gc:
  git.latest:
    - name: https://github.com/spotify/docker-gc
    - target: /usr/local/src/docker-gc

/usr/local/bin/docker-gc:
  file.symlink:
    - target: /usr/local/src/docker-gc/docker-gc
    - require:
      - git: /usr/local/src/docker-gc
