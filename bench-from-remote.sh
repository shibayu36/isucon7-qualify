#!/bin/bash
set -ex
IPADDR=$1

ssh isucon@$IPADDR "/home/isucon/isubata/bench.sh"
scp isucon@$IPADDR:isubata/bench/result.json .
