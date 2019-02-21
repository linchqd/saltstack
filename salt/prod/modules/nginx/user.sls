nginx-user-group:
  group.present:
    - name: nginx
    - gid: 2005
    - unless: grep nginx /etc/gshadow
  user.present:
    - name: nginx
    - fullname: nginx
    - uid: 2005
    - gid: 2005
    - shell: /sbin/nologin
    - unless: grep nginx /etc/passwd
