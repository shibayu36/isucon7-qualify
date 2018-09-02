#!/bin/bash
set -ex

if [ -f /var/lib/mysql/mysqld-slow.log ]; then
    sudo mv /var/lib/mysql/mysqld-slow.log /var/lib/mysql/mysqld-slow.log.$(date "+%Y%m%d_%H%M%S")
fi
if [ -f /var/log/nginx/access.log.tsv ]; then
    sudo mv /var/log/nginx/access.log.tsv /var/log/nginx/access.log.tsv.$(date "+%Y%m%d_%H%M%S")
fi
sudo systemctl restart mysql
sudo systemctl restart nginx
sudo systemctl restart isubata.golang.service

cd /home/isucon/isubata/bench/
./bin/bench -remotes=127.0.0.1 -output result.json
jq . < result.json
