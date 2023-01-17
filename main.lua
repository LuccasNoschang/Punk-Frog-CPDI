
-- -- Solicita o compositor de cenas
-- local composer = require "composer"

-- -- função que me leva para a cena desejada
-- composer.gotoScene( "menu" )


display.setDefault("magTextureFilter", "nearest")
display.setDefault("minTextureFilter", "nearest")
local composer = require "composer"

-- Recicla a imagem utilizada anteriormente
-- Não cria novas imagens uma em cima da outra ao voltar para cena 
composer.recycleOnSceneChange = true
-- função que me leva para a cena desejada 
composer.gotoScene( "levels.menu" )
