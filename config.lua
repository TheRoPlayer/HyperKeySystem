-- config.lua
local Config = {
    ["Key"] = "lol",
    ["KeyLink"] = "https://linkvertise.com/yourlink",
    ["MainScriptURL"] = "https://raw.githubusercontent.com/TheRoPlayer/hacks/refs/heads/main/2025script.lua",
    ["Title"] = "GEMINI <font color='#7850FF'>PROJECT</font>",
    ["Accent"] = Color3.fromRGB(120, 80, 255)
}

-- SAFETY CHECK LOADER
local LoaderSource = game:HttpGet("https://raw.githubusercontent.com/TheRoPlayer/HyperKeySystem/refs/heads/main/main.lua")

if LoaderSource and LoaderSource ~= "" then
    local LoaderFunction = loadstring(LoaderSource)()
    
    if type(LoaderFunction) == "function" then
        LoaderFunction(Config)
    else
        warn("GEMINI ERROR: Loader script did not return a function! Make sure it starts with 'return function(Config)'")
    end
else
    warn("GEMINI ERROR: Could not reach the Loader URL. Check your link!")
end
