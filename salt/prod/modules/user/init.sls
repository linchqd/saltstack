www-user-group:
  group.present:
    - name: www
    - gid: 2000
    - unless: grep www /etc/gshadow
  user.present:
    - name: www
    - uid: 2000
    - gid: 2000
    - fullname: www
    - shell: /sbin/nologin
    - unless: grep www /etc/passwd
