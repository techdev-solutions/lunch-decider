local redis = require "resty.redis";
local red = redis:new();
local ok, err = red:connect("127.0.0.1", 6379);
if not ok then
    ngx.say("failed to connect to redis", err);
    return
end

local function delete(id)
  red:srem("lunch.options", id);
  red:del("lunch.options:" .. id);
  ngx.status = ngx.HTTP_OK;
  ngx.exit(ngx.HTTP_OK);
end

if ngx.req.get_method() == "DELETE" then
  delete(ngx.var.id); 
else
  ngx.status = ngx.HTTP_NOT_ALLOWED;
  ngx.exit(ngx.HTTP_OK);
end

