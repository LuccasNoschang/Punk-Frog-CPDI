local ClassPlayer = {}
local ClassAttack = require ("scripts.player.playerAttack")
local emiterPlayerParams = require ("emitter.PlayerEmitter")
local ClassSlash = require ("scripts.player.playerSlash")

function ClassPlayer.new(x, y, camera)


	local playerSpriteSheet = graphics.newImageSheet( "scripts/player/spritePlayer.png", {width = 64, height = 48, numFrames = 25})

	local playerSequence =
	{
		{
			name = "idle",
			frames = {1,2,3},
			time = 450,
			loopCount = 0,
		},

		{
			name = "running",
			frames = {4,5,6,7,8,9},
			time = 600,
			loopCount = 0,
		},
		{
			name = "attack",
			frames = {11,11,12,12,13,13,14,15,15},
			time = 350,
			loopCount = 1,
		},
		{
			name = "death",
			frames = {16,17,18,19,20,21,22,23},
			time = 500,
			loopCount = 1,
		},
		{
			name = "jump",
			frames = {24,25},
			time = 200,
			loopCount = 1,
		},
	}



	local player = display.newSprite(playerSpriteSheet, playerSequence)
	player.x = x
	player.y = y
	player.id = "player"
	playerbox = {x= 0,y = 3,halfWidth = 8, halfHeight = 20, angle = 0}
	physics.addBody( player, "dynamic", {friction = 1, bounce = 0, box = playerbox} )
	player.life = 2
	player.isFixedRotation = true
	player.damage = 1
	player.Blocking = false
	player.attacking = false
	player.TakingDamage = false
	player.invencible = false
	player.ableToMove = true
	player.inAir = false
	camera:add(player,1)
			player:setSequence( "idle" )
			player:play()
	player.cameraside = true



	local emitter = display.newEmitter( emiterPlayerParams )
		emitter.x = 0
		emitter.y = 0
		camera:add(emitter,1)
	local function emitterposition ()
		emitter.x = player.x
		emitter.y = player.y
	end

	Runtime:addEventListener("enterFrame", emitterposition)




-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------

	player.WalkRight = false
	player.WalkLeft = false




	local function playerWalkingAnimation ()
		if (player.x ~= nil) then
			if (player.ableToMove == true) then
				if (player.attacking == false) then
					if(player.inAir == false) then
						if (player.WalkRight == true) then
								player:setSequence( "running" )
								player:play()
						elseif (player.WalkLeft == true) then
								player:setSequence( "running" )
								player:play()
						elseif (player.WalkRight == false and player.WalkLeft == false) then
								player:setSequence( "idle" )
								player:play()
						end
				elseif(player.inAir == true) then
		
					end
				end
			end
		end
	end




	local function switchDirection(event)
		if (player.x ~= nil) then
			if (event.phase == "down") then
				if (event.keyName == "right") then
					player.WalkLeft = false
					player.xScale = 1
					player.WalkRight = true
					playerWalkingAnimation()
				elseif (event.keyName == "left") then
					player.WalkRight = false
					player.xScale = -1
					player.WalkLeft = true
					playerWalkingAnimation()
				end
			end
			if (event.phase == "up") then
				if (event.keyName == "right") then
					player.WalkRight = false
					playerWalkingAnimation()
			elseif (event.keyName == "left") then
					player.WalkLeft = false
					playerWalkingAnimation()
				end
			end
		else
			Runtime:removeEventListener("key", switchDirection)
		end
	end
	Runtime:addEventListener( "key", switchDirection )






-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
	player.speed = 2

	local function walking ()
		if (player.x ~= nil) then
			if (player.ableToMove == true) then
				if (player.attacking == false) then
					if (player.WalkRight == true) then
						player.x = player.x + player.speed

					elseif (player.WalkLeft == true) then
						player.x = player.x - player.speed

					end
				end
			end
		else
			Runtime:removeEventListener("enterFrame", walking)
		end
	end
	Runtime:addEventListener( "enterFrame", walking)


-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------



	player.doubleJump = true
	player.jump = 1

	local function playerJumping (event)
		if (player.x ~= nil) then
			if (player.ableToMove == true) then
				if (event.phase == "down") then
					if (event.keyName == "space") then
						if (player.jump >= 1) then
						playerWalkingAnimation()
						player:setSequence( "jump" )
						player:play()
						player.jump = player.jump - 1
						player:setLinearVelocity( 0, -200   )
						end
					end
				end
			end
		else
			Runtime:removeEventListener("key", playerJumping)
		end
	end

	Runtime:addEventListener("key", playerJumping)





-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------


	local function attack(event)
		if (player.x ~= nil) then
			if (player.ableToMove == true) then
				if (event.phase == "down") then
					if (event.keyName == "x") then
						if (player.Blocking == false) then
							if(player.attacking == false and player.xScale == 1) then
								player.attacking = true
								local attack = ClassAttack.new(player.x+27, player.y, player, player.damage,camera, 1)
								player:setSequence( "attack" ) 
								player:play() 
								local slash = ClassSlash.new (player.x+32, player.y-6, 2, camera)
								timer.performWithDelay( 400,function ()
										display.remove(attack)
								end ,1)
								timer.performWithDelay(400, function()
										player.attacking = false
									playerWalkingAnimation()
								end,1)
							elseif(player.attacking == false and player.xScale == -1) then
								player.attacking = true
								local attack = ClassAttack.new(player.x-27, player.y, player, player.damage,camera, -1)
								local slash = ClassSlash.new (player.x-32, player.y-6, -2, camera)
								player:setSequence( "attack" ) 
								player:play() 
								timer.performWithDelay( 400,function ()
										display.remove(attack)
								end ,1)
								timer.performWithDelay(400, function()
										player.attacking = false
									playerWalkingAnimation()
								end,1)
							end
						end
					end
				end
			end
		else
			Runtime:removeEventListener( "key", attack )

		end
	end

	Runtime:addEventListener("key", attack)



-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------


	local function cameraside()
		if (player.x ~= nil) then
			if(player.ableToMove == true) then
				if (player.cameraside == true) then
					if (player.xScale == 1) then
						camera:setMasterOffset(-50,0)

					elseif (player.xScale == -1) then
						camera:setMasterOffset(50,0)

					end
				end
			end
		else
			Runtime:removeEventListener("enterFrame", cameraside)
		end
	end


	Runtime:addEventListener("enterFrame", cameraside)





-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------




	player.damageOrientation = ""

	local function playerTakingDamage()
		if (player.x ~= nil) then
			if (player.ableToMove == true) then
				if (player.TakingDamage == true) then
					if (player.damageOrientation == "left") then
					player:setLinearVelocity( -90, -90 )
					player.TakingDamage = false
					player.invencible = true
					player.ableToMove = false

				elseif (player.damageOrientation == "right") then
					player:setLinearVelocity( 90, -90 )
					player.TakingDamage = false
					player.invencible = true
					player.ableToMove = false
					end
				end
			end
		else
			Runtime:removeEventListener("enterFrame", playerTakingDamage)
		end
	end

	Runtime:addEventListener("enterFrame", playerTakingDamage)



	local function collision(self, event)
		if (event.phase == "began") then
			if (event.other.id == "floor") then
				if(event.other.y > player.y) then
					if (player.invencible == true) then
							player.invencible = false
							player.inAir = false
							player.ableToMove = true
							playerWalkingAnimation()
						if (player.doubleJump == false) then
							player.jump = 1
						elseif (player.doubleJump == true) then
							player.jump = 2
						end
					elseif (player.invencible == false) then
							player.inAir = false
							player.invencible = false
							playerWalkingAnimation()
						if (player.doubleJump == false) then
							player.jump = 1
						elseif (player.doubleJump == true) then
							player.jump = 2
						end
					end
				end
			elseif(event.other.id == "spike") then
				player.life = 0
			end
		elseif (event.phase == "ended") then
			if (event.other.id == "floor") then
					player.inAir = true
					playerWalkingAnimation()
			end
		end
	end

	player.collision = collision
	player:addEventListener( "collision" )


	local function lifeLimiter()
		if (player.x ~= nil) then
			if (player.life > 5) then
				player.life = 5
			end
		else
			Runtime:removeEventListener("enterFrame", lifeLimiter)
		end
	end
	Runtime:addEventListener("enterFrame", lifeLimiter)




	local function lifeCheck ()
		if (player.x ~= nil) then
			if (player.life <= 0) then
				player.ableToMove = false
				Runtime:removeEventListener("enterFrame", lifeCheck)
				player:removeEventListener( "collision" )
				player:setSequence( "death" )
				player:play()
				physics.removeBody( player )
				timer.performWithDelay(1000, function()

					display.remove (player)
					Runtime:removeEventListener("key", playerBlock)
					Runtime:removeEventListener("key", attack)
					Runtime:removeEventListener("key", playerJumping)
					Runtime:removeEventListener( "key", switchDirection )
					Runtime:removeEventListener( "enterFrame", walking)
					Runtime:removeEventListener("enterFrame", lifeLimiter)
					Runtime:removeEventListener("enterFrame", playerTakingDamage)
					Runtime:removeEventListener("enterFrame", idlestand)
					camera:destroy()
				end, 1 )

			end
		else
			Runtime:removeEventListener("enterFrame", lifeCheck)
		end
	end

 	Runtime:addEventListener( "enterFrame", lifeCheck )



return player

end

return ClassPlayer
