#!/bin/sh
 
sed -i "s/\$SENTINEL_QUORUM/${SENTINEL_QUORUM}/g" /redis/sentinel.conf
sed -i "s/\$SENTINEL_DOWN_AFTER/${SENTINEL_DOWN_AFTER}/g" /redis/sentinel.conf
sed -i "s/\$SENTINEL_FAILOVER_TIMEOUT/${SENTINEL_FAILOVER_TIMEOUT}/g" /redis/sentinel.conf

echo "bonjour"
redis-server /redis/sentinel.conf --sentinel