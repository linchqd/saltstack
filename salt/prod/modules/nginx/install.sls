include:
  - modules.nginx.pkg
  - modules.nginx.user

pcre-install:
  file.managed:
    - name: /usr/local/src/pcre-8.37.tar.gz
    - source: salt://modules/nginx/files/pcre-8.37.tar.gz
    - user: root
    - group: root
    - mode: 755

  cmd.run:
    - name: cd /usr/local/src/ && tar zxf pcre-8.37.tar.gz && cd pcre-8.37 && ./configure --prefix=/usr/local/pcre && make && make install
    - unless: test -d /usr/local/pcre
    - require:
      - pkg: nginx-requirements-pkg
      - file: pcre-install

nginx-install:
  file.managed:
    - name: /usr/local/src/nginx-1.14.1.tar.gz
    - source: salt://modules/nginx/files/nginx-1.14.1.tar.gz
    - user: root
    - group: root
    - mode: 755

  cmd.run:
    - name: cd /usr/local/src/ && tar zxf nginx-1.14.1.tar.gz && cd nginx-1.14.1 && ./configure --user=nginx --group=nginx --prefix=/usr/local/nginx-1.14.1 --conf-path=/usr/local/nginx-1.14.1/conf/nginx.conf --error-log-path=/usr/local/nginx-1.14.1/logs/error.log --http-log-path=/usr/local/nginx-1.14.1/logs/access.log --pid-path=/usr/local/nginx-1.14.1/logs/nginx.pid --lock-path=/usr/local/nginx-1.14.1/logs/nginx.lock --with-http_ssl_module --with-http_stub_status_module --with-http_gzip_static_module --with-http_xslt_module --with-http_sub_module --with-http_realip_module --with-http_image_filter_module --with-http_geoip_module --with-http_dav_module --with-http_addition_module --http-client-body-temp-path=/usr/local/nginx-1.14.1/client_body_temp/ --http-fastcgi-temp-path=/usr/local/nginx-1.14.1/fastcgi_temp/ --http-proxy-temp-path=/usr/local/nginx-1.14.1/proxy_temp/ --http-scgi-temp-path=/usr/local/nginx-1.14.1/scgi_temp/ --http-uwsgi-temp-path=/usr/local/nginx-1.14.1/uwsgi_temp/ --with-debug --with-file-aio --with-pcre=/usr/local/src/pcre-8.37 && make && make install
    - unless: test -d /usr/local/nginx-1.14.1
    - require:
      - pkg: nginx-requirements-pkg
      - file: nginx-install
      - cmd: pcre-install
nginx-sbin-link:
  cmd.run:
    - name: ln -s /usr/local/nginx-1.14.1/sbin/nginx /usr/local/sbin/
    - unless: test -L /usr/local/sbin/nginx
    - require:
      - cmd: nginx-install
