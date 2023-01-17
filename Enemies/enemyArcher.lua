local ClassArcher = {}
local ClassEnemyAttacking = require ("scripts.SkeletonArcher.enemyAttack")


function ClassArcher.new( x , y, patrolx, xscale, player, damage, camera, tag)

	local SkeletonArcherSpriteSheet = graphics.newImageSheet( "scripts/SkeletonArcher/SkeletonArcher.png", 
				{width = 48, height = 48, numFrames = 20} )

	local SkeletonArcherSequenceAnimation =
	{
		{
			name = "paradonobailao",
			frames = {1},
			time = 20,
			loopCount = 0,
		},
		{
			name = "walking",
			frames = {2,3},
			time = 300,
			loopCount = 0,			
		},
		{
			name = "shooting",
			frames = {6,7,8,9},
			time = 800,
			loopCount = 1,
		},
		{
			name = "dead",
			frames = {11,12,13,14,15,16,17,18},
			time = 500,
			loopCount = 1,
		}

	}


	local SkeletonArcherBox =
	{x = 0 , y = 0 , halfWidth = 12 , halfHeight = 18, angle}

	local SkeletonArcher = display.newSprite (SkeletonArcherSpriteSheet, SkeletonArcherSequenceAnimation)
		SkeletonArcher.x = x
		SkeletonArcher.y = y
		physics.addBody(SkeletonArcher, "dynamic", {friction = 1, bounce = 0, box = SkeletonArcherBox})
		SkeletonArcher.isFixedRotation = true
		SkeletonArcher.id = "enemy"
		SkeletonArcher.life = 1
		SkeletonArcher.damagereceived = false
		SkeletonArcher.damage = damage
		SkeletonArcher.Action = "walking"
		SkeletonArcher.xScale = xscale
		camera:add(SkeletonArcher, 1)






	local patrol = "left"


	local function SkeletonArcherPatrol()
		if (SkeletonArcher.x ~= nil) then
			if (SkeletonArcher.Action == "walking") then
				SkeletonArcher.Action = ""
				if (patrol == "right") then
					SkeletonArcher:setSequence("walking")
					SkeletonArcher:play()
					transition.to( SkeletonArcher,{ x = SkeletonArcher.x + patrolx, time = 1000,
						onComplete = function()
						patrol = "left"
						SkeletonArcher.Action = "shooting"
						end, tag = "SkeletonMoving"})
				elseif (patrol == "left") then
					SkeletonArcher:setSequence("walking")
					SkeletonArcher:play()
					transition.to( SkeletonArcher,{ x = SkeletonArcher.x - patrolx, time = 1000,
						onComplete = function()
						patrol = "right"
						SkeletonArcher.Action = "shooting"
					   end, tag = tag })
				end
			end
		else
			Runtime:removeEventListener("enterFrame", SkeletonArcherPatrol)
		end
	end

	Runtime:addEventListener("enterFrame", SkeletonArcherPatrol)

	local function SkeletonArcherAttack()
		if (SkeletonArcher.x ~= nil) then
			if (SkeletonArcher.Action == "shooting") then
				if (SkeletonArcher.xScale == 1) then
					SkeletonArcher:setSequence( "shooting" )
					SkeletonArcher:play()
					SkeletonArcher.Action = ""
						local shoot = timer.performWithDelay( 800,function()
						local projectile = ClassEnemyAttacking.new(SkeletonArcher.x-25,SkeletonArcher.y-25,SkeletonArcher.damage, -100, -100, camera)
						SkeletonArcher.Action = "walking"
						end, 1, tag )  
				elseif (SkeletonArcher.xScale == -1) then
					SkeletonArcher:setSequence( "shooting" )
					SkeletonArcher:play()
					SkeletonArcher.Action = ""
						local shoot = timer.performWithDelay( 800,function()
						local projectile = ClassEnemyAttacking.new(SkeletonArcher.x+25,SkeletonArcher.y-25,SkeletonArcher.damage, 100, -100, camera)
						SkeletonArcher.Action = "walking"
						end, 1,tag )  
				end
			end
		else
			Runtime:removeEventListener("enterFrame", SkeletonArcherAttack)
			timer.cancel(tag)
		end
	end

	Runtime:addEventListener("enterFrame", SkeletonArcherAttack)









	local function receivedDamage ()
		if (SkeletonArcher.x ~= nil) then
			if (SkeletonArcher.life >= 1)then
				if (SkeletonArcher.damagereceived == true) then
					if (SkeletonArcher.x >= player.x) then
						SkeletonArcher:setFillColor(0.2)
						SkeletonArcher:setLinearVelocity( 100, -100 )
						SkeletonArcher.damagereceived = false

					end
				end
			end
		else
			Runtime:removeEventListener("enterFrame", receivedDamage)
		end
	end

	Runtime:addEventListener("enterFrame", receivedDamage)

	local function collision(self, event)
		if (event.phase == "began") then
			if ( event.other.id == "floor") then
				SkeletonArcher:setFillColor(1)
				patrol = "left"


			end
			if ( event.other.id == "player") then
				if (event.other.invencible == false) then
					if (SkeletonArcher.x <= player.x) then
						event.other.damageOrientation = "right"
						event.other.TakingDamage = true
						event.other.life = event.other.life - SkeletonArcher.damage
					elseif (SkeletonArcher.x >= player.x) then
						event.other.damageOrientation = "left"
						event.other.TakingDamage = true
						event.other.life = event.other.life - SkeletonArcher.damage
					end
				end
			end
		end
	end
	SkeletonArcher.collision = collision
	SkeletonArcher:addEventListener( "collision" )

		-- timer.performWithDelay( 1200, function ()
		-- local projectile = ClassEnemyAttacking.new(SkeletonArcher.x, SkeletonArcher.y, SkeletonArcher.damage)


		-- end, 0, "shotprojectile" )


	local function lifeend()
		if (SkeletonArcher.x ~= nil) then
			if (SkeletonArcher.life <= 0) then
				local parametrosAudioMenu =
		        {

		            loops = 0,
		            fadein = 0,
		            channel = 2,
		            duration = 1000,
		        }

        		local arquivoAudioMenu = audio.loadStream( "sfx_deathscream_human5.mp3"  )
        		local canalAudioMenu = audio.play (arquivoAudioMenu, parametrosAudioMenu)
				SkeletonArcher:setSequence( "dead" )
				SkeletonArcher:play()
				physics.removeBody( SkeletonArcher )
				Runtime:removeEventListener( "enterFrame", receivedDamage)
				Runtime:removeEventListener( "enterFrame", patrolSkeletonArcher )
				Runtime:removeEventListener( "enterFrame", switchPatrol)
				Runtime:removeEventListener( "enterFrame", lifeend)
				Runtime:removeEventListener( "enterFrame", SkeletonArcherAttack)
				Runtime:removeEventListener( "collision")
				timer.cancel( tag )
				transition.cancel( tag )

			end
		else
			Runtime:removeEventListener("enterFrame", lifeend)
		end
	end

	Runtime:addEventListener( "enterFrame", lifeend )








return SkeletonArcher

end

return ClassArcher
