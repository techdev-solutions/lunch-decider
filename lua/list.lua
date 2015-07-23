local redis = require "resty.redis";
local red = redis:new();
local ok, err = red:connect("127.0.0.1", 6379);
if not ok then
    ngx.say("failed to connect to redis", err);
    return
end

local function list()
  local lunchOptions = red:smembers "lunch.options";
  local data = {};
  for key, value in pairs(lunchOptions) do
    local optionValues = red:hgetall("lunch.options:" .. value);
    local option = red:array_to_hash(optionValues); 
    table.insert(data, option); 
  end
  local response = json.encode(data);
  ngx.say(response);
end

local function create()
 -- todo: get new id, save new hash with name from request param, add new id to list, return id
end

if ngx.req.get_method() == "GET" then
  list();
elseif ngx.req.get_method() == "POST" then
  create();
else
  ngx.status = ngx.HTTP_NOT_ALLOWED;
  ngx.exit(ngx.HTTP_OK);
end


