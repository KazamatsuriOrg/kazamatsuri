allow-http:
  iptables.append:
    - table: filter
    - chain: INPUT
    - proto: tcp
    - dports:
      - 80
      - 443
    - jump: ACCEPT
    - save: True
