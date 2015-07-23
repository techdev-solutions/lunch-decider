#!/bin/sh
PATH=/usr/local/openresty/nginx/sbin:$PATH
nginx -p `pwd`/ -c conf/nginx.conf
