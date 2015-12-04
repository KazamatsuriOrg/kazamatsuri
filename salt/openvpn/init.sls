net.ipv4.ip_forward:
  sysctl.present:
    - value: 1

openvpn:
  pkg.installed: []
  service.running:
    - enable: True
    - require:
      - file: /etc/openvpn/server.conf
      - cmd: /etc/openvpn/keys/dh2048.pem
      - cmd: /etc/openvpn/keys/ca.crt
      - cmd: /etc/openvpn/keys/server.crt
    - watch:
      - file: /etc/openvpn/server.conf

easy-rsa:
  pkg.installed: []

patch-pkitool:
  file.replace:
    - name: /usr/share/easy-rsa/pkitool
    - pattern: 'KEY_ALTNAMES="\$KEY_CN"'
    - repl: 'KEY_ALTNAMES="DNS:${KEY_CN}"'
    - require:
      - pkg: easy-rsa

/root/easy-rsa-vars.sh:
  file.managed:
    - source: salt://openvpn/easy-rsa-vars.sh
    - template: jinja
    - require:
      - pkg: easy-rsa

/etc/openvpn/server.conf:
  file.managed:
    - source: salt://openvpn/server.conf
    - template: jinja

/etc/openvpn/keys/:
  cmd.run:
    - name: 'source /root/easy-rsa-vars.sh && /usr/share/easy-rsa/clean-all'
    - creates: /etc/openvpn/keys
    - require:
      - pkg: easy-rsa
      - file: patch-pkitool
      - file: /root/easy-rsa-vars.sh

/etc/openvpn/keys/dh2048.pem:
  cmd.run:
    - name: 'source /root/easy-rsa-vars.sh && /usr/share/easy-rsa/build-dh'
    - creates: /etc/openvpn/keys/dh2048.pem
    - require:
      - cmd: /etc/openvpn/keys/

/etc/openvpn/keys/ca.crt:
  cmd.run:
    - name: 'source /root/easy-rsa-vars.sh && /usr/share/easy-rsa/pkitool --initca'
    - creates: /etc/openvpn/keys/ca.crt
    - require:
      - cmd: /etc/openvpn/keys/

/etc/openvpn/keys/server.crt:
  cmd.run:
    - name: 'source /root/easy-rsa-vars.sh && /usr/share/easy-rsa/pkitool --server server'
    - creates: /etc/openvpn/keys/server.crt
    - env:
      - KEY_CN: Jena
    - require:
      - cmd: /etc/openvpn/keys/
