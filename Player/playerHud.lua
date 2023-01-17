local ClassHud = {}
local player = require ("scripts.player.player")

 function ClassHud.new(player)
 	local groupHud = display.newGroup()
 	local PlayerIcon = display.newImageRect("scripts/player/PlayerIcon.png", 64, 64)
 		PlayerIcon.x = 30
 		PlayerIcon.y = 30
    groupHud:insert( PlayerIcon )
 	local hpOptions = {
    text = "",     
    x = 120,
    y = 30,
    width = 128,
    font = "scripts/words/Minecraft.ttf",   
    fontSize = 30,
    align = "left"  -- Alignment parameter
		}
 	local Hpcount = display.newText(hpOptions)
 	Hpcount:setFillColor( 1,0,0 )
  groupHud:insert(Hpcount)

 	local function HpcountAtt()
    if ( Hpcount.x ~= nil ) then
   		if (player.life == 0) then
   			Hpcount.text = ""

   		elseif (player.life == 1) then
    			Hpcount.text = "♥"

    		elseif (player.life == 2) then
    			Hpcount.text = "♥♥"

    		elseif (player.life == 3) then
    			Hpcount.text = "♥♥♥"

     		elseif (player.life == 4) then
    			Hpcount.text = "♥♥♥♥"

     		elseif (player.life == 5) then
    			Hpcount.text = "♥♥♥♥♥"
   		end
    end
 	end

 	Runtime:addEventListener( "enterFrame", HpcountAtt )


  hudDestroyis = false
  local function hudDestroy()
      print( hudDestroyis )
    if ( hudDestroyis == true or player.life <= 0) then
      display.remove(groupHud)
      Runtime:removeEventListener("enterFrame", hudDestroy)

    end
  end
  Runtime:addEventListener("enterFrame", hudDestroy)
 	

return grupoHud

end


return ClassHud