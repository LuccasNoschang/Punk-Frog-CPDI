local ClassAttack = {}

 function ClassAttack.new (x, y, target, damage, camera, XSCALE)
		local attackHitBox = display.newRect( x, y, 45, 40 )
		attackHitBox.alpha = 0
		camera:add(attackHitBox,1)
		attackHitBox.id = "attackHitBox"
		physics.addBody(attackHitBox, "dynamic", {isSensor = true})
		local jointPlayerAttack = physics.newJoint( "weld", target, attackHitBox, x, y )




	local function collision(self, event )
		if (event.phase == "began") then		
			if (event.other.id =="enemy") then
				event.other.life = event.other.life - damage
				event.other.damagereceived = true
			end
		end
	end

	attackHitBox.collision = collision
	attackHitBox:addEventListener( "collision")



return attackHitBox

 end

return ClassAttack