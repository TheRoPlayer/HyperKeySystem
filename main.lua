-- Gemini UI Library (Open Source Version)
-- Optimized for GitHub Hosting & User Customization

local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

--// THEME SETTINGS
local Theme = {
    Main = Color3.fromRGB(15, 15, 18),
    Side = Color3.fromRGB(22, 22, 25),
    Accent = Color3.fromRGB(120, 80, 255),
    Element = Color3.fromRGB(30, 30, 35),
    Text = Color3.fromRGB(255, 255, 255),
    Dim = Color3.fromRGB(160, 160, 165)
}

--// LOAD CONFIGURATION
-- (Users change this URL to their own RAW GitHub config link)
local ConfigURL = "https://raw.githubusercontent.com/TheRoPlayer/HyperKeySystem/refs/heads/main/config.json"
local success, Config = pcall(function() return HttpService:JSONDecode(game:HttpGet(ConfigURL)) end)

if not success then 
    warn("Gemini: Failed to load config.json. Check your URL.")
    return 
end

--// UI INITIALIZATION
local Parent = (game:GetService("CoreGui") or LP:WaitForChild("PlayerGui"))
if Parent:FindFirstChild("Gemini_Library") then Parent["Gemini_Library"]:Destroy() end

local ScreenGui = Instance.new("ScreenGui", Parent)
ScreenGui.Name = "Gemini_Library"
ScreenGui.IgnoreGuiInset = true

--// KEY SYSTEM FRAME
local KeyMain = Instance.new("Frame", ScreenGui)
KeyMain.Size = UDim2.new(0, 400, 0, 260)
KeyMain.Position = UDim2.new(0.5, -200, 0.5, -130)
KeyMain.BackgroundColor3 = Theme.Main
KeyMain.Active = true -- NOT DRAGGABLE
Instance.new("UICorner", KeyMain).CornerRadius = UDim.new(0, 12)
local KStroke = Instance.new("UIStroke", KeyMain); KStroke.Color = Theme.Accent; KStroke.Thickness = 2

local KTitle = Instance.new("TextLabel", KeyMain)
KTitle.Text = "SYSTEM AUTHENTICATION"; KTitle.Size = UDim2.new(1,0,0,60); KTitle.TextColor3 = Theme.Text; KTitle.Font = "GothamBold"; KTitle.TextSize = 18; KTitle.BackgroundTransparency = 1

local KInput = Instance.new("TextBox", KeyMain)
KInput.Size = UDim2.new(0.8, 0, 0, 45); KInput.Position = UDim2.new(0.1, 0, 0.4, 0); KInput.PlaceholderText = "Enter Access Key..."; KInput.BackgroundColor3 = Theme.Side; KInput.TextColor3 = Theme.Text; KInput.Font = "GothamSemibold"; KInput.Text = ""; Instance.new("UICorner", KInput)

local GetBtn = Instance.new("TextButton", KeyMain)
GetBtn.Text = "GET KEY"; GetBtn.Size = UDim2.new(0.38, 0, 0, 40); GetBtn.Position = UDim2.new(0.1, 0, 0.7, 0); GetBtn.BackgroundColor3 = Theme.Element; GetBtn.TextColor3 = Theme.Text; GetBtn.Font = "GothamBold"; Instance.new("UICorner", GetBtn)

local SubBtn = Instance.new("TextButton", KeyMain)
SubBtn.Text = "VERIFY"; SubBtn.Size = UDim2.new(0.38, 0, 0, 40); SubBtn.Position = UDim2.new(0.52, 0, 0.7, 0); SubBtn.BackgroundColor3 = Theme.Accent; SubBtn.TextColor3 = Theme.Text; SubBtn.Font = "GothamBold"; Instance.new("UICorner", SubBtn)

--// MAIN EXECUTOR FRAME (Hidden at start)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 620, 0, 400)
Main.Position = UDim2.new(0.5, -310, 0.5, -200)
Main.BackgroundColor3 = Theme.Main
Main.Visible = false
Main.Active = true -- NOT DRAGGABLE
Instance.new("UICorner", Main)
Instance.new("UIStroke", Main).Color = Theme.Element

