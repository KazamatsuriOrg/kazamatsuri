kazamatsuri:
  ghost:
    db_password: SOME_SECRET

  discourse:
    db_password: SOME_SECRET

  s3:
    access_key_id:
    access_key:
    bucket: kazamatsuri
    region: us-west-1
    cdn:

rokkenjima:
  ghost:
    db_password: SOME_SECRET

  discourse:
    db_password: SOME_SECRET

  s3:
    access_key_id:
    access_key:
    bucket: rokkenjima
    region: us-west-1
    cdn:

smtp:
  host: smtp.example.com
  port: 587
  username: username@example.com
  password: SOME_SECRET

haproxy:
  stats_users:
    - admin: password

cloud:
  digital_ocean:
    token: YOUR_TOKEN_HERE
    key_file: /etc/salt/keys/kazamatsuri
    key_names: id_dsa,kazamatsuri

newrelic:
  license_key:

syslog:
  host:

yumemi:
  discord:
    email:
    password:
