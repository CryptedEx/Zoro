--// if ZoroUser:IsInGroup(14806953) then
if game.PlaceId == 155615604 then
    print("Prison Life")
loadstring(game:HttpGet("https://raw.githubusercontent.com/CryptedEx/Zoro/main/Games/Prison%20Life.lua", true))()
else
  rconsolename('Zoro V2')
  rconsoleclear();
  rconsoleprint('@@RED@@')
  rconsoleprint('We have detected this game isnt on our github!\n')
end
