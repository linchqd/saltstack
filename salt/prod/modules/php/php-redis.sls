php-ext-redis:
  file.managed:
    - name: /usr/local/src/redis-3.1.2.tgz
    - source: salt://modules/php/files/redis-3.1.2.tgz
    - user: root
    - group: root
    - mode: 755

  cmd.run:
    - name: cd /usr/local/src/ && tar zxf redis-3.1.2.tgz && cd redis-3.1.2 && phpize && ./configure --with-php-config=/usr/local/php/bin/php-config && make && make install
    - unless: test -f /usr/local/php/lib/php/extensions/*/redis.so
    - require:
      - file: php-ext-redis
