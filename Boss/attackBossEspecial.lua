local ClassAttackBossEspecial = {}


function ClassAttackBossEspecial.new (xPos , yPos , XScale, YScale, camera)
	local fireballSpriteSheet = graphics.newImageSheet("scripts/boss/fireball.png", {width = 32, height = 32, numFrames = 2})

	local fireballSequence = 
	{
		{
			name = "normal",
			frames = {1,2},
			time = 300,
			loopCount = 0,
		}
	}

	local fireBallShape = 
	{
		-37,-22,	20,-22,	
							55,0,
		-37,22,		20,22

	}
	local fireBall = display.newSprite (fireballSpriteSheet, fireballSequence) 
		fireBall.x = xPos
		fireBall.y = yPos
		fireBall.xScale = XScale
		fireBall.yScale = YScale
		fireBall.id = "fireBall"
		fireBall.damage = 2
		camera:add(fireBall, 1)
	physics.addBody(fireBall, "kinematic", {isSensor = true, shape = fireBallShape})



	transition.to(fireBall, {x = (fireBall.x + 1000*-XScale), time = 14000, tag = "fireBall"})


	local function collision (self, event)
		if (event.phase == "began") then
			if(event.other.id == "player") then
				if (fireBall.x > event.other.x) then
					if(event.other.invencible == false) then
						event.other.life = event.other.life - fireBall.damage
						event.other.damageOrientation = "left"
						event.other.TakingDamage = true

						display.remove(fireBall, fireballparametros)
					end
				elseif (fireBall.x < event.other.x) then
					if(event.other.invencible == false) then
						event.other.life = event.other.life - fireBall.damage
						event.other.damageOrientation = "right"
						event.other.TakingDamage = true

						display.remove(fireBall, fireballparametros)
					end
				end
			elseif (event.other.id == "enemy") then
			elseif (event.other.id == "attackHitBox") then
			else
				transition.cancel(fireBall)
				display.remove(fireBall)
			end
		end
	end

	fireBall.collision = collision
	fireBall:addEventListener( "collision" )



return fireBall
end
return ClassAttackBossEspecial
