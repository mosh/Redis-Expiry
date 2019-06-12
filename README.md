# Redis-Expiry
Redis key expiry example

example config

http://download.redis.io/redis-stable/redis.conf

notifications

https://redis.io/topics/notifications

Example 2: to get the stream of the expired keys subscribing to channel
#             name __keyevent@0__:expired use:
#
#  notify-keyspace-events Ex

docker page for redis

https://hub.docker.com/_/redis


Running docker reds with a conf

docker run -v /Users/JohnMoshakis/Documents/develop/RedisConf/redis.conf:/usr/local/etc/redis/redis.conf --name some-redis -p 6379:6379 -d redis redis-server /usr/local/etc/redis/redis.conf


redis.conf is

notify-keyspace-events Ex

