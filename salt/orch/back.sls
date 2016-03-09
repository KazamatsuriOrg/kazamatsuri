backend_setup:
  salt.state:
    - tgt: 'P@roles:(master|storage|database|registry|mail)'
    - tgt_type: compound
    - highstate: True
