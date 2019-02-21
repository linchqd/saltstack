include:
  - modules.nginx.install

/usr/local/nginx-1.14.1/conf/nginx.conf:
  file.managed:
    - source: salt://modules/nginx/files/nginx.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: nginx-install

nginx-service:
  file.managed:
    {% if grains['osmajorrelease'] == 7 %}
    - name: /usr/lib/systemd/system/nginx.service
    - source: salt://modules/nginx/files/nginx-centos7
    {% elif grains['osmajorrelease'] == 6 %}
    - name: /etc/init.d/nginx
    - source: salt://modules/nginx/files/nginx-centos6
    {% endif %}
    - user: root
    - group: root
    - mode: 755
  
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - require:
      - cmd: nginx-install
      - file: /usr/local/nginx-1.14.1/conf/nginx.conf
      - file: nginx-service
    - watch:
      - file: /usr/local/nginx-1.14.1/conf/nginx.conf
