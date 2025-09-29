-- shorten.lua
-- 生成随机域名
local charset = {}
do
    for c = 97, 122 do table.insert(charset, string.char(c)) end -- a-z
end

-- 随机字符串
local function randomString(length)
    local result = {}
    for i = 1, length do
        local index = math.random(1, #charset)
        result[i] = charset[index]
    end
    return table.concat(result)
end

-- 随机域名
local function randomDomain()
    return randomString(8) .. ".com"
end

-- 每个请求执行
request = function()
    local url = "http://localhost:8888/shorten?url=" .. randomDomain()
    return wrk.format("GET", url)
end