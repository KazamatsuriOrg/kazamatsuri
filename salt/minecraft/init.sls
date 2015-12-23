minecraft:
  user.present:
    - gid_from_name: True
    - system: True
    - home: /var/lib/minecraft
  service.running:
    - enable: True
    - require:
      - file: /etc/systemd/system/minecraft.service
      - cmd: build_spigot

/srv/minecraft/:
  file.directory:
    - user: minecraft
    - group: minecraft
    - require:
      - user: minecraft

/srv/minecraft/BuildTools.jar:
  file.managed:
    - source: "https://hub.spigotmc.org/jenkins/job/BuildTools/{{ pillar['minecraft']['buildtools']['build'] }}/artifact/target/BuildTools.jar"
    - source_hash: {{ pillar['minecraft']['buildtools']['hash'] }}
    - user: minecraft
    - require:
      - user: minecraft
      - file: /srv/minecraft/

build_spigot:
  cmd.run:
    - name: /usr/bin/java -jar BuildTools.jar --rev {{ pillar['minecraft']['version'] }}
    - cwd: /srv/minecraft
    - user: minecraft
    - creates: /srv/minecraft/spigot-{{ pillar['minecraft']['version'] }}.jar
    - require:
      - user: minecraft
      - file: /srv/minecraft/
      - pkg: java

/etc/systemd/system/minecraft.service:
  file.managed:
    - source: salt://minecraft/minecraft.service
    - template: jinja

{% for filename in pillar['minecraft']['files'] %}
/srv/minecraft/{{ filename }}:
  file.managed:
    - source: salt://minecraft/files/{{ filename }}
    - user: minecraft
    - group: minecraft
    - mode: 644
    - require:
      - file: /srv/minecraft/
    - require_in:
      - service: minecraft
{% endfor %}
