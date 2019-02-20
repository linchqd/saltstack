include:
  - modules.keepalived.install

keepalived-service:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://modules/keepalived/files/keepalived.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    {% if grains['fqdn'] == 'ceph-node1.cqt.com' %}
    - ROUTEID: haproxy_ha
    - STATEID: MASTER
    - PRIORITYID: 150
    {% elif grains['fqdn'] == 'ceph-node2.cqt.com' %}
    - ROUTEID: haproxy_ha
    - STATEID: BACKUP
    - PRIORITYID: 100
    {% endif %}
  service.running:
    - name: keepalived
    - enable: True
    - require:
      - cmd: keepalived-install
      - file: keepalived-service
      - cmd: keepalived-init
    - watch:
      - file: keepalived-service
