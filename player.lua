local ClassPlayer = {}
local ClassAttack = require ("playerAttack")
local ClassDefense = require ("playerDefense")

function ClassPlayer.new(x, y)
	
	local player = display.newRect(x, y, 30, 30)
	player.id = "player"
	physics.addBody( player, "dynamic", {friction = 1, bounce = 0} )
	player.isFixedRotation = true
	player.damage = 1
	player.Blocking = false
	player.attacking = false
	player.TakingDamage = false
	player.invencible = false
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------

	local playerWalkRight = false
	local playerWalkLeft = false


	local function switchDirection(event)
		if (event.phase == "down") then
			if (event.keyName == "right") then
				player.xScale = 1
				playerWalkRight = true
			elseif (event.keyName == "left") then
				player.xScale = -1
				playerWalkLeft = true
			end
		end
		if (event.phase == "up") then
			if (event.keyName == "right") then
				playerWalkRight = false
		elseif (event.keyName == "left") then
				playerWalkLeft = false
			end
		end
	end
	Runtime:addEventListener( "key", switchDirection )


-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
	local speed = 2

	local function walking ()
		if (playerWalkRight == true) then
			player.x = player.x + speed
		elseif (playerWalkLeft == true) then
			player.x = player.x - speed
		end
	end
	Runtime:addEventListener( "enterFrame", walking)

-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------


	local function attack(event)
		if (event.phase == "down") then
			if (event.keyName == "x") then
				if (player.Blocking == false) then
					if(player.attacking == false and player.xScale == 1) then
						player.attacking = true
						local attack = ClassAttack.new(player.x+25, player.y, player, player.damage)
						timer.performWithDelay( 400,function ()
								display.remove(attack)
								player.attacking = false
						end ,1)
					elseif(player.attacking == false and player.xScale == -1) then
						player.attacking = true
						local attack = ClassAttack.new(player.x-25, player.y, player, player.damage)
						timer.performWithDelay( 400,function ()
								display.remove(attack)
								player.attacking = false
						end ,1)
					end
				end
			end
		end
	end

	Runtime:addEventListener("key", attack)


	local function playerBlock(event)
		if(event.phase == "down") then
			if (event.keyName == "c") then
				if (player.attacking == false and player.xScale == 1) then
					local shield = ClassDefense.shield(player.x+25 , player.y, player)
					player.Blocking = true
				end
				if (player.attacking == false and player.xScale == -1) then
					local shield = ClassDefense.shield(player.x-25 , player.y, player)
					player.Blocking = true
				end
			end
		elseif (event.phase == "up") then
				if (event.keyName == "c") then
					ClassDefense.removeshield()
					player.Blocking = false
				end
			
		end
	end

	Runtime:addEventListener("key", playerBlock)


	local function playerTakingDamage()
		if (player.TakingDamage == true) then
			player:setLinearVelocity( -90, -90 )
			player.TakingDamage = false
			player.invencible = true
		end
	end

	Runtime:addEventListener("enterFrame", playerTakingDamage)



	local function collision(self, event)
		if (event.phase == "began") then
			if (event.other.id == "enemy") then
				if (player.invencible == false) then
				player.TakingDamage = true
				player.invencible = true
				end
			end
			if (event.other.id == "floor") then
				player.invencible = false
			end

		end
	end

	player.collision = collision
	player:addEventListener( "collision" )

return player

end

return ClassPlayer