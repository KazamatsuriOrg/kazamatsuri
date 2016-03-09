web_setup:
  salt.state:
    - tgt: 'P@roles:(web)'
    - tgt_type: compound
    - highstate: True
