local ClassEnemy = {}


function ClassEnemy.new( x , y, player)


	local enemy = display.newRect (x,y, 30,30)
		enemy:setFillColor(0.8, 0, 0)
		physics.addBody(enemy, "dynamic", {friction = 1, bounce = 0})
		enemy.id = "enemy"
		enemy.life = 2
		enemy.damagereceived = false

	local patrol = "left"
	-- local startPatrol = display.newRect(enemy.x, enemy.y, 5,5)
	local xInicial = x
	local function patrolEnemy ()
		if (patrol == "left") then
			enemy.x = enemy.x - 2

		elseif (patrol == "right") then
			enemy.x = enemy.x + 2

		end
	end
	Runtime:addEventListener( "enterFrame", patrolEnemy )

	local function switchPatrol()
		if (enemy.x <= xInicial-70) then
			patrol = "right"
		elseif (enemy.x >= xInicial+70) then
			patrol = "left"
		end
	end
	Runtime:addEventListener( "enterFrame", switchPatrol )


	local function receivedDamage ()
		if (enemy.life >= 1)then
			if (enemy.damagereceived == true) then
				if (enemy.x >= player.x) then
					patrol = ""
					enemy:setFillColor(0.2)
					enemy:setLinearVelocity( 100, -100 )
					enemy.damagereceived = false
				end
			end
		end
	end

	Runtime:addEventListener("enterFrame", receivedDamage)

	local function collision(self, event)
		if (event.phase == "began") then
			if ( event.other.id == "floor") then
				patrol = "left"
				enemy:setFillColor(0.8, 0, 0)
			end
		end
	end
	enemy.collision = collision
	enemy:addEventListener( "collision" )




	local function lifeend()
		if (enemy.life <= 0) then

			Runtime:removeEventListener( "enterFrame", receivedDamage)
			Runtime:removeEventListener( "enterFrame", patrolEnemy )
			Runtime:removeEventListener( "enterFrame", switchPatrol)
			Runtime:removeEventListener( "enterFrame", lifeend)
			Runtime:removeEventListener( "collision")
			display.remove(enemy)

		end
	end

	Runtime:addEventListener( "enterFrame", lifeend )



return enemy

end

return ClassEnemy