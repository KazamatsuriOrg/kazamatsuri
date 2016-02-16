fail2ban:
  pkg.installed: []
  service.running:
    - require:
      - pkg: fail2ban
    - watch:
      - file: /etc/fail2ban/fail2ban.conf
      - file: /etc/fail2ban/jail.conf

/etc/fail2ban/fail2ban.conf:
  file.managed:
    - source: salt://fail2ban/fail2ban.conf
    - template: jinja
    - require:
      - pkg: fail2ban

/etc/fail2ban/jail.conf:
  file.managed:
    - source: salt://fail2ban/jail.conf
    - template: jinja
    - require:
      - pkg: fail2ban
