# techdev lunch decider
The lunch decider is a web application running in [OpenResty](http://openresty.org) with [Redis](http://redis.io) as
a storage backend.

See [this blog article](http://blog.techdev.de/the-techdev-lunch-deciding-tool) for its story!

# How to run
Prerequirements:

1. Redis must be installed and a Redis server must be running on the port 6379
2. OpenResty must be installed under `/usr/local/openresty` (if it's somewhere else edit `start.sh`).

Then it suffices to run `start.sh` in the folder where it lies. After that the tool is available under
[http://localhost:8080](http://localhost:8080).

Start to add some options for lunch and let the tool decide for you where to eat!
