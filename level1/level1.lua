local composer = require( "composer" )
local perspective = require ("levels.perspective")
local ClassPlayer = require ("scripts.player.player")
local ClassArcher = require ("scripts.SkeletonArcher.enemyArcher")
local ClassHud = require ("scripts.player.playerHud")
local ClassWarrior = require ("scripts.Warrior.enemyWarrior")
local ClassWords = require ("scripts.words.words")
local ClassLifeCrystal = require("scripts.heart.heart")
local ClassPiriquito = require("scripts.piriquitomaldido.piriquito")
local ClassBoss = require("scripts.boss.boss")
local tiled = require ("com.ponywolf.ponytiled")
local physics = require ("physics")
local json = require ("json")


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
        composer.removeScene("menu")
        physics.start()
        physics.setGravity( 0, 9.8 )
        -- physics.setDrawMode( "hybrid" )

         local parametrosAudioMenu =
        {

            loops = -1,
            fadein = 2000,
            channel = 1,
            duration = 400450,

        }

        local arquivoAudioMenu = audio.loadStream( "Jeremy Blake - Powerup!.mp3"  )
        local volumeChannel1 = audio.getVolume( { channel=1, 0.7 } )
        local canalAudioMenu = audio.play (arquivoAudioMenu, parametrosAudioMenu)
        
        local maingroup = display.newGroup()
        sceneGroup:insert(maingroup)
        local camera = perspective.createView()
        camera:prependLayer()

        local map = display.newImageRect( "levels/tutorial/tutorial.png", 3072, 3072)
        map.x, map.y = 1500,300
        maingroup:insert(map)
        local background = display.newImageRect("Images/tutorialBackground.jpg", 1920, 1200)
        background.x, background.y = display.contentCenterX, 0
        background.xScale, background.yScale = 0.5,0.5
        camera:add(background, 7)
        camera:add(maingroup, 1)
