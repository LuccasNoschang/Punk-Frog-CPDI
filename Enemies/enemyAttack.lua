local ClassEnemyAttacking = {}


function ClassEnemyAttacking.new(x , y, damage, xspeed, yspeed,camera)

	local projectile = display.newImageRect("scripts/SkeletonArcher/rockProjectile.png", 10, 10)
	projectile.x = x
	projectile.y = y
	projectile.id = "projectile"
	projectile.damage = damage
	projectile.xScale = 0.7
	projectile.yScale = 0.7
	projectile.rotation = 45
		physics.addBody(projectile, "dynamic", { bounce = 0, density = 1.6,})
	projectile:setLinearVelocity( xspeed, yspeed )

	camera:add(projectile,1)


	local function collision (self, event)
		if (event.phase == "began") then
			

			if (event.other.id == "player") then
				if (event.other.invencible == false) then
					event.other.life = event.other.life - projectile.damage
					event.other.TakingDamage = true
					print(event.other.life)
					display.remove( projectile )
				end
			else
				display.remove(projectile)



			end
		end
	end

	projectile.collision = collision 
	projectile:addEventListener( "collision" )




return projectile

end


return ClassEnemyAttacking