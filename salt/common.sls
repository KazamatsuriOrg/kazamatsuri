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

unzip:
  pkg.installed

apt-transport-https:
  pkg.installed
