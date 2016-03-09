dnsmasq:
  pkg.installed: []
  service.running:
    - enable: True
    - require:
      - pkg: dnsmasq
    - require_in:
      - file: /etc/resolv.conf
    - watch:
      - file: /etc/dnsmasq.conf
      - file: /etc/dnsmasq_hosts.conf
      - file: /etc/dnsmasq_resolv.conf

/etc/dnsmasq.conf:
  file.managed:
    - source: salt://dnsmasq/dnsmasq.conf
    - require:
      - pkg: dnsmasq

/etc/dnsmasq_hosts.conf:
  file.managed:
    - source: salt://dnsmasq/dnsmasq_hosts.conf
    - template: jinja
    - require:
      - pkg: dnsmasq

/etc/dnsmasq_resolv.conf:
  file.managed:
    - source: salt://dnsmasq/dnsmasq_resolv.conf
    - template: jinja
    - require:
      - pkg: dnsmasq
