# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "letsencrypt/map.jinja" import letsencrypt with context %}

letsencrypt-client:
  {% if letsencrypt.use_package %}
  pkg.installed:
    - pkgs: {{ letsencrypt.pkgs }}
  {% else %}
  pkg.installed:
    - name: git
  {% if letsencrypt.version is defined and letsencrypt.version|length %}
  git.cloned:
    - name: https://github.com/letsencrypt/letsencrypt
    - branch: {{ letsencrypt.version }}
    - target: {{ letsencrypt.cli_install_dir }}
    - force_fetch: True
  {% else %}
  git.latest:
    - name: https://github.com/letsencrypt/letsencrypt
    - target: {{ letsencrypt.cli_install_dir }}
    - force_reset: True
    - force_fetch: True
  {% endif %}
  {% endif %}