-- Close Button (Only appears after key is correct)
local Close = Instance.new("TextButton", Main)
Close.Text = "×"; Close.Size = UDim2.new(0,30,0,30); Close.Position = UDim2.new(1,-35,0,5); Close.BackgroundTransparency = 1; Close.TextColor3 = Color3.fromRGB(255,80,80); Close.TextSize = 30
Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Sidebar
local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0, 140, 1, 0); Side.BackgroundColor3 = Theme.Side; Instance.new("UICorner", Side)

-- Pages
local Container = Instance.new("Frame", Main); Container.Size = UDim2.new(1,-150,1,-40); Container.Position = UDim2.new(0,145,0,35); Container.BackgroundTransparency = 1
local ExecPage = Instance.new("Frame", Container); ExecPage.Size = UDim2.new(1,0,1,0); ExecPage.BackgroundTransparency = 1
local HubPage = Instance.new("ScrollingFrame", Container); HubPage.Size = UDim2.new(1,0,1,0); HubPage.BackgroundTransparency = 1; HubPage.Visible = false; HubPage.ScrollBarThickness = 0
Instance.new("UIListLayout", HubPage).Padding = UDim.new(0,5)

-- Executor Content
local CodeBox = Instance.new("TextBox", ExecPage); CodeBox.Size = UDim2.new(1,0,0.85,0); CodeBox.BackgroundColor3 = Theme.Side; CodeBox.TextColor3 = Color3.fromRGB(150,255,150); CodeBox.ClearTextOnFocus = false; CodeBox.MultiLine = true; CodeBox.TextXAlignment = "Left"; CodeBox.TextYAlignment = "Top"; CodeBox.Text = "-- Welcome"; Instance.new("UICorner", CodeBox)
local Run = Instance.new("TextButton", ExecPage); Run.Size = UDim2.new(1,0,0,40); Run.Position = UDim2.new(0,0,1,-40); Run.Text = "EXECUTE"; Run.BackgroundColor3 = Theme.Accent; Run.TextColor3 = Theme.Text; Run.Font = "GothamBold"; Instance.new("UICorner", Run)

Run.MouseButton1Click:Connect(function() 
    local s, e = pcall(function() loadstring(CodeBox.Text)() end)
    if not s then warn("Execution Error: "..e) end
end)

-- Tab Logic
local function AddTab(name, pos, page)
    local t = Instance.new("TextButton", Side); t.Size = UDim2.new(0.9,0,0,35); t.Position = pos; t.Text = name; t.BackgroundColor3 = Theme.Element; t.TextColor3 = Theme.Text; t.Font = "GothamBold"; Instance.new("UICorner", t)
    t.MouseButton1Click:Connect(function() ExecPage.Visible = false; HubPage.Visible = false; page.Visible = true end)
end
AddTab("EXECUTOR", UDim2.new(0.05,0,0,60), ExecPage)
AddTab("SCRIPT HUB", UDim2.new(0.05,0,0,105), HubPage)

--// KEY LOGIC
GetBtn.MouseButton1Click:Connect(function()
    setclipboard(Config.KeyLink)
    GetBtn.Text = "COPIED!"
    task.wait(2)
    GetBtn.Text = "GET KEY"
end)

SubBtn.MouseButton1Click:Connect(function()
    if KInput.Text == Config.Key then
        KeyMain:Destroy()
        Main.Visible = true
        -- Optionally run the MainScript from JSON automatically
        if Config.MainScript and Config.MainScript ~= "" then
            pcall(function() loadstring(game:HttpGet(Config.MainScript))() end)
        end
    else
        KInput.Text = ""
        KInput.PlaceholderText = "INVALID KEY"
        TS:Create(KStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(255,0,0)}):Play()
        task.wait(1)
        TS:Create(KStroke, TweenInfo.new(0.3), {Color = Theme.Accent}):Play()
    end
end)
