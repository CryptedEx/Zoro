local Kavo = {}

local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")

local Utility = {}
local Objects = {}
function Kavo:DraggingEnabled(frame, parent)
        
    parent = parent or frame
    
    -- stolen from wally or kiriot, kek
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    input.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

function Utility:TweenObject(obj, properties, duration, ...)
    tween:Create(obj, tweeninfo(duration, ...), properties):Play()
end


local themes = {
    SchemeColor = Color3.fromRGB(74, 99, 135),
    Background = Color3.fromRGB(36, 37, 43),
    Header = Color3.fromRGB(28, 29, 34),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(32, 32, 38)
}
local themeStyles = {
    DarkTheme = {
        SchemeColor = Color3.fromRGB(64, 64, 64),
        Background = Color3.fromRGB(0, 0, 0),
        Header = Color3.fromRGB(0, 0, 0),
        TextColor = Color3.fromRGB(255,255,255),
        ElementColor = Color3.fromRGB(20, 20, 20)
    },
    LightTheme = {
        SchemeColor = Color3.fromRGB(150, 150, 150),
        Background = Color3.fromRGB(255,255,255),
        Header = Color3.fromRGB(200, 200, 200),
        TextColor = Color3.fromRGB(0,0,0),
        ElementColor = Color3.fromRGB(224, 224, 224)
    },
    BloodTheme = {
        SchemeColor = Color3.fromRGB(227, 27, 27),
        Background = Color3.fromRGB(10, 10, 10),
        Header = Color3.fromRGB(5, 5, 5),
        TextColor = Color3.fromRGB(255,255,255),
        ElementColor = Color3.fromRGB(20, 20, 20)
    },
    GrapeTheme = {
        SchemeColor = Color3.fromRGB(166, 71, 214),
        Background = Color3.fromRGB(64, 50, 71),
        Header = Color3.fromRGB(36, 28, 41),
        TextColor = Color3.fromRGB(255,255,255),
        ElementColor = Color3.fromRGB(74, 58, 84)
    },
    Ocean = {
        SchemeColor = Color3.fromRGB(86, 76, 251),
        Background = Color3.fromRGB(26, 32, 58),
        Header = Color3.fromRGB(38, 45, 71),
        TextColor = Color3.fromRGB(200, 200, 200),
        ElementColor = Color3.fromRGB(38, 45, 71)
    },
    Midnight = {
        SchemeColor = Color3.fromRGB(26, 189, 158),
        Background = Color3.fromRGB(44, 62, 82),
        Header = Color3.fromRGB(57, 81, 105),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(52, 74, 95)
    },
    Sentinel = {
        SchemeColor = Color3.fromRGB(230, 35, 69),
        Background = Color3.fromRGB(32, 32, 32),
        Header = Color3.fromRGB(24, 24, 24),
        TextColor = Color3.fromRGB(119, 209, 138),
        ElementColor = Color3.fromRGB(24, 24, 24)
    },
    Synapse = {
        SchemeColor = Color3.fromRGB(46, 48, 43),
        Background = Color3.fromRGB(13, 15, 12),
        Header = Color3.fromRGB(36, 38, 35),
        TextColor = Color3.fromRGB(152, 99, 53),
        ElementColor = Color3.fromRGB(24, 24, 24)
    },
    Serpent = {
        SchemeColor = Color3.fromRGB(0, 166, 58),
        Background = Color3.fromRGB(31, 41, 43),
        Header = Color3.fromRGB(22, 29, 31),
        TextColor = Color3.fromRGB(255,255,255),
        ElementColor = Color3.fromRGB(22, 29, 31)
    }
}
local oldTheme = ""

local SettingsT = {

}

local Name = "KavoConfig.JSON"

pcall(function()

if not pcall(function() readfile(Name) end) then
writefile(Name, game:service'HttpService':JSONEncode(SettingsT))
end

Settings = game:service'HttpService':JSONEncode(readfile(Name))
end)

local LibName = tostring(math.random(1, 100))..tostring(math.random(1,50))..tostring(math.random(1, 100))

function Kavo:ToggleUI()
    if game.CoreGui[LibName].Enabled then
        game.CoreGui[LibName].Enabled = false
    else
        game.CoreGui[LibName].Enabled = true
    end
end

function Kavo.CreateLib(kavName, themeList)
    if not themeList then
        themeList = themes
    end
    if themeList == "DarkTheme" then
        themeList = themeStyles.DarkTheme
    elseif themeList == "LightTheme" then
        themeList = themeStyles.LightTheme
    elseif themeList == "BloodTheme" then
        themeList = themeStyles.BloodTheme
    elseif themeList == "GrapeTheme" then
        themeList = themeStyles.GrapeTheme
    elseif themeList == "Ocean" then
        themeList = themeStyles.Ocean
    elseif themeList == "Midnight" then
        themeList = themeStyles.Midnight
    elseif themeList == "Sentinel" then
        themeList = themeStyles.Sentinel
    elseif themeList == "Synapse" then
        themeList = themeStyles.Synapse
    elseif themeList == "Serpent" then
        themeList = themeStyles.Serpent
    else
        if themeList.SchemeColor == nil then
            themeList.SchemeColor = Color3.fromRGB(74, 99, 135)
        elseif themeList.Background == nil then
            themeList.Background = Color3.fromRGB(36, 37, 43)
        elseif themeList.Header == nil then
            themeList.Header = Color3.fromRGB(28, 29, 34)
        elseif themeList.TextColor == nil then
            themeList.TextColor = Color3.fromRGB(255,255,255)
        elseif themeList.ElementColor == nil then
            themeList.ElementColor = Color3.fromRGB(32, 32, 38)
        end
    end

    themeList = themeList or {}
    local selectedTab 
    kavName = kavName or "Library"
    table.insert(Kavo, kavName)
    for i,v in pairs(game.CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name == kavName then
            v:Destroy()
        end
    end
    local ScreenGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local MainHeader = Instance.new("Frame")
    local headerCover = Instance.new("UICorner")
    local coverup = Instance.new("Frame")
    local title = Instance.new("TextLabel")
    local MainSide = Instance.new("Frame")
    local sideCorner = Instance.new("UICorner")
    local coverup_2 = Instance.new("Frame")
    local tabFrames = Instance.new("Frame")
    local tabListing = Instance.new("UIListLayout")
    local pages = Instance.new("Frame")
    local Pages = Instance.new("Folder")
    local infoContainer = Instance.new("Frame")
    local TextLabel = Instance.new("TextLabel")
local TextLabel_2 = Instance.new("TextLabel")
local ZoroRewriteTEXT = Instance.new("TextLabel")
local Profile = Instance.new("ImageButton")
local UserFrame = Instance.new("ImageLabel")
local Shadow = Instance.new("ImageLabel")
local Frame = Instance.new("Frame")
local Frame_2 = Instance.new("Frame")
local Frame_3 = Instance.new("Frame")
local Profile2 = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")
local SettingsText = Instance.new("TextLabel")
local UsernameText = Instance.new("TextLabel")
local PlayerNameText = Instance.new("TextLabel")
local ExploitNameText = Instance.new("TextLabel")
local ExploitText = Instance.new("TextLabel")
local Frame_4 = Instance.new("Frame")
local KeyNameText = Instance.new("TextLabel")
local KeyText = Instance.new("TextLabel")
local UserBottomFrame = Instance.new("ImageLabel")
local Frame_5 = Instance.new("Frame")
local brightness_3 = Instance.new("ImageButton")
local Frame_6 = Instance.new("Frame")
local account_circle = Instance.new("ImageButton")
local cloud_queue = Instance.new("ImageButton")
local Frame_7 = Instance.new("Frame")
local Frame_8 = Instance.new("Frame")
local Frame_9 = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local resize = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local minimise = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local close = Instance.new("TextButton")
local UICorner_5 = Instance.new("UICorner")
local Shadow_2 = Instance.new("ImageLabel")
local ShadowTwo = Instance.new("ImageLabel")
local Neon = Instance.new("ImageLabel")
local KeySystemFrame = Instance.new("ImageLabel")
KeySystemFrame.Visible = false;
local Pattern = Instance.new("ImageLabel")
local Frame_10 = Instance.new("ImageLabel")
local Frame_11 = Instance.new("ImageLabel")
local Frame_12 = Instance.new("ImageLabel")
local Frame_13 = Instance.new("ImageLabel")
local Frame_14 = Instance.new("ImageLabel")
local Frame_15 = Instance.new("ImageLabel")
local Frame_16 = Instance.new("ImageLabel")
local Frame_17 = Instance.new("ImageLabel")
local Frame_18 = Instance.new("ImageLabel")
local Frame_19 = Instance.new("ImageLabel")
local Frame_20 = Instance.new("ImageLabel")
local Frame_21 = Instance.new("ImageLabel")
local Frame_22 = Instance.new("ImageLabel")
local Frame_23 = Instance.new("ImageLabel")
local Frame_24 = Instance.new("ImageLabel")
local Frame_25 = Instance.new("ImageLabel")
local Frame_26 = Instance.new("ImageLabel")
local Frame_27 = Instance.new("ImageLabel")
local Frame_28 = Instance.new("ImageLabel")
local Frame_29 = Instance.new("ImageLabel")
local Frame_30 = Instance.new("ImageLabel")
local Frame_31 = Instance.new("ImageLabel")
local Frame_32 = Instance.new("ImageLabel")
local Frame_33 = Instance.new("ImageLabel")
local Frame_34 = Instance.new("ImageLabel")
local Frame_35 = Instance.new("ImageLabel")
local Frame_36 = Instance.new("ImageLabel")
local Frame_37 = Instance.new("ImageLabel")
local Frame_38 = Instance.new("ImageLabel")
local Frame_39 = Instance.new("ImageLabel")
local Frame_40 = Instance.new("ImageLabel")
local Frame_41 = Instance.new("ImageLabel")
local Frame_42 = Instance.new("ImageLabel")
local Frame_43 = Instance.new("ImageLabel")
local Frame_44 = Instance.new("ImageLabel")
local Frame_45 = Instance.new("ImageLabel")
local WelcometoZoro = Instance.new("TextLabel")
local Frame_46 = Instance.new("ImageLabel")
local Frame_47 = Instance.new("ImageLabel")
local Frame_48 = Instance.new("ImageLabel")
local Frame_49 = Instance.new("ImageLabel")
local Frame_50 = Instance.new("ImageLabel")
local Frame_51 = Instance.new("ImageLabel")
local Frame_52 = Instance.new("ImageLabel")
local Frame_53 = Instance.new("ImageLabel")
local Frame_54 = Instance.new("ImageLabel")
local Frame_55 = Instance.new("ImageLabel")
local Frame_56 = Instance.new("ImageLabel")
local Frame_57 = Instance.new("ImageLabel")
local Frame_58 = Instance.new("ImageLabel")
local Frame_59 = Instance.new("ImageLabel")
local Frame_60 = Instance.new("ImageLabel")
local Frame_61 = Instance.new("ImageLabel")
local Frame_62 = Instance.new("ImageLabel")
local Frame_63 = Instance.new("ImageLabel")
local Frame_64 = Instance.new("ImageLabel")
local Frame_65 = Instance.new("ImageLabel")
local Frame_66 = Instance.new("ImageLabel")
local Frame_67 = Instance.new("ImageLabel")
local Frame_68 = Instance.new("ImageLabel")
local Frame_69 = Instance.new("ImageLabel")
local Frame_70 = Instance.new("ImageLabel")
local Frame_71 = Instance.new("ImageLabel")
local Frame_72 = Instance.new("ImageLabel")
local Frame_73 = Instance.new("ImageLabel")
local Frame_74 = Instance.new("ImageLabel")
local Frame_75 = Instance.new("ImageLabel")
local Frame_76 = Instance.new("ImageLabel")
local Frame_77 = Instance.new("ImageLabel")
local Frame_78 = Instance.new("ImageLabel")
local Frame_79 = Instance.new("ImageLabel")
local Frame_80 = Instance.new("ImageLabel")
local Frame_81 = Instance.new("ImageLabel")
local SubmitKeyTextBox = Instance.new("TextBox")
local UICorner_6 = Instance.new("UICorner")
local Discord = Instance.new("TextButton")
local UICorner_7 = Instance.new("UICorner")
local SubmitKey = Instance.new("TextButton")
local UICorner_8 = Instance.new("UICorner")

    local blurFrame = Instance.new("Frame")

    Kavo:DraggingEnabled(MainHeader, Main)

    blurFrame.Name = "blurFrame"
    blurFrame.Parent = pages
    blurFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blurFrame.BackgroundTransparency = 1
    blurFrame.BorderSizePixel = 0
    blurFrame.Position = UDim2.new(-0.0222222228, 0, -0.0371747203, 0)
    blurFrame.Size = UDim2.new(0, 376, 0, 289)
    blurFrame.ZIndex = 999

    ScreenGui.Parent = game.CoreGui
    ScreenGui.Name = LibName
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = themeList.Background
    Main.ClipsDescendants = true
    Main.Position = UDim2.new(0.336503863, 0, 0.275485456, 0)
    Main.Size = UDim2.new(0, 525, 0, 318)

    MainCorner.CornerRadius = UDim.new(0, 4)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main
    
    
    
    
    ZoroRewriteTEXT.Name = "ZoroRewriteTEXT"
ZoroRewriteTEXT.Parent = Main
ZoroRewriteTEXT.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ZoroRewriteTEXT.BackgroundTransparency = 1.000
ZoroRewriteTEXT.BorderSizePixel = 0
ZoroRewriteTEXT.Position = UDim2.new(0, 0, 1.02201259, 0)
ZoroRewriteTEXT.Size = UDim2.new(0, 525, 0, 42)
ZoroRewriteTEXT.Font = Enum.Font.SourceSansBold
ZoroRewriteTEXT.Text = "// ZORO - THIS IS A WORK IN PROGRESS AND DOES NOT REPRESENT THE FINAL REWRITE PRODUCT"
ZoroRewriteTEXT.TextColor3 = Color3.fromRGB(112, 112, 112)
ZoroRewriteTEXT.TextScaled = true
ZoroRewriteTEXT.TextSize = 30.000
ZoroRewriteTEXT.TextWrapped = true

Profile.Name = "Profile"
Profile.Parent = Main
Profile.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Profile.BorderSizePixel = 0
Profile.Position = UDim2.new(0.929523826, 0, 0, 0)
Profile.Size = UDim2.new(0, 31, 0, 30)
Profile.Image = userinfo["pfp"] or "https://www.roblox.com/headshot-thumbnail/image?userId=".. game.Players.LocalPlayer.UserId .."&width=420&height=420&format=png"
local Toggle = false
Profile.MouseButton1Down:connect(function()
Toggle = not Toggle
end)
game:GetService('RunService').Stepped:connect(function()
    if Toggle then
        UserFrame.Visible = true
    else
        UserFrame.Visible = false
end 
    end)
UserFrame.Name = "UserFrame"
UserFrame.Parent = Profile
UserFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
UserFrame.BackgroundTransparency = 1.000
UserFrame.Position = UDim2.new(-6.12903214, 0, 1.20000005, 0)
UserFrame.Size = UDim2.new(0, 221, 0, 263)
UserFrame.Visible = false
UserFrame.Image = "rbxassetid://3570695787"
UserFrame.ImageColor3 = Color3.fromRGB(20, 20, 20)
UserFrame.ScaleType = Enum.ScaleType.Slice
UserFrame.SliceCenter = Rect.new(100, 100, 100, 100)
UserFrame.SliceScale = 0.070

Shadow.Name = "Shadow"
Shadow.Parent = UserFrame
Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Shadow.BackgroundTransparency = 1.000
Shadow.Position = UDim2.new(0, -15, 0, -15)
Shadow.Size = UDim2.new(1, 30, 1, 30)
Shadow.Image = "http://www.roblox.com/asset/?id=5554236805"
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(23, 23, 277, 277)

Frame.Parent = UserFrame
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0, 0, 0.277566552, 0)
Frame.Size = UDim2.new(0, 221, 0, 2)

Frame_2.Parent = UserFrame
Frame_2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(0, 0, 0.414448619, 0)
Frame_2.Size = UDim2.new(0, 221, 0, 2)

Frame_3.Parent = UserFrame
Frame_3.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame_3.BorderSizePixel = 0
Frame_3.Position = UDim2.new(0, 0, 0.543726206, 0)
Frame_3.Size = UDim2.new(0, 221, 0, 2)

Profile2.Name = "Profile2"
Profile2.Parent = UserFrame
Profile2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Profile2.BorderSizePixel = 0
Profile2.Position = UDim2.new(0.3910622, 0, 0.102661595, 0)
Profile2.Size = UDim2.new(0, 43, 0, 40)
Profile2.Image = userinfo["pfp"] or "https://www.roblox.com/headshot-thumbnail/image?userId=".. game.Players.LocalPlayer.UserId .."&width=420&height=420&format=png"

UICorner.CornerRadius = UDim.new(0.5, 0)
UICorner.Parent = Profile2

SettingsText.Name = "Settings Text"
SettingsText.Parent = UserFrame
SettingsText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SettingsText.BackgroundTransparency = 1.000
SettingsText.BorderSizePixel = 0
SettingsText.Size = UDim2.new(0, 221, 0, 27)
SettingsText.Font = Enum.Font.Gotham
SettingsText.Text = "Settings"
SettingsText.TextColor3 = Color3.fromRGB(135, 135, 135)
SettingsText.TextSize = 14.000

UsernameText.Name = "Username Text"
UsernameText.Parent = UserFrame
UsernameText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
UsernameText.BackgroundTransparency = 1.000
UsernameText.BorderSizePixel = 0
UsernameText.Size = UDim2.new(0, 86, 0, 169)
UsernameText.Font = Enum.Font.Gotham
UsernameText.Text = "Username"
UsernameText.TextColor3 = Color3.fromRGB(135, 135, 135)
UsernameText.TextSize = 12.000

PlayerNameText.Name = "PlayerName Text"
PlayerNameText.Parent = UserFrame
PlayerNameText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PlayerNameText.BackgroundTransparency = 1.000
PlayerNameText.BorderSizePixel = 0
PlayerNameText.Position = UDim2.new(0.0678733066, 0, 0.129277572, 0)
PlayerNameText.Size = UDim2.new(0, 206, 0, 135)
PlayerNameText.Font = Enum.Font.Gotham
PlayerNameText.Text = ""
PlayerNameText.TextColor3 = Color3.fromRGB(203, 203, 203)
PlayerNameText.TextSize = 10.000
PlayerNameText.TextXAlignment = Enum.TextXAlignment.Left
PlayerNameText = game.Players.LocalPlayer.Name .. " | " .. game.Players.LocalPlayer.UserId 

ExploitNameText.Name = "ExploitName Text"
ExploitNameText.Parent = UserFrame
ExploitNameText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ExploitNameText.BackgroundTransparency = 1.000
ExploitNameText.BorderSizePixel = 0
ExploitNameText.Position = UDim2.new(0, 0, 0.277566552, 0)
ExploitNameText.Size = UDim2.new(0, 67, 0, 92)
ExploitNameText.Font = Enum.Font.Gotham
ExploitNameText.Text = "Exploit"
ExploitNameText.TextColor3 = Color3.fromRGB(135, 135, 135)
ExploitNameText.TextSize = 12.000

