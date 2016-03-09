frontend_setup:
  salt.state:
    - tgt: 'P@roles:(balancer)'
    - tgt_type: compound
    - highstate: True
