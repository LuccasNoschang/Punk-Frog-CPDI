local ClassWarrior = {}



function ClassWarrior.new( x , y, patrolvalue, player , xscale, damage, camera)

	local warriorSpriteSheet = graphics.newImageSheet( "scripts/Warrior/WarriorSpriteSheet.png", 
				{width = 48, height = 48, numFrames = 10} )

	local warriorSequenceAnimation =
	{
		{
			name = "walking",
			frames = {2,3},
			time = 300,
			loopCount = 0,			
		},
		{
			name = "dead",
			frames = {5,6,7,8,9},
			time = 450,
			loopCount = 1,	
		}


	}


	local warriorBox =
	{x = 1 , y = 0 , halfWidth = 18 , halfHeight = 22, angle = 0}

	local warrior = display.newSprite (warriorSpriteSheet, warriorSequenceAnimation)
		warrior.x = x
		warrior.y = y
		physics.addBody(warrior, "dynamic", {friction = 1, bounce = 0, box = warriorBox})
		warrior.isFixedRotation = true
		warrior.id = "enemy"
		warrior.life = 2
		warrior.damagereceived = false
		warrior.damage = damage
		warrior:setSequence( "walking" )
		warrior:play()
		camera:add(warrior,1)
		warrior.xScale = xscale




	local patrol = "left"
	local patrolis = "left"

	local xInicial = x
	local function patrolwarrior ()
		if (warrior.x ~= nil) then
			
			if (patrol == "left") then

				warrior.x = warrior.x - 2

			elseif (patrol == "right") then
				warrior.x = warrior.x + 2
			end

		end
	end
	Runtime:addEventListener( "enterFrame", patrolwarrior )

	local function switchPatrol()
		if (warrior.x ~= nil) then
			if (warrior.x <= xInicial-patrolvalue) then
				patrol = "right"
				patrolis = "left"

			elseif (warrior.x >= xInicial+patrolvalue) then
				patrol = "left"
				patrolis = "right"

			end
		else
			Runtime:removeEventListener( "enterFrame", switchPatrol )

		end
	end
	Runtime:addEventListener( "enterFrame", switchPatrol )






	local function receivedDamage ()
		if (warrior.life >= 0)then
			if (warrior.damagereceived == true) then
				if (warrior.x >= player.x) then
					patrol = ""
					warrior:setFillColor(0.2)
					warrior:setLinearVelocity( 100, -100 )
					warrior.damagereceived = false

				end
				if (warrior.x <= player.x) then
					patrol = ""
					warrior:setFillColor(0.2)
					warrior:setLinearVelocity( -100, -100 )
					warrior.damagereceived = false
				end
			end
		end
	end

	Runtime:addEventListener("enterFrame", receivedDamage)

	local function collision(self, event)
		if (event.phase == "began") then
			if ( event.other.id == "floor") then
				warrior:setFillColor(1)
				patrol = patrolis

			end
			if ( event.other.id == "player") then
				if (event.other.invencible == false) then
					if (warrior.x <= player.x) then
						event.other.damageOrientation = "right"
						event.other.TakingDamage = true
						event.other.life = event.other.life - warrior.damage
					elseif (warrior.x >= player.x) then
						event.other.damageOrientation = "left"
						event.other.TakingDamage = true
						event.other.life = event.other.life - warrior.damage

					end
				end
			end
		end
	end
	warrior.collision = collision
	warrior:addEventListener( "collision" )




	local function warriorLifeend()
		if (warrior.life <= 0) then
			local parametrosAudioMenu =
		        {

		            loops = 0,
		            fadein = 0,
		            channel = 3,
		            duration = 1000,
		        }

        		local arquivoAudioMenu = audio.loadStream( "sfx_deathscream_human12.mp3"  )
        		local canalAudioMenu = audio.play (arquivoAudioMenu, parametrosAudioMenu)
			warrior:setSequence( "dead" )
			warrior:play()
			physics.removeBody( warrior )
			warrior:setFillColor(1)
			Runtime:removeEventListener( "enterFrame", receivedDamage )
			Runtime:removeEventListener( "enterFrame", patrolwarrior )
			Runtime:removeEventListener( "enterFrame", switchPatrol )
			Runtime:removeEventListener( "enterFrame", warriorLifeend )
			Runtime:removeEventListener( "enterFrame", warriorAttack )
			Runtime:removeEventListener( "collision" )
		end
	end

	Runtime:addEventListener( "enterFrame", warriorLifeend )








return warrior

end

return ClassWarrior