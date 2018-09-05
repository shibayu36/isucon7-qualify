#!/bin/bash
set -ex
IPADDR=$1

ssh isucon@$IPADDR "export INIT_DATABASE=$INIT_DATABASE; /home/isucon/isubata/bench.sh"
scp isucon@$IPADDR:isubata/bench/result.json .
