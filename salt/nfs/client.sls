nfs-client:
  pkg.installed:
    - name: nfs-common

/shared:
  mount.mounted:
    {% if 'storage' in grains['roles'] %}
    - fstype: none
    - opts: bind
    - device: /srv/shared
    {% else %}
    - fstype: nfs4
    - device: "{{ salt['mine.get']('roles:storage', 'private_ip_addrs', expr_form='grain').values()[0][0] }}:/srv/shared"
    {% endif %}
    - mkmnt: True
    - require:
      - pkg: nfs-client
