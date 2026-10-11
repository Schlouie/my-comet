-- Auto-generated loader
-- Fetches and runs: https://raw.githubusercontent.com/Schlouie/my-comet/main/CometZ.lua

local URL = "https://raw.githubusercontent.com/Schlouie/my-comet/main/CometZ.lua"

local function httpGet(url)
    if typeof(syn) == "table" and syn.request then
        local ok, r = pcall(syn.request, {Url = url, Method = "GET"})
        if ok and r and r.Body and #r.Body > 0 then return r.Body end
    end
    if typeof(http) == "table" and http.request then
        local ok, r = pcall(http.request, {Url = url, Method = "GET"})
        if ok and r and r.Body and #r.Body > 0 then return r.Body end
    end
    if typeof(request) == "function" then
        local ok, r = pcall(request, {Url = url, Method = "GET"})
        if ok and r and r.Body and #r.Body > 0 then return r.Body end
    end
    if typeof(game.HttpGet) == "function" then
        local ok, r = pcall(function() return game:HttpGet(url, true) end)
        if ok and type(r) == "string" and #r > 0 then return r end
        ok, r = pcall(function() return game:HttpGet(url) end)
        if ok and type(r) == "string" and #r > 0 then return r end
    end
    local ok, r = pcall(function()
        return game:GetService("HttpService"):GetAsync(url, true)
    end)
    if ok and type(r) == "string" and #r > 0 then return r end
    error("[loader] no working HTTP method for " .. url)
end

local src = httpGet(URL)
if type(src) ~= "string" or #src == 0 then
    error("[loader] empty response from " .. URL)
end
if src:sub(1,1) == "<" then
    error("[loader] server returned HTML (repo is private or URL is wrong): " .. URL)
end

local fn, err = (loadstring or load)(src, "@" .. URL)
if not fn then error("[loader] compile error: " .. tostring(err)) end
return fn()