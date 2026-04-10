-- config.lua
local Config = {
    ["Key"] = "test",
    ["KeyLink"] = "https://linkvertise.com/yourlink",
    ["MainScriptURL"] = "https://raw.githubusercontent.com/User/Repo/main/protected.lua",
    ["Title"] = "test hub <font color='#7850FF'>PROJECT</font>",
    ["Accent"] = Color3.fromRGB(120, 80, 255)
}

-- This fetches your Obfuscated Loader and "injects" the config into it
local Loader = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheRoPlayer/HyperKeySystem/refs/heads/main/main.lua"))()
Loader(Config)