ExploitText.Name = "Exploit Text"
ExploitText.Parent = UserFrame
ExploitText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ExploitText.BackgroundTransparency = 1.000
ExploitText.BorderSizePixel = 0
ExploitText.Position = UDim2.new(0.0678733066, 0, 0.351002336, 0)
ExploitText.Size = UDim2.new(0, 206, 0, 85)
ExploitText.Font = Enum.Font.Gotham
ExploitText.Text = "JJSploit Premium"
ExploitText.TextColor3 = Color3.fromRGB(203, 203, 203)
ExploitText.TextSize = 10.000
ExploitText.TextXAlignment = Enum.TextXAlignment.Left
if KRNL_LOADED then
ExploitText.Text = "Krnl"
end
if syn then
ExploitText.Text = "Synapse X"
end
if PROTOSMASHER_LOADED then
ExploitText.Text = "Protosmasher"
end;
if is_sirhurt_closure then
ExploitText.Text = "Sirhurt"
end;
if sentinelbuy() then
ExploitText.Text = "Sentinel"
end;
if SONA_LOADED then
ExploitText.Text = "Sona"
end;
if getexecutorname() then
ExploitText.Text = "Script-Ware"
end
if WrapGlobal then
ExploitText.Text = "WeAreDevs API"
end;
if isvm then
ExploitText.Text = "Proxo"
end
if shadow_env then
ExploitText.Text = "Shadow"
end
if jit then
ExploitText.Text = "EasyExploits API"
end;
if getscriptsenvs then
ExploitText.Text = "Calamari"
end
if OXYGEN_LOADED then
ExploitText.Text = "Oxygen U"
end;
if IsElectron then
ExploitText.Text = "Electron"
else
ExploitText.Text = "Couldnt identify executor."
end;

Frame_4.Parent = UserFrame
Frame_4.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame_4.BorderSizePixel = 0
Frame_4.Position = UDim2.new(0, 0, 0.700812221, 0)
Frame_4.Size = UDim2.new(0, 221, 0, 3)

KeyNameText.Name = "KeyName Text"
KeyNameText.Parent = UserFrame
KeyNameText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
KeyNameText.BackgroundTransparency = 1.000
KeyNameText.BorderSizePixel = 0
KeyNameText.Position = UDim2.new(0, 0, 0.543726206, 0)
KeyNameText.Size = UDim2.new(0, 86, 0, 22)
KeyNameText.Font = Enum.Font.Gotham
KeyNameText.Text = "Valid Key"
KeyNameText.TextColor3 = Color3.fromRGB(135, 135, 135)
KeyNameText.TextSize = 12.000

KeyText.Name = "Key Text"
KeyText.Parent = UserFrame
KeyText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
KeyText.BackgroundTransparency = 1.000
KeyText.BorderSizePixel = 0
KeyText.Position = UDim2.new(0.0678733066, 0, 0.627376378, 0)
KeyText.Size = UDim2.new(0, 206, 0, 19)
KeyText.Font = Enum.Font.Gotham
KeyText.Text = SubmitKeyTextBox.Text
KeyText.TextColor3 = Color3.fromRGB(203, 203, 203)
KeyText.TextSize = 10.000
KeyText.TextXAlignment = Enum.TextXAlignment.Left

UserBottomFrame.Name = "UserBottomFrame"
UserBottomFrame.Parent = UserFrame
UserBottomFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
UserBottomFrame.BackgroundTransparency = 1.000
UserBottomFrame.Position = UDim2.new(0, 0, 0.851710975, 0)
UserBottomFrame.Size = UDim2.new(0, 221, 0, 39)
UserBottomFrame.Image = "rbxassetid://3570695787"
UserBottomFrame.ImageColor3 = Color3.fromRGB(25, 25, 25)
UserBottomFrame.ScaleType = Enum.ScaleType.Slice
UserBottomFrame.SliceCenter = Rect.new(100, 100, 100, 100)
UserBottomFrame.SliceScale = 0.070

Frame_5.Parent = UserBottomFrame
Frame_5.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
Frame_5.BorderSizePixel = 0
Frame_5.Position = UDim2.new(0.0678733066, 0, 0.774788082, 0)
Frame_5.Size = UDim2.new(0, 52, 0, 1)

brightness_3.Name = "brightness_3"
brightness_3.Parent = UserBottomFrame
brightness_3.BackgroundTransparency = 1.000
brightness_3.Position = UDim2.new(0.441176474, 0, 0.115384594, 0)
brightness_3.Size = UDim2.new(0, 25, 0, 25)
brightness_3.ZIndex = 2
brightness_3.Image = "rbxassetid://3926307971"
brightness_3.ImageColor3 = Color3.fromRGB(163, 162, 165)
brightness_3.ImageRectOffset = Vector2.new(324, 204)
brightness_3.ImageRectSize = Vector2.new(36, 36)

Frame_6.Parent = UserBottomFrame
Frame_6.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
Frame_6.BorderSizePixel = 0
Frame_6.Position = UDim2.new(0.389140278, 0, 0.774788082, 0)
Frame_6.Size = UDim2.new(0, 49, 0, 1)

account_circle.Name = "account_circle"
account_circle.Parent = UserBottomFrame
account_circle.BackgroundTransparency = 1.000
account_circle.Position = UDim2.new(0.128959268, 0, 0.115384609, 0)
account_circle.Size = UDim2.new(0, 25, 0, 25)
account_circle.ZIndex = 2
account_circle.Image = "rbxassetid://3926307971"
account_circle.ImageColor3 = Color3.fromRGB(163, 162, 165)
account_circle.ImageRectOffset = Vector2.new(124, 204)
account_circle.ImageRectSize = Vector2.new(36, 36)

cloud_queue.Name = "cloud_queue"
cloud_queue.Parent = UserBottomFrame
cloud_queue.BackgroundTransparency = 1.000
cloud_queue.Position = UDim2.new(0.771493196, 0, 0.115384609, 0)
cloud_queue.Size = UDim2.new(0, 25, 0, 25)
cloud_queue.ZIndex = 2
cloud_queue.Image = "rbxassetid://3926305904"
cloud_queue.ImageColor3 = Color3.fromRGB(163, 162, 165)
cloud_queue.ImageRectOffset = Vector2.new(324, 844)
cloud_queue.ImageRectSize = Vector2.new(36, 36)

Frame_7.Parent = UserBottomFrame
Frame_7.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
Frame_7.BorderSizePixel = 0
Frame_7.Position = UDim2.new(0.710407257, 0, 0.774788082, 0)
Frame_7.Size = UDim2.new(0, 55, 0, 1)

Frame_8.Parent = UserBottomFrame
Frame_8.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
Frame_8.BorderSizePixel = 0
Frame_8.Position = UDim2.new(0, 0, -0.15384616, 0)
Frame_8.Size = UDim2.new(0, 221, 0, 6)

Frame_9.Parent = UserFrame
Frame_9.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame_9.BorderSizePixel = 0
Frame_9.Position = UDim2.new(0, 0, 0.851710975, 0)
Frame_9.Size = UDim2.new(0, 221, 0, 6)

UICorner_2.CornerRadius = UDim.new(0.5, 0)
UICorner_2.Parent = Profile

resize.Name = "resize"
resize.Parent = Main
resize.BackgroundColor3 = Color3.fromRGB(76, 255, 0)
resize.BorderSizePixel = 0
resize.Position = UDim2.new(0.893333316, 0, 0.0251572318, 0)
resize.Size = UDim2.new(0, 13, 0, 13)
resize.Font = Enum.Font.SourceSans
resize.Text = ""
resize.TextColor3 = Color3.fromRGB(0, 0, 0)
resize.TextSize = 14.000

UICorner_3.CornerRadius = UDim.new(0.5, 0)
UICorner_3.Parent = resize

minimise.Name = "minimise"
minimise.Parent = Main
minimise.BackgroundColor3 = Color3.fromRGB(255, 247, 0)
minimise.BorderSizePixel = 0
minimise.Position = UDim2.new(0.85523802, 0, 0.0251572318, 0)
minimise.Size = UDim2.new(0, 13, 0, 13)
minimise.Font = Enum.Font.SourceSans
minimise.Text = ""
minimise.TextColor3 = Color3.fromRGB(0, 0, 0)
minimise.TextSize = 14.000

UICorner_4.CornerRadius = UDim.new(0.5, 0)
UICorner_4.Parent = minimise

close.Name = "close"
close.Parent = Main
close.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
close.BorderSizePixel = 0
close.Position = UDim2.new(0.815238059, 0, 0.0251572318, 0)
close.Size = UDim2.new(0, 13, 0, 13)
close.Font = Enum.Font.SourceSans
close.Text = ""
close.TextColor3 = Color3.fromRGB(0, 0, 0)
close.TextSize = 14.000
 close.MouseButton1Click:Connect(function()
        game.TweenService:Create(close, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            ImageTransparency = 1
        }):Play()
        wait()
        game.TweenService:Create(Main, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(0,0,0,0),
			Position = UDim2.new(0, Main.AbsolutePosition.X + (Main.AbsoluteSize.X / 2), 0, Main.AbsolutePosition.Y + (Main.AbsoluteSize.Y / 2))
		}):Play()
        wait(1)
        ScreenGui:Destroy()
    end)
UICorner_5.CornerRadius = UDim.new(0.5, 0)
UICorner_5.Parent = close

Shadow_2.Name = "Shadow"
Shadow_2.Parent = Main
Shadow_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Shadow_2.BackgroundTransparency = 1.000
Shadow_2.Position = UDim2.new(0, -15, 0, -15)
Shadow_2.Selectable = true
Shadow_2.Size = UDim2.new(1, 30, 1, 30)
Shadow_2.Image = "http://www.roblox.com/asset/?id=5761498316"
Shadow_2.ImageColor3 = Color3.fromRGB(255, 110, 74)
Shadow_2.ScaleType = Enum.ScaleType.Slice
Shadow_2.SliceCenter = Rect.new(17, 17, 283, 283)

ShadowTwo.Name = "ShadowTwo"
ShadowTwo.Parent = Main
ShadowTwo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ShadowTwo.BackgroundTransparency = 1.000
ShadowTwo.Position = UDim2.new(0, -15, 0, -15)
ShadowTwo.Selectable = true
ShadowTwo.Size = UDim2.new(1, 30, 1, 30)
ShadowTwo.Image = "http://www.roblox.com/asset/?id=5761504593"
ShadowTwo.ImageColor3 = Color3.fromRGB(255, 110, 74)
ShadowTwo.ScaleType = Enum.ScaleType.Slice
ShadowTwo.SliceCenter = Rect.new(17, 17, 283, 283)

Neon.Name = "Neon"
Neon.Parent = Main
Neon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Neon.BackgroundTransparency = 1.000
Neon.Position = UDim2.new(0, -15, 0, -15)
Neon.Size = UDim2.new(1, 30, 1, 30)
Neon.Image = "http://www.roblox.com/asset/?id=5554236805"
Neon.ImageColor3 = Color3.fromRGB(255, 110, 74)
Neon.ScaleType = Enum.ScaleType.Slice
Neon.SliceCenter = Rect.new(23, 23, 277, 277)

KeySystemFrame.Name = "KeySystemFrame"
KeySystemFrame.Parent = Main
KeySystemFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
KeySystemFrame.BackgroundTransparency = 1.000
KeySystemFrame.Size = UDim2.new(0, 525, 0, 318)
KeySystemFrame.Visible = false
KeySystemFrame.Image = "rbxassetid://3570695787"
KeySystemFrame.ImageColor3 = Color3.fromRGB(18, 18, 18)
KeySystemFrame.ScaleType = Enum.ScaleType.Slice
KeySystemFrame.SliceCenter = Rect.new(100, 100, 100, 100)
KeySystemFrame.SliceScale = 0.040
KeySystemFrame.Visibe = true;

Pattern.Name = "Pattern"
Pattern.Parent = KeySystemFrame
Pattern.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Pattern.BackgroundTransparency = 1.000
Pattern.Position = UDim2.new(-0.000952380942, 0, 0, 0)
Pattern.Size = UDim2.new(0, 525, 0, 317)
Pattern.ZIndex = 9
Pattern.Image = "rbxassetid://300134974"
Pattern.ImageColor3 = Color3.fromRGB(52, 52, 52)
Pattern.ImageTransparency = 0.950
Pattern.ScaleType = Enum.ScaleType.Tile
Pattern.SliceCenter = Rect.new(0, 256, 0, 256)
Pattern.TileSize = UDim2.new(0, 30, 0, 30)

