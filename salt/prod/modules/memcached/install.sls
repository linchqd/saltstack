include:
  - modules.memcached.pkg

memcached-install:
  file.managed:
    - name: /usr/local/src/memcached-1.5.12.tar.gz
    - source: salt://modules/memcached/files/memcached-1.5.12.tar.gz
    - user: root
    - group: root
    - mode: 755
  
  cmd.run:
    - name: cd /usr/local/src/ && tar zxf memcached-1.5.12.tar.gz && cd memcached-1.5.12 && ./configure --prefix=/usr/local/memcached --enable-64bit && make && make install
    - unless: test -d /usr/local/memcached
    - require:
      - pkg: memcached-requirements-pkg
      - file: memcached-install
