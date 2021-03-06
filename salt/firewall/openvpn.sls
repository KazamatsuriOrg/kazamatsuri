allow-openvpn-udp:
  iptables.append:
    - table: filter
    - chain: INPUT
    - proto: udp
    - dport: 1194
    - jump: ACCEPT
    - save: True

# allow-tun:
#   iptables.append:
#     - table: filter
#     - chain: INPUT
#     - in-interface: tun+
#     - jump: ACCEPT
#     - save: True

# allow-tun-forward:
#   iptables.append:
#     - table: filter
#     - chain: FORWARD
#     - in-interface: tun+
#     - jump: ACCEPT
#     - save: True

forward-openvpn-related:
  iptables.append:
    - table: filter
    - chain: FORWARD
    - in-interface: tun+
    - out-interface: eth+
    - match: state
    - connstate: "ESTABLISHED,RELATED"
    - jump: ACCEPT
    - save: True

forward-openvpn:
  iptables.append:
    - table: filter
    - chain: FORWARD
    - source: 172.32.0.0/24
    - in-interface: tun+
    - out-interface: eth+
    - jump: ACCEPT
    - save: True

masquerade-openvpn-traffic:
  iptables.append:
    - table: nat
    - chain: POSTROUTING
    - source: 172.32.0.0/24
    - out-interface: eth+
    - jump: MASQUERADE
    - save: True