------------------------------------------------
------------------------------------------------
        local diefloor = display.newRect(1000, 300, 4000, 50)
        diefloor.id = "spike"
        physics.addBody( diefloor, "static", {isSensor = true} )
        camera:add(diefloor,1)


        local collisionjumpbox1 = display.newRect(235, 52, 553, 15 )
        collisionjumpbox1.alpha = 0
        collisionjumpbox1.id = "floor"
        physics.addBody( collisionjumpbox1, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox1, 1)
        maingroup:insert(collisionjumpbox1)
        local collisionterrainbox1 = display.newRect(235, 91, 537, 90 )
        collisionterrainbox1.alpha = 0
        collisionterrainbox1.id = ""
        physics.addBody( collisionterrainbox1, "static", {friction = 1 , bounce = 0})
        camera:add(collisionterrainbox1, 1)
        maingroup:insert(collisionterrainbox1)


        local collisionjumpbox2 = display.newRect(800, 52, 253, 15 )
        collisionjumpbox2.alpha = 0
        collisionjumpbox2.id = "floor"
        physics.addBody( collisionjumpbox2, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox2, 1)
        maingroup:insert(collisionjumpbox2)
        local collisionterrainbox2 = display.newRect(800, 95, 255, 95 )
        collisionterrainbox2.alpha = 0
        collisionterrainbox2.id = ""
        physics.addBody( collisionterrainbox2, "static", {friction = 1 , bounce = 0})
        camera:add(collisionterrainbox2, 1)
        maingroup:insert(collisionterrainbox2)


        local collisionjumpbox3 = display.newRect(1133, -75, 415, 15 )
        collisionjumpbox3.alpha = 0
        collisionjumpbox3.id = "floor"
        physics.addBody( collisionjumpbox3, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox3, 1)
        maingroup:insert(collisionjumpbox3)
        local collisionterrainbox3 = display.newRect(1133, 28, 410, 220 )
        collisionterrainbox3.alpha = 0
        collisionterrainbox3.id = ""
        physics.addBody( collisionterrainbox3, "static", {friction = 1 , bounce = 0})
        camera:add(collisionterrainbox3, 1)
        maingroup:insert(collisionterrainbox3)


        local collisionjumpbox4 = display.newRect(1372, 21, 60, 15 )
        collisionjumpbox4.alpha = 0
        collisionjumpbox4.id = "floor"
        physics.addBody( collisionjumpbox4, "static", { bounce = 0, isSensor = true})
        camera:add(collisionjumpbox4, 1)
        local collisionterrainbox4 = display.newRect(1372, 55, 60, 60 )
        collisionterrainbox4.alpha = 0
        collisionterrainbox4.id = ""
        physics.addBody( collisionterrainbox4, "static", {friction = 1 , bounce = 0,
         shape =
         {5,52,
         -30,-40,
         -30,0,
         30,0,
         30,-40,
         -5,52
         }})
        camera:add(collisionterrainbox4, 1)
        maingroup:insert(collisionterrainbox4)


        local collisionjumpbox5 = display.newRect(1690, 85, 315, 15 )
        collisionjumpbox5.alpha = 0
        collisionjumpbox5.id = "floor"
        physics.addBody( collisionjumpbox5, "static", {bounce = 0,isSensor = true})
        camera:add(collisionjumpbox5, 1)
        maingroup:insert(collisionjumpbox5)
        local collisionterrainbox6 = display.newRect(1690, 109, 310, 60 )
        collisionterrainbox6.alpha = 0
        collisionterrainbox6.id = ""
        physics.addBody( collisionterrainbox6, "static", {friction = 1 , bounce = 0})
        camera:add(collisionterrainbox6, 1)
        maingroup:insert(collisionterrainbox6)


        local collisionjumpbox6 = display.newRect(1692, -75, 305, 15 )
        collisionjumpbox6.alpha = 0
        collisionjumpbox6.id = "floor"
        physics.addBody( collisionjumpbox6, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox6, 1)
        maingroup:insert(collisionjumpbox6)
        local collisionterrainbox7 = display.newRect(1692, -52, 315, 58 )
        collisionterrainbox7.alpha = 0
        collisionterrainbox7.id = ""
        physics.addBody( collisionterrainbox7, "static", {friction = 1 , bounce = 0})
        camera:add(collisionterrainbox7, 1)
        maingroup:insert(collisionterrainbox7)
        local collisionterrainbox8 = display.newRect(1842, 42, 15, 200 )
        collisionterrainbox8.alpha = 0
        collisionterrainbox8.id = ""
        physics.addBody( collisionterrainbox8, "static", {friction = 1 , bounce = 0})
        camera:add(collisionterrainbox8, 1)
        maingroup:insert(collisionterrainbox8)

        local collisionjumpbox7 = display.newRect(2092, -107, 145, 15 )
        collisionjumpbox7.alpha = 0
        collisionjumpbox7.id = "floor"
        physics.addBody( collisionjumpbox7, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox7, 1)
        maingroup:insert(collisionjumpbox7)
        local collisionterrainbox9 = display.newRect(2092, -84, 153, 60 )
        collisionterrainbox9.alpha = 0
        collisionterrainbox9.id = ""
        physics.addBody( collisionterrainbox9, "static", {friction = 1 , bounce = 0})
        camera:add(collisionterrainbox9, 1)
        maingroup:insert(collisionterrainbox9)

        local collisionjumpbox8 = display.newRect(2332, -170, 110, 15 )
        collisionjumpbox8.alpha = 0
        collisionjumpbox8.id = "floor"
        physics.addBody( collisionjumpbox8, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox8, 1)
        maingroup:insert(collisionjumpbox8)
        local collisionterrainbox10 = display.newRect(2332, -147, 120, 60 )
        collisionterrainbox10.alpha = 0
        collisionterrainbox10.id = ""
        physics.addBody( collisionterrainbox10, "static", {friction = 1 , bounce = 0})
        camera:add(collisionterrainbox10, 1)
        maingroup:insert(collisionterrainbox10)

        local collisionjumpbox9 = display.newRect(2092, -267, 145, 15 )
        collisionjumpbox9.alpha = 0
        collisionjumpbox9.id = "floor"
        physics.addBody( collisionjumpbox9, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox9, 1)
        maingroup:insert(collisionjumpbox9)
        local collisionterrainbox11 = display.newRect(2092, -243, 153, 60 )
        collisionterrainbox11.alpha = 0
        collisionterrainbox11.id = ""
        physics.addBody( collisionterrainbox11, "static", {friction = 1 , bounce = 0})
        camera:add(collisionterrainbox11, 1)
        maingroup:insert(collisionterrainbox11)

        local collisionjumpbox10 = display.newRect(1868, -330, 145, 15 )
        collisionjumpbox10.alpha = 0
        collisionjumpbox10.id = "floor"
        physics.addBody( collisionjumpbox10, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox10, 1)
        maingroup:insert(collisionjumpbox10)
        local collisionterrainbox12 = display.newRect(1868, -307, 153, 60 )
        collisionterrainbox12.alpha = 0
        collisionterrainbox12.id = ""
        physics.addBody( collisionterrainbox12, "static", {friction = 1 , bounce = 0})
        camera:add(collisionterrainbox12, 1)
        maingroup:insert(collisionterrainbox12)

        local collisionjumpbox11 = display.newRect(1581, -365, 142, 15 )
        collisionjumpbox11.alpha = 0
        collisionjumpbox11.id = "floor"
        physics.addBody( collisionjumpbox11, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox11, 1)
        maingroup:insert(collisionjumpbox11)
        local collisionterrainbox13 = display.newRect(1581, -340, 151, 60 )
        collisionterrainbox13.alpha = 0
        collisionterrainbox13.id = ""
        physics.addBody( collisionterrainbox13, "static", {friction = 1 , bounce = 0})
        camera:add(collisionterrainbox13, 1)
        maingroup:insert(collisionterrainbox13)

        local collisionjumpbox12 = display.newRect(1357, -427, 144, 15 )
        collisionjumpbox12.alpha = 0
        collisionjumpbox12.id = "floor"
        physics.addBody( collisionjumpbox12, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox12, 1)
        maingroup:insert(collisionjumpbox12)
        local collisionterrainbox14 = display.newRect(1357, -403, 153, 60 )
        collisionterrainbox14.alpha = 0
        collisionterrainbox14.id = ""
        physics.addBody( collisionterrainbox14, "static", {friction = 1 , bounce = 0})
        camera:add(collisionterrainbox14, 1)
        maingroup:insert(collisionterrainbox14)
        
        local collisionjumpbox13 = display.newRect(1163, -491, 145, 15 )
        collisionjumpbox13.alpha = 0
        collisionjumpbox13.id = "floor"
        physics.addBody( collisionjumpbox13, "static", {bounce = 0})
        camera:add(collisionjumpbox13, 1)
        maingroup:insert(collisionjumpbox13)
        local collisionterrainbox14 = display.newRect(1165, -470, 153, 60 )
        collisionterrainbox14.alpha = 0
        collisionterrainbox14.id = ""
        physics.addBody( collisionterrainbox14, "static", {friction = 1 , bounce = 0,

            shape = {
            -79,-28,            75,-28,

            -79,7,              75,7,


                -20,34,      20,34

            }})
        camera:add(collisionterrainbox14, 1)
        maingroup:insert(collisionterrainbox14)

        local collisionjumpbox14 = display.newRect(1373, -587, 116, 15 )
        collisionjumpbox14.alpha = 0
        collisionjumpbox14.id = "floor"
        physics.addBody( collisionjumpbox14, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox14, 1)
        maingroup:insert(collisionjumpbox14)
        local collisionterrainbox15 = display.newRect(1373, -565, 153, 60 )
        collisionterrainbox15.alpha = 0
        collisionterrainbox15.id = ""
        physics.addBody( collisionterrainbox15, "static", {friction = 1 , bounce = 0,

            shape = {
            -63,-28,            60,-28,

            -63,4,              60,4,


                -7,30,      7,30

            }})
                camera:add(collisionterrainbox15, 1)
        maingroup:insert(collisionterrainbox15)

        local collisionjumpbox15 = display.newRect(1147, -651, 115, 15 )
        collisionjumpbox15.alpha = 0
        collisionjumpbox15.id = "floor"
        physics.addBody( collisionjumpbox15, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox15, 1)
        maingroup:insert(collisionjumpbox15)
        local collisionterrainbox16 = display.newRect(1149, -628, 153, 60 )
        collisionterrainbox16.alpha = 0
        collisionterrainbox16.id = ""
        physics.addBody( collisionterrainbox16, "static", {friction = 1 , bounce = 0,

            shape = {
            -63,-28,            60,-28,

            -63,4,              60,4,


                -7,30,      7,30

            }})
                camera:add(collisionterrainbox16, 1)
        maingroup:insert(collisionterrainbox16)

        local collisionjumpbox16 = display.newRect(1373, -747, 118, 15 )
        collisionjumpbox16.alpha = 0
        collisionjumpbox16.id = "floor"
        physics.addBody( collisionjumpbox16, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox16, 1)
        maingroup:insert(collisionjumpbox16)
        local collisionterrainbox17 = display.newRect(1373, -725, 153, 60 )
        collisionterrainbox17.alpha = 0
        collisionterrainbox17.id = ""
        physics.addBody( collisionterrainbox17, "static", {friction = 1 , bounce = 0,

            shape = {
            -63,-28,            60,-28,

            -63,4,              60,4,


                -7,30,      7,30

            }})
                camera:add(collisionterrainbox17, 1)
        maingroup:insert(collisionterrainbox17)

        local collisionjumpbox17 = display.newRect(1147, -811, 118, 15 )
        collisionjumpbox17.alpha = 0
        collisionjumpbox17.id = "floor"
        physics.addBody( collisionjumpbox17, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox17, 1)
        maingroup:insert(collisionjumpbox17)
        local collisionterrainbox18 = display.newRect(1149, -788, 153, 60 )
        collisionterrainbox18.alpha = 0
        collisionterrainbox18.id = ""
        physics.addBody( collisionterrainbox18, "static", {friction = 1 , bounce = 0,

            shape = {
            -63,-28,            60,-28,

            -63,4,              60,4,


                -7,30,      7,30

            }})
                camera:add(collisionterrainbox18, 1)
        maingroup:insert(collisionterrainbox18)

        local collisionjumpbox18 = display.newRect(1021, -811, 54, 15 )
        collisionjumpbox18.alpha = 0
        collisionjumpbox18.id = "floor"
        physics.addBody( collisionjumpbox18, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox18, 1)
        maingroup:insert(collisionjumpbox18)
        local collisionterrainbox19 = display.newRect(1021, -789, 153, 60 )
        collisionterrainbox19.alpha = 0
        collisionterrainbox19.id = ""
        physics.addBody( collisionterrainbox19, "static", {friction = 1 , bounce = 0,

            shape = {
            -30,-28,            30,-28,

            -30,4,              30,4,


                -7,60,      5,60

            }})
                camera:add(collisionterrainbox19, 1)
        maingroup:insert(collisionterrainbox19)

        local collisionjumpbox19 = display.newRect(893, -843, 54, 15 )
        collisionjumpbox19.alpha = 0
        collisionjumpbox19.id = "floor"
        physics.addBody( collisionjumpbox19, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox19, 1)
        maingroup:insert(collisionjumpbox19)
        local collisionterrainbox20 = display.newRect(893, -822, 153, 60 )
        collisionterrainbox20.alpha = 0
        collisionterrainbox20.id = ""
        physics.addBody( collisionterrainbox20, "static", {friction = 1 , bounce = 0,

            shape = {
            -30,-28,            30,-28,

            -30,4,              30,4,


                -7,60,      5,60

            }})
                camera:add(collisionterrainbox20, 1)
        maingroup:insert(collisionterrainbox20)

        local collisionjumpbox20 = display.newRect(732, -843, 54, 15 )
        collisionjumpbox20.alpha = 0
        collisionjumpbox20.id = "floor"
        physics.addBody( collisionjumpbox20, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox20, 1)
        maingroup:insert(collisionjumpbox20)
        local collisionterrainbox21 = display.newRect(732, -822, 153, 60 )
        collisionterrainbox21.alpha = 0
        collisionterrainbox21.id = ""
        physics.addBody( collisionterrainbox21, "static", {friction = 1 , bounce = 0,

            shape = {
            -30,-28,            30,-28,

            -30,4,              30,4,


                -7,60,      5,60

            }})
                camera:add(collisionterrainbox21, 1)
        maingroup:insert(collisionterrainbox21)

        local collisionjumpbox21 = display.newRect(571, -843, 54, 15 )
        collisionjumpbox21.alpha = 0
        collisionjumpbox21.id = "floor"
        physics.addBody( collisionjumpbox21, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox21, 1)
        maingroup:insert(collisionjumpbox21)
        local collisionterrainbox22 = display.newRect(571, -822, 153, 60 )
        collisionterrainbox22.alpha = 0
        collisionterrainbox22.id = ""
        physics.addBody( collisionterrainbox22, "static", {friction = 1 , bounce = 0,

            shape = {
            -30,-28,            30,-28,

            -30,4,              30,4,


                -7,60,      5,60

            }})
                camera:add(collisionterrainbox22, 1)
        maingroup:insert(collisionterrainbox22)

        local collisionjumpbox22 = display.newRect(410, -843, 54, 15 )
        collisionjumpbox22.alpha = 0
        collisionjumpbox22.id = "floor"
        physics.addBody( collisionjumpbox22, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox22, 1)
        maingroup:insert(collisionjumpbox22)
        local collisionterrainbox23 = display.newRect(412, -822, 153, 60 )
        collisionterrainbox23.alpha = 0
        collisionterrainbox23.id = ""
        physics.addBody( collisionterrainbox23, "static", {friction = 1 , bounce = 0,

            shape = {
            -30,-28,            30,-28,

            -30,4,              30,4,


                -7,60,      5,60

            }})
                camera:add(collisionterrainbox23, 1)
        maingroup:insert(collisionterrainbox23)

        local collisionjumpbox23 = display.newRect(252, -875, 57, 15 )
        collisionjumpbox23.alpha = 0
        collisionjumpbox23.id = "floor"
        physics.addBody( collisionjumpbox23, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox23, 1)
        maingroup:insert(collisionjumpbox23)
        local collisionterrainbox24 = display.newRect(252, -851, 57, 60 )
        collisionterrainbox24.alpha = 0
        collisionterrainbox24.id = ""
        physics.addBody( collisionterrainbox24, "static", {friction = 1 , bounce = 0})
        camera:add(collisionterrainbox24, 1)
        maingroup:insert(collisionterrainbox24)

        local collisionjumpbox24 = display.newRect(77, -940, 150, 15 )
        collisionjumpbox24.alpha = 0
        collisionjumpbox24.id = "floor"
        physics.addBody( collisionjumpbox24, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox24, 1)
        maingroup:insert(collisionjumpbox24)
        local collisionterrainbox25 = display.newRect(77, -918, 153, 60 )
        collisionterrainbox25.alpha = 0
        collisionterrainbox25.id = ""
        physics.addBody( collisionterrainbox25, "static", {friction = 1 , bounce = 0,

            shape = {
            -79,-28,            75,-28,

            -79,7,              75,7,


                -20,34,      20,34

            }})
        camera:add(collisionterrainbox25, 1)
        maingroup:insert(collisionterrainbox25)

        local collisionjumpbox25 = display.newRect(476, -1037, 430, 15 )
        collisionjumpbox25.alpha = 0
        collisionjumpbox25.id = "floor"
        physics.addBody( collisionjumpbox25, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox25, 1)
        maingroup:insert(collisionjumpbox25)
        local collisionterrainbox26 = display.newRect(476, -1012, 440, 60 )
        collisionterrainbox26.alpha = 0
        collisionterrainbox26.id = ""
        physics.addBody( collisionterrainbox26, "static", {friction = 1 , bounce = 0})
        camera:add(collisionterrainbox26, 1)
        maingroup:insert(collisionterrainbox26)

        local collisionjumpbox26 = display.newRect(476, -1164, 115, 15 )
        collisionjumpbox26.alpha = 0
        collisionjumpbox26.id = "floor"
        physics.addBody( collisionjumpbox26, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox26, 1)
        maingroup:insert(collisionjumpbox26)
        local collisionterrainbox17 = display.newRect(478, -1142, 153, 60 )
        collisionterrainbox17.alpha = 0
        collisionterrainbox17.id = ""
        physics.addBody( collisionterrainbox17, "static", {friction = 1 , bounce = 0,

            shape = {
            -63,-28,            60,-28,

            -63,4,              60,4,


                -7,30,      7,30

            }})
                camera:add(collisionterrainbox17, 1)
        maingroup:insert(collisionterrainbox17)

        local collisionjumpbox27 = display.newRect(1117, -1003, 367, 15 )
        collisionjumpbox27.alpha = 0
        collisionjumpbox27.id = "floor"
        physics.addBody( collisionjumpbox27, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox27, 1)
        maingroup:insert(collisionjumpbox27)
        local collisionterrainbox28 = display.newRect(1117, -981, 153, 60 )
        collisionterrainbox28.alpha = 0
        collisionterrainbox28.id = ""
        physics.addBody( collisionterrainbox28, "static", {friction = 1 , bounce = 0,

            shape = {
            -188,-28,            188,-28,

            -188,4,              188,4,


                -140,30,      140,30

            }})
                camera:add(collisionterrainbox28, 1)
        maingroup:insert(collisionterrainbox28)

        local collisionjumpbox28 = display.newRect(1756, -1069, 753, 15 )
        collisionjumpbox28.alpha = 0
        collisionjumpbox28.id = "floor"
        physics.addBody( collisionjumpbox28, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox28, 1)
        maingroup:insert(collisionjumpbox28)
        local collisionterrainbox28 = display.newRect(1756, -1044, 153, 60 )
        collisionterrainbox28.alpha = 0
        collisionterrainbox28.id = ""
        physics.addBody( collisionterrainbox28, "static", {friction = 1 , bounce = 0,

            shape = {
            -379,-31,            379,-31,

            -379,4,              379,4,


            -335,30,     90,100,        379,100

            }})
                camera:add(collisionterrainbox28, 1)
        maingroup:insert(collisionterrainbox28)

        local collisionjumpbox29 = display.newRect(2223, -939, 200, 15 )
        collisionjumpbox29.alpha = 0
        collisionjumpbox29.id = "floor"
        physics.addBody( collisionjumpbox29, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox29, 1)
        maingroup:insert(collisionjumpbox29)
        local collisionterrainbox30 = display.newRect(2228, -918, 153, 60 )
        collisionterrainbox30.alpha = 0
        collisionterrainbox30.id = ""
        physics.addBody( collisionterrainbox30, "static", {friction = 1 , bounce = 0,

            shape = {
            -120,-28,            100,-28,

            -120,4,              100,4,


                -50,30,      50,30

            }})
                camera:add(collisionterrainbox30, 1)
        maingroup:insert(collisionterrainbox30)



