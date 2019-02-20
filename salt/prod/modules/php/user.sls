php-fpm-user-group:
  group.present:
    - name: php-fpm
    - gid: 2002
    - unless: grep php-fpm /etc/gshadow
  
  user.present:
    - name: php-fpm
    - fullname: php-fpm
    - uid: 2002
    - gid: 2002
    - shell: /sbin/nologin
    - unless: grep php-fpm /etc/passwd
