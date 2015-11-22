allow-smtp:
  iptables.append:
    - table: filter
    - chain: INPUT
    - proto: tcp
    - dports:
      - 25
      - 587
    - jump: ACCEPT
    - save: True