for i=1,5 do
    stairX = 2447 + (32*i)
    stairY = -907 + (-32*i)
        local collisionjumpbox30 = display.newRect(stairX, stairY, 30, 15 )
        collisionjumpbox30.alpha = 0
        collisionjumpbox30.id = "floor"
        physics.addBody( collisionjumpbox30, "static", {bounce = 0})
        camera:add(collisionjumpbox30, 1)
        maingroup:insert(collisionjumpbox30)

end

        local collisionjumpbox31 = display.newRect(2733, -1100, 217, 15 )
        collisionjumpbox31.alpha = 0
        collisionjumpbox31.id = "floor"
        physics.addBody( collisionjumpbox31, "static", {bounce = 0, isSensor = true})
        camera:add(collisionjumpbox31, 1)
        maingroup:insert(collisionjumpbox31)
        local collisionterrainbox32 = display.newRect(2733, -1044, 217, 120 )
        collisionterrainbox32.alpha = 0
        collisionterrainbox32.id = ""
        physics.addBody( collisionterrainbox32, "static", {friction = 1 , bounce = 0})
        camera:add(collisionterrainbox32, 1)
        maingroup:insert(collisionterrainbox32)

        


------------------------------------------------
------------------------------------------------

        camera:add(map,1)

        local word = display.newText("Use as setas para ir para a direita e esquerda.", 0, -20, "scripts/words/Minecraft.ttf", 15)
        word:setFillColor( 0 )
        camera:add(word, 1)
        timer.performWithDelay( 5000,function()
            display.remove(word)
        end ,1 )


        local word1 = display.newText("Barra de espaço pula, pode pular ate no ar.", 430, -20, "scripts/words/Minecraft.ttf", 15)
        word1:setFillColor( 0 )
        camera:add(word1, 1)
        maingroup:insert(word1)

        local eventbox = display.newRect(800, -15, 270, 130)
        eventbox.alpha = 0
        eventbox.id = "eventbox"
        physics.addBody( eventbox, "static", {isSensor = true} )
        camera:add(eventbox, 1)
        maingroup:insert(eventbox)
        local word2 = display.newText("", 800, -20, "scripts/words/Minecraft.ttf", 15)
        word2:setFillColor( 0 )
        camera:add(word2, 1)
        maingroup:insert(word2)

        local eventbox2 = display.newRect(970, -153, 50, 170)
        eventbox2.alpha = 0
        physics.addBody( eventbox2, "static", {isSensor = true} )
        camera:add(eventbox2, 1)
        maingroup:insert(eventbox2)
        local word3 = display.newText("", 950, -130, "scripts/words/Minecraft.ttf", 15)
        word3:setFillColor( 0 )
        camera:add(word3, 1)
        maingroup:insert(word3)





        local word4 = display.newText("↓", 1400, -130, "scripts/words/Minecraft.ttf", 50)
        word4:setFillColor( 0 )
        camera:add(word4, 1)
        maingroup:insert(word4)



        local eventbox3 = display.newRect(2100, -190, 50, 170)
        eventbox3.alpha = 0
        physics.addBody( eventbox3, "static", {isSensor = true} )
        camera:add(eventbox3, 1)
        maingroup:insert(eventbox3)
        local word5 = display.newText("", 2100, -190, "scripts/words/Minecraft.ttf", 15)
        word5:setFillColor( 0 )
        camera:add(word5, 1)
        maingroup:insert(word5)

        local word6 = display.newText("↓", 2180, -1090, "scripts/words/Minecraft.ttf", 50)
        word6:setFillColor( 0 )
        camera:add(word6, 1)
        maingroup:insert(word6)


        local eventbox4 = display.newRect(2765, -1190, 50, 170)
        eventbox4.alpha = 0
        physics.addBody( eventbox4, "static", {isSensor = true} )
        camera:add(eventbox4, 1)
        maingroup:insert(eventbox4)
        local word7 = display.newText("", 2733, -1200, "scripts/words/Minecraft.ttf", 15)
        word7:setFillColor( 0 )
        camera:add(word7, 1)
        maingroup:insert(word7)

