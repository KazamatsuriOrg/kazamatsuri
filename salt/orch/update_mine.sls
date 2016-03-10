update_pillar:
  salt.function:
    - tgt: '*'
    - name: saltutil.refresh_pillar

update_mine:
  salt.function:
    - tgt: '*'
    - name: mine.update
    - require:
      - salt: update_pillar
