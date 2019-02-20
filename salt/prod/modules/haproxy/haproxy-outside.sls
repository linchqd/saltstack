include:
  - modules.haproxy.install

haproxy-service:
  file.managed:
    - name: /etc/haproxy/haproxy.cfg
    - source: salt://modules/haproxy/files/haproxy-outside.cfg
    - root: root
    - group: root
    - mode: 644
  service.running:
    - name: haproxy
    - enable: True
    - reload: True
    - require:
      - cmd: haproxy_install
      - cmd: haproxy-init
      - file: haproxy-service
    - watch:
      - file: haproxy-service
