/srv/registry:
  file.directory

/srv/registry/data:
  file.directory:
    - require:
      - file: /srv/registry

registry:2:
  dockerng.image_present:
    - require:
      - sls: docker

registry:
  dockerng.running:
    - image: registry:2
    - binds:
      - /srv/registry/data:/var/lib/registry
    - port_bindings:
      - 127.0.0.1:5000:5000
    - require:
      - dockerng: registry:2
      - file: /srv/registry/data
