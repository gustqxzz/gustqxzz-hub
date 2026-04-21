local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Scroll = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local OpenBtn = Instance.new("TextButton")
local FPSLabel = Instance.new("TextLabel")
local TS = game:GetService("TweenService")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "BF_Manager_HYPER"

-- FPS Counter
FPSLabel.Parent = ScreenGui
FPSLabel.BackgroundColor3 = Color3.new(0, 0, 0)
FPSLabel.BackgroundTransparency = 0.7
FPSLabel.Position = UDim2.new(0, 10, 0, 10)
FPSLabel.Size = UDim2.new(0, 80, 0, 30)
FPSLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
FPSLabel.TextSize = 14
FPSLabel.Font = Enum.Font.Code
task.spawn(function()
    local RS = game:GetService("RunService")
    while task.wait(0.5) do FPSLabel.Text = "FPS: " .. math.floor(1/RS.RenderStepped:Wait()) end
end)

-- Draggable
local function Drag(gui)
    local dragging, dragInput, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = gui.Position
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            TS:Create(gui, TweenInfo.new(0.07), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play()
        end
    end)
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
end

-- UI Setup
OpenBtn.Parent = ScreenGui
OpenBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
OpenBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
OpenBtn.Size = UDim2.new(0, 70, 0, 30)
OpenBtn.Text = "MENU"
OpenBtn.TextColor3 = Color3.new(1, 1, 1)
Drag(OpenBtn)

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 230, 0, 320)
MainFrame.Visible = true
Drag(MainFrame)

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Text = "HYPER FPS | GUSTXQZZ"
Title.TextColor3 = Color3.fromRGB(0, 255, 200)

Scroll.Parent = MainFrame
Scroll.Position = UDim2.new(0, 5, 0, 40)
Scroll.Size = UDim2.new(0, 220, 0, 275)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 450)
Scroll.BackgroundTransparency = 1
UIListLayout.Parent = Scroll
UIListLayout.Padding = UDim.new(0, 4)

OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- Anti-AFK (O que faltava)
local afkBtn = Instance.new("TextButton", Scroll)
afkBtn.Size = UDim2.new(0.95, 0, 0, 35)
afkBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
afkBtn.Text = "ANTI-AFK: OFF"
afkBtn.TextColor3 = Color3.new(1, 1, 1)

local afkActive = false
afkBtn.MouseButton1Click:Connect(function()
    afkActive = not afkActive
    afkBtn.Text = afkActive and "ANTI-AFK: ON" or "ANTI-AFK: OFF"
    afkBtn.BackgroundColor3 = afkActive and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)
end)

task.spawn(function()
    while task.wait(30) do
        if afkActive then
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):ClickButton2(Vector2.new())
        end
    end
end)

-- Hyper Boost
local function HyperBoost()
    if setfpscap then setfpscap(0) end
    settings().Rendering.QualityLevel = 1
    local L = game:GetService("Lighting")
    L.GlobalShadows = false; L.FogEnd = 9e20; L.Brightness = 3
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic; v.CastShadow = false
        elseif v:IsA("Decal") or v:IsA("Texture") then v:Destroy()
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then v.Enabled = false end
    end
end

local function Add(name, link)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(0.95, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.MouseButton1Click:Connect(function() pcall(function() loadstring(game:HttpGet(link))() end) end)
end

-- Botão Boost
local b = Instance.new("TextButton", Scroll)
b.Size = UDim2.new(0.95, 0, 0, 40)
b.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
b.Text = "🚀 HYPER FPS (MIN + CORES)"
b.TextColor3 = Color3.new(1, 1, 1)
b.MouseButton1Click:Connect(HyperBoost)

Add("Night Hub Main", "https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/BF-Beta.lua")
Add("RedZ Hub", "https://raw.githubusercontent.com/huy384/redzHub/refs/heads/main/redzHub.lua")
Add("Night Mystic", "https://raw.githubusercontent.com/Dev-NightMystic/Bloxfruits/refs/heads/main/Script.lua")
Add("Gravity Hub", "https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/Main.lua")
Add("Banana Hub", "https://raw.githubusercontent.com/aloaloalo322/sssdas/refs/heads/main/cc")
Add("Ok Hub", "https://raw.githubusercontent.com/fakekuri/Okhubhere/main/MainBloxFruit.lua")
