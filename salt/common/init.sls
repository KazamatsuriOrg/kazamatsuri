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

python-pip:
  pkg.installed

unzip:
  pkg.installed

apt-transport-https:
  pkg.installed

/etc/rc.local:
  file.managed:
    - source: salt://common/rc.local.sh
    - mode: 755

/etc/resolv.conf:
  file.managed:
    - source: salt://common/resolv.conf
    - template: jinja
