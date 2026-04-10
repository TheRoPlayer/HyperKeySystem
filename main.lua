-- Gemini Loader System
local HttpService = game:GetService("HttpService")

-- CONFIG URL: Replace this with your RAW GitHub link to the config.json
local ConfigURL = "https://raw.githubusercontent.com/TheRoPlayer/HyperKeySystem/refs/heads/main/config.json"

local function GetConfig()
    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(ConfigURL))
    end)
    if success then return result end
    warn("Failed to load Gemini Configuration")
    return nil
end

local Config = GetConfig()
if not Config then return end

-- Start the Key System (Protected)
-- We pass the Config data into the UI logic
local KeyUI = [[
    local Data = ...
    local CORRECT_KEY = Data.Key
    local KEY_LINK = Data.KeyLink
    local TARGET_SCRIPT = Data.MainScript

    -- [The Key System UI Code I gave you before goes here]
    -- Instead of a hardcoded key, it uses 'CORRECT_KEY'
    
    -- When the key is correct:
    -- loadstring(game:HttpGet(TARGET_SCRIPT))()
]]

-- Execute the hidden UI logic
loadstring(KeyUI)(Config)
