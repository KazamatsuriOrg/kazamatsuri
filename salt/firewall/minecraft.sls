allow-minecraft:
  iptables.append:
    - table: filter
    - chain: INPUT
    - proto: tcp
    - dport: 25565
    - jump: ACCEPT
    - save: True
