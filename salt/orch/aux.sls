backend_setup:
  salt.state:
    - tgt: 'P@roles:(minecraft|voice)'
    - tgt_type: compound
    - highstate: True
