#!/bin/bash
set -ex

if [ -f /var/log/mysql/mysql-slow.log ]; then
    sudo mv /var/log/mysql/mysql-slow.log /var/log/mysql/mysql-slow.log.$(date "+%Y%m%d_%H%M%S")
fi
if [ -f /var/log/nginx/access.log.tsv ]; then
    sudo mv /var/log/nginx/access.log.tsv /var/log/nginx/access.log.tsv.$(date "+%Y%m%d_%H%M%S")
fi
sudo systemctl restart mysql
sudo systemctl restart nginx
sudo systemctl restart isubata.golang.service

# ベンチのたびに初期データ投入するのは厳しそう
if [ $INIT_DATABASE ]; then
  sudo /home/isucon/isubata/db/init.sh
  zcat /home/isucon/isubata/bench/isucon7q-initial-dataset.sql.gz | sudo mysql isubata
fi

cd /home/isucon/isubata/bench/
./bin/bench -remotes=127.0.0.1 -output result.json
jq . < result.json
