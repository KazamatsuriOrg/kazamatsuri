postfix:
  pkg.installed:
    - pkgs:
      - postfix
      - postfix-pgsql
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: postfix
    - watch:
      - file: /etc/mailname
      - file: /etc/postfix/main.cf
      - file: /etc/postfix/master.cf
      - cmd: /etc/aliases
      - cmd: /etc/postfix/virtual
      # - cmd: /etc/postfix/sasl_passwd.db

/etc/mailname:
  file.managed:
    - contents: {{ pillar['smtp']['mailname'] }}
    - require:
      - pkg: postfix

/etc/postfix/main.cf:
  file.managed:
    - source: salt://postfix/main.cf
    - template: jinja
    - require:
      - pkg: postfix

/etc/postfix/master.cf:
  file.managed:
    - source: salt://postfix/master.cf
    - template: jinja
    - require:
      - pkg: postfix

/etc/aliases:
  file.managed:
    - source: salt://postfix/aliases
    - template: jinja
    - require:
      - pkg: postfix
  cmd.wait:
    - name: /usr/sbin/postalias /etc/aliases
    - watch:
      - file: /etc/aliases

/etc/postfix/virtual:
  file.managed:
    - source: salt://postfix/virtual
    - template: jinja
    - require:
      - pkg: postfix
  cmd.wait:
    - name: /usr/sbin/postmap /etc/postfix/virtual
    - watch:
      - file: /etc/postfix/virtual

# /etc/postfix/sasl_passwd:
#   file.managed:
#     - source: salt://postfix/sasl_passwd
#     - template: jinja
#     - user: root
#     - group: root
#     - mode: 600
#     - require:
#       - pkg: postfix

# /etc/postfix/sasl_passwd.db:
#   cmd.wait:
#     - name: /usr/sbin/postmap /etc/postfix/sasl_passwd
#     - watch:
#       - file: /etc/postfix/sasl_passwd
#     - require:
#       - file: /etc/postfix/sasl_passwd
