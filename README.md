# saltstack
salt configure tree


# php memcache 

https://github.com/websupport-sk/pecl-memcache/archive/php7.zip

salt -E 'ceph-node[12]' state.sls modules/php/php-memcache saltenv=prod

# php redis

wget http://pecl.php.net/get/redis-3.1.2.tgz

salt -E 'ceph-node[12]' state.sls modules/php/php-redis saltenv=prod
