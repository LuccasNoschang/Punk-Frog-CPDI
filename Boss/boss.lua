local ClassBoss = {}
local ClassAttackBoss = require ("scripts.boss.attackBoss")
local ClassAttackBossEspecial = require ("scripts.boss.attackBossEspecial")

function ClassBoss.new (xPos, yPos, camera, player)
		local bigFrogSpriteSheet = graphics.newImageSheet( "scripts/boss/bigFrog.png", {width = 64, height = 64, numFrames = 5})

		local bigFrogSequence = 
		{

			{
				name = "idle",
				frames = {1},
				time = 300,
				loopCount = 0,
			},
			{
				name = "preattack",
				frames = {2},
				time = 300,
				loopCount = 0,
			},
			{
				name = "attack",
				frames = {3,4},
				time = 100,
				loopCount = 1,
			},
			{
				name = "attacktoidle",
				frames = {4,3,2,1},
				time = 120,
				loopCount = 1,
			},

			{
				name = "jump",
				frames = {5},
				time = 300,
				loopCount = 1,
			}

		}

		local bigFrogshapeL = {
			-34,-23,		38,-23,


			-23,28,			28,28

			}

		local bigFrog = display.newSprite(bigFrogSpriteSheet, bigFrogSequence)
			bigFrog.x = xPos
			bigFrog.y = yPos
			bigFrog.xScale = 1.5
			bigFrog.yScale = 1.5
			bigFrog.life = 15
			bigFrog.damage = 1
			bigFrog.id = "enemy"
			bigFrog.damagereceived = false
			bigFrog.active = false
			bigFrog.action = ""
			bigFrog.attackcount = 0
			physics.addBody( bigFrog, "dynamic", { friction = 1, bounce = 0, shape = bigFrogshapeL } )
			bigFrog.isFixedRotation = true
			camera:add(bigFrog,1)

			

		


		local function bossAttack()
			if (bigFrog.attackcount < 2 ) then
				if (bigFrog.action == "attack") then
				bigFrog:setSequence( "preattack" )
				bigFrog:play()
				bigFrog.action = ""
					timer.performWithDelay(1200, function ()
					bigFrog:setSequence( "attack" )
					bigFrog:play()
					bigFrog.action = "jump"
						if (bigFrog.xScale == 1.5) then
							local attack = ClassAttackBoss.new(bigFrog.x-35, bigFrog.y, 1, camera)
							bigFrog.attackcount = bigFrog.attackcount + 1
						elseif (bigFrog.xScale == -1.5) then
							local attack = ClassAttackBoss.new(bigFrog.x+35, bigFrog.y, -1, camera)
							bigFrog.attackcount = bigFrog.attackcount + 1
						end
					end, 1, "boss")
				end
			elseif (bigFrog.attackcount >= 2) then
				bigFrog:setSequence( "preattack" )
				bigFrog:play()
				bigFrog.action = ""
				timer.performWithDelay(500, function()
				bigFrog:setFillColor( 0.84,0.32,0.07 )
				end,1 )
				timer.performWithDelay(1000, function()
				bigFrog:setFillColor( 1 )
					bigFrog:setSequence( "attack" )
					bigFrog:play()
					bigFrog.action = ""
					if (bigFrog.xScale == 1.5) then
						local attack = ClassAttackBossEspecial.new(bigFrog.x-20, bigFrog.y, 4,4, camera)
						bigFrog.attackcount = 0
					elseif (bigFrog.xScale == - 1.5) then
						local attack = ClassAttackBossEspecial.new(bigFrog.x-20, bigFrog.y, -4,4, camera)
						bigFrog.attackcount = 0
					end
				end,1 )
				timer.performWithDelay(1300, function()
				bigFrog:setFillColor( 1 )
					bigFrog:setSequence( "attack" )
					bigFrog:play()
					bigFrog.action = ""
					if (bigFrog.xScale == 1.5) then
						local attack = ClassAttackBossEspecial.new(bigFrog.x-20, bigFrog.y, 4,4, camera)
						bigFrog.attackcount = 0
					elseif (bigFrog.xScale == - 1.5) then
						local attack = ClassAttackBossEspecial.new(bigFrog.x-20, bigFrog.y, -4,4, camera)
						bigFrog.attackcount = 0
					end
				end,1 )
				timer.performWithDelay(1600, function()
				bigFrog:setFillColor( 1 )
					bigFrog:setSequence( "attack" )
					bigFrog:play()
					bigFrog.action = "jump"
					if (bigFrog.xScale == 1.5) then
						local attack = ClassAttackBossEspecial.new(bigFrog.x-20, bigFrog.y, 4,4, camera)
						bigFrog.attackcount = 0
					elseif (bigFrog.xScale == - 1.5) then
						local attack = ClassAttackBossEspecial.new(bigFrog.x-20, bigFrog.y, -4,4, camera)
						bigFrog.attackcount = 0
					end
				end,1 )
			end
		end


		local bossJumpx = math.random(100, 170)

		local function bossJumping()
			if (bigFrog.action == "jump" ) then
				bigFrog:setSequence( "attacktoidle" )
				bigFrog:play()
				bigFrog.action = ""
				if (bigFrog.xScale == 1.5) then
					bossJumpx = math.random(100, 170)
					timer.performWithDelay(1500, function()
						bigFrog:setSequence( "jump" )
						bigFrog:play()
						bigFrog:setLinearVelocity( -bossJumpx , -300 )

					end, 1, "boss" )

				elseif (bigFrog.xScale == -1.5) then
					bossJumpx = math.random(100, 170)
					timer.performWithDelay(1500, function()
						bigFrog:setSequence( "jump" )
						bigFrog:play()
						bigFrog:setLinearVelocity( bossJumpx , -300 )

					end, 1, "boss"  )					
				end

			end
		end




		local function bossAction()
			if (bigFrog.x ~= nil) then
				if (bigFrog.action == "jump") then
					bossJumping()

				elseif (bigFrog.action == "attack") then
					bossAttack()
				end
			end
		end

		Runtime:addEventListener( "enterFrame", bossAction )


		local function recievedDamage()
			if (bigFrog.x ~= nil) then
				if (bigFrog.damagereceived == true) then
					bigFrog:setFillColor( 1,0.5,0.5 )
					timer.performWithDelay( 300,function()
					bigFrog:setFillColor( 1 )
					end,1, "boss" )
					bigFrog.damagereceived = false
				end
			end
		end

		Runtime:addEventListener( "enterFrame", recievedDamage )


		local function collision (self, event)
			if (bigFrog.active == true) then
				if (event.phase == "began") then
					if (event.other.id == "floor") then
						if (event.other.y > bigFrog.y) then
							if (bigFrog.x > player.x) then
								bigFrog.xScale = 1.5
								bigFrog:setSequence("idle")
								bigFrog:play()
								bigFrog.action = "attack"


							elseif (bigFrog.x < player.x) then
								bigFrog.xScale = -1.5
								bigFrog:setSequence("idle")
								bigFrog:play()
								bigFrog.action = "attack"


							end
						end
				elseif (event.other.id == "player") then
						if (bigFrog.x >= event.other.x) then
							event.other.life = event.other.life - bigFrog.damage
							event.other.damageOrientation = "left"
							event.other.TakingDamage = true
							print("ba")

						elseif (bigFrog.x <= event.other.x) then
							event.other.life = event.other.life - bigFrog.damage
							event.other.damageOrientation = "right"
							event.other.TakingDamage = true
						end
					end
				end
			end
		end


		bigFrog.collision = collision
		bigFrog:addEventListener("collision")


		local function lifeEnd()
			if (bigFrog.life <= 0) then
				bigFrog:setFillColor( 0.8, 0, 0 )
					Runtime:removeEventListener("enterFrame", lifeEnd)
					bigFrog:removeEventListener("collision")
					Runtime:removeEventListener( "enterFrame", recievedDamage )
					physics.removeBody( bigFrog )
					timer.cancel( "boss" )
			end	
		end

		Runtime:addEventListener("enterFrame", lifeEnd)

		local function bossnil()
			if (bigFrog.x == nil) then
						Runtime:removeEventListener("enterFrame", lifeEnd)
						Runtime:removeEventListener( "enterFrame", recievedDamage )
						timer.cancel( "boss" )
						Runtime:removeEventListener("enterFrame",bossnil)
			end	
		end

		Runtime:addEventListener("enterFrame",bossnil)


return bigFrog
end
return ClassBoss
