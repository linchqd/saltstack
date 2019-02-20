include:
  - modules.haproxy.pkg

haproxy_install:
  file.managed:
    - name: /usr/local/src/haproxy-1.6.3.tar.gz
    - source: salt://modules/haproxy/files/haproxy-1.6.3.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src/ && tar zxf haproxy-1.6.3.tar.gz && cd haproxy-1.6.3 && make TARGET=linux2628 PREFIX=/usr/local/haproxy-1.6.3 && make install PREFIX=/usr/local/haproxy-1.6.3 && ln -s /usr/local/haproxy-1.6.3 /usr/local/haproxy
    - unless: test -L /usr/local/haproxy
    - require:
      - pkg: haproxy-requirements-pkg
      - file: haproxy_install

haproxy-init:
  file.managed:
    - name: /etc/init.d/haproxy
    - source: salt://modules/haproxy/files/haproxy.init
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: chkconfig --add haproxy
    - unless: chkconfig --list | grep haproxy
    - require:
      - file: haproxy-init

net.ipv4.ip_nonlocal_bind:
  sysctl.present:
    - value: 1

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1

haproxy-config-dir:
  file.directory:
    - name: /etc/haproxy
    - user: root
    - group: root
    - mode: 755
