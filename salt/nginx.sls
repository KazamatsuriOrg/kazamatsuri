nginx:
  pkg.installed:
    - require:
      - pkgrepo: dotdeb
