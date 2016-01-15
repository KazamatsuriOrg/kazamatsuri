essentials:
  pkg.installed:
    - pkgs:
      - build-essential
      - vim
      - git
      - tmux
      - htop
      - strace
      - ltrace
      - zsh
      - curl

unzip:
  pkg.installed

apt-transport-https:
  pkg.installed

/etc/rc.local:
  file.managed:
    - source: salt://common/rc.local.sh
    - mode: 755