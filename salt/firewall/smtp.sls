allow-smtp:
  iptables.append:
    - table: filter
    - chain: INPUT
    - proto: tcp
    - dports:
      - 80
      - 587
    - jump: ACCEPT
    - save: True
