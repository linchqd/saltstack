yum_repo_epel_release:
  pkg.installed:
    - source:
      - epel-release: http://mirrors.aliyun.com/epel/epel-release-latest-7.noarch.rpm
    - unless: rpm -qa | grep epel-release-latest-7
