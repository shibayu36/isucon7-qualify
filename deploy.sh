#!/bin/bash
set -ex
IPADDR=$1
BRANCH=`git symbolic-ref --short HEAD`
USERNAME=$USER

echo $BRANCH

scp nginx/nginx.conf root@$IPADDR:/etc/nginx/nginx.conf
scp nginx/sites-enabled/nginx.conf root@$IPADDR:/etc/nginx/sites-enabled/nginx.conf
scp mysql/my.cnf root@$IPADDR:/etc/mysql/my.cnf
ssh isucon@$IPADDR "source ~/.profile && source ~/.bashrc && cd /home/isucon/isubata && git fetch && git checkout -f origin/$BRANCH && cd webapp/go && make && sudo systemctl restart mysql && sudo systemctl restart nginx && sudo sudo systemctl restart isubata.golang.service && sudo sysctl -p"

# ssh isucon@$IPADDR "source ~/.profile && source ~/.bashrc && cd /home/isucon/isubata && git fetch && git checkout -f origin/$BRANCH && ~/.local/perl/bin/carton install && sudo systemctl restart mysql && sudo systemctl restart nginx && sudo sudo systemctl restart isubata.golang.service && sudo sysctl -p"
