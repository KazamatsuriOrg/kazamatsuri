libsasl:
  pkg.installed:
    - pkgs:
      - libsasl2-2
      - sasl2-bin
  service.running:
    - name: saslauthd
    - enable: True
    - require:
      - pkg: libsasl
    - watch:
      - file: /etc/default/saslauthd
      - file: /etc/sasl2/smtpd.conf

/etc/default/saslauthd:
  file.managed:
    - source: salt://libsasl/saslauthd.sh
    - template: jinja
    - require:
      - pkg: libsasl

/etc/sasl2/smtpd.conf:
  file.managed:
    - source: salt://libsasl/smtpd.conf
    - template: jinja
    - makedirs: True
    - require:
      - pkg: libsasl

sasl-smtp-group:
  group.present:
    - name: sasl
    - system: True
