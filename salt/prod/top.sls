prod:
  'E@ceph-node[12]':
    - modules.haproxy
    - modules.keepalived
    - modules.php
    - modules.nginx
  'ceph-node3.cqt.com':
    - modules.memcached
