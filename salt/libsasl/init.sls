libsasl:
  pkg.removed:
    - pkgs:
      - sasl2-bin
    - require:
      - service: libsasl
      - file: /etc/default/saslauthd
      - file: /etc/sasl2/smtpd.conf
  service.dead:
    - name: saslauthd
    - enable: False

/etc/default/saslauthd:
  file.absent: []

/etc/sasl2/smtpd.conf:
  file.absent: []

sasl-smtp-group:
  group.present:
    - name: sasl
    - delusers:
      - postfix
