local composer = require( "composer" )
local perspective = require ("perspective")
local physics = require ("physics")
local player = require ("scripts.player.player")

local scene = composer.newScene()
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
 
end 
            
        
-- show()
function scene:show( event )

    -- grupo da cena
    -- todos os objetos fora da camera ficarão dentro deste grupo
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
    elseif ( phase == "did" ) then
     physics.start( )
        physics.setGravity( 0, 9,8 )
        
        local camera = perspective.createView()
        camera:prependLayer()













         --o paralax ( as funções da camera), podem vir aqui

         -- Não há necessidade de alterar
--          Camadas(1,  2,   3,   4,   5,   6,   7,  8 )
camera:setParallax( 1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0 ) -- Aqui alteramos o "Parallax" na ordem decrescente para cada layer

camera.damping = 20 -- Controla a fluidez da camera ao seguir o player
camera:setFocus( player ) -- Troca o foco para o player
camera:track() -- Inicia a perseguição da camera



    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
 
    elseif ( phase == "did" ) then
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene