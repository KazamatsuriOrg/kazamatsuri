nfs-client:
  pkg.installed:
    - name: nfs-common

/shared/:
  mount.mounted:
    - fstype: nfs4
    - device: "{{ pillar['db_host'] }}:/srv/shared"
    - mkmnt: True
