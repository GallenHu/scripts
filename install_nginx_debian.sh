#! /bin/bash
# 安装最新版本nginx, 适用于
# debian 7
# debian 8

Close_Apache2()
{
    if [ ! -f "/etc/init.d/apache2" ]; then
        echo '/etc/init.d/apache2 not exsit!\n'
    else
        /etc/init.d/apache2 stop
    fi
}
Close_Apache2

Install_Nginx()
{
    v=`cat /etc/os-release|grep VERSION_ID|cut -d \" -f 2`

    if [ "$v" == "7" ]; then
        echo "deb http://nginx.org/packages/debian/ wheezy nginx" >> /etc/apt/sources.list
        echo "deb-src http://nginx.org/packages/debian/ wheezy nginx" >> /etc/apt/sources.list
    else
        echo "deb http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list
        echo "deb-src http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list
    fi

    wget http://nginx.org/keys/nginx_signing.key && apt-key add nginx_signing.key && apt-get update && apt-get install nginx -y
}
Install_Nginx

systemctl status nginx.service
