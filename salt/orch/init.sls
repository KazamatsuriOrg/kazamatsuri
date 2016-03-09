backend_setup:
  salt.state:
    - tgt: 'P@roles:(database|balancer|storage|registry|master)'
    - tgt_type: compound
    - highstate: True

satellite_setup:
  salt.state:
    - tgt: 'P@roles:(web|minecraft)'
    - tgt_type: compound
    - highstate: True
    - require:
      - salt: backend_setup
