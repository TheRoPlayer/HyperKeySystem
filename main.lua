--[[
    GEMINI KEY SYSTEM - ALL-IN-ONE
    - Non-Draggable
    - Cannot be closed without a key
    - Customizable Settings below
]]

local Settings = {
    ["Key"] = "UWUtest", -- The actual key
    ["KeyLink"] = "https://linkvertise.com/yourlink", -- Where they get the key
    ["ScriptToRun"] = function() 
        -- PASTE YOUR MAIN SCRIPT/EXECUTOR CODE INSIDE THESE BRACKETS
        print("Key Verified! Main Script Running...")
        
        -- Example: loadstring(game:HttpGet("https://raw.githubusercontent.com/..."))()
    end,
    ["Title"] = "test hub <font color='#7850FF'>PROJECT</font>",
    ["AccentColor"] = Color3.fromRGB(120, 80, 255)
}

--// Services
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

--// UI Setup
local Parent = (game:GetService("CoreGui") or LP:WaitForChild("PlayerGui"))
if Parent:FindFirstChild("Gemini_Gatekeeper") then Parent["Gemini_Gatekeeper"]:Destroy() end

local ScreenGui = Instance.new("ScreenGui", Parent)
ScreenGui.Name = "Gemini_Gatekeeper"
ScreenGui.IgnoreGuiInset = true -- Covers the whole screen

-- Background Blur/Overlay
local Overlay = Instance.new("Frame", ScreenGui)
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3 = Color3.new(0,0,0)
Overlay.BackgroundTransparency = 0.5
Overlay.Active = true -- Blocks clicks to the game

-- Main Frame
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 400, 0, 250)
Main.Position = UDim2.new(0.5, -200, 0.5, -125)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Main.BorderSizePixel = 0
Main.Active = true -- NOT DRAGGABLE

-- Visual Polish
local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0, 12)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Settings.AccentColor
Stroke.Thickness = 2

-- Title
local Title = Instance.new("TextLabel", Main)
Title.Text = Settings.Title; Title.RichText = true; Title.Size = UDim2.new(1, 0, 0, 60)
Title.TextColor3 = Color3.new(1,1,1); Title.Font = Enum.Font.GothamBold; Title.TextSize = 22; Title.BackgroundTransparency = 1

-- Key Input
local Input = Instance.new("TextBox", Main)
Input.Size = UDim2.new(0.8, 0, 0, 45); Input.Position = UDim2.new(0.1, 0, 0.4, 0)
Input.BackgroundColor3 = Color3.fromRGB(25, 25, 30); Input.TextColor3 = Color3.new(1,1,1)
Input.PlaceholderText = "Enter Access Key..."; Input.Text = ""; Input.Font = Enum.Font.GothamSemibold; Input.TextSize = 14
Instance.new("UICorner", Input)
local InputStroke = Instance.new("UIStroke", Input); InputStroke.Color = Color3.fromRGB(40, 40, 45)

-- Status Text
local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1, 0, 0, 20); Status.Position = UDim2.new(0, 0, 0.6, 0)
Status.BackgroundTransparency = 1; Status.TextColor3 = Color3.fromRGB(150, 150, 150)
Status.Font = Enum.Font.Gotham; Status.TextSize = 11; Status.Text = "Required for verification"

-- Buttons
local function CreateBtn(text, pos, color)
    local b = Instance.new("TextButton", Main)
    b.Text = text; b.Size = UDim2.new(0.38, 0, 0, 45); b.Position = pos
    b.BackgroundColor3 = color; b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold; b.TextSize = 14; Instance.new("UICorner", b)
    return b
end

local GetKey = CreateBtn("GET KEY", UDim2.new(0.1, 0, 0.72, 0), Color3.fromRGB(30, 30, 35))
local Verify = CreateBtn("VERIFY", UDim2.new(0.52, 0, 0.72, 0), Settings.AccentColor)

--// Logic
GetKey.MouseButton1Click:Connect(function()
    setclipboard(Settings.KeyLink)
    Status.Text = "Link copied to clipboard!"
    Status.TextColor3 = Settings.AccentColor
    task.wait(2)
    Status.Text = "Required for verification"
    Status.TextColor3 = Color3.fromRGB(150, 150, 150)
end)

Verify.MouseButton1Click:Connect(function()
    if Input.Text == Settings.Key then
        Status.Text = "Access Granted! Loading..."; Status.TextColor3 = Color3.fromRGB(100, 255, 100)
        
        -- Animation out
        TS:Create(Main, TweenInfo.new(0.5), {BackgroundTransparency = 1, Position = UDim2.new(0.5, -200, 0.5, -100)}):Play()
        TS:Create(Overlay, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        
        task.wait(0.6)
        ScreenGui:Destroy()
        
        -- RUN THE MAIN SCRIPT
        Settings.ScriptToRun()
    else
        Input.Text = ""
        Status.Text = "Invalid Key! Try again."; Status.TextColor3 = Color3.fromRGB(255, 100, 100)
        TS:Create(Stroke, TweenInfo.new(0.2), {Color = Color3.new(1, 0, 0)}):Play()
        task.wait(0.5)
        TS:Create(Stroke, TweenInfo.new(0.2), {Color = Settings.AccentColor}):Play()
    end
end)
