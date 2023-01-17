local ClassAttackBoss = {}
local fireballEmiterParams = require ("emitter.emitterFireBall")

function ClassAttackBoss.new (xPos , yPos , XScale, camera)
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

	local fireballbox = {x= 0,y = 0,halfWidth = 14, halfHeight = 7, angle = 0}


	local fireBall = display.newSprite (fireballSpriteSheet, fireballSequence) 
		fireBall.x = xPos
		fireBall.y = yPos
		fireBall.xScale = XScale
		fireBall.id = "fireBall" 
		fireBall.damage = 1
		camera:add(fireBall, 1)
	physics.addBody(fireBall, "kinematic", {isSensor = true, box = fireballbox})


	transition.to(fireBall, {x = (fireBall.x + 1000*-XScale), time = 8000, tag = "fireBall"})

		fireBall:setSequence()
		fireBall:play()


	local emitter = display.newEmitter(fireballEmiterParams)
		emitter.x = fireBall.x
		emitter.y = 0
		camera:add(emitter,1)
	local function emitterposition()
		emitter.x = fireBall.x
		emitter.y = fireBall.y
	end

	Runtime:addEventListener( "enterFrame", emitterposition )


	local function collision (self, event)
		if (event.phase == "began") then
			if(event.other.id == "player") then
				if (fireBall.x > event.other.x) then
						event.other.life = event.other.life - fireBall.damage
						event.other.damageOrientation = "left"
						event.other.TakingDamage = true
						display.remove(fireBall)

				elseif (fireBall.x < event.other.x) then
						event.other.life = event.other.life - fireBall.damage
						event.other.damageOrientation = "right"
						event.other.TakingDamage = true
						display.remove(fireBall)


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
return ClassAttackBoss
