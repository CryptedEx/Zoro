local MPS = game:GetService("MarketplaceService")
local GPI = MPS.GetProductInfo

local function Info(Id)
    return GPI(MPS, Id)
end

local function Time(Hour, Minute, Second, Day, Month, Year)
    return os.time(
        {
            year = Year or os.date("%Y"),
            month = Month or os.date("%m"),
            day = Day or os.date("%d"),
            hour = Hour or 0,
            min = Minute or 0,
            sec = Second or 0
        }
    )
end

local function ExtractTimeComponents(DateTime)
    local Year, Month, Day, Hour, Minute, Second =
        string.match(DateTime, "([%w]+)%-([%w]+)%-([%w]+)T([%w]+):([%w]+):([%w]+)Z")
    return {Year, Month, Day, Hour, Minute, Second}
end

local function UpdateCheck(ScriptLastUpdated)
    local PI = Info(game.PlaceId)
    local UP = PI.Updated
    local CO = ExtractTimeComponents(UP)
    local SC = Time(unpack(ScriptLastUpdated))
    local GA = Time(unpack(CO))
    return (SC > GA)
end

if (UpdateCheck({23, 13, 00, 07, 10, 2021})) then
    print("UP TO DATE")
else
    print("OUT OF DATE - WAIT FOR UPDATE")
end

--[[ ==========  Executed Check  ========== ]]

if getgenv().zorov2 then
    local sound = Instance.new("Sound", game.Workspace)
sound.SoundId = "rbxassetid://5204290066";
game.StarterGui:SetCore("SendNotification", {
Title = "Zoro V2 [ERROR]"; 
Text = "Hi" .. game.Players.LocalPlayer.Name ..", ZoroV2 has already been executed in this game"; 
Icon = "https://www.roblox.com/headshot-thumbnail/image?userId=".. game.Players.LocalPlayer.UserId .."&width=420&height=420&format=png"; 
Duration = 10; 
sound:Play()
})
    return
end

getgenv().zorov2 = true

--[[ ==========  Compatibility  ========== ]]

local missing = {}

local funcs = {
    ["Drawing.new"] = {},
    ["firesignal"] = {},
    ["firetouchinterest"] = {},
    ["getconnections"] = {},
    ["getconstants"] = { "debug.getconstants" },
    ["getgc"] = { "get_gc_objects" },
    ["getinfo"] = { "debug.getinfo" },
    ["getloadedmodules"] = { "get_loaded_modules", "getmodules", "get_modules" },
    ["getupvalue"] = { "debug.getupvalue" },
    ["getupvalues"] = { "debug.getupvalues" },
    ["hookmetamethod"] = {},
    ["httprequest"] = { "http_request", "request", "syn.request" },
    ["islclosure"] = { "is_l_closure" },
    ["newcclosure"] = { "new_c_closure" },
    ["require"] = {},
	["setconstant"] = { "debug.setconstant" },
    ["setthreadidentity"] = { "setidentity", "setcontext", "setthreadcontext", "syn.set_thread_identity" },
    ["setupvalue"] = { "debug.setupvalue" },
    ["traceback"] = { "debug.traceback" }
}

local function parseFunc(str)
    local parsed, index = getfenv(), 1
    while parsed and type(parsed) == "table" do
        local dotIndex = str:find("%.")
        parsed = parsed[str:sub(index, dotIndex and dotIndex - 1 or #str - index + 1)]
        if dotIndex then
            str = str:sub(dotIndex + 1)
            index = str:find("%.") or 1
        end
    end
    return type(parsed) == "function" and parsed or false
end

for used, aliases in next, funcs do
    local hasFunc = parseFunc(used) ~= false
    if hasFunc == false then
        for _, alias in next, aliases do
            local parsedFunc = parseFunc(alias)
            if parsedFunc then
                getgenv()[used] = parsedFunc
                hasFunc = true
                break
            end
        end
        if hasFunc == false then
            missing[#missing + 1] = used
        end
    end
end

if #missing > 0 then
        local sound = Instance.new("Sound", game.Workspace)
sound.SoundId = "rbxassetid://784747919";
game.StarterGui:SetCore("SendNotification", {
Title = "Zoro V2 [Reminder]"; 
Text = "Hi" .. game.Players.LocalPlayer.Name ..", Your exploit is not supported. We recommend you use Synapse or KRNL or Oxygen U."; 
Icon = "https://www.roblox.com/headshot-thumbnail/image?userId=".. game.Players.LocalPlayer.UserId .."&width=420&height=420&format=png"; 
Duration = 10; 
sound:Play()
})
    return
end

--[[ ==========  Game Loader  ========== ]]

local chosenGame = ({
    [5490351219] = "clickermadness.lua",
    [155615604] = "prisonlife.lua"
})[game.PlaceId]

if chosenGame then
    loadstring(game:HttpGetAsync("https://notcryptex.000webhostapp.com/Games/" .. chosenGame))()
else
     local sound = Instance.new("Sound", game.Workspace)
sound.SoundId = "rbxassetid://5204290066";
game.StarterGui:SetCore("SendNotification", {
Title = "Zoro V2 [ERROR]"; 
Text = "Hi" .. game.Players.LocalPlayer.Name ..", ZoroV2 does not support this game"; 
Icon = "https://www.roblox.com/headshot-thumbnail/image?userId=".. game.Players.LocalPlayer.UserId .."&width=420&height=420&format=png"; 
Duration = 10; 
sound:Play()
})
        rconsolename("Zoro V2")
        rconsoleclear()
        rconsoleprint("@@RED@@")
        rconsoleprint("We have detected this game isnt on our hoster!\n")
    end
end
end;
