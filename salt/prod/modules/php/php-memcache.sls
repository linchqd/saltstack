php-ext-memcache:
  file.managed:
    - name: /usr/local/src/php7.zip
    - source: salt://modules/php/files/php7.zip
    - user: root
    - group: root
    - mode: 755

  pkg.installed:
    - name: unzip

  cmd.run:
    - name: cd /usr/local/src/ && unzip php7.zip && cd pecl-memcache-php7 && phpize && ./configure --with-php-config=/usr/local/php/bin/php-config && make && make install
    - unless: test -f /usr/local/php/lib/php/extensions/*/memcache.so
    - require:
      - file: php-ext-memcache
