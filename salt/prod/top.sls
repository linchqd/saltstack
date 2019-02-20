prod:
  'E@ceph-node[12]':
    - modules.haproxy
    - modules.keepalived
  'ceph-node3.cqt.com':
    - modules.memcached
