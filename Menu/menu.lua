local composer = require( "composer" )

local emitterParams = require ( "levels.menu.emitter" )

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

         local parametrosAudioMenu =
        {

            loops = -1,
            fadein = 2000,
            channel = 1,
            duration = 400450,

        }

        local menuSong = audio.loadStream( "Density & Time - MAZE.mp3" )

           local background = display.newImageRect ( "levels/menu/backgroundNovo.png", display.actualContentWidth, display.actualContentHeight )
           background.x = display.contentCenterX
           background.y = display.contentCenterY
           sceneGroup:insert( background )

           local emitter = display.newEmitter( emitterParams )
           emitter.x = display.contentCenterX
           emitter.y = display.contentCenterY + 50

           local botaoIniciar = display.newImageRect ( "levels/menu/buttonStart.png", 200/3, 190/3 )
           botaoIniciar.x = display.contentCenterX
           botaoIniciar.y = display.contentCenterY + 50
           sceneGroup:insert( botaoIniciar )

           audio.play( menuSong, parametrosAudioMenu )

           local function iniciarJogo( event )
               if ( event.phase == "began" ) then
                  display.remove( emitter )
                  botaoIniciar.xScale = 0.8
                  botaoIniciar.yScale = 0.8
                  botaoIniciar.alpha = 1


                  elseif (event.phase == "ended") then
                  audio.stop( {channel = 1} )
                  composer.gotoScene( "levels.level1" )



           end
       end
       botaoIniciar:addEventListener( "touch", iniciarJogo )

        
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