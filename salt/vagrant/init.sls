/etc/dhcp/dhclient-enter-hooks.d/dont-touch-resolvconf:
  file.managed:
    - source: salt://vagrant/dhclient-dont-touch-resolvconf.sh
    - mode: 755
    - require_in:
      - file: /etc/resolv.conf
