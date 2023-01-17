local ClassDefense = {}


function ClassDefense.shield(x , y , target )
	local shield = display.newRect( x , y , 10 , 30)
	shield.id = "shield"
	shield:setFillColor( 0.3 , 0.3 , 0 )
	physics.addBody( shield, "dynamic", {isSensor = true})
	physics.newJoint( "weld", target, shield, x, y )





	function ClassDefense.removeshield()
		display.remove(shield)

	end


	local function collision(self, event)
		if (event.phase == "began") then
			if (event.other.id == "enemy") then
				target:setLinearVelocity( -100, -200 )
			end
		end
	end


	shield.collision = collision 
	shield:addEventListener("collision")




return shield

end

return ClassDefense