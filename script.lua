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

if ZoroUser:IsInGroup(14806953) then
    if game.PlaceId == 155615604 then
        print("Prison Life")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CryptedEx/Zoro/main/Games/Prison%20Life.lua", true))(

        )
    end
    if game.PlaceId == 5490351219 then
        print("Clicker Madness")
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/CryptedEx/Zoro/main/Games/Clicker%20Madness.lua", true)
        )()
    else
        rconsolename("Zoro V2")
        rconsoleclear()
        rconsoleprint("@@RED@@")
        rconsoleprint("We have detected this game isnt on our github!\n")
    end
end