Frame_10.Name = "Frame"
Frame_10.Parent = Pattern
Frame_10.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_10.BackgroundTransparency = 1.000
Frame_10.BorderSizePixel = 0
Frame_10.Position = UDim2.new(0.767619014, 0, 0.842767298, 0)
Frame_10.Size = UDim2.new(0, 35, 0, 32)
Frame_10.Image = "rbxassetid://3570695787"
Frame_10.ImageColor3 = Color3.fromRGB(255, 93, 199)
Frame_10.ImageTransparency = 0.900
Frame_10.ScaleType = Enum.ScaleType.Slice
Frame_10.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_11.Name = "Frame"
Frame_11.Parent = Pattern
Frame_11.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_11.BackgroundTransparency = 1.000
Frame_11.BorderSizePixel = 0
Frame_11.Position = UDim2.new(0.788571417, 0, 0.723270416, 0)
Frame_11.Size = UDim2.new(0, 35, 0, 32)
Frame_11.Image = "rbxassetid://3570695787"
Frame_11.ImageColor3 = Color3.fromRGB(255, 126, 128)
Frame_11.ImageTransparency = 0.900
Frame_11.ScaleType = Enum.ScaleType.Slice
Frame_11.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_12.Name = "Frame"
Frame_12.Parent = Pattern
Frame_12.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_12.BackgroundTransparency = 1.000
Frame_12.BorderSizePixel = 0
Frame_12.Position = UDim2.new(0.851428568, 0, 0.723270476, 0)
Frame_12.Size = UDim2.new(0, 35, 0, 32)
Frame_12.Image = "rbxassetid://3570695787"
Frame_12.ImageColor3 = Color3.fromRGB(162, 143, 255)
Frame_12.ImageTransparency = 0.900
Frame_12.ScaleType = Enum.ScaleType.Slice
Frame_12.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_13.Name = "Frame"
Frame_13.Parent = Pattern
Frame_13.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_13.BackgroundTransparency = 1.000
Frame_13.BorderSizePixel = 0
Frame_13.Position = UDim2.new(0.918095231, 0, 0.723270476, 0)
Frame_13.Size = UDim2.new(0, 35, 0, 32)
Frame_13.Image = "rbxassetid://3570695787"
Frame_13.ImageColor3 = Color3.fromRGB(67, 255, 218)
Frame_13.ImageTransparency = 0.900
Frame_13.ScaleType = Enum.ScaleType.Slice
Frame_13.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_14.Name = "Frame"
Frame_14.Parent = Pattern
Frame_14.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_14.BackgroundTransparency = 1.000
Frame_14.BorderSizePixel = 0
Frame_14.Position = UDim2.new(0.918095231, 0, 0.795597553, 0)
Frame_14.Size = UDim2.new(0, 35, 0, 32)
Frame_14.Image = "rbxassetid://3570695787"
Frame_14.ImageColor3 = Color3.fromRGB(255, 216, 19)
Frame_14.ImageTransparency = 0.900
Frame_14.ScaleType = Enum.ScaleType.Slice
Frame_14.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_15.Name = "Frame"
Frame_15.Parent = Pattern
Frame_15.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_15.BackgroundTransparency = 1.000
Frame_15.BorderSizePixel = 0
Frame_15.Position = UDim2.new(0.872380972, 0, 0.773584962, 0)
Frame_15.Size = UDim2.new(0, 35, 0, 32)
Frame_15.Image = "rbxassetid://3570695787"
Frame_15.ImageColor3 = Color3.fromRGB(0, 255, 93)
Frame_15.ImageTransparency = 0.900
Frame_15.ScaleType = Enum.ScaleType.Slice
Frame_15.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_16.Name = "Frame"
Frame_16.Parent = Pattern
Frame_16.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_16.BackgroundTransparency = 1.000
Frame_16.BorderSizePixel = 0
Frame_16.Position = UDim2.new(0.815238118, 0, 0.896226466, 0)
Frame_16.Size = UDim2.new(0, 35, 0, 32)
Frame_16.Image = "rbxassetid://3570695787"
Frame_16.ImageColor3 = Color3.fromRGB(255, 239, 181)
Frame_16.ImageTransparency = 0.900
Frame_16.ScaleType = Enum.ScaleType.Slice
Frame_16.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_17.Name = "Frame"
Frame_17.Parent = Pattern
Frame_17.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_17.BackgroundTransparency = 1.000
Frame_17.BorderSizePixel = 0
Frame_17.Position = UDim2.new(0.834285736, 0, 0.669811368, 0)
Frame_17.Size = UDim2.new(0, 35, 0, 32)
Frame_17.Image = "rbxassetid://3570695787"
Frame_17.ImageColor3 = Color3.fromRGB(255, 239, 114)
Frame_17.ImageTransparency = 0.900
Frame_17.ScaleType = Enum.ScaleType.Slice
Frame_17.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_18.Name = "Frame"
Frame_18.Parent = Pattern
Frame_18.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_18.BackgroundTransparency = 1.000
Frame_18.BorderSizePixel = 0
Frame_18.Position = UDim2.new(0.794285774, 0, 0.773584962, 0)
Frame_18.Size = UDim2.new(0, 35, 0, 32)
Frame_18.Image = "rbxassetid://3570695787"
Frame_18.ImageColor3 = Color3.fromRGB(51, 37, 255)
Frame_18.ImageTransparency = 0.900
Frame_18.ScaleType = Enum.ScaleType.Slice
Frame_18.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_19.Name = "Frame"
Frame_19.Parent = Pattern
Frame_19.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_19.BackgroundTransparency = 1.000
Frame_19.BorderSizePixel = 0
Frame_19.Position = UDim2.new(0.872380972, 0, 0.874213934, 0)
Frame_19.Size = UDim2.new(0, 35, 0, 32)
Frame_19.Image = "rbxassetid://3570695787"
Frame_19.ImageColor3 = Color3.fromRGB(255, 0, 0)
Frame_19.ImageTransparency = 0.900
Frame_19.ScaleType = Enum.ScaleType.Slice
Frame_19.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_20.Name = "Frame"
Frame_20.Parent = Pattern
Frame_20.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_20.BackgroundTransparency = 1.000
Frame_20.BorderSizePixel = 0
Frame_20.Position = UDim2.new(0.921904802, 0, 0.874213934, 0)
Frame_20.Size = UDim2.new(0, 35, 0, 32)
Frame_20.Image = "rbxassetid://3570695787"
Frame_20.ImageColor3 = Color3.fromRGB(255, 0, 0)
Frame_20.ImageTransparency = 0.900
Frame_20.ScaleType = Enum.ScaleType.Slice
Frame_20.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_21.Name = "Frame"
Frame_21.Parent = Pattern
Frame_21.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_21.BackgroundTransparency = 1.000
Frame_21.BorderSizePixel = 0
Frame_21.Position = UDim2.new(0.630476177, 0, 0.842767298, 0)
Frame_21.Size = UDim2.new(0, 35, 0, 32)
Frame_21.Image = "rbxassetid://3570695787"
Frame_21.ImageColor3 = Color3.fromRGB(255, 93, 199)
Frame_21.ImageTransparency = 0.900
Frame_21.ScaleType = Enum.ScaleType.Slice
Frame_21.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_22.Name = "Frame"
Frame_22.Parent = Pattern
Frame_22.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_22.BackgroundTransparency = 1.000
Frame_22.BorderSizePixel = 0
Frame_22.Position = UDim2.new(0.657142937, 0, 0.773584962, 0)
Frame_22.Size = UDim2.new(0, 35, 0, 32)
Frame_22.Image = "rbxassetid://3570695787"
Frame_22.ImageColor3 = Color3.fromRGB(51, 37, 255)
Frame_22.ImageTransparency = 0.900
Frame_22.ScaleType = Enum.ScaleType.Slice
Frame_22.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_23.Name = "Frame"
Frame_23.Parent = Pattern
Frame_23.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_23.BackgroundTransparency = 1.000
Frame_23.BorderSizePixel = 0
Frame_23.Position = UDim2.new(0.65142858, 0, 0.723270416, 0)
Frame_23.Size = UDim2.new(0, 35, 0, 32)
Frame_23.Image = "rbxassetid://3570695787"
Frame_23.ImageColor3 = Color3.fromRGB(255, 126, 128)
Frame_23.ImageTransparency = 0.900
Frame_23.ScaleType = Enum.ScaleType.Slice
Frame_23.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_24.Name = "Frame"
Frame_24.Parent = Pattern
Frame_24.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_24.BackgroundTransparency = 1.000
Frame_24.BorderSizePixel = 0
Frame_24.Position = UDim2.new(0.689523816, 0, 0.82704401, 0)
Frame_24.Size = UDim2.new(0, 35, 0, 32)
Frame_24.Image = "rbxassetid://3570695787"
Frame_24.ImageColor3 = Color3.fromRGB(241, 38, 255)
Frame_24.ImageTransparency = 0.900
Frame_24.ScaleType = Enum.ScaleType.Slice
Frame_24.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_25.Name = "Frame"
Frame_25.Parent = Pattern
Frame_25.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_25.BackgroundTransparency = 1.000
Frame_25.BorderSizePixel = 0
Frame_25.Position = UDim2.new(0.780952394, 0, 0.723270476, 0)
Frame_25.Size = UDim2.new(0, 35, 0, 32)
Frame_25.Image = "rbxassetid://3570695787"
Frame_25.ImageColor3 = Color3.fromRGB(67, 255, 218)
Frame_25.ImageTransparency = 0.900
Frame_25.ScaleType = Enum.ScaleType.Slice
Frame_25.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_26.Name = "Frame"
Frame_26.Parent = Pattern
Frame_26.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_26.BackgroundTransparency = 1.000
Frame_26.BorderSizePixel = 0
Frame_26.Position = UDim2.new(0.714285731, 0, 0.723270476, 0)
Frame_26.Size = UDim2.new(0, 35, 0, 32)
Frame_26.Image = "rbxassetid://3570695787"
Frame_26.ImageColor3 = Color3.fromRGB(162, 143, 255)
Frame_26.ImageTransparency = 0.900
Frame_26.ScaleType = Enum.ScaleType.Slice
Frame_26.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_27.Name = "Frame"
Frame_27.Parent = Pattern
Frame_27.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_27.BackgroundTransparency = 1.000
Frame_27.BorderSizePixel = 0
Frame_27.Position = UDim2.new(0.697142899, 0, 0.669811368, 0)
Frame_27.Size = UDim2.new(0, 35, 0, 32)
Frame_27.Image = "rbxassetid://3570695787"
Frame_27.ImageColor3 = Color3.fromRGB(255, 239, 114)
Frame_27.ImageTransparency = 0.900
Frame_27.ScaleType = Enum.ScaleType.Slice
Frame_27.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_28.Name = "Frame"
Frame_28.Parent = Pattern
Frame_28.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_28.BackgroundTransparency = 1.000
Frame_28.BorderSizePixel = 0
Frame_28.Position = UDim2.new(0.735238135, 0, 0.874213934, 0)
Frame_28.Size = UDim2.new(0, 35, 0, 32)
Frame_28.Image = "rbxassetid://3570695787"
Frame_28.ImageColor3 = Color3.fromRGB(255, 0, 0)
Frame_28.ImageTransparency = 0.900
Frame_28.ScaleType = Enum.ScaleType.Slice
Frame_28.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_29.Name = "Frame"
Frame_29.Parent = Pattern
Frame_29.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_29.BackgroundTransparency = 1.000
Frame_29.BorderSizePixel = 0
Frame_29.Position = UDim2.new(0.65142858, 0, 0.685534596, 0)
Frame_29.Size = UDim2.new(0, 35, 0, 32)
Frame_29.Image = "rbxassetid://3570695787"
Frame_29.ImageColor3 = Color3.fromRGB(255, 93, 199)
Frame_29.ImageTransparency = 0.900
Frame_29.ScaleType = Enum.ScaleType.Slice
Frame_29.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_30.Name = "Frame"
Frame_30.Parent = Pattern
Frame_30.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_30.BackgroundTransparency = 1.000
Frame_30.BorderSizePixel = 0
Frame_30.Position = UDim2.new(0.939047635, 0, 0.638364851, 0)
Frame_30.Size = UDim2.new(0, 35, 0, 32)
Frame_30.Image = "rbxassetid://3570695787"
Frame_30.ImageColor3 = Color3.fromRGB(255, 216, 19)
Frame_30.ImageTransparency = 0.900
Frame_30.ScaleType = Enum.ScaleType.Slice
Frame_30.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_31.Name = "Frame"
Frame_31.Parent = Pattern
Frame_31.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_31.BackgroundTransparency = 1.000
Frame_31.BorderSizePixel = 0
Frame_31.Position = UDim2.new(0.788571417, 0, 0.685534596, 0)
Frame_31.Size = UDim2.new(0, 35, 0, 32)
Frame_31.Image = "rbxassetid://3570695787"
Frame_31.ImageColor3 = Color3.fromRGB(255, 93, 199)
Frame_31.ImageTransparency = 0.900
Frame_31.ScaleType = Enum.ScaleType.Slice
Frame_31.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_32.Name = "Frame"
Frame_32.Parent = Pattern
Frame_32.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_32.BackgroundTransparency = 1.000
Frame_32.BorderSizePixel = 0
Frame_32.Position = UDim2.new(0.809523821, 0, 0.566037714, 0)
Frame_32.Size = UDim2.new(0, 35, 0, 32)
Frame_32.Image = "rbxassetid://3570695787"
Frame_32.ImageColor3 = Color3.fromRGB(255, 126, 128)
Frame_32.ImageTransparency = 0.900
Frame_32.ScaleType = Enum.ScaleType.Slice
Frame_32.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_33.Name = "Frame"
Frame_33.Parent = Pattern
Frame_33.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_33.BackgroundTransparency = 1.000
Frame_33.BorderSizePixel = 0
Frame_33.Position = UDim2.new(0.872380972, 0, 0.566037774, 0)
Frame_33.Size = UDim2.new(0, 35, 0, 32)
Frame_33.Image = "rbxassetid://3570695787"
Frame_33.ImageColor3 = Color3.fromRGB(162, 143, 255)
Frame_33.ImageTransparency = 0.900
Frame_33.ScaleType = Enum.ScaleType.Slice
Frame_33.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_34.Name = "Frame"
Frame_34.Parent = Pattern
Frame_34.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_34.BackgroundTransparency = 1.000
Frame_34.BorderSizePixel = 0
Frame_34.Position = UDim2.new(0.939047635, 0, 0.566037774, 0)
Frame_34.Size = UDim2.new(0, 35, 0, 32)
Frame_34.Image = "rbxassetid://3570695787"
Frame_34.ImageColor3 = Color3.fromRGB(67, 255, 218)
Frame_34.ImageTransparency = 0.900
Frame_34.ScaleType = Enum.ScaleType.Slice
Frame_34.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_35.Name = "Frame"
Frame_35.Parent = Pattern
Frame_35.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_35.BackgroundTransparency = 1.000
Frame_35.BorderSizePixel = 0
Frame_35.Position = UDim2.new(0.914285779, 0, 0.493710756, 0)
Frame_35.Size = UDim2.new(0, 35, 0, 32)
Frame_35.Image = "rbxassetid://3570695787"
Frame_35.ImageColor3 = Color3.fromRGB(255, 207, 11)
Frame_35.ImageTransparency = 0.900
Frame_35.ScaleType = Enum.ScaleType.Slice
Frame_35.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_36.Name = "Frame"
Frame_36.Parent = Pattern
Frame_36.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_36.BackgroundTransparency = 1.000
Frame_36.BorderSizePixel = 0
Frame_36.Position = UDim2.new(0.85523814, 0, 0.512578666, 0)
Frame_36.Size = UDim2.new(0, 35, 0, 32)
Frame_36.Image = "rbxassetid://3570695787"
Frame_36.ImageColor3 = Color3.fromRGB(255, 239, 114)
Frame_36.ImageTransparency = 0.900
Frame_36.ScaleType = Enum.ScaleType.Slice
Frame_36.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_37.Name = "Frame"
Frame_37.Parent = Pattern
Frame_37.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_37.BackgroundTransparency = 1.000
Frame_37.BorderSizePixel = 0
Frame_37.Position = UDim2.new(0.815238178, 0, 0.61635226, 0)
Frame_37.Size = UDim2.new(0, 35, 0, 32)
Frame_37.Image = "rbxassetid://3570695787"
Frame_37.ImageColor3 = Color3.fromRGB(51, 37, 255)
Frame_37.ImageTransparency = 0.900
Frame_37.ScaleType = Enum.ScaleType.Slice
Frame_37.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_38.Name = "Frame"
Frame_38.Parent = Pattern
Frame_38.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_38.BackgroundTransparency = 1.000
Frame_38.BorderSizePixel = 0
Frame_38.Position = UDim2.new(0.893333375, 0, 0.716981232, 0)
Frame_38.Size = UDim2.new(0, 35, 0, 32)
Frame_38.Image = "rbxassetid://3570695787"
Frame_38.ImageColor3 = Color3.fromRGB(255, 0, 0)
Frame_38.ImageTransparency = 0.900
Frame_38.ScaleType = Enum.ScaleType.Slice
Frame_38.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_39.Name = "Frame"
Frame_39.Parent = Pattern
Frame_39.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_39.BackgroundTransparency = 1.000
Frame_39.BorderSizePixel = 0
Frame_39.Position = UDim2.new(0.801904798, 0, 0.566037774, 0)
Frame_39.Size = UDim2.new(0, 35, 0, 32)
Frame_39.Image = "rbxassetid://3570695787"
Frame_39.ImageColor3 = Color3.fromRGB(67, 255, 218)
Frame_39.ImageTransparency = 0.900
Frame_39.ScaleType = Enum.ScaleType.Slice
Frame_39.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_40.Name = "Frame"
Frame_40.Parent = Pattern
Frame_40.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_40.BackgroundTransparency = 1.000
Frame_40.BorderSizePixel = 0
Frame_40.Position = UDim2.new(0.678095341, 0, 0.61635226, 0)
Frame_40.Size = UDim2.new(0, 35, 0, 32)
Frame_40.Image = "rbxassetid://3570695787"
Frame_40.ImageColor3 = Color3.fromRGB(51, 37, 255)
Frame_40.ImageTransparency = 0.900
Frame_40.ScaleType = Enum.ScaleType.Slice
Frame_40.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_41.Name = "Frame"
Frame_41.Parent = Pattern
Frame_41.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_41.BackgroundTransparency = 1.000
Frame_41.BorderSizePixel = 0
Frame_41.Position = UDim2.new(0.71047622, 0, 0.669811308, 0)
Frame_41.Size = UDim2.new(0, 35, 0, 32)
Frame_41.Image = "rbxassetid://3570695787"
Frame_41.ImageColor3 = Color3.fromRGB(241, 38, 255)
Frame_41.ImageTransparency = 0.900
Frame_41.ScaleType = Enum.ScaleType.Slice
Frame_41.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_42.Name = "Frame"
Frame_42.Parent = Pattern
Frame_42.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_42.BackgroundTransparency = 1.000
Frame_42.BorderSizePixel = 0
Frame_42.Position = UDim2.new(0.805714369, 0, 0.716981232, 0)
Frame_42.Size = UDim2.new(0, 35, 0, 32)
Frame_42.Image = "rbxassetid://3570695787"
Frame_42.ImageColor3 = Color3.fromRGB(255, 0, 0)
Frame_42.ImageTransparency = 0.900
Frame_42.ScaleType = Enum.ScaleType.Slice
Frame_42.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_43.Name = "Frame"
Frame_43.Parent = Pattern
Frame_43.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_43.BackgroundTransparency = 1.000
Frame_43.BorderSizePixel = 0
Frame_43.Position = UDim2.new(0.756190538, 0, 0.61635226, 0)
Frame_43.Size = UDim2.new(0, 35, 0, 32)
Frame_43.Image = "rbxassetid://3570695787"
Frame_43.ImageColor3 = Color3.fromRGB(0, 255, 93)
Frame_43.ImageTransparency = 0.900
Frame_43.ScaleType = Enum.ScaleType.Slice
Frame_43.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_44.Name = "Frame"
Frame_44.Parent = Pattern
Frame_44.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_44.BackgroundTransparency = 1.000
Frame_44.BorderSizePixel = 0
Frame_44.Position = UDim2.new(0.826666653, 0, 0.82704401, 0)
Frame_44.Size = UDim2.new(0, 35, 0, 32)
Frame_44.Image = "rbxassetid://3570695787"
Frame_44.ImageColor3 = Color3.fromRGB(241, 38, 255)
Frame_44.ImageTransparency = 0.900
Frame_44.ScaleType = Enum.ScaleType.Slice
Frame_44.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_45.Name = "Frame"
Frame_45.Parent = KeySystemFrame
Frame_45.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_45.BackgroundTransparency = 1.000
Frame_45.Size = UDim2.new(0, 525, 0, 317)
Frame_45.Image = "rbxassetid://3570695787"
Frame_45.ImageColor3 = Color3.fromRGB(20, 20, 20)
Frame_45.ImageTransparency = 0.700
Frame_45.ScaleType = Enum.ScaleType.Slice
Frame_45.SliceCenter = Rect.new(100, 100, 100, 100)
Frame_45.SliceScale = 0.040

WelcometoZoro.Name = "Welcome to Zoro!"
WelcometoZoro.Parent = Frame_45
WelcometoZoro.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WelcometoZoro.BackgroundTransparency = 1.000
WelcometoZoro.Position = UDim2.new(0.297142863, 0, 0.337539434, 0)
WelcometoZoro.Size = UDim2.new(0, 200, 0, 50)
WelcometoZoro.Font = Enum.Font.Ubuntu
WelcometoZoro.Text = "Welcome to Zoro!"
WelcometoZoro.TextColor3 = Color3.fromRGB(118, 118, 118)
WelcometoZoro.TextSize = 20.000
WelcometoZoro.TextWrapped = true

