postfix:
  pkg.installed: []

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
  cmd.run:
    - name: /usr/sbin/postalias /etc/aliases
    - creates: /etc/postfix/sasl_passwd.db
    - watch:
      - file: /etc/aliases
    - require:
      - file: /etc/aliases

/etc/postfix/sasl_passwd:
  file.managed:
    - source: salt://postfix/sasl_passwd
    - template: jinja
    - require:
      - pkg: postfix

/etc/postfix/sasl_passwd.db:
  cmd.run:
    - name: /usr/sbin/postmap /etc/postfix/sasl_passwd
    - creates: /etc/postfix/sasl_passwd.db
    - watch:
      - file: /etc/postfix/sasl_passwd
    - require:
      - file: /etc/postfix/sasl_passwd
