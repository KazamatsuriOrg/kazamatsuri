allow-ssh:
  iptables.insert:
    - table: filter
    - chain: INPUT
    - position: 1
    - proto: tcp
    - dport: 22
    - jump: ACCEPT
    - save: True

allow-private:
  iptables.append:
    - table: filter
    - chain: INPUT
    - proto: all
    - source: 10.0.0.0/8
    - jump: ACCEPT
    - save: True

allow-loopback:
  iptables.append:
    - table: filter
    - chain: INPUT
    - proto: all
    - in-interface: lo
    - jump: ACCEPT
    - save: True

allow-established:
  iptables.append:
    - table: filter
    - chain: INPUT
    - proto: all
    - match: state
    - connstate: "ESTABLISHED,RELATED"
    - jump: ACCEPT
    - save: True

default-drop:
  iptables.set_policy:
    - order: 1
    - table: filter
    - chain: INPUT
    - policy: DROP
    - save: True
    - require:
      - iptables: allow-ssh
      - iptables: allow-private
      - iptables: allow-loopback
      - iptables: allow-established