Frame_46.Name = "Frame"
Frame_46.Parent = Frame_45
Frame_46.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_46.BackgroundTransparency = 1.000
Frame_46.BorderSizePixel = 0
Frame_46.Position = UDim2.new(0.826666653, 0, 0.82704401, 0)
Frame_46.Size = UDim2.new(0, 35, 0, 32)
Frame_46.Image = "rbxassetid://3570695787"
Frame_46.ImageColor3 = Color3.fromRGB(241, 38, 255)
Frame_46.ImageTransparency = 0.900
Frame_46.ScaleType = Enum.ScaleType.Slice
Frame_46.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_47.Name = "Frame"
Frame_47.Parent = Frame_45
Frame_47.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_47.BackgroundTransparency = 1.000
Frame_47.BorderSizePixel = 0
Frame_47.Position = UDim2.new(0.767619014, 0, 0.842767298, 0)
Frame_47.Size = UDim2.new(0, 35, 0, 32)
Frame_47.Image = "rbxassetid://3570695787"
Frame_47.ImageColor3 = Color3.fromRGB(255, 93, 199)
Frame_47.ImageTransparency = 0.900
Frame_47.ScaleType = Enum.ScaleType.Slice
Frame_47.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_48.Name = "Frame"
Frame_48.Parent = Frame_45
Frame_48.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_48.BackgroundTransparency = 1.000
Frame_48.BorderSizePixel = 0
Frame_48.Position = UDim2.new(0.788571417, 0, 0.723270416, 0)
Frame_48.Size = UDim2.new(0, 35, 0, 32)
Frame_48.Image = "rbxassetid://3570695787"
Frame_48.ImageColor3 = Color3.fromRGB(255, 126, 128)
Frame_48.ImageTransparency = 0.900
Frame_48.ScaleType = Enum.ScaleType.Slice
Frame_48.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_49.Name = "Frame"
Frame_49.Parent = Frame_45
Frame_49.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_49.BackgroundTransparency = 1.000
Frame_49.BorderSizePixel = 0
Frame_49.Position = UDim2.new(0.851428568, 0, 0.723270476, 0)
Frame_49.Size = UDim2.new(0, 35, 0, 32)
Frame_49.Image = "rbxassetid://3570695787"
Frame_49.ImageColor3 = Color3.fromRGB(162, 143, 255)
Frame_49.ImageTransparency = 0.900
Frame_49.ScaleType = Enum.ScaleType.Slice
Frame_49.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_50.Name = "Frame"
Frame_50.Parent = Frame_45
Frame_50.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_50.BackgroundTransparency = 1.000
Frame_50.BorderSizePixel = 0
Frame_50.Position = UDim2.new(0.918095231, 0, 0.723270476, 0)
Frame_50.Size = UDim2.new(0, 35, 0, 32)
Frame_50.Image = "rbxassetid://3570695787"
Frame_50.ImageColor3 = Color3.fromRGB(67, 255, 218)
Frame_50.ImageTransparency = 0.900
Frame_50.ScaleType = Enum.ScaleType.Slice
Frame_50.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_51.Name = "Frame"
Frame_51.Parent = Frame_45
Frame_51.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_51.BackgroundTransparency = 1.000
Frame_51.BorderSizePixel = 0
Frame_51.Position = UDim2.new(0.918095231, 0, 0.795597553, 0)
Frame_51.Size = UDim2.new(0, 35, 0, 32)
Frame_51.Image = "rbxassetid://3570695787"
Frame_51.ImageColor3 = Color3.fromRGB(255, 216, 19)
Frame_51.ImageTransparency = 0.900
Frame_51.ScaleType = Enum.ScaleType.Slice
Frame_51.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_52.Name = "Frame"
Frame_52.Parent = Frame_45
Frame_52.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_52.BackgroundTransparency = 1.000
Frame_52.BorderSizePixel = 0
Frame_52.Position = UDim2.new(0.872380972, 0, 0.773584962, 0)
Frame_52.Size = UDim2.new(0, 35, 0, 32)
Frame_52.Image = "rbxassetid://3570695787"
Frame_52.ImageColor3 = Color3.fromRGB(0, 255, 93)
Frame_52.ImageTransparency = 0.900
Frame_52.ScaleType = Enum.ScaleType.Slice
Frame_52.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_53.Name = "Frame"
Frame_53.Parent = Frame_45
Frame_53.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_53.BackgroundTransparency = 1.000
Frame_53.BorderSizePixel = 0
Frame_53.Position = UDim2.new(0.815238118, 0, 0.896226466, 0)
Frame_53.Size = UDim2.new(0, 35, 0, 32)
Frame_53.Image = "rbxassetid://3570695787"
Frame_53.ImageColor3 = Color3.fromRGB(255, 239, 181)
Frame_53.ImageTransparency = 0.900
Frame_53.ScaleType = Enum.ScaleType.Slice
Frame_53.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_54.Name = "Frame"
Frame_54.Parent = Frame_45
Frame_54.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_54.BackgroundTransparency = 1.000
Frame_54.BorderSizePixel = 0
Frame_54.Position = UDim2.new(0.834285736, 0, 0.669811368, 0)
Frame_54.Size = UDim2.new(0, 35, 0, 32)
Frame_54.Image = "rbxassetid://3570695787"
Frame_54.ImageColor3 = Color3.fromRGB(255, 239, 114)
Frame_54.ImageTransparency = 0.900
Frame_54.ScaleType = Enum.ScaleType.Slice
Frame_54.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_55.Name = "Frame"
Frame_55.Parent = Frame_45
Frame_55.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_55.BackgroundTransparency = 1.000
Frame_55.BorderSizePixel = 0
Frame_55.Position = UDim2.new(0.794285774, 0, 0.773584962, 0)
Frame_55.Size = UDim2.new(0, 35, 0, 32)
Frame_55.Image = "rbxassetid://3570695787"
Frame_55.ImageColor3 = Color3.fromRGB(51, 37, 255)
Frame_55.ImageTransparency = 0.900
Frame_55.ScaleType = Enum.ScaleType.Slice
Frame_55.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_56.Name = "Frame"
Frame_56.Parent = Frame_45
Frame_56.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_56.BackgroundTransparency = 1.000
Frame_56.BorderSizePixel = 0
Frame_56.Position = UDim2.new(0.872380972, 0, 0.874213934, 0)
Frame_56.Size = UDim2.new(0, 35, 0, 32)
Frame_56.Image = "rbxassetid://3570695787"
Frame_56.ImageColor3 = Color3.fromRGB(255, 0, 0)
Frame_56.ImageTransparency = 0.900
Frame_56.ScaleType = Enum.ScaleType.Slice
Frame_56.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_57.Name = "Frame"
Frame_57.Parent = Frame_45
Frame_57.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_57.BackgroundTransparency = 1.000
Frame_57.BorderSizePixel = 0
Frame_57.Position = UDim2.new(0.921904802, 0, 0.874213934, 0)
Frame_57.Size = UDim2.new(0, 35, 0, 32)
Frame_57.Image = "rbxassetid://3570695787"
Frame_57.ImageColor3 = Color3.fromRGB(255, 0, 0)
Frame_57.ImageTransparency = 0.900
Frame_57.ScaleType = Enum.ScaleType.Slice
Frame_57.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_58.Name = "Frame"
Frame_58.Parent = Frame_45
Frame_58.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_58.BackgroundTransparency = 1.000
Frame_58.BorderSizePixel = 0
Frame_58.Position = UDim2.new(0.630476177, 0, 0.842767298, 0)
Frame_58.Size = UDim2.new(0, 35, 0, 32)
Frame_58.Image = "rbxassetid://3570695787"
Frame_58.ImageColor3 = Color3.fromRGB(255, 93, 199)
Frame_58.ImageTransparency = 0.900
Frame_58.ScaleType = Enum.ScaleType.Slice
Frame_58.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_59.Name = "Frame"
Frame_59.Parent = Frame_45
Frame_59.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_59.BackgroundTransparency = 1.000
Frame_59.BorderSizePixel = 0
Frame_59.Position = UDim2.new(0.657142937, 0, 0.773584962, 0)
Frame_59.Size = UDim2.new(0, 35, 0, 32)
Frame_59.Image = "rbxassetid://3570695787"
Frame_59.ImageColor3 = Color3.fromRGB(51, 37, 255)
Frame_59.ImageTransparency = 0.900
Frame_59.ScaleType = Enum.ScaleType.Slice
Frame_59.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_60.Name = "Frame"
Frame_60.Parent = Frame_45
Frame_60.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_60.BackgroundTransparency = 1.000
Frame_60.BorderSizePixel = 0
Frame_60.Position = UDim2.new(0.65142858, 0, 0.723270416, 0)
Frame_60.Size = UDim2.new(0, 35, 0, 32)
Frame_60.Image = "rbxassetid://3570695787"
Frame_60.ImageColor3 = Color3.fromRGB(255, 126, 128)
Frame_60.ImageTransparency = 0.900
Frame_60.ScaleType = Enum.ScaleType.Slice
Frame_60.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_61.Name = "Frame"
Frame_61.Parent = Frame_45
Frame_61.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_61.BackgroundTransparency = 1.000
Frame_61.BorderSizePixel = 0
Frame_61.Position = UDim2.new(0.689523816, 0, 0.82704401, 0)
Frame_61.Size = UDim2.new(0, 35, 0, 32)
Frame_61.Image = "rbxassetid://3570695787"
Frame_61.ImageColor3 = Color3.fromRGB(241, 38, 255)
Frame_61.ImageTransparency = 0.900
Frame_61.ScaleType = Enum.ScaleType.Slice
Frame_61.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_62.Name = "Frame"
Frame_62.Parent = Frame_45
Frame_62.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_62.BackgroundTransparency = 1.000
Frame_62.BorderSizePixel = 0
Frame_62.Position = UDim2.new(0.780952394, 0, 0.723270476, 0)
Frame_62.Size = UDim2.new(0, 35, 0, 32)
Frame_62.Image = "rbxassetid://3570695787"
Frame_62.ImageColor3 = Color3.fromRGB(67, 255, 218)
Frame_62.ImageTransparency = 0.900
Frame_62.ScaleType = Enum.ScaleType.Slice
Frame_62.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_63.Name = "Frame"
Frame_63.Parent = Frame_45
Frame_63.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_63.BackgroundTransparency = 1.000
Frame_63.BorderSizePixel = 0
Frame_63.Position = UDim2.new(0.714285731, 0, 0.723270476, 0)
Frame_63.Size = UDim2.new(0, 35, 0, 32)
Frame_63.Image = "rbxassetid://3570695787"
Frame_63.ImageColor3 = Color3.fromRGB(162, 143, 255)
Frame_63.ImageTransparency = 0.900
Frame_63.ScaleType = Enum.ScaleType.Slice
Frame_63.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_64.Name = "Frame"
Frame_64.Parent = Frame_45
Frame_64.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_64.BackgroundTransparency = 1.000
Frame_64.BorderSizePixel = 0
Frame_64.Position = UDim2.new(0.697142899, 0, 0.669811368, 0)
Frame_64.Size = UDim2.new(0, 35, 0, 32)
Frame_64.Image = "rbxassetid://3570695787"
Frame_64.ImageColor3 = Color3.fromRGB(255, 239, 114)
Frame_64.ImageTransparency = 0.900
Frame_64.ScaleType = Enum.ScaleType.Slice
Frame_64.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_65.Name = "Frame"
Frame_65.Parent = Frame_45
Frame_65.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_65.BackgroundTransparency = 1.000
Frame_65.BorderSizePixel = 0
Frame_65.Position = UDim2.new(0.735238135, 0, 0.874213934, 0)
Frame_65.Size = UDim2.new(0, 35, 0, 32)
Frame_65.Image = "rbxassetid://3570695787"
Frame_65.ImageColor3 = Color3.fromRGB(255, 0, 0)
Frame_65.ImageTransparency = 0.900
Frame_65.ScaleType = Enum.ScaleType.Slice
Frame_65.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_66.Name = "Frame"
Frame_66.Parent = Frame_45
Frame_66.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_66.BackgroundTransparency = 1.000
Frame_66.BorderSizePixel = 0
Frame_66.Position = UDim2.new(0.65142858, 0, 0.685534596, 0)
Frame_66.Size = UDim2.new(0, 35, 0, 32)
Frame_66.Image = "rbxassetid://3570695787"
Frame_66.ImageColor3 = Color3.fromRGB(255, 93, 199)
Frame_66.ImageTransparency = 0.900
Frame_66.ScaleType = Enum.ScaleType.Slice
Frame_66.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_67.Name = "Frame"
Frame_67.Parent = Frame_45
Frame_67.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_67.BackgroundTransparency = 1.000
Frame_67.BorderSizePixel = 0
Frame_67.Position = UDim2.new(0.939047635, 0, 0.638364851, 0)
Frame_67.Size = UDim2.new(0, 35, 0, 32)
Frame_67.Image = "rbxassetid://3570695787"
Frame_67.ImageColor3 = Color3.fromRGB(255, 216, 19)
Frame_67.ImageTransparency = 0.900
Frame_67.ScaleType = Enum.ScaleType.Slice
Frame_67.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_68.Name = "Frame"
Frame_68.Parent = Frame_45
Frame_68.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_68.BackgroundTransparency = 1.000
Frame_68.BorderSizePixel = 0
Frame_68.Position = UDim2.new(0.788571417, 0, 0.685534596, 0)
Frame_68.Size = UDim2.new(0, 35, 0, 32)
Frame_68.Image = "rbxassetid://3570695787"
Frame_68.ImageColor3 = Color3.fromRGB(255, 93, 199)
Frame_68.ImageTransparency = 0.900
Frame_68.ScaleType = Enum.ScaleType.Slice
Frame_68.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_69.Name = "Frame"
Frame_69.Parent = Frame_45
Frame_69.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_69.BackgroundTransparency = 1.000
Frame_69.BorderSizePixel = 0
Frame_69.Position = UDim2.new(0.809523821, 0, 0.566037714, 0)
Frame_69.Size = UDim2.new(0, 35, 0, 32)
Frame_69.Image = "rbxassetid://3570695787"
Frame_69.ImageColor3 = Color3.fromRGB(255, 126, 128)
Frame_69.ImageTransparency = 0.900
Frame_69.ScaleType = Enum.ScaleType.Slice
Frame_69.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_70.Name = "Frame"
Frame_70.Parent = Frame_45
Frame_70.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_70.BackgroundTransparency = 1.000
Frame_70.BorderSizePixel = 0
Frame_70.Position = UDim2.new(0.872380972, 0, 0.566037774, 0)
Frame_70.Size = UDim2.new(0, 35, 0, 32)
Frame_70.Image = "rbxassetid://3570695787"
Frame_70.ImageColor3 = Color3.fromRGB(162, 143, 255)
Frame_70.ImageTransparency = 0.900
Frame_70.ScaleType = Enum.ScaleType.Slice
Frame_70.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_71.Name = "Frame"
Frame_71.Parent = Frame_45
Frame_71.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_71.BackgroundTransparency = 1.000
Frame_71.BorderSizePixel = 0
Frame_71.Position = UDim2.new(0.939047635, 0, 0.566037774, 0)
Frame_71.Size = UDim2.new(0, 35, 0, 32)
Frame_71.Image = "rbxassetid://3570695787"
Frame_71.ImageColor3 = Color3.fromRGB(67, 255, 218)
Frame_71.ImageTransparency = 0.900
Frame_71.ScaleType = Enum.ScaleType.Slice
Frame_71.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_72.Name = "Frame"
Frame_72.Parent = Frame_45
Frame_72.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_72.BackgroundTransparency = 1.000
Frame_72.BorderSizePixel = 0
Frame_72.Position = UDim2.new(0.914285779, 0, 0.493710756, 0)
Frame_72.Size = UDim2.new(0, 35, 0, 32)
Frame_72.Image = "rbxassetid://3570695787"
Frame_72.ImageColor3 = Color3.fromRGB(255, 207, 11)
Frame_72.ImageTransparency = 0.900
Frame_72.ScaleType = Enum.ScaleType.Slice
Frame_72.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_73.Name = "Frame"
Frame_73.Parent = Frame_45
Frame_73.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_73.BackgroundTransparency = 1.000
Frame_73.BorderSizePixel = 0
Frame_73.Position = UDim2.new(0.85523814, 0, 0.512578666, 0)
Frame_73.Size = UDim2.new(0, 35, 0, 32)
Frame_73.Image = "rbxassetid://3570695787"
Frame_73.ImageColor3 = Color3.fromRGB(255, 239, 114)
Frame_73.ImageTransparency = 0.900
Frame_73.ScaleType = Enum.ScaleType.Slice
Frame_73.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_74.Name = "Frame"
Frame_74.Parent = Frame_45
Frame_74.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_74.BackgroundTransparency = 1.000
Frame_74.BorderSizePixel = 0
Frame_74.Position = UDim2.new(0.815238178, 0, 0.61635226, 0)
Frame_74.Size = UDim2.new(0, 35, 0, 32)
Frame_74.Image = "rbxassetid://3570695787"
Frame_74.ImageColor3 = Color3.fromRGB(51, 37, 255)
Frame_74.ImageTransparency = 0.900
Frame_74.ScaleType = Enum.ScaleType.Slice
Frame_74.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_75.Name = "Frame"
Frame_75.Parent = Frame_45
Frame_75.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_75.BackgroundTransparency = 1.000
Frame_75.BorderSizePixel = 0
Frame_75.Position = UDim2.new(0.893333375, 0, 0.716981232, 0)
Frame_75.Size = UDim2.new(0, 35, 0, 32)
Frame_75.Image = "rbxassetid://3570695787"
Frame_75.ImageColor3 = Color3.fromRGB(255, 0, 0)
Frame_75.ImageTransparency = 0.900
Frame_75.ScaleType = Enum.ScaleType.Slice
Frame_75.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_76.Name = "Frame"
Frame_76.Parent = Frame_45
Frame_76.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_76.BackgroundTransparency = 1.000
Frame_76.BorderSizePixel = 0
Frame_76.Position = UDim2.new(0.801904798, 0, 0.566037774, 0)
Frame_76.Size = UDim2.new(0, 35, 0, 32)
Frame_76.Image = "rbxassetid://3570695787"
Frame_76.ImageColor3 = Color3.fromRGB(67, 255, 218)
Frame_76.ImageTransparency = 0.900
Frame_76.ScaleType = Enum.ScaleType.Slice
Frame_76.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_77.Name = "Frame"
Frame_77.Parent = Frame_45
Frame_77.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_77.BackgroundTransparency = 1.000
Frame_77.BorderSizePixel = 0
Frame_77.Position = UDim2.new(0.678095341, 0, 0.61635226, 0)
Frame_77.Size = UDim2.new(0, 35, 0, 32)
Frame_77.Image = "rbxassetid://3570695787"
Frame_77.ImageColor3 = Color3.fromRGB(51, 37, 255)
Frame_77.ImageTransparency = 0.900
Frame_77.ScaleType = Enum.ScaleType.Slice
Frame_77.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_78.Name = "Frame"
Frame_78.Parent = Frame_45
Frame_78.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_78.BackgroundTransparency = 1.000
Frame_78.BorderSizePixel = 0
Frame_78.Position = UDim2.new(0.71047622, 0, 0.669811308, 0)
Frame_78.Size = UDim2.new(0, 35, 0, 32)
Frame_78.Image = "rbxassetid://3570695787"
Frame_78.ImageColor3 = Color3.fromRGB(241, 38, 255)
Frame_78.ImageTransparency = 0.900
Frame_78.ScaleType = Enum.ScaleType.Slice
Frame_78.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_79.Name = "Frame"
Frame_79.Parent = Frame_45
Frame_79.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_79.BackgroundTransparency = 1.000
Frame_79.BorderSizePixel = 0
Frame_79.Position = UDim2.new(0.805714369, 0, 0.716981232, 0)
Frame_79.Size = UDim2.new(0, 35, 0, 32)
Frame_79.Image = "rbxassetid://3570695787"
Frame_79.ImageColor3 = Color3.fromRGB(255, 0, 0)
Frame_79.ImageTransparency = 0.900
Frame_79.ScaleType = Enum.ScaleType.Slice
Frame_79.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_80.Name = "Frame"
Frame_80.Parent = Frame_45
Frame_80.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_80.BackgroundTransparency = 1.000
Frame_80.BorderSizePixel = 0
Frame_80.Position = UDim2.new(0.756190538, 0, 0.61635226, 0)
Frame_80.Size = UDim2.new(0, 35, 0, 32)
Frame_80.Image = "rbxassetid://3570695787"
Frame_80.ImageColor3 = Color3.fromRGB(0, 255, 93)
Frame_80.ImageTransparency = 0.900
Frame_80.ScaleType = Enum.ScaleType.Slice
Frame_80.SliceCenter = Rect.new(100, 100, 100, 100)

Frame_81.Name = "Frame"
Frame_81.Parent = Frame_45
Frame_81.BackgroundColor3 = Color3.fromRGB(255, 136, 38)
Frame_81.BackgroundTransparency = 1.000
Frame_81.BorderSizePixel = 0
Frame_81.Position = UDim2.new(0.767619014, 0, 0.842767298, 0)
Frame_81.Size = UDim2.new(0, 35, 0, 32)
Frame_81.Image = "rbxassetid://3570695787"
Frame_81.ImageColor3 = Color3.fromRGB(255, 93, 199)
Frame_81.ImageTransparency = 0.900
Frame_81.ScaleType = Enum.ScaleType.Slice
Frame_81.SliceCenter = Rect.new(100, 100, 100, 100)

SubmitKeyTextBox.Name = "SubmitKeyTextBox"
SubmitKeyTextBox.Parent = KeySystemFrame
SubmitKeyTextBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SubmitKeyTextBox.BorderSizePixel = 0
SubmitKeyTextBox.Position = UDim2.new(0.234285712, 0, 0.510966778, 0)
SubmitKeyTextBox.Size = UDim2.new(0, 263, 0, 26)
SubmitKeyTextBox.Font = Enum.Font.SourceSans
SubmitKeyTextBox.PlaceholderColor3 = Color3.fromRGB(178, 40, 40)
SubmitKeyTextBox.PlaceholderText = "Insert key here"
SubmitKeyTextBox.Text = ""
SubmitKeyTextBox.TextColor3 = Color3.fromRGB(144, 144, 144)
SubmitKeyTextBox.TextSize = 14.000

UICorner_6.CornerRadius = UDim.new(0.200000003, 0)
UICorner_6.Parent = SubmitKeyTextBox

Discord.Name = "Discord"
Discord.Parent = KeySystemFrame
Discord.BackgroundColor3 = Color3.fromRGB(1, 1, 1)
Discord.BorderSizePixel = 0
Discord.Position = UDim2.new(0.234285712, 0, 0.614413977, 0)
Discord.Size = UDim2.new(0, 122, 0, 31)
Discord.Font = Enum.Font.Ubuntu
Discord.Text = "Discord"
Discord.TextColor3 = Color3.fromRGB(163, 163, 163)
Discord.TextSize = 13.000

UICorner_7.CornerRadius = UDim.new(0.224999994, 0)
UICorner_7.Parent = Discord

SubmitKey.Name = "SubmitKey"
SubmitKey.Parent = KeySystemFrame
SubmitKey.BackgroundColor3 = Color3.fromRGB(1, 1, 1)
SubmitKey.BorderSizePixel = 0
SubmitKey.Position = UDim2.new(0.49333334, 0, 0.614413977, 0)
SubmitKey.Size = UDim2.new(0, 126, 0, 31)
SubmitKey.Font = Enum.Font.Ubuntu
SubmitKey.Text = "Submit"
SubmitKey.TextColor3 = Color3.fromRGB(163, 163, 163)
SubmitKey.TextSize = 13.000
SubmitKey.MouseButton1Down:connect(function()
SubmitKeyTextBox.Text = getfenv().Key
KeySystemFrame.Visible = false;
end)

