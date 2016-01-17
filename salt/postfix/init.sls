postfix:
  pkg.installed: []
  service.running:
    - enable: True
    - require:
      - pkg: postfix
    - watch:
      - file: /etc/postfix/main.cf
      - cmd: /etc/aliases.db
      - cmd: /etc/postfix/sasl_passwd.db

/etc/mailname:
  file.managed:
    - contents: kazamatsuri.org
    - require:
      - pkg: postfix

/etc/postfix/main.cf:
  file.managed:
    - source: salt://postfix/main.cf
    - template: jinja
    - require:
      - pkg: postfix

/etc/aliases:
  file.managed:
    - source: salt://postfix/aliases
    - template: jinja
    - require:
      - pkg: postfix

/etc/aliases.db:
  cmd.wait:
    - name: /usr/sbin/postalias /etc/aliases
    - watch:
      - file: /etc/aliases
    - require:
      - file: /etc/aliases

/etc/postfix/sasl_passwd:
  file.managed:
    - source: salt://postfix/sasl_passwd
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - require:
      - pkg: postfix

/etc/postfix/sasl_passwd.db:
  cmd.wait:
    - name: /usr/sbin/postmap /etc/postfix/sasl_passwd
    - watch:
      - file: /etc/postfix/sasl_passwd
    - require:
      - file: /etc/postfix/sasl_passwd
