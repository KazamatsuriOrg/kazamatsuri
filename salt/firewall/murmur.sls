allow-murmur-tcp:
  iptables.append:
    - table: filter
    - chain: INPUT
    - proto: tcp
    - dport: 64738
    - jump: ACCEPT
    - save: True

allow-murmur-udp:
  iptables.append:
    - table: filter
    - chain: INPUT
    - proto: udp
    - dport: 64738
    - jump: ACCEPT
    - save: True
