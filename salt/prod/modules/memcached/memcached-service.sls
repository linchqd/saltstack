include:
  - modules.memcached.install
  - modules.memcached.user

memcached-service:
  cmd.run:
    - name: /usr/local/memcached/bin/memcached -d -m 128 -p 11211 -c 8096 -u www
    - unless: netstat -lnput | grep 11211
    - require:
      - cmd: memcached-install
      - user: www-user-group 
