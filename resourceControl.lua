--[[
 resourceControl.lua
 GDC Game - Group 5
  Group: Rob, Steve, Chuck, Dylan, Chris, Sam
]]--

function mainMenuResources()        --Loading resources for main menu

	bgimg = love.graphics.newImage("//resources//mainMenu.png")   --splitting the main menu into quads
	menuQuad = love.graphics.newQuad(0, 0, 960, 640, 1024, 1024)
	startQuad = love.graphics.newQuad(2, 743, 120, 85, 1024, 1024)
	optionsQuad = love.graphics.newQuad(2, 645, 140, 85, 1024, 1024)
	howQuad = love.graphics.newQuad(2, 835, 170, 85, 1024, 1024)
	aboutQuad = love.graphics.newQuad(2, 935, 129, 86, 1024, 1024)
	
	fontimg = love.graphics.newImage("//resources//font.png")   --loading new font into game
	fontimg:setFilter("nearest","nearest")
	imgfont = love.graphics.newImageFont(fontimg,"ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.!?()':; *" )  --Cause lower-case is for pussies
	imgfont:setLineHeight(5)
	love.graphics.setFont(imgfont)
	
	mainMenuMusic = love.audio.newSource("//resources//mainMenu.ogg")   --Loading up the main menu song to play
	love.audio.play(mainMenuMusic)
	
end

function creditScreenResources()      --Loading resources for the credit screen
	csbgimg = love.graphics.newImage("//resources//troll.png" )	
	credits = love.graphics.newImage("//resources//credits.png" )
	fx.lightrays:send( "exposure", 0.21 ) --.3
	fx.lightrays:send( "decay", 0.95 )
	fx.lightrays:send( "density", 0.04  ) --.4
	fx.lightrays:send( "weight", 0.2  ) --.25
	fx.lightrays:send( "lightPositionOnScreen", {0.5,0.5} )
	fx.lightrays:send( "NUM_SAMPLES", 50  )
end

function optionScreenResources()  --Loeading resources for the option screen
	miniLogo = love.graphics.newQuad(150, 644, 626, 476 ,100, 1024, 1024)
end

function gameResources()
   bg = love.graphics.newImage("basic_bg.png")
   running_images = {}
    for i=1,2,1 do
      running_images[i-1] = love.graphics.newImage("resources/running/run" .. i .. ".png")
    end
   running_images_axe = {}
    for i=1,2,1 do
      running_images_axe[i-1] = love.graphics.newImage("resources/runningaxe/run" .. i .. ".png")
    end
   running_images_gun = {}
    for i=1,2,1 do
      running_images_gun[i-1] = love.graphics.newImage("resources/runninggun/run" .. i .. ".png")
    end
    enemy_images = {}
    for i=1,4,1 do
      enemy_images[i-1] = love.graphics.newImage("resources/enemies/enemy" .. i .. ".png")
    end
   trollman = running_images[runFrame]
   idle = love.graphics.newImage("resources/idle.png")
   idleaxe = love.graphics.newImage("resources/idleaxe.png")
   idlegun = love.graphics.newImage("resources/idlegun.png")
   axe = love.graphics.newImage("resources/axe.png")
   gun = love.graphics.newImage("resources/gun.png")
end