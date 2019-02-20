include:
  - modules.keepalived.pkg

{% set keepalived_tarfile = 'keepalived-1.2.17.tar.gz' %}
{% set keepalived_source_tarfile = 'salt://modules/keepalived/files/keepalived-1.2.17.tar.gz' %}

keepalived-install:
  file.managed:
    - name: /usr/local/src/{{ keepalived_tarfile }}
    - source: {{ keepalived_source_tarfile }}
    - user: root
    - group: root
    - mode: 755

  cmd.run:
    - name: cd /usr/local/src && tar zxf {{ keepalived_tarfile }} && cd keepalived-1.2.17 && ./configure --prefix=/usr/local/keepalived --disable-fwmark && make && make install
    - unless: test -d /usr/local/keepalived
    - require:
      - file: keepalived-install
      - pkg: keepalived-requirements-pkg

/etc/sysconfig/keepalived:
  file.managed:
    - source: salt://modules/keepalived/files/keepalived.sysconfig
    - user: root
    - group: root
    - mode: 644

keepalived-init:
  file.managed:
    - name: /etc/init.d/keepalived
    - source: salt://modules/keepalived/files/keepalived.init
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: chkconfig --add keepalived
    - unless: chkconfig --list | grep keepalived
    - require:
      - file: keepalived-init

/etc/keepalived:
  file.directory:
    - user: root
    - group: root
    - mode: 755
