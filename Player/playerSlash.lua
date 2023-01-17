local ClassSlash = {}


 function ClassSlash.new (x,y, XSCALE,camera)

 		local parametrosAudioMenu =
		        {

		            loops = 0,
		            fadein = 0,
		            channel = 5,
		            duration = 1000,
		        }

        local arquivoAudioMenu = audio.loadStream( "sfx_wpn_sword1.mp3"  )
        local canalAudioMenu = audio.play (arquivoAudioMenu, parametrosAudioMenu)

		local slashspritesheet = graphics.newImageSheet("scripts/player/rastroLaminaSpriteSheet.png", {width = 32, height = 32, numFrames = 4})

		local slashsequence = 
		{
			{
				name = "normal",
				frames = {1,2,3,4},
				time = 300,
				loopcount = 1

			}
		}


		local slash = display.newSprite( slashspritesheet, slashsequence )
			slash.x = x
			slash.y = y
			slash.xScale = XSCALE
			slash.yScale = 2
			slash:setSequence( "normal" )
			slash:play()
			camera:add(slash, 1)
			timer.performWithDelay( 300,function ()
					display.remove(slash)
			end ,1)

return slash

end

return ClassSlash