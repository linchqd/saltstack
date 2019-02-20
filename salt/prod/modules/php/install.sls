include:
  - modules.php.pkg
  - modules.php.user

php-install:
  file.managed:
    - name: /usr/local/src/php-7.2.4.tar.gz
    - source: salt://modules/php/files/php-7.2.4.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src/ && tar zxf php-7.2.4.tar.gz && cd php-7.2.4 && ./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-zlib-dir --with-freetype-dir --enable-mbstring --with-libxml-dir=/usr --enable-xmlreader --enable-xmlwriter --enable-soap --enable-calendar --with-curl --with-zlib --with-gd --with-pdo-sqlite --with-pdo-mysql=mysqlnd --with-mysqli=mysqlnd --with-mysql-sock --enable-mysqlnd --disable-rpath --enable-inline-optimization --with-bz2 --with-zlib --enable-sockets --enable-sysvsem --enable-sysvshm --enable-pcntl --enable-mbregex --enable-exif --enable-bcmath --with-mhash --enable-zip --with-pcre-regex --with-jpeg-dir=/usr --with-png-dir=/usr --with-openssl --enable-ftp --with-kerberos --with-gettext --with-xmlrpc --with-xsl --enable-fpm --with-fpm-user=php-fpm --with-fpm-group=php-fpm --with-fpm-systemd --with-iconv-dir --with-libdir=lib64 --with-pear --enable-shmop --enable-xml && make && make install
    - unless: test -d /usr/local/php
    - require:
      - user: php-fpm-user-group
      - file: php-install

php-bin-link:
  cmd.run:
    - name: ln -s /usr/local/php/bin/* /usr/local/bin/ && ln -s /usr/local/php/sbin/* /usr/local/sbin/
    - require:
      - cmd: php-install
    - unless: test -L /usr/local/bin/phpize

pdo_mysql:
  cmd.run:
    - name: cd /usr/local/src/php-7.2.4/ext/pdo_mysql/ && phpize && ./configure --with-php-config=/usr/local/php/bin/php-config --with-pdo-mysql=mysqlnd && make && make install
    - require:
      - cmd: php-bin-link
    - unless: test -f /usr/local/php/lib/php/extensions/*/pdo_mysql.so
