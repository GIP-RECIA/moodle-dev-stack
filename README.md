Mettre en pause un des redis un des redis :
docker exec mde_redis1 redis-cli -p 6379 DEBUG sleep 30

Consulter les get et set d'un des redis :
docker exec mde_redis1 redis-cli monitor | grep -E ' "(G|S)ET" '

Faire un set sur un des redis :
docker exec mde_redis1 redis-cli SET hello "world"

Faire un get sur un des redis :
docker exec mde_redis1 redis-cli GET hello

Faire un set sur haproxy :
docker exec mde_redis1 redis-cli -h haproxy -p 6380 SET hello "world"

Faire un get sur haproxy :
docker exec mde_redis1 redis-cli -h haproxy GET hello

Faire un ping sur un redis/haproxy :
docker exec mde_redis1 redis-cli ping

Savoir si un redis est amster :
docker exec mde_redis1 redis-cli info replication | grep role