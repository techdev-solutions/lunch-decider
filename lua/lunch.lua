if ngx.req.get_method() ~= "GET" then
  ngx.status = ngx.HTTP_NOT_ALLOWED;
  ngx.exit(ngx.HTTP_OK);
  return;
end

local redis = require "resty.redis";

local red = redis:new();

local ok, err = red:connect("127.0.0.1", 6379);
if not ok then
    ngx.say("failed to connect to redis", err);
    return
end

local randomOption = red:srandmember("lunch.options", 1);
local randomName = red:hgetall("lunch.options:" .. randomOption[1]);
local response = json.encode(red:array_to_hash(randomName));

math.randomseed( os.time() );
local sleepTime = math.random(0, 2);
ngx.sleep(sleepTime);

ngx.say(response);