UICorner_8.CornerRadius = UDim.new(0.224999994, 0)
UICorner_8.Parent = SubmitKey

    MainHeader.Name = "MainHeader"
    MainHeader.Parent = Main
    MainHeader.BackgroundColor3 = themeList.Header
    Objects[MainHeader] = "BackgroundColor3"
    MainHeader.Size = UDim2.new(0, 525, 0, 29)
    headerCover.CornerRadius = UDim.new(0, 4)
    headerCover.Name = "headerCover"
    headerCover.Parent = MainHeader

    coverup.Name = "coverup"
    coverup.Parent = MainHeader
    coverup.BackgroundColor3 = themeList.Header
    Objects[coverup] = "BackgroundColor3"
    coverup.BorderSizePixel = 0
    coverup.Position = UDim2.new(0, 0, 0.758620679, 0)
    coverup.Size = UDim2.new(0, 525, 0, 7)

    title.Name = "title"
    title.Parent = MainHeader
    title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1.000
    title.BorderSizePixel = 0
    title.Position = UDim2.new(0.0171428565, 0, 0.344827592, 0)
    title.Size = UDim2.new(0, 204, 0, 8)
    title.Font = Enum.Font.Gotham
    title.RichText = true
    title.Text = kavName
    title.TextColor3 = Color3.fromRGB(245, 245, 245)
    title.TextSize = 16.000
    title.TextXAlignment = Enum.TextXAlignment.Left

    MainSide.Name = "MainSide"
    MainSide.Parent = Main
    MainSide.BackgroundColor3 = themeList.Header
    Objects[MainSide] = "Header"
    MainSide.Position = UDim2.new(-7.4505806e-09, 0, 0.0911949649, 0)
    MainSide.Size = UDim2.new(0, 149, 0, 289)

    sideCorner.CornerRadius = UDim.new(0, 4)
    sideCorner.Name = "sideCorner"
    sideCorner.Parent = MainSide

    coverup_2.Name = "coverup"
    coverup_2.Parent = MainSide
    coverup_2.BackgroundColor3 = themeList.Header
    Objects[coverup_2] = "Header"
    coverup_2.BorderSizePixel = 0
    coverup_2.Position = UDim2.new(0.949939311, 0, 0, 0)
    coverup_2.Size = UDim2.new(0, 7, 0, 289)

    tabFrames.Name = "tabFrames"
    tabFrames.Parent = MainSide
    tabFrames.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tabFrames.BackgroundTransparency = 1.000
    tabFrames.Position = UDim2.new(0.0438990258, 0, -0.00066378375, 0)
    tabFrames.Size = UDim2.new(0, 135, 0, 283)

    tabListing.Name = "tabListing"
    tabListing.Parent = tabFrames
    tabListing.SortOrder = Enum.SortOrder.LayoutOrder

    pages.Name = "pages"
    pages.Parent = Main
    pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    pages.BackgroundTransparency = 1.000
    pages.BorderSizePixel = 0
    pages.Position = UDim2.new(0.299047589, 0, 0.122641519, 0)
    pages.Size = UDim2.new(0, 360, 0, 269)

    Pages.Name = "Pages"
    Pages.Parent = pages

    infoContainer.Name = "infoContainer"
    infoContainer.Parent = Main
    infoContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    infoContainer.BackgroundTransparency = 1.000
    infoContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
    infoContainer.ClipsDescendants = true
    infoContainer.Position = UDim2.new(0.299047619, 0, 0.874213815, 0)
    infoContainer.Size = UDim2.new(0, 368, 0, 33)

    
    coroutine.wrap(function()
        while wait() do
            Main.BackgroundColor3 = themeList.Background
            MainHeader.BackgroundColor3 = themeList.Header
            MainSide.BackgroundColor3 = themeList.Header
            coverup_2.BackgroundColor3 = themeList.Header
            coverup.BackgroundColor3 = themeList.Header
        end
    end)()

    function Kavo:ChangeColor(prope,color)
        if prope == "Background" then
            themeList.Background = color
        elseif prope == "SchemeColor" then
            themeList.SchemeColor = color
        elseif prope == "Header" then
            themeList.Header = color
        elseif prope == "TextColor" then
            themeList.TextColor = color
        elseif prope == "ElementColor" then
            themeList.ElementColor = color
        end
    end
    local Tabs = {}

    local first = true

    function Tabs:NewTab(tabName)
        tabName = tabName or "Tab"
        local tabButton = Instance.new("TextButton")
        local UICorner = Instance.new("UICorner")
        local page = Instance.new("ScrollingFrame")
        local pageListing = Instance.new("UIListLayout")

        local function UpdateSize()
            local cS = pageListing.AbsoluteContentSize

            game.TweenService:Create(page, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                CanvasSize = UDim2.new(0,cS.X,0,cS.Y)
            }):Play()
        end

        page.Name = "Page"
        page.Parent = Pages
        page.Active = true
        page.BackgroundColor3 = themeList.Background
        page.BorderSizePixel = 0
        page.Position = UDim2.new(0, 0, -0.00371747208, 0)
        page.Size = UDim2.new(1, 0, 1, 0)
        page.ScrollBarThickness = 5
        page.Visible = false
        page.ScrollBarImageColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 16, themeList.SchemeColor.g * 255 - 15, themeList.SchemeColor.b * 255 - 28)

        pageListing.Name = "pageListing"
        pageListing.Parent = page
        pageListing.SortOrder = Enum.SortOrder.LayoutOrder
        pageListing.Padding = UDim.new(0, 5)

        tabButton.Name = tabName.."TabButton"
        tabButton.Parent = tabFrames
        tabButton.BackgroundColor3 = themeList.SchemeColor
        Objects[tabButton] = "SchemeColor"
        tabButton.Size = UDim2.new(0, 135, 0, 28)
        tabButton.AutoButtonColor = false
        tabButton.Font = Enum.Font.Gotham
        tabButton.Text = tabName
        tabButton.TextColor3 = themeList.TextColor
        Objects[tabButton] = "TextColor3"
        tabButton.TextSize = 14.000
        tabButton.BackgroundTransparency = 1

        if first then
            first = false
            page.Visible = true
            tabButton.BackgroundTransparency = 0
            UpdateSize()
        else
            page.Visible = false
            tabButton.BackgroundTransparency = 1
        end

        UICorner.CornerRadius = UDim.new(0, 5)
        UICorner.Parent = tabButton
        table.insert(Tabs, tabName)

        UpdateSize()
        page.ChildAdded:Connect(UpdateSize)
        page.ChildRemoved:Connect(UpdateSize)

        tabButton.MouseButton1Click:Connect(function()
            UpdateSize()
            for i,v in next, Pages:GetChildren() do
                v.Visible = false
            end
            page.Visible = true
            for i,v in next, tabFrames:GetChildren() do
                if v:IsA("TextButton") then
                    if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                        Utility:TweenObject(v, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                    end 
                    if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                        Utility:TweenObject(v, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                    end 
                    Utility:TweenObject(v, {BackgroundTransparency = 1}, 0.2)
                end
            end
            if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                Utility:TweenObject(tabButton, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
            end 
            if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                Utility:TweenObject(tabButton, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
            end 
            Utility:TweenObject(tabButton, {BackgroundTransparency = 0}, 0.2)
        end)
        local Sections = {}
        local focusing = false
        local viewDe = false

        coroutine.wrap(function()
            while wait() do
                page.BackgroundColor3 = themeList.Background
                page.ScrollBarImageColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 16, themeList.SchemeColor.g * 255 - 15, themeList.SchemeColor.b * 255 - 28)
                tabButton.TextColor3 = themeList.TextColor
                tabButton.BackgroundColor3 = themeList.SchemeColor
            end
        end)()
    
        function Sections:NewSection(secName, hidden)
            secName = secName or "Section"
            local sectionFunctions = {}
            local modules = {}
	    hidden = hidden or false
            local sectionFrame = Instance.new("Frame")
            local sectionlistoknvm = Instance.new("UIListLayout")
            local sectionHead = Instance.new("Frame")
            local sHeadCorner = Instance.new("UICorner")
            local sectionName = Instance.new("TextLabel")
            local sectionInners = Instance.new("Frame")
            local sectionElListing = Instance.new("UIListLayout")
			
	    if hidden then
		sectionHead.Visible = false
	    else
		sectionHead.Visible = true
	    end

            sectionFrame.Name = "sectionFrame"
            sectionFrame.Parent = page
            sectionFrame.BackgroundColor3 = themeList.Background--36, 37, 43
            sectionFrame.BorderSizePixel = 0
            
            sectionlistoknvm.Name = "sectionlistoknvm"
            sectionlistoknvm.Parent = sectionFrame
            sectionlistoknvm.SortOrder = Enum.SortOrder.LayoutOrder
            sectionlistoknvm.Padding = UDim.new(0, 5)

            for i,v in pairs(sectionInners:GetChildren()) do
                while wait() do
                    if v:IsA("Frame") or v:IsA("TextButton") then
                        function size(pro)
                            if pro == "Size" then
                                UpdateSize()
                                updateSectionFrame()
                            end
                        end
                        v.Changed:Connect(size)
                    end
                end
            end
            sectionHead.Name = "sectionHead"
            sectionHead.Parent = sectionFrame
            sectionHead.BackgroundColor3 = themeList.SchemeColor
            Objects[sectionHead] = "BackgroundColor3"
            sectionHead.Size = UDim2.new(0, 352, 0, 33)

            sHeadCorner.CornerRadius = UDim.new(0, 4)
            sHeadCorner.Name = "sHeadCorner"
            sHeadCorner.Parent = sectionHead

            sectionName.Name = "sectionName"
            sectionName.Parent = sectionHead
            sectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectionName.BackgroundTransparency = 1.000
            sectionName.BorderColor3 = Color3.fromRGB(27, 42, 53)
            sectionName.Position = UDim2.new(0.0198863633, 0, 0, 0)
            sectionName.Size = UDim2.new(0.980113626, 0, 1, 0)
            sectionName.Font = Enum.Font.Gotham
            sectionName.Text = secName
            sectionName.RichText = true
            sectionName.TextColor3 = themeList.TextColor
            Objects[sectionName] = "TextColor3"
            sectionName.TextSize = 14.000
            sectionName.TextXAlignment = Enum.TextXAlignment.Left
            if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                Utility:TweenObject(sectionName, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
            end 
            if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                Utility:TweenObject(sectionName, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
            end 
               
            sectionInners.Name = "sectionInners"
            sectionInners.Parent = sectionFrame
            sectionInners.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectionInners.BackgroundTransparency = 1.000
            sectionInners.Position = UDim2.new(0, 0, 0.190751448, 0)

            sectionElListing.Name = "sectionElListing"
            sectionElListing.Parent = sectionInners
            sectionElListing.SortOrder = Enum.SortOrder.LayoutOrder
            sectionElListing.Padding = UDim.new(0, 3)

            
        coroutine.wrap(function()
            while wait() do
                sectionFrame.BackgroundColor3 = themeList.Background
                sectionHead.BackgroundColor3 = themeList.SchemeColor
                tabButton.TextColor3 = themeList.TextColor
                tabButton.BackgroundColor3 = themeList.SchemeColor
                sectionName.TextColor3 = themeList.TextColor
            end
        end)()

            local function updateSectionFrame()
                local innerSc = sectionElListing.AbsoluteContentSize
                sectionInners.Size = UDim2.new(1, 0, 0, innerSc.Y)
                local frameSc = sectionlistoknvm.AbsoluteContentSize
                sectionFrame.Size = UDim2.new(0, 352, 0, frameSc.Y)
            end
                updateSectionFrame()
                UpdateSize()
            local Elements = {}
            function Elements:NewButton(bname,tipINf, callback)
                showLogo = showLogo or true
                local ButtonFunction = {}
                tipINf = tipINf or "Tip: Clicking this nothing will happen!"
                bname = bname or "Click Me!"
                callback = callback or function() end

                local buttonElement = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local btnInfo = Instance.new("TextLabel")
                local viewInfo = Instance.new("ImageButton")
                local touch = Instance.new("ImageLabel")
                local Sample = Instance.new("ImageLabel")

                table.insert(modules, bname)

                buttonElement.Name = bname
                buttonElement.Parent = sectionInners
                buttonElement.BackgroundColor3 = themeList.ElementColor
                buttonElement.ClipsDescendants = true
                buttonElement.Size = UDim2.new(0, 352, 0, 33)
                buttonElement.AutoButtonColor = false
                buttonElement.Font = Enum.Font.SourceSans
                buttonElement.Text = ""
                buttonElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                buttonElement.TextSize = 14.000
                Objects[buttonElement] = "BackgroundColor3"

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = buttonElement

                viewInfo.Name = "viewInfo"
                viewInfo.Parent = buttonElement
                viewInfo.BackgroundTransparency = 1.000
                viewInfo.LayoutOrder = 9
                viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                viewInfo.Size = UDim2.new(0, 23, 0, 23)
                viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"
                viewInfo.ImageColor3 = themeList.SchemeColor
                Objects[viewInfo] = "ImageColor3"
                viewInfo.ImageRectOffset = Vector2.new(764, 764)
                viewInfo.ImageRectSize = Vector2.new(36, 36)

                Sample.Name = "Sample"
                Sample.Parent = buttonElement
                Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sample.BackgroundTransparency = 1.000
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = themeList.SchemeColor
                Objects[Sample] = "ImageColor3"
                Sample.ImageTransparency = 0.600

                local moreInfo = Instance.new("TextLabel")
                local UICorner = Instance.new("UICorner")

                moreInfo.Name = "TipMore"
                moreInfo.Parent = infoContainer
                moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                moreInfo.Position = UDim2.new(0, 0, 2, 0)
                moreInfo.Size = UDim2.new(0, 353, 0, 33)
                moreInfo.ZIndex = 9
                moreInfo.Font = Enum.Font.GothamSemibold
                moreInfo.Text = "  "..tipINf
                moreInfo.RichText = true
                moreInfo.TextColor3 = themeList.TextColor
                Objects[moreInfo] = "TextColor3"
                moreInfo.TextSize = 14.000
                moreInfo.TextXAlignment = Enum.TextXAlignment.Left
                Objects[moreInfo] = "BackgroundColor3"

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = moreInfo

                touch.Name = "touch"
                touch.Parent = buttonElement
                touch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                touch.BackgroundTransparency = 1.000
                touch.BorderColor3 = Color3.fromRGB(27, 42, 53)
                touch.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                touch.Size = UDim2.new(0, 21, 0, 21)
                touch.Image = "rbxassetid://3926305904"
                touch.ImageColor3 = themeList.SchemeColor
                Objects[touch] = "SchemeColor"
                touch.ImageRectOffset = Vector2.new(84, 204)
                touch.ImageRectSize = Vector2.new(36, 36)
                touch.ImageTransparency = 0

                btnInfo.Name = "btnInfo"
                btnInfo.Parent = buttonElement
                btnInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                btnInfo.BackgroundTransparency = 1.000
                btnInfo.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
                btnInfo.Size = UDim2.new(0, 314, 0, 14)
                btnInfo.Font = Enum.Font.GothamSemibold
                btnInfo.Text = bname
                btnInfo.RichText = true
                btnInfo.TextColor3 = themeList.TextColor
                Objects[btnInfo] = "TextColor3"
                btnInfo.TextSize = 14.000
                btnInfo.TextXAlignment = Enum.TextXAlignment.Left

                if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                end 
                if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                end 

                updateSectionFrame()
                                UpdateSize()

                local ms = game.Players.LocalPlayer:GetMouse()

                local btn = buttonElement
                local sample = Sample

                btn.MouseButton1Click:Connect(function()
                    if not focusing then
                        callback()
                        local c = sample:Clone()
                        c.Parent = btn
                        local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                        c.Position = UDim2.new(0, x, 0, y)
                        local len, size = 0.35, nil
                        if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                            size = (btn.AbsoluteSize.X * 1.5)
                        else
                            size = (btn.AbsoluteSize.Y * 1.5)
                        end
                        c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                        for i = 1, 10 do
                            c.ImageTransparency = c.ImageTransparency + 0.05
                            wait(len / 12)
                        end
                        c:Destroy()
                    else
                        for i,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    end
                end)
                local hovering = false
                btn.MouseEnter:Connect(function()
                    if not focusing then
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
                        }):Play()
                        hovering = true
                    end
                end)
                btn.MouseLeave:Connect(function()
                    if not focusing then 
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = themeList.ElementColor
                        }):Play()
                        hovering = false
                    end
                end)
                viewInfo.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for i,v in next, infoContainer:GetChildren() do
                            if v ~= moreInfo then
                                Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            end
                        end
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
                        Utility:TweenObject(btn, {BackgroundColor3 = themeList.ElementColor}, 0.2)
                        wait(1.5)
                        focusing = false
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                        wait(0)
                        viewDe = false
                    end
                end)
                coroutine.wrap(function()
                    while wait() do
                        if not hovering then
                            buttonElement.BackgroundColor3 = themeList.ElementColor
                        end
                        viewInfo.ImageColor3 = themeList.SchemeColor
                        Sample.ImageColor3 = themeList.SchemeColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                        moreInfo.TextColor3 = themeList.TextColor
                        touch.ImageColor3 = themeList.SchemeColor
                        btnInfo.TextColor3 = themeList.TextColor
                    end
                end)()
                
                function ButtonFunction:UpdateButton(newTitle)
                    btnInfo.Text = newTitle
                end
                return ButtonFunction
            end

            function Elements:NewTextBox(tname, tTip, callback)
                tname = tname or "Textbox"
                tTip = tTip or "Gets a value of Textbox"
                callback = callback or function() end
                local textboxElement = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local viewInfo = Instance.new("ImageButton")
                local write = Instance.new("ImageLabel")
                local TextBox = Instance.new("TextBox")
                local UICorner_2 = Instance.new("UICorner")
                local togName = Instance.new("TextLabel")

                textboxElement.Name = "textboxElement"
                textboxElement.Parent = sectionInners
                textboxElement.BackgroundColor3 = themeList.ElementColor
                textboxElement.ClipsDescendants = true
                textboxElement.Size = UDim2.new(0, 352, 0, 33)
                textboxElement.AutoButtonColor = false
                textboxElement.Font = Enum.Font.SourceSans
                textboxElement.Text = ""
                textboxElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                textboxElement.TextSize = 14.000

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = textboxElement

                viewInfo.Name = "viewInfo"
                viewInfo.Parent = textboxElement
                viewInfo.BackgroundTransparency = 1.000
                viewInfo.LayoutOrder = 9
                viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                viewInfo.Size = UDim2.new(0, 23, 0, 23)
                viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"
                viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764, 764)
                viewInfo.ImageRectSize = Vector2.new(36, 36)

                write.Name = "write"
                write.Parent = textboxElement
                write.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                write.BackgroundTransparency = 1.000
                write.BorderColor3 = Color3.fromRGB(27, 42, 53)
                write.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                write.Size = UDim2.new(0, 21, 0, 21)
                write.Image = "rbxassetid://3926305904"
                write.ImageColor3 = themeList.SchemeColor
                write.ImageRectOffset = Vector2.new(324, 604)
                write.ImageRectSize = Vector2.new(36, 36)

                TextBox.Parent = textboxElement
                TextBox.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 - 6, themeList.ElementColor.g * 255 - 6, themeList.ElementColor.b * 255 - 7)
                TextBox.BorderSizePixel = 0
                TextBox.ClipsDescendants = true
                TextBox.Position = UDim2.new(0.488749921, 0, 0.212121218, 0)
                TextBox.Size = UDim2.new(0, 150, 0, 18)
                TextBox.ZIndex = 99
                TextBox.ClearTextOnFocus = false
                TextBox.Font = Enum.Font.Gotham
                TextBox.PlaceholderColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 19, themeList.SchemeColor.g * 255 - 26, themeList.SchemeColor.b * 255 - 35)
                TextBox.PlaceholderText = "Type here!"
                TextBox.Text = ""
                TextBox.TextColor3 = themeList.SchemeColor
                TextBox.TextSize = 12.000

                UICorner_2.CornerRadius = UDim.new(0, 4)
                UICorner_2.Parent = TextBox

                togName.Name = "togName"
                togName.Parent = textboxElement
                togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                togName.BackgroundTransparency = 1.000
                togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
                togName.Size = UDim2.new(0, 138, 0, 14)
                togName.Font = Enum.Font.GothamSemibold
                togName.Text = tname
                togName.RichText = true
                togName.TextColor3 = themeList.TextColor
                togName.TextSize = 14.000
                togName.TextXAlignment = Enum.TextXAlignment.Left

                local moreInfo = Instance.new("TextLabel")
                local UICorner = Instance.new("UICorner")

                moreInfo.Name = "TipMore"
                moreInfo.Parent = infoContainer
                moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                moreInfo.Position = UDim2.new(0, 0, 2, 0)
                moreInfo.Size = UDim2.new(0, 353, 0, 33)
                moreInfo.ZIndex = 9
                moreInfo.Font = Enum.Font.GothamSemibold
                moreInfo.RichText = true
                moreInfo.Text = "  "..tTip
                moreInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
                moreInfo.TextSize = 14.000
                moreInfo.TextXAlignment = Enum.TextXAlignment.Left

                if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                end 
                if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                end 

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = moreInfo


                updateSectionFrame()
                                UpdateSize()
            
                local btn = textboxElement
                local infBtn = viewInfo

                btn.MouseButton1Click:Connect(function()
                    if focusing then
                        for i,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    end
                end)
                local hovering = false
                btn.MouseEnter:Connect(function()
                    if not focusing then
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
                        }):Play()
                        hovering = true
                    end 
                end)

                btn.MouseLeave:Connect(function()
                    if not focusing then
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = themeList.ElementColor
                        }):Play()
                        hovering = false
                    end
                end)

                TextBox.FocusLost:Connect(function(EnterPressed)
                    if focusing then
                        for i,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    end
                    if not EnterPressed then 
                        return
                    else
                        callback(TextBox.Text)
                        wait(0.18)
                        TextBox.Text = ""  
                    end
                end)

                viewInfo.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for i,v in next, infoContainer:GetChildren() do
                            if v ~= moreInfo then
                                Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            end
                        end
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
                        Utility:TweenObject(btn, {BackgroundColor3 = themeList.ElementColor}, 0.2)
                        wait(1.5)
                        focusing = false
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                        wait(0)
                        viewDe = false
                    end
                end)
                coroutine.wrap(function()
                    while wait() do
                        if not hovering then
                            textboxElement.BackgroundColor3 = themeList.ElementColor
                        end
                        TextBox.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 - 6, themeList.ElementColor.g * 255 - 6, themeList.ElementColor.b * 255 - 7)
                        viewInfo.ImageColor3 = themeList.SchemeColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                        moreInfo.TextColor3 = themeList.TextColor
                        write.ImageColor3 = themeList.SchemeColor
                        togName.TextColor3 = themeList.TextColor
                        TextBox.PlaceholderColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 19, themeList.SchemeColor.g * 255 - 26, themeList.SchemeColor.b * 255 - 35)
                        TextBox.TextColor3 = themeList.SchemeColor
                    end
                end)()
            end 

                function Elements:NewToggle(tname, nTip, callback)
                    local TogFunction = {}
                    tname = tname or "Toggle"
                    nTip = nTip or "Prints Current Toggle State"
                    callback = callback or function() end
                    local toggled = false
                    table.insert(SettingsT, tname)

                    local toggleElement = Instance.new("TextButton")
                    local UICorner = Instance.new("UICorner")
                    local toggleDisabled = Instance.new("ImageLabel")
                    local toggleEnabled = Instance.new("ImageLabel")
                    local togName = Instance.new("TextLabel")
                    local viewInfo = Instance.new("ImageButton")
                    local Sample = Instance.new("ImageLabel")

                    toggleElement.Name = "toggleElement"
                    toggleElement.Parent = sectionInners
                    toggleElement.BackgroundColor3 = themeList.ElementColor
                    toggleElement.ClipsDescendants = true
                    toggleElement.Size = UDim2.new(0, 352, 0, 33)
                    toggleElement.AutoButtonColor = false
                    toggleElement.Font = Enum.Font.SourceSans
                    toggleElement.Text = ""
                    toggleElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                    toggleElement.TextSize = 14.000

                    UICorner.CornerRadius = UDim.new(0, 4)
                    UICorner.Parent = toggleElement

                    toggleDisabled.Name = "toggleDisabled"
                    toggleDisabled.Parent = toggleElement
                    toggleDisabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    toggleDisabled.BackgroundTransparency = 1.000
                    toggleDisabled.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                    toggleDisabled.Size = UDim2.new(0, 21, 0, 21)
                    toggleDisabled.Image = "rbxassetid://3926309567"
                    toggleDisabled.ImageColor3 = themeList.SchemeColor
                    toggleDisabled.ImageRectOffset = Vector2.new(628, 420)
                    toggleDisabled.ImageRectSize = Vector2.new(48, 48)

                    toggleEnabled.Name = "toggleEnabled"
                    toggleEnabled.Parent = toggleElement
                    toggleEnabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    toggleEnabled.BackgroundTransparency = 1.000
                    toggleEnabled.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                    toggleEnabled.Size = UDim2.new(0, 21, 0, 21)
                    toggleEnabled.Image = "rbxassetid://3926309567"
                    toggleEnabled.ImageColor3 = themeList.SchemeColor
                    toggleEnabled.ImageRectOffset = Vector2.new(784, 420)
                    toggleEnabled.ImageRectSize = Vector2.new(48, 48)
                    toggleEnabled.ImageTransparency = 1.000

                    togName.Name = "togName"
                    togName.Parent = toggleElement
                    togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    togName.BackgroundTransparency = 1.000
                    togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
                    togName.Size = UDim2.new(0, 288, 0, 14)
                    togName.Font = Enum.Font.GothamSemibold
                    togName.Text = tname
                    togName.RichText = true
                    togName.TextColor3 = themeList.TextColor
                    togName.TextSize = 14.000
                    togName.TextXAlignment = Enum.TextXAlignment.Left

                    viewInfo.Name = "viewInfo"
                    viewInfo.Parent = toggleElement
                    viewInfo.BackgroundTransparency = 1.000
                    viewInfo.LayoutOrder = 9
                    viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                    viewInfo.Size = UDim2.new(0, 23, 0, 23)
                    viewInfo.ZIndex = 2
                    viewInfo.Image = "rbxassetid://3926305904"
                    viewInfo.ImageColor3 = themeList.SchemeColor
                    viewInfo.ImageRectOffset = Vector2.new(764, 764)
                    viewInfo.ImageRectSize = Vector2.new(36, 36)

                    Sample.Name = "Sample"
                    Sample.Parent = toggleElement
                    Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Sample.BackgroundTransparency = 1.000
                    Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                    Sample.ImageColor3 = themeList.SchemeColor
                    Sample.ImageTransparency = 0.600

                    local moreInfo = Instance.new("TextLabel")
                    local UICorner = Instance.new("UICorner")
    
                    moreInfo.Name = "TipMore"
                    moreInfo.Parent = infoContainer
                    moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                    moreInfo.Position = UDim2.new(0, 0, 2, 0)
                    moreInfo.Size = UDim2.new(0, 353, 0, 33)
                    moreInfo.ZIndex = 9
                    moreInfo.Font = Enum.Font.GothamSemibold
                    moreInfo.RichText = true
                    moreInfo.Text = "  "..nTip
                    moreInfo.TextColor3 = themeList.TextColor
                    moreInfo.TextSize = 14.000
                    moreInfo.TextXAlignment = Enum.TextXAlignment.Left
    
                    UICorner.CornerRadius = UDim.new(0, 4)
                    UICorner.Parent = moreInfo

                    local ms = game.Players.LocalPlayer:GetMouse()

                    if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                        Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                    end 
                    if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                        Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                    end 

                    local btn = toggleElement
                    local sample = Sample
                    local img = toggleEnabled
                    local infBtn = viewInfo

                                    updateSectionFrame()
                UpdateSize()

                    btn.MouseButton1Click:Connect(function()
                        if not focusing then
                            if toggled == false then
                                game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                                    ImageTransparency = 0
                                }):Play()
                                local c = sample:Clone()
                                c.Parent = btn
                                local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                                c.Position = UDim2.new(0, x, 0, y)
                                local len, size = 0.35, nil
                                if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                                    size = (btn.AbsoluteSize.X * 1.5)
                                else
                                    size = (btn.AbsoluteSize.Y * 1.5)
                                end
                                c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                                for i = 1, 10 do
                                    c.ImageTransparency = c.ImageTransparency + 0.05
                                    wait(len / 12)
                                end
                                c:Destroy()
                            else
                                game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                                    ImageTransparency = 1
                                }):Play()
                                local c = sample:Clone()
                                c.Parent = btn
                                local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                                c.Position = UDim2.new(0, x, 0, y)
                                local len, size = 0.35, nil
                                if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                                    size = (btn.AbsoluteSize.X * 1.5)
                                else
                                    size = (btn.AbsoluteSize.Y * 1.5)
                                end
                                c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                                for i = 1, 10 do
                                    c.ImageTransparency = c.ImageTransparency + 0.05
                                    wait(len / 12)
                                end
                                c:Destroy()
                            end
                            toggled = not toggled
                            pcall(callback, toggled)
                        else
                            for i,v in next, infoContainer:GetChildren() do
                                Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                                focusing = false
                            end
                            Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                        end
                    end)
                    local hovering = false
                    btn.MouseEnter:Connect(function()
                        if not focusing then
                            game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
                            }):Play()
                            hovering = true
                        end 
                    end)
                    btn.MouseLeave:Connect(function()
                        if not focusing then
                            game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                BackgroundColor3 = themeList.ElementColor
                            }):Play()
                            hovering = false
                        end
                    end)

                    coroutine.wrap(function()
                        while wait() do
                            if not hovering then
                                toggleElement.BackgroundColor3 = themeList.ElementColor
                            end
                            toggleDisabled.ImageColor3 = themeList.SchemeColor
                            toggleEnabled.ImageColor3 = themeList.SchemeColor
                            togName.TextColor3 = themeList.TextColor
                            viewInfo.ImageColor3 = themeList.SchemeColor
                            Sample.ImageColor3 = themeList.SchemeColor
                            moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                            moreInfo.TextColor3 = themeList.TextColor
                        end
                    end)()
                    viewInfo.MouseButton1Click:Connect(function()
                        if not viewDe then
                            viewDe = true
                            focusing = true
                            for i,v in next, infoContainer:GetChildren() do
                                if v ~= moreInfo then
                                    Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                                end
                            end
                            Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
                            Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
                            Utility:TweenObject(btn, {BackgroundColor3 = themeList.ElementColor}, 0.2)
                            wait(1.5)
                            focusing = false
                            Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                            wait(0)
                            viewDe = false
                        end
                    end)
                    function TogFunction:UpdateToggle(newText, isTogOn)
                        isTogOn = isTogOn or toggle
                        if newText ~= nil then 
                            togName.Text = newText
                        end
                        if isTogOn then
                            toggled = true
                            game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                                ImageTransparency = 0
                            }):Play()
                            pcall(callback, toggled)
                        else
                            toggled = false
                            game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                                ImageTransparency = 1
                            }):Play()
                            pcall(callback, toggled)
                        end
                    end
                    return TogFunction
            end

            function Elements:NewSlider(slidInf, slidTip, maxvalue, minvalue, callback)
                slidInf = slidInf or "Slider"
                slidTip = slidTip or "Slider tip here"
                maxvalue = maxvalue or 500
                minvalue = minvalue or 16
                startVal = startVal or 0
                callback = callback or function() end

                local sliderElement = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local togName = Instance.new("TextLabel")
                local viewInfo = Instance.new("ImageButton")
                local sliderBtn = Instance.new("TextButton")
                local UICorner_2 = Instance.new("UICorner")
                local UIListLayout = Instance.new("UIListLayout")
                local sliderDrag = Instance.new("Frame")
                local UICorner_3 = Instance.new("UICorner")
                local write = Instance.new("ImageLabel")
                local val = Instance.new("TextLabel")

                sliderElement.Name = "sliderElement"
                sliderElement.Parent = sectionInners
                sliderElement.BackgroundColor3 = themeList.ElementColor
                sliderElement.ClipsDescendants = true
                sliderElement.Size = UDim2.new(0, 352, 0, 33)
                sliderElement.AutoButtonColor = false
                sliderElement.Font = Enum.Font.SourceSans
                sliderElement.Text = ""
                sliderElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                sliderElement.TextSize = 14.000

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = sliderElement

                togName.Name = "togName"
                togName.Parent = sliderElement
                togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                togName.BackgroundTransparency = 1.000
                togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
                togName.Size = UDim2.new(0, 138, 0, 14)
                togName.Font = Enum.Font.GothamSemibold
                togName.Text = slidInf
                togName.RichText = true
                togName.TextColor3 = themeList.TextColor
                togName.TextSize = 14.000
                togName.TextXAlignment = Enum.TextXAlignment.Left

                viewInfo.Name = "viewInfo"
                viewInfo.Parent = sliderElement
                viewInfo.BackgroundTransparency = 1.000
                viewInfo.LayoutOrder = 9
                viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                viewInfo.Size = UDim2.new(0, 23, 0, 23)
                viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"
                viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764, 764)
                viewInfo.ImageRectSize = Vector2.new(36, 36)

                sliderBtn.Name = "sliderBtn"
                sliderBtn.Parent = sliderElement
                sliderBtn.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 5, themeList.ElementColor.g * 255 + 5, themeList.ElementColor.b * 255  + 5)
                sliderBtn.BorderSizePixel = 0
                sliderBtn.Position = UDim2.new(0.488749951, 0, 0.393939406, 0)
                sliderBtn.Size = UDim2.new(0, 149, 0, 6)
                sliderBtn.AutoButtonColor = false
                sliderBtn.Font = Enum.Font.SourceSans
                sliderBtn.Text = ""
                sliderBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                sliderBtn.TextSize = 14.000

                UICorner_2.Parent = sliderBtn

                UIListLayout.Parent = sliderBtn
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

                sliderDrag.Name = "sliderDrag"
                sliderDrag.Parent = sliderBtn
                sliderDrag.BackgroundColor3 = themeList.SchemeColor
                sliderDrag.BorderColor3 = Color3.fromRGB(74, 99, 135)
                sliderDrag.BorderSizePixel = 0
                sliderDrag.Size = UDim2.new(-0.671140969, 100,1,0)

                UICorner_3.Parent = sliderDrag

                write.Name = "write"
                write.Parent = sliderElement
                write.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                write.BackgroundTransparency = 1.000
                write.BorderColor3 = Color3.fromRGB(27, 42, 53)
                write.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                write.Size = UDim2.new(0, 21, 0, 21)
                write.Image = "rbxassetid://3926307971"
                write.ImageColor3 = themeList.SchemeColor
                write.ImageRectOffset = Vector2.new(404, 164)
                write.ImageRectSize = Vector2.new(36, 36)

                val.Name = "val"
                val.Parent = sliderElement
                val.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                val.BackgroundTransparency = 1.000
                val.Position = UDim2.new(0.352386296, 0, 0.272727281, 0)
                val.Size = UDim2.new(0, 41, 0, 14)
                val.Font = Enum.Font.GothamSemibold
                val.Text = minvalue
                val.TextColor3 = themeList.TextColor
                val.TextSize = 14.000
                val.TextTransparency = 1.000
                val.TextXAlignment = Enum.TextXAlignment.Right

                local moreInfo = Instance.new("TextLabel")
                local UICorner = Instance.new("UICorner")

                moreInfo.Name = "TipMore"
                moreInfo.Parent = infoContainer
                moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                moreInfo.Position = UDim2.new(0, 0, 2, 0)
                moreInfo.Size = UDim2.new(0, 353, 0, 33)
                moreInfo.ZIndex = 9
                moreInfo.Font = Enum.Font.GothamSemibold
                moreInfo.Text = "  "..slidTip
                moreInfo.TextColor3 = themeList.TextColor
                moreInfo.TextSize = 14.000
                moreInfo.RichText = true
                moreInfo.TextXAlignment = Enum.TextXAlignment.Left

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = moreInfo

                if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                end 
                if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                end 


                                updateSectionFrame()
                UpdateSize()
                local mouse = game:GetService("Players").LocalPlayer:GetMouse();

                local ms = game.Players.LocalPlayer:GetMouse()
                local uis = game:GetService("UserInputService")
                local btn = sliderElement
                local infBtn = viewInfo
                local hovering = false
                btn.MouseEnter:Connect(function()
                    if not focusing then
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
                        }):Play()
                        hovering = true
                    end 
                end)
                btn.MouseLeave:Connect(function()
                    if not focusing then
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = themeList.ElementColor
                        }):Play()
                        hovering = false
                    end
                end)        

                coroutine.wrap(function()
                    while wait() do
                        if not hovering then
                            sliderElement.BackgroundColor3 = themeList.ElementColor
                        end
                        moreInfo.TextColor3 = themeList.TextColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                        val.TextColor3 = themeList.TextColor
                        write.ImageColor3 = themeList.SchemeColor
                        togName.TextColor3 = themeList.TextColor
                        viewInfo.ImageColor3 = themeList.SchemeColor
                        sliderBtn.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 5, themeList.ElementColor.g * 255 + 5, themeList.ElementColor.b * 255  + 5)
                        sliderDrag.BackgroundColor3 = themeList.SchemeColor
                    end
                end)()

                local Value
                sliderBtn.MouseButton1Down:Connect(function()
                    if not focusing then
                        game.TweenService:Create(val, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            TextTransparency = 0
                        }):Play()
                        Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 149) * sliderDrag.AbsoluteSize.X) + tonumber(minvalue)) or 0
                        pcall(function()
                            callback(Value)
                        end)
                        sliderDrag:TweenSize(UDim2.new(0, math.clamp(mouse.X - sliderDrag.AbsolutePosition.X, 0, 149), 0, 6), "InOut", "Linear", 0.05, true)
                        moveconnection = mouse.Move:Connect(function()
                            val.Text = Value
                            Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 149) * sliderDrag.AbsoluteSize.X) + tonumber(minvalue))
                            pcall(function()
                                callback(Value)
                            end)
                            sliderDrag:TweenSize(UDim2.new(0, math.clamp(mouse.X - sliderDrag.AbsolutePosition.X, 0, 149), 0, 6), "InOut", "Linear", 0.05, true)
                        end)
                        releaseconnection = uis.InputEnded:Connect(function(Mouse)
                            if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                                Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 149) * sliderDrag.AbsoluteSize.X) + tonumber(minvalue))
                                pcall(function()
                                    callback(Value)
                                end)
                                val.Text = Value
                                game.TweenService:Create(val, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                    TextTransparency = 1
                                }):Play()
                                sliderDrag:TweenSize(UDim2.new(0, math.clamp(mouse.X - sliderDrag.AbsolutePosition.X, 0, 149), 0, 6), "InOut", "Linear", 0.05, true)
                                moveconnection:Disconnect()
                                releaseconnection:Disconnect()
                            end
                        end)
                    else
                        for i,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    end
                end)
                viewInfo.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for i,v in next, infoContainer:GetChildren() do
                            if v ~= moreInfo then
                                Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            end
                        end
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
                        Utility:TweenObject(btn, {BackgroundColor3 = themeList.ElementColor}, 0.2)
                        wait(1.5)
                        focusing = false
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                        wait(0)
                        viewDe = false
                    end
                end)        
            end

            function Elements:NewDropdown(dropname, dropinf, list, callback)
                local DropFunction = {}
                dropname = dropname or "Dropdown"
                list = list or {}
                dropinf = dropinf or "Dropdown info"
                callback = callback or function() end   

                local opened = false
                local DropYSize = 33


                local dropFrame = Instance.new("Frame")
                local dropOpen = Instance.new("TextButton")
                local listImg = Instance.new("ImageLabel")
                local itemTextbox = Instance.new("TextLabel")
                local viewInfo = Instance.new("ImageButton")
                local UICorner = Instance.new("UICorner")
                local UIListLayout = Instance.new("UIListLayout")
                local Sample = Instance.new("ImageLabel")

                local ms = game.Players.LocalPlayer:GetMouse()
                Sample.Name = "Sample"
                Sample.Parent = dropOpen
                Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sample.BackgroundTransparency = 1.000
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = themeList.SchemeColor
                Sample.ImageTransparency = 0.600
                
                dropFrame.Name = "dropFrame"
                dropFrame.Parent = sectionInners
                dropFrame.BackgroundColor3 = themeList.Background
                dropFrame.BorderSizePixel = 0
                dropFrame.Position = UDim2.new(0, 0, 1.23571432, 0)
                dropFrame.Size = UDim2.new(0, 352, 0, 33)
                dropFrame.ClipsDescendants = true
                local sample = Sample
                local btn = dropOpen
                dropOpen.Name = "dropOpen"
                dropOpen.Parent = dropFrame
                dropOpen.BackgroundColor3 = themeList.ElementColor
                dropOpen.Size = UDim2.new(0, 352, 0, 33)
                dropOpen.AutoButtonColor = false
                dropOpen.Font = Enum.Font.SourceSans
                dropOpen.Text = ""
                dropOpen.TextColor3 = Color3.fromRGB(0, 0, 0)
                dropOpen.TextSize = 14.000
                dropOpen.ClipsDescendants = true
                dropOpen.MouseButton1Click:Connect(function()
                    if not focusing then
                        if opened then
                            opened = false
                            dropFrame:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
                            wait(0.1)
                            updateSectionFrame()
                            UpdateSize()
                            local c = sample:Clone()
                            c.Parent = btn
                            local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                            c.Position = UDim2.new(0, x, 0, y)
                            local len, size = 0.35, nil
                            if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                                size = (btn.AbsoluteSize.X * 1.5)
                            else
                                size = (btn.AbsoluteSize.Y * 1.5)
                            end
                            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                            for i = 1, 10 do
                                c.ImageTransparency = c.ImageTransparency + 0.05
                                wait(len / 12)
                            end
                            c:Destroy()
                        else
                            opened = true
                            dropFrame:TweenSize(UDim2.new(0, 352, 0, UIListLayout.AbsoluteContentSize.Y), "InOut", "Linear", 0.08, true)
                            wait(0.1)
                            updateSectionFrame()
                            UpdateSize()
                            local c = sample:Clone()
                            c.Parent = btn
                            local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                            c.Position = UDim2.new(0, x, 0, y)
                            local len, size = 0.35, nil
                            if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                                size = (btn.AbsoluteSize.X * 1.5)
                            else
                                size = (btn.AbsoluteSize.Y * 1.5)
                            end
                            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                            for i = 1, 10 do
                                c.ImageTransparency = c.ImageTransparency + 0.05
                                wait(len / 12)
                            end
                            c:Destroy()
                        end
                    else
                        for i,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    end
                end)

                listImg.Name = "listImg"
                listImg.Parent = dropOpen
                listImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                listImg.BackgroundTransparency = 1.000
                listImg.BorderColor3 = Color3.fromRGB(27, 42, 53)
                listImg.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                listImg.Size = UDim2.new(0, 21, 0, 21)
                listImg.Image = "rbxassetid://3926305904"
                listImg.ImageColor3 = themeList.SchemeColor
                listImg.ImageRectOffset = Vector2.new(644, 364)
                listImg.ImageRectSize = Vector2.new(36, 36)

                itemTextbox.Name = "itemTextbox"
                itemTextbox.Parent = dropOpen
                itemTextbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                itemTextbox.BackgroundTransparency = 1.000
                itemTextbox.Position = UDim2.new(0.0970000029, 0, 0.273000002, 0)
                itemTextbox.Size = UDim2.new(0, 138, 0, 14)
                itemTextbox.Font = Enum.Font.GothamSemibold
                itemTextbox.Text = dropname
                itemTextbox.RichText = true
                itemTextbox.TextColor3 = themeList.TextColor
                itemTextbox.TextSize = 14.000
                itemTextbox.TextXAlignment = Enum.TextXAlignment.Left

                viewInfo.Name = "viewInfo"
                viewInfo.Parent = dropOpen
                viewInfo.BackgroundTransparency = 1.000
                viewInfo.LayoutOrder = 9
                viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                viewInfo.Size = UDim2.new(0, 23, 0, 23)
                viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"
                viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764, 764)
                viewInfo.ImageRectSize = Vector2.new(36, 36)

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = dropOpen

                local Sample = Instance.new("ImageLabel")

                Sample.Name = "Sample"
                Sample.Parent = dropOpen
                Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sample.BackgroundTransparency = 1.000
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = themeList.SchemeColor
                Sample.ImageTransparency = 0.600

                UIListLayout.Parent = dropFrame
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Padding = UDim.new(0, 3)

                updateSectionFrame() 
                UpdateSize()

                local ms = game.Players.LocalPlayer:GetMouse()
                local uis = game:GetService("UserInputService")
                local infBtn = viewInfo

                local moreInfo = Instance.new("TextLabel")
                local UICorner = Instance.new("UICorner")

                moreInfo.Name = "TipMore"
                moreInfo.Parent = infoContainer
                moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                moreInfo.Position = UDim2.new(0, 0, 2, 0)
                moreInfo.Size = UDim2.new(0, 353, 0, 33)
                moreInfo.ZIndex = 9
                moreInfo.RichText = true
                moreInfo.Font = Enum.Font.GothamSemibold
                moreInfo.Text = "  "..dropinf
                moreInfo.TextColor3 = themeList.TextColor
                moreInfo.TextSize = 14.000
                moreInfo.TextXAlignment = Enum.TextXAlignment.Left

                local hovering = false
                btn.MouseEnter:Connect(function()
                    if not focusing then
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
                        }):Play()
                        hovering = true
                    end 
                end)
                btn.MouseLeave:Connect(function()
                    if not focusing then
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = themeList.ElementColor
                        }):Play()
                        hovering = false
                    end
                end)        
                coroutine.wrap(function()
                    while wait() do
                        if not hovering then
                            dropOpen.BackgroundColor3 = themeList.ElementColor
                        end
                        Sample.ImageColor3 = themeList.SchemeColor
                        dropFrame.BackgroundColor3 = themeList.Background
                        listImg.ImageColor3 = themeList.SchemeColor
                        itemTextbox.TextColor3 = themeList.TextColor
                        viewInfo.ImageColor3 = themeList.SchemeColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                        moreInfo.TextColor3 = themeList.TextColor
                    end
                end)()
                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = moreInfo

                if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                end 
                if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                end 

                viewInfo.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for i,v in next, infoContainer:GetChildren() do
                            if v ~= moreInfo then
                                Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            end
                        end
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
                        Utility:TweenObject(btn, {BackgroundColor3 = themeList.ElementColor}, 0.2)
                        wait(1.5)
                        focusing = false
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                        wait(0)
                        viewDe = false
                    end
                end)     

                for i,v in next, list do
                    local optionSelect = Instance.new("TextButton")
                    local UICorner_2 = Instance.new("UICorner")
                    local Sample1 = Instance.new("ImageLabel")

                    local ms = game.Players.LocalPlayer:GetMouse()
                    Sample1.Name = "Sample1"
                    Sample1.Parent = optionSelect
                    Sample1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Sample1.BackgroundTransparency = 1.000
                    Sample1.Image = "http://www.roblox.com/asset/?id=4560909609"
                    Sample1.ImageColor3 = themeList.SchemeColor
                    Sample1.ImageTransparency = 0.600

                    local sample1 = Sample1
                    DropYSize = DropYSize + 33
                    optionSelect.Name = "optionSelect"
                    optionSelect.Parent = dropFrame
                    optionSelect.BackgroundColor3 = themeList.ElementColor
                    optionSelect.Position = UDim2.new(0, 0, 0.235294119, 0)
                    optionSelect.Size = UDim2.new(0, 352, 0, 33)
                    optionSelect.AutoButtonColor = false
                    optionSelect.Font = Enum.Font.GothamSemibold
                    optionSelect.Text = "  "..v
                    optionSelect.TextColor3 = Color3.fromRGB(themeList.TextColor.r * 255 - 6, themeList.TextColor.g * 255 - 6, themeList.TextColor.b * 255 - 6)
                    optionSelect.TextSize = 14.000
                    optionSelect.TextXAlignment = Enum.TextXAlignment.Left
                    optionSelect.ClipsDescendants = true
                    optionSelect.MouseButton1Click:Connect(function()
                        if not focusing then
                            opened = false
                            callback(v)
                            itemTextbox.Text = v
                            dropFrame:TweenSize(UDim2.new(0, 352, 0, 33), 'InOut', 'Linear', 0.08)
                            wait(0.1)
                            updateSectionFrame()
                            UpdateSize()
                            local c = sample1:Clone()
                            c.Parent = optionSelect
                            local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                            c.Position = UDim2.new(0, x, 0, y)
                            local len, size = 0.35, nil
                            if optionSelect.AbsoluteSize.X >= optionSelect.AbsoluteSize.Y then
                                size = (optionSelect.AbsoluteSize.X * 1.5)
                            else
                                size = (optionSelect.AbsoluteSize.Y * 1.5)
                            end
                            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                            for i = 1, 10 do
                                c.ImageTransparency = c.ImageTransparency + 0.05
                                wait(len / 12)
                            end
                            c:Destroy()         
                        else
                            for i,v in next, infoContainer:GetChildren() do
                                Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                                focusing = false
                            end
                            Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                        end
                    end)
    
                    UICorner_2.CornerRadius = UDim.new(0, 4)
                    UICorner_2.Parent = optionSelect

                    local oHover = false
                    optionSelect.MouseEnter:Connect(function()
                        if not focusing then
                            game.TweenService:Create(optionSelect, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
                            }):Play()
                            oHover = true
                        end 
                    end)
                    optionSelect.MouseLeave:Connect(function()
                        if not focusing then
                            game.TweenService:Create(optionSelect, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                BackgroundColor3 = themeList.ElementColor
                            }):Play()
                            oHover = false
                        end
                    end)   
                    coroutine.wrap(function()
                        while wait() do
                            if not oHover then
                                optionSelect.BackgroundColor3 = themeList.ElementColor
                            end
                            optionSelect.TextColor3 = Color3.fromRGB(themeList.TextColor.r * 255 - 6, themeList.TextColor.g * 255 - 6, themeList.TextColor.b * 255 - 6)
                            Sample1.ImageColor3 = themeList.SchemeColor
                        end
                    end)()
                end

                function DropFunction:Refresh(newList)
                    newList = newList or {}
                    for i,v in next, dropFrame:GetChildren() do
                        if v.Name == "optionSelect" then
                            v:Destroy()
                        end
                    end
                    for i,v in next, newList do
                        local optionSelect = Instance.new("TextButton")
                        local UICorner_2 = Instance.new("UICorner")
                        local Sample11 = Instance.new("ImageLabel")
                        local ms = game.Players.LocalPlayer:GetMouse()
                        Sample11.Name = "Sample11"
                        Sample11.Parent = optionSelect
                        Sample11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        Sample11.BackgroundTransparency = 1.000
                        Sample11.Image = "http://www.roblox.com/asset/?id=4560909609"
                        Sample11.ImageColor3 = themeList.SchemeColor
                        Sample11.ImageTransparency = 0.600
    
                        local sample11 = Sample11
                        DropYSize = DropYSize + 33
                        optionSelect.Name = "optionSelect"
                        optionSelect.Parent = dropFrame
                        optionSelect.BackgroundColor3 = themeList.ElementColor
                        optionSelect.Position = UDim2.new(0, 0, 0.235294119, 0)
                        optionSelect.Size = UDim2.new(0, 352, 0, 33)
                        optionSelect.AutoButtonColor = false
                        optionSelect.Font = Enum.Font.GothamSemibold
                        optionSelect.Text = "  "..v
                        optionSelect.TextColor3 = Color3.fromRGB(themeList.TextColor.r * 255 - 6, themeList.TextColor.g * 255 - 6, themeList.TextColor.b * 255 - 6)
                        optionSelect.TextSize = 14.000
                        optionSelect.TextXAlignment = Enum.TextXAlignment.Left
                        optionSelect.ClipsDescendants = true
                        UICorner_2.CornerRadius = UDim.new(0, 4)
                        UICorner_2.Parent = optionSelect
                        optionSelect.MouseButton1Click:Connect(function()
                            if not focusing then
                                opened = false
                                callback(v)
                                itemTextbox.Text = v
                                dropFrame:TweenSize(UDim2.new(0, 352, 0, 33), 'InOut', 'Linear', 0.08)
                                wait(0.1)
                                updateSectionFrame()
                                UpdateSize()
                                local c = sample11:Clone()
                                c.Parent = optionSelect
                                local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                                c.Position = UDim2.new(0, x, 0, y)
                                local len, size = 0.35, nil
                                if optionSelect.AbsoluteSize.X >= optionSelect.AbsoluteSize.Y then
                                    size = (optionSelect.AbsoluteSize.X * 1.5)
                                else
                                    size = (optionSelect.AbsoluteSize.Y * 1.5)
                                end
                                c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                                for i = 1, 10 do
                                    c.ImageTransparency = c.ImageTransparency + 0.05
                                    wait(len / 12)
                                end
                                c:Destroy()         
                            else
                                for i,v in next, infoContainer:GetChildren() do
                                    Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                                    focusing = false
                                end
                                Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                            end
                        end)
                                        updateSectionFrame()
                UpdateSize()
                        local hov = false
                        optionSelect.MouseEnter:Connect(function()
                            if not focusing then
                                game.TweenService:Create(optionSelect, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                    BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
                                }):Play()
                                hov = true
                            end 
                        end)
                        optionSelect.MouseLeave:Connect(function()
                            if not focusing then
                                game.TweenService:Create(optionSelect, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                    BackgroundColor3 = themeList.ElementColor
                                }):Play()
                                hov = false
                            end
                        end)   
                        coroutine.wrap(function()
                            while wait() do
                                if not oHover then
                                    optionSelect.BackgroundColor3 = themeList.ElementColor
                                end
                                optionSelect.TextColor3 = Color3.fromRGB(themeList.TextColor.r * 255 - 6, themeList.TextColor.g * 255 - 6, themeList.TextColor.b * 255 - 6)
                                Sample11.ImageColor3 = themeList.SchemeColor
                            end
                        end)()
                    end
                    if opened then 
                        dropFrame:TweenSize(UDim2.new(0, 352, 0, UIListLayout.AbsoluteContentSize.Y), "InOut", "Linear", 0.08, true)
                        wait(0.1)
                        updateSectionFrame()
                        UpdateSize()
                    else
                        dropFrame:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
                        wait(0.1)
                        updateSectionFrame()
                        UpdateSize()
                    end
                end
                return DropFunction
            end
            function Elements:NewKeybind(keytext, keyinf, first, callback)
                keytext = keytext or "KeybindText"
                keyinf = keyinf or "KebindInfo"
                callback = callback or function() end
                local oldKey = first.Name
                local keybindElement = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local togName = Instance.new("TextLabel")
                local viewInfo = Instance.new("ImageButton")
                local touch = Instance.new("ImageLabel")
                local Sample = Instance.new("ImageLabel")
                local togName_2 = Instance.new("TextLabel")

                local ms = game.Players.LocalPlayer:GetMouse()
                local uis = game:GetService("UserInputService")
                local infBtn = viewInfo

                local moreInfo = Instance.new("TextLabel")
                local UICorner1 = Instance.new("UICorner")

                local sample = Sample

                keybindElement.Name = "keybindElement"
                keybindElement.Parent = sectionInners
                keybindElement.BackgroundColor3 = themeList.ElementColor
                keybindElement.ClipsDescendants = true
                keybindElement.Size = UDim2.new(0, 352, 0, 33)
                keybindElement.AutoButtonColor = false
                keybindElement.Font = Enum.Font.SourceSans
                keybindElement.Text = ""
                keybindElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                keybindElement.TextSize = 14.000
                keybindElement.MouseButton1Click:connect(function(e) 
                    if not focusing then
                        togName_2.Text = ". . ."
                        local a, b = game:GetService('UserInputService').InputBegan:wait();
                        if a.KeyCode.Name ~= "Unknown" then
                            togName_2.Text = a.KeyCode.Name
                            oldKey = a.KeyCode.Name;
                        end
                        local c = sample:Clone()
                        c.Parent = keybindElement
                        local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                        c.Position = UDim2.new(0, x, 0, y)
                        local len, size = 0.35, nil
                        if keybindElement.AbsoluteSize.X >= keybindElement.AbsoluteSize.Y then
                            size = (keybindElement.AbsoluteSize.X * 1.5)
                        else
                            size = (keybindElement.AbsoluteSize.Y * 1.5)
                        end
                        c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                        for i = 1, 10 do
                        c.ImageTransparency = c.ImageTransparency + 0.05
                            wait(len / 12)
                        end
                    else
                        for i,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    end
                end)
        
                game:GetService("UserInputService").InputBegan:connect(function(current, ok) 
                    if not ok then 
                        if current.KeyCode.Name == oldKey then 
                            callback()
                        end
                    end
                end)

                moreInfo.Name = "TipMore"
                moreInfo.Parent = infoContainer
                moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                moreInfo.Position = UDim2.new(0, 0, 2, 0)
                moreInfo.Size = UDim2.new(0, 353, 0, 33)
                moreInfo.ZIndex = 9
                moreInfo.RichText = true
                moreInfo.Font = Enum.Font.GothamSemibold
                moreInfo.Text = "  "..keyinf
                moreInfo.TextColor3 = themeList.TextColor
                moreInfo.TextSize = 14.000
                moreInfo.TextXAlignment = Enum.TextXAlignment.Left

                Sample.Name = "Sample"
                Sample.Parent = keybindElement
                Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sample.BackgroundTransparency = 1.000
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = themeList.SchemeColor
                Sample.ImageTransparency = 0.600

                
                togName.Name = "togName"
                togName.Parent = keybindElement
                togName.BackgroundColor3 = themeList.TextColor
                togName.BackgroundTransparency = 1.000
                togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
                togName.Size = UDim2.new(0, 222, 0, 14)
                togName.Font = Enum.Font.GothamSemibold
                togName.Text = keytext
                togName.RichText = true
                togName.TextColor3 = themeList.TextColor
                togName.TextSize = 14.000
                togName.TextXAlignment = Enum.TextXAlignment.Left

                viewInfo.Name = "viewInfo"
                viewInfo.Parent = keybindElement
                viewInfo.BackgroundTransparency = 1.000
                viewInfo.LayoutOrder = 9
                viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                viewInfo.Size = UDim2.new(0, 23, 0, 23)
                viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"
                viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764, 764)
                viewInfo.ImageRectSize = Vector2.new(36, 36)
                viewInfo.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for i,v in next, infoContainer:GetChildren() do
                            if v ~= moreInfo then
                                Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            end
                        end
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
                        Utility:TweenObject(keybindElement, {BackgroundColor3 = themeList.ElementColor}, 0.2)
                        wait(1.5)
                        focusing = false
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                        wait(0)
                        viewDe = false
                    end
                end)  
                                updateSectionFrame()
                UpdateSize()
                local oHover = false
                keybindElement.MouseEnter:Connect(function()
                    if not focusing then
                        game.TweenService:Create(keybindElement, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
                        }):Play()
                        oHover = true
                    end 
                end)
                keybindElement.MouseLeave:Connect(function()
                    if not focusing then
                        game.TweenService:Create(keybindElement, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = themeList.ElementColor
                        }):Play()
                        oHover = false
                    end
                end)        

                UICorner1.CornerRadius = UDim.new(0, 4)
                UICorner1.Parent = moreInfo

                if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                end 
                if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                end 

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = keybindElement

                touch.Name = "touch"
                touch.Parent = keybindElement
                touch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                touch.BackgroundTransparency = 1.000
                touch.BorderColor3 = Color3.fromRGB(27, 42, 53)
                touch.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                touch.Size = UDim2.new(0, 21, 0, 21)
                touch.Image = "rbxassetid://3926305904"
                touch.ImageColor3 = themeList.SchemeColor
                touch.ImageRectOffset = Vector2.new(364, 284)
                touch.ImageRectSize = Vector2.new(36, 36)

                togName_2.Name = "togName"
                togName_2.Parent = keybindElement
                togName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                togName_2.BackgroundTransparency = 1.000
                togName_2.Position = UDim2.new(0.727386296, 0, 0.272727281, 0)
                togName_2.Size = UDim2.new(0, 70, 0, 14)
                togName_2.Font = Enum.Font.GothamSemibold
                togName_2.Text = oldKey
                togName_2.TextColor3 = themeList.SchemeColor
                togName_2.TextSize = 14.000
                togName_2.TextXAlignment = Enum.TextXAlignment.Right   

                coroutine.wrap(function()
                    while wait() do
                        if not oHover then
                            keybindElement.BackgroundColor3 = themeList.ElementColor
                        end
                        togName_2.TextColor3 = themeList.SchemeColor
                        touch.ImageColor3 = themeList.SchemeColor
                        viewInfo.ImageColor3 = themeList.SchemeColor
                        togName.BackgroundColor3 = themeList.TextColor
                        togName.TextColor3 = themeList.TextColor
                        Sample.ImageColor3 = themeList.SchemeColor
                        moreInfo.TextColor3 = themeList.TextColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)

                    end
                end)()
            end

            function Elements:NewColorPicker(colText, colInf, defcolor, callback)
                colText = colText or "ColorPicker"
                callback = callback or function() end
                defcolor = defcolor or Color3.fromRGB(1,1,1)
                local h, s, v = Color3.toHSV(defcolor)
                local ms = game.Players.LocalPlayer:GetMouse()
                local colorOpened = false
                local colorElement = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local colorHeader = Instance.new("Frame")
                local UICorner_2 = Instance.new("UICorner")
                local touch = Instance.new("ImageLabel")
                local togName = Instance.new("TextLabel")
                local viewInfo = Instance.new("ImageButton")
                local colorCurrent = Instance.new("Frame")
                local UICorner_3 = Instance.new("UICorner")
                local UIListLayout = Instance.new("UIListLayout")
                local colorInners = Instance.new("Frame")
                local UICorner_4 = Instance.new("UICorner")
                local rgb = Instance.new("ImageButton")
                local UICorner_5 = Instance.new("UICorner")
                local rbgcircle = Instance.new("ImageLabel")
                local darkness = Instance.new("ImageButton")
                local UICorner_6 = Instance.new("UICorner")
                local darkcircle = Instance.new("ImageLabel")
                local toggleDisabled = Instance.new("ImageLabel")
                local toggleEnabled = Instance.new("ImageLabel")
                local onrainbow = Instance.new("TextButton")
                local togName_2 = Instance.new("TextLabel")

                --Properties:
                local Sample = Instance.new("ImageLabel")
                Sample.Name = "Sample"
                Sample.Parent = colorHeader
                Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sample.BackgroundTransparency = 1.000
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = themeList.SchemeColor
                Sample.ImageTransparency = 0.600

                local btn = colorHeader
                local sample = Sample

                colorElement.Name = "colorElement"
                colorElement.Parent = sectionInners
                colorElement.BackgroundColor3 = themeList.ElementColor
                colorElement.BackgroundTransparency = 1.000
                colorElement.ClipsDescendants = true
                colorElement.Position = UDim2.new(0, 0, 0.566834569, 0)
                colorElement.Size = UDim2.new(0, 352, 0, 33)
                colorElement.AutoButtonColor = false
                colorElement.Font = Enum.Font.SourceSans
                colorElement.Text = ""
                colorElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                colorElement.TextSize = 14.000
                colorElement.MouseButton1Click:Connect(function()
                    if not focusing then
                        if colorOpened then
                            colorOpened = false
                            colorElement:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
                            wait(0.1)
                            updateSectionFrame()
                            UpdateSize()
                            local c = sample:Clone()
                            c.Parent = btn
                            local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                            c.Position = UDim2.new(0, x, 0, y)
                            local len, size = 0.35, nil
                            if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                                size = (btn.AbsoluteSize.X * 1.5)
                            else
                                size = (btn.AbsoluteSize.Y * 1.5)
                            end
                            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                            for i = 1, 10 do
                                c.ImageTransparency = c.ImageTransparency + 0.05
                                wait(len / 12)
                            end
                            c:Destroy()
                        else
                            colorOpened = true
                            colorElement:TweenSize(UDim2.new(0, 352, 0, 141), "InOut", "Linear", 0.08, true)
                            wait(0.1)
                            updateSectionFrame()
                            UpdateSize()
                            local c = sample:Clone()
                            c.Parent = btn
                            local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                            c.Position = UDim2.new(0, x, 0, y)
                            local len, size = 0.35, nil
                            if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                                size = (btn.AbsoluteSize.X * 1.5)
                            else
                                size = (btn.AbsoluteSize.Y * 1.5)
                            end
                            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                            for i = 1, 10 do
                                c.ImageTransparency = c.ImageTransparency + 0.05
                                wait(len / 12)
                            end
                            c:Destroy()
                        end
                    else
                        for i,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    end
                end)
                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = colorElement

                colorHeader.Name = "colorHeader"
                colorHeader.Parent = colorElement
                colorHeader.BackgroundColor3 = themeList.ElementColor
                colorHeader.Size = UDim2.new(0, 352, 0, 33)
                colorHeader.ClipsDescendants = true

                UICorner_2.CornerRadius = UDim.new(0, 4)
                UICorner_2.Parent = colorHeader
                
                touch.Name = "touch"
                touch.Parent = colorHeader
                touch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                touch.BackgroundTransparency = 1.000
                touch.BorderColor3 = Color3.fromRGB(27, 42, 53)
                touch.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                touch.Size = UDim2.new(0, 21, 0, 21)
                touch.Image = "rbxassetid://3926305904"
                touch.ImageColor3 = themeList.SchemeColor
                touch.ImageRectOffset = Vector2.new(44, 964)
                touch.ImageRectSize = Vector2.new(36, 36)

                togName.Name = "togName"
                togName.Parent = colorHeader
                togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                togName.BackgroundTransparency = 1.000
                togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
                togName.Size = UDim2.new(0, 288, 0, 14)
                togName.Font = Enum.Font.GothamSemibold
                togName.Text = colText
                togName.TextColor3 = themeList.TextColor
                togName.TextSize = 14.000
                togName.RichText = true
                togName.TextXAlignment = Enum.TextXAlignment.Left

                local moreInfo = Instance.new("TextLabel")
                local UICorner = Instance.new("UICorner")

                moreInfo.Name = "TipMore"
                moreInfo.Parent = infoContainer
                moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                moreInfo.Position = UDim2.new(0, 0, 2, 0)
                moreInfo.Size = UDim2.new(0, 353, 0, 33)
                moreInfo.ZIndex = 9
                moreInfo.Font = Enum.Font.GothamSemibold
                moreInfo.Text = "  "..colInf
                moreInfo.TextColor3 = themeList.TextColor
                moreInfo.TextSize = 14.000
                moreInfo.RichText = true
                moreInfo.TextXAlignment = Enum.TextXAlignment.Left

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = moreInfo

                viewInfo.Name = "viewInfo"
                viewInfo.Parent = colorHeader
                viewInfo.BackgroundTransparency = 1.000
                viewInfo.LayoutOrder = 9
                viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                viewInfo.Size = UDim2.new(0, 23, 0, 23)
                viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"
                viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764, 764)
                viewInfo.ImageRectSize = Vector2.new(36, 36)
                viewInfo.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for i,v in next, infoContainer:GetChildren() do
                            if v ~= moreInfo then
                                Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            end
                        end
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
                        Utility:TweenObject(colorElement, {BackgroundColor3 = themeList.ElementColor}, 0.2)
                        wait(1.5)
                        focusing = false
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                        wait(0)
                        viewDe = false
                    end
                end)   

                colorCurrent.Name = "colorCurrent"
                colorCurrent.Parent = colorHeader
                colorCurrent.BackgroundColor3 = defcolor
                colorCurrent.Position = UDim2.new(0.792613626, 0, 0.212121218, 0)
                colorCurrent.Size = UDim2.new(0, 42, 0, 18)

                UICorner_3.CornerRadius = UDim.new(0, 4)
                UICorner_3.Parent = colorCurrent

                UIListLayout.Parent = colorElement
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Padding = UDim.new(0, 3)

                colorInners.Name = "colorInners"
                colorInners.Parent = colorElement
                colorInners.BackgroundColor3 = themeList.ElementColor
                colorInners.Position = UDim2.new(0, 0, 0.255319148, 0)
                colorInners.Size = UDim2.new(0, 352, 0, 105)

                UICorner_4.CornerRadius = UDim.new(0, 4)
                UICorner_4.Parent = colorInners

                rgb.Name = "rgb"
                rgb.Parent = colorInners
                rgb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                rgb.BackgroundTransparency = 1.000
                rgb.Position = UDim2.new(0.0198863633, 0, 0.0476190485, 0)
                rgb.Size = UDim2.new(0, 211, 0, 93)
                rgb.Image = "http://www.roblox.com/asset/?id=6523286724"

                UICorner_5.CornerRadius = UDim.new(0, 4)
                UICorner_5.Parent = rgb

                rbgcircle.Name = "rbgcircle"
                rbgcircle.Parent = rgb
                rbgcircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                rbgcircle.BackgroundTransparency = 1.000
                rbgcircle.Size = UDim2.new(0, 14, 0, 14)
                rbgcircle.Image = "rbxassetid://3926309567"
                rbgcircle.ImageColor3 = Color3.fromRGB(0, 0, 0)
                rbgcircle.ImageRectOffset = Vector2.new(628, 420)
                rbgcircle.ImageRectSize = Vector2.new(48, 48)

                darkness.Name = "darkness"
                darkness.Parent = colorInners
                darkness.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                darkness.BackgroundTransparency = 1.000
                darkness.Position = UDim2.new(0.636363626, 0, 0.0476190485, 0)
                darkness.Size = UDim2.new(0, 18, 0, 93)
                darkness.Image = "http://www.roblox.com/asset/?id=6523291212"

                UICorner_6.CornerRadius = UDim.new(0, 4)
                UICorner_6.Parent = darkness

                darkcircle.Name = "darkcircle"
                darkcircle.Parent = darkness
                darkcircle.AnchorPoint = Vector2.new(0.5, 0)
                darkcircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                darkcircle.BackgroundTransparency = 1.000
                darkcircle.Size = UDim2.new(0, 14, 0, 14)
                darkcircle.Image = "rbxassetid://3926309567"
                darkcircle.ImageColor3 = Color3.fromRGB(0, 0, 0)
                darkcircle.ImageRectOffset = Vector2.new(628, 420)
                darkcircle.ImageRectSize = Vector2.new(48, 48)

                toggleDisabled.Name = "toggleDisabled"
                toggleDisabled.Parent = colorInners
                toggleDisabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggleDisabled.BackgroundTransparency = 1.000
                toggleDisabled.Position = UDim2.new(0.704659104, 0, 0.0657142699, 0)
                toggleDisabled.Size = UDim2.new(0, 21, 0, 21)
                toggleDisabled.Image = "rbxassetid://3926309567"
                toggleDisabled.ImageColor3 = themeList.SchemeColor
                toggleDisabled.ImageRectOffset = Vector2.new(628, 420)
                toggleDisabled.ImageRectSize = Vector2.new(48, 48)

                toggleEnabled.Name = "toggleEnabled"
                toggleEnabled.Parent = colorInners
                toggleEnabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggleEnabled.BackgroundTransparency = 1.000
                toggleEnabled.Position = UDim2.new(0.704999983, 0, 0.0659999996, 0)
                toggleEnabled.Size = UDim2.new(0, 21, 0, 21)
                toggleEnabled.Image = "rbxassetid://3926309567"
                toggleEnabled.ImageColor3 = themeList.SchemeColor
                toggleEnabled.ImageRectOffset = Vector2.new(784, 420)
                toggleEnabled.ImageRectSize = Vector2.new(48, 48)
                toggleEnabled.ImageTransparency = 1.000

                onrainbow.Name = "onrainbow"
                onrainbow.Parent = toggleEnabled
                onrainbow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                onrainbow.BackgroundTransparency = 1.000
                onrainbow.Position = UDim2.new(2.90643607e-06, 0, 0, 0)
                onrainbow.Size = UDim2.new(1, 0, 1, 0)
                onrainbow.Font = Enum.Font.SourceSans
                onrainbow.Text = ""
                onrainbow.TextColor3 = Color3.fromRGB(0, 0, 0)
                onrainbow.TextSize = 14.000

                togName_2.Name = "togName"
                togName_2.Parent = colorInners
                togName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                togName_2.BackgroundTransparency = 1.000
                togName_2.Position = UDim2.new(0.779999971, 0, 0.100000001, 0)
                togName_2.Size = UDim2.new(0, 278, 0, 14)
                togName_2.Font = Enum.Font.GothamSemibold
                togName_2.Text = "Rainbow"
                togName_2.TextColor3 = themeList.TextColor
                togName_2.TextSize = 14.000
                togName_2.TextXAlignment = Enum.TextXAlignment.Left

                if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                end 
                if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                end 
                local hovering = false

                colorElement.MouseEnter:Connect(function()
                    if not focusing then
                        game.TweenService:Create(colorElement, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
                        }):Play()
                        hovering = true
                    end 
                end)
                colorElement.MouseLeave:Connect(function()
                    if not focusing then
                        game.TweenService:Create(colorElement, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = themeList.ElementColor
                        }):Play()
                        hovering = false
                    end
                end)        

                if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                end 
                if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                end 
                coroutine.wrap(function()
                    while wait() do
                        if not hovering then
                            colorElement.BackgroundColor3 = themeList.ElementColor
                        end
                        touch.ImageColor3 = themeList.SchemeColor
                        colorHeader.BackgroundColor3 = themeList.ElementColor
                        togName.TextColor3 = themeList.TextColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                        moreInfo.TextColor3 = themeList.TextColor
                        viewInfo.ImageColor3 = themeList.SchemeColor
                        colorInners.BackgroundColor3 = themeList.ElementColor
                        toggleDisabled.ImageColor3 = themeList.SchemeColor
                        toggleEnabled.ImageColor3 = themeList.SchemeColor
                        togName_2.TextColor3 = themeList.TextColor
                        Sample.ImageColor3 = themeList.SchemeColor
                    end
                end)()
                updateSectionFrame()
                UpdateSize()
                local plr = game.Players.LocalPlayer
                local mouse = plr:GetMouse()
                local uis = game:GetService('UserInputService')
                local rs = game:GetService("RunService")
                local colorpicker = false
                local darknesss = false
                local dark = false
                local rgb = rgb    
                local dark = darkness    
                local cursor = rbgcircle
                local cursor2 = darkcircle
                local color = {1,1,1}
                local rainbow = false
                local rainbowconnection
                local counter = 0
                --
                local function zigzag(X) return math.acos(math.cos(X*math.pi))/math.pi end
                counter = 0
                local function mouseLocation()
                    return plr:GetMouse()
                end
                local function cp()
                    if colorpicker then
                        local ml = mouseLocation()
                        local x,y = ml.X - rgb.AbsolutePosition.X,ml.Y - rgb.AbsolutePosition.Y
                        local maxX,maxY = rgb.AbsoluteSize.X,rgb.AbsoluteSize.Y
                        if x<0 then x=0 end
                        if x>maxX then x=maxX end
                        if y<0 then y=0 end
                        if y>maxY then y=maxY end
                        x = x/maxX
                        y = y/maxY
                        local cx = cursor.AbsoluteSize.X/2
                        local cy = cursor.AbsoluteSize.Y/2
                        cursor.Position = UDim2.new(x,-cx,y,-cy)
                        color = {1-x,1-y,color[3]}
                        local realcolor = Color3.fromHSV(color[1],color[2],color[3])
                        colorCurrent.BackgroundColor3 = realcolor
                        callback(realcolor)
                    end
                    if darknesss then
                        local ml = mouseLocation()
                        local y = ml.Y - dark.AbsolutePosition.Y
                        local maxY = dark.AbsoluteSize.Y
                        if y<0 then y=0 end
                        if y>maxY then y=maxY end
                        y = y/maxY
                        local cy = cursor2.AbsoluteSize.Y/2
                        cursor2.Position = UDim2.new(0.5,0,y,-cy)
                        cursor2.ImageColor3 = Color3.fromHSV(0,0,y)
                        color = {color[1],color[2],1-y}
                        local realcolor = Color3.fromHSV(color[1],color[2],color[3])
                        colorCurrent.BackgroundColor3 = realcolor
                        callback(realcolor)
                    end
                end

                local function setcolor(tbl)
                    local cx = cursor.AbsoluteSize.X/2
                    local cy = cursor.AbsoluteSize.Y/2
                    color = {tbl[1],tbl[2],tbl[3]}
                    cursor.Position = UDim2.new(color[1],-cx,color[2]-1,-cy)
                    cursor2.Position = UDim2.new(0.5,0,color[3]-1,-cy)
                    local realcolor = Color3.fromHSV(color[1],color[2],color[3])
                    colorCurrent.BackgroundColor3 = realcolor
                end
                local function setrgbcolor(tbl)
                    local cx = cursor.AbsoluteSize.X/2
                    local cy = cursor.AbsoluteSize.Y/2
                    color = {tbl[1],tbl[2],color[3]}
                    cursor.Position = UDim2.new(color[1],-cx,color[2]-1,-cy)
                    local realcolor = Color3.fromHSV(color[1],color[2],color[3])
                    colorCurrent.BackgroundColor3 = realcolor
                    callback(realcolor)
                end
                local function togglerainbow()
                    if rainbow then
                        game.TweenService:Create(toggleEnabled, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                            ImageTransparency = 1
                        }):Play()
                        rainbow = false
                        rainbowconnection:Disconnect()
                    else
                        game.TweenService:Create(toggleEnabled, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                            ImageTransparency = 0
                        }):Play()
                        rainbow = true
                        rainbowconnection = rs.RenderStepped:Connect(function()
                            setrgbcolor({zigzag(counter),1,1})
                            counter = counter + 0.01
                        end)
                    end
                end

                onrainbow.MouseButton1Click:Connect(togglerainbow)
                --
                mouse.Move:connect(cp)
                rgb.MouseButton1Down:connect(function()colorpicker=true end)
                dark.MouseButton1Down:connect(function()darknesss=true end)
                uis.InputEnded:Connect(function(input)
                    if input.UserInputType.Name == 'MouseButton1' then
                        if darknesss then darknesss = false end
                        if colorpicker then colorpicker = false end
                    end
                end)
                setcolor({h,s,v})
            end
            
            function Elements:NewLabel(title)
            	local labelFunctions = {}
            	local label = Instance.new("TextLabel")
            	local UICorner = Instance.new("UICorner")
            	label.Name = "label"
            	label.Parent = sectionInners
            	label.BackgroundColor3 = themeList.SchemeColor
            	label.BorderSizePixel = 0
				label.ClipsDescendants = true
            	label.Text = title
           		label.Size = UDim2.new(0, 352, 0, 33)
	            label.Font = Enum.Font.Gotham
	            label.Text = "  "..title
	            label.RichText = true
	            label.TextColor3 = themeList.TextColor
	            Objects[label] = "TextColor3"
	            label.TextSize = 14.000
	            label.TextXAlignment = Enum.TextXAlignment.Left
	            
	           	UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = label
            	
	            if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
	                Utility:TweenObject(label, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
	            end 
	            if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
	                Utility:TweenObject(label, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
	            end 

		        coroutine.wrap(function()
		            while wait() do
		                label.BackgroundColor3 = themeList.SchemeColor
		                label.TextColor3 = themeList.TextColor
		            end
		        end)()
                updateSectionFrame()
                UpdateSize()
                function labelFunctions:UpdateLabel(newText)
                	if label.Text ~= "  "..newText then
                		label.Text = "  "..newText
                	end
                end	
                return labelFunctions
            end	
            return Elements
        end
        return Sections
    end  
    return Tabs
end
return Kavo
end
