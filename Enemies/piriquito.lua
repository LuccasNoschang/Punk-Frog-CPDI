local ClassPiriquito = {}
local emitterBirdDying = require ("emitter.BirdDying")


function ClassPiriquito.new( x , y, player , damage, camera)

	local piriquitoSpriteSheet = graphics.newImageSheet( "scripts/piriquitomaldido/piriquitomaldido.png", 
				{width = 48, height = 48, numFrames = 2} )

	local piriquitoSequenceAnimation =
	{
		{
			name = "flying",
			frames = {1,2},
			time = 700,
			loopCount = 0,			
		}

	}


	local piriquitoBox =
	{x = 0 , y = 0 , halfWidth = 12 , halfHeight = 18, angle = 0}

	local piriquito = display.newSprite (piriquitoSpriteSheet, piriquitoSequenceAnimation)
		piriquito.x = x
		piriquito.y = y
		physics.addBody(piriquito, "static", {friction = 1, bounce = 0, box = piriquitoBox})
		piriquito.isFixedRotation = true
		piriquito.id = "enemy"
		piriquito.life = 1
		piriquito.damagereceived = false
		piriquito.damage = damage
		piriquito:setSequence( "flying" )
		piriquito:play()
		camera:add(piriquito,1)






	local patrol = "left"
	local patrolis = "left"

	local xInicial = x
	local function patrolpiriquito ()
		if (piriquito.x ~= nil) then
			if (patrol == "left") then
				piriquito.xScale = -1
				piriquito.x = piriquito.x - 2

			elseif (patrol == "right") then
				piriquito.xScale = 1
				piriquito.x = piriquito.x + 2
			end
		else
			Runtime:removeEventListener("enterFrame", patrolpiriquito)
		end
	end
	Runtime:addEventListener( "enterFrame", patrolpiriquito )

	local function switchPatrol()
		if (piriquito.x ~= nil) then

			
			if (piriquito.x <= xInicial-70) then
				patrol = "right"
				patrolis = "left"

			elseif (piriquito.x >= xInicial+70) then
				patrol = "left"
				patrolis = "right"

			end
		else
			Runtime:removeEventListener("enterFrame", switchPatrol)
		end
	end
	Runtime:addEventListener( "enterFrame", switchPatrol )





	local function collision(self, event)
		if (event.phase == "began") then
			if ( event.other.id == "player") then
				if (event.other.invencible == false) then
					if (piriquito.x <= player.x) then
						event.other.damageOrientation = "right"
						event.other.TakingDamage = true
						event.other.life = event.other.life - piriquito.damage
					elseif (piriquito.x >= player.x) then
						event.other.damageOrientation = "left"
						event.other.TakingDamage = true
						event.other.life = event.other.life - piriquito.damage

					end
				end
			end
		end
	end
	piriquito.collision = collision
	piriquito:addEventListener( "collision" )




	local function lifeend()
		if (piriquito.life <= 0) then
			local parametrosAudioMenu =
		        {

		            loops = 0,
		            fadein = 0,
		            channel = 4,
		            duration = 1000,
		        }

        	local arquivoAudioMenu = audio.loadStream( "sfx_deathscream_alien2.mp3"  )
        	local canalAudioMenu = audio.play (arquivoAudioMenu, parametrosAudioMenu)
			physics.removeBody( piriquito )
			piriquito:setFillColor(1)
			Runtime:removeEventListener( "enterFrame", patrolpiriquito )
			Runtime:removeEventListener( "enterFrame", switchPatrol)
			Runtime:removeEventListener( "enterFrame", lifeend)
			Runtime:removeEventListener( "collision")
			local emitter = display.newEmitter (emitterBirdDying)
			emitter.x = piriquito.x
			emitter.y = piriquito.y
			camera:add(emitter,1)
			display.remove(piriquito)

		end
	end

	Runtime:addEventListener( "enterFrame", lifeend )








return piriquito

end

return ClassPiriquito
