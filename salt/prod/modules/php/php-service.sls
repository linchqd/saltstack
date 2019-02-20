include:
  - modules.php.install

/usr/local/php/etc/php-fpm.conf:
  file.managed:
    - source: salt://modules/php/files/php-fpm.conf
    - user: root
    - group: root
    - mode: 644
    - reuqire:
      - cmd: php-install

/usr/local/php/etc/php.ini:
  file.managed:
    - source: salt://modules/php/files/php.ini
    - user: root
    - group: root
    - mode: 644
    - reuqire:
      - cmd: php-install

/usr/local/php/etc/php-fpm.d/www.conf:
  file.managed:
    - source: salt://modules/php/files/www.conf
    - user: root
    - group: root
    - mode: 644
    - reuqire:
      - cmd: php-install

php-service:
  file.managed:
    - name: /usr/lib/systemd/system/php-fpm.service
    - source: salt://modules/php/files/php-fpm.service
    - user: root
    - group: root
    - mode: 755

  service.running:
    - name: php-fpm.service
    - enable: True
    - require:
      - file: /usr/local/php/etc/php-fpm.d/www.conf
      - file: php-service
      - file: /usr/local/php/etc/php.ini
      - file: /usr/local/php/etc/php-fpm.conf
    - watch:
      - file: /usr/local/php/etc/php-fpm.d/www.conf
      - file: /usr/local/php/etc/php.ini
      - file: /usr/local/php/etc/php-fpm.conf