------------------------------------------------------------------------------------------
        local player = ClassPlayer.new(0, 0,camera)
        -- maingroup:insert(player)
------------------------------------------------------------------------------------------
        local lifeCrystal1 = ClassLifeCrystal.new (1800, 30, camera)
        -- maingroup:insert(lifeCrystal1)
        local lifeCrystal2 = ClassLifeCrystal.new (478, -1200, camera)
        -- maingroup:insert(lifeCrystal2)
------------------------------------------------------------------------------------------
        local groupHud = ClassHud.new(player)
        local enemy1 = ClassArcher.new(1230,0, 100, 1, player, 1, camera, "a")
        local enemy2 = ClassArcher.new(2092, -330, 30, -1, player, 1, camera, "b")
        local enemy3 = ClassWarrior.new(1870, -350, 70, player,-1, 1, camera)
        local enemy4 = ClassArcher.new(1380, -610,40, 1, player, 1, camera, "d")
        local enemy5 = ClassPiriquito.new(700, -930, player, 1, camera)
        local enemy6 = ClassArcher.new(582, -860,20, -1, player, 1, camera, "f")
        local enemy7 = ClassWarrior.new(476, -1050, 70, player,1, 1, camera)
        local enemy8 = ClassWarrior.new(1656, -1069, 70, player,1, 1, camera)
        local enemy9 = ClassWarrior.new(1856, -1069, 70, player,1, 1, camera)



        local function word2Event( self , event )
            if (event.phase == "began") then
                if (event.other.id == "player") then
                    timer.performWithDelay( 10000, function()
                    word2.text = "É so pular sobre o ar o bundão"
                end, 1, "words2")
                end
            elseif (event.phase == "ended") then
                if (event.other.id == "player") then
                timer.cancel( "words2" )
                end
            end
        end
        eventbox.collision = word2Event
        eventbox:addEventListener( "collision")


        local function word3Event(self, event)
            if (event.phase == "began") then
                if(event.other.id == "player") then
                    eventbox2:removeEventListener( "collision" )
                    eventbox:removeEventListener( "collision" )
                    camera:setMasterOffset(-200,0)
                    player.ableToMove = false
                    player:setSequence( "idle" )
                    player:play()
                    timer.performWithDelay( 2000, function()
                    camera:setMasterOffset(0,0)
                    word3.text = "OLHA O ESQULETO QUE INDECENTE"
                    end, 1 )
                    timer.performWithDelay( 4200, function()
                    word3.text = "ESTA SEM CALÇAS!!"
                    end, 1 )
                    timer.performWithDelay( 6400, function()
                    word3.text = "Aperte 'x' para moer ele na porrada"
                    player.WalkRight = false
                    player.WalkLeft = false
                    player.ableToMove = true
                    end, 1 )
                    timer.performWithDelay( 8600, function()
                    word3.text = ""
                    end, 1 )


                end
            end
        end

        eventbox2.collision = word3Event
        eventbox2:addEventListener( "collision" )



        local function word5Event (self, event)
             if (event.phase == "began") then
                if (event.other.id == "player") then
                    eventbox3:removeEventListener( "collision" )
                    word5.text = "B A H"
                    timer.performWithDelay( 3000, function()
                    word5.text = "E essas plataformas flutuantes ein?"
                    end, 1)
                end
            end
        end

        eventbox3.collision = word5Event
        eventbox3:addEventListener( "collision" )


        local function word7Event (self, event)
             if (event.phase == "began") then
                if (event.other.id == "player") then
                    eventbox4:removeEventListener( "collision" )
                    player.ableToMove = false
                    player.WalkRight = false
                    player.WalkLeft = false
                    player:setSequence( "idle" )
                    player:play()
                    word7.text = "Pronto"
                    timer.performWithDelay( 3000, function()
                    word7.text = "Agora deita os outros na porrada"
                    end, 1)

                    timer.performWithDelay(6000, function()
                        audio.stop(canalAudioMenu)
                        composer.gotoScene("levels.level2")
                        camera:destroy()
                        display.remove( maingroup )
                        hudDestroyis = true
                        hudDestroyis = false
                    end,1)
                end
            end
        end

        eventbox4.collision = word7Event
        eventbox4:addEventListener( "collision" )

         --o paralax ( as funções da camera), podem vir aqui

         -- Não há necessidade de alterar
--          Camadas(1,  2,   3,   4,   5,   6,   7,  8 )
camera:setParallax( 1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.1, 0 ) -- Aqui alteramos o "Parallax" na ordem decrescente para cada layer

camera.damping = 10 -- Controla a fluidez da camera ao seguir o player
camera:setFocus(player) -- Troca o foco para o player
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
