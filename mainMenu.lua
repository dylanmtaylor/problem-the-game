--[[
 mainMenu.lua
 GDC Game - Group 5
  Group: Rob, Steve, Chuck, Dylan, Chris, Sam
]]--

	selection = 0  -- 0-> Start, 1->Options, 2-> HowTo, 3->About

function mainMenuDraw()
	love.graphics.setColor(255, 255, 255, 255) -- this fixes the main menu shading bug
	love.graphics.drawq(bgimg, menuQuad, 0, 0)  --Draws menu onto screen
	--love.graphics.print("SAMPLE TEXT",0,0)
	updateSelection()

end 

function mainMenuKeys(key)

	if key == "up" then   --Scrolling the menus with up/down keys
		if selection ~= 0 then    --Makes sure the player can not go off the screen
			selection = selection - 1
		end
	end
	
	if key == "down" then
		if selection ~= 3 then     --Makes sure the player can not go off screen
			selection = selection + 1
		end
	end
	if key == "return" then
		if selection == 3 then  --Enters into the credits pane
			gameState = 9001 
		elseif selection == 1 then  --Enters the option pane
			gameState = 9002
		elseif selection == 0 then  --Enters the game
			initGame()
			gameState = 9003
		end
	end

end

function updateSelection()

	if selection == 0 then   --Checking what currently is selected on the menu
		love.graphics.drawq(bgimg, startQuad, 417, 193)
	elseif selection == 1 then
		love.graphics.drawq(bgimg, optionsQuad, 405, 288)
	elseif selection == 2 then
		love.graphics.drawq(bgimg, howQuad, 391, 381)
	elseif selection == 3 then
		love.graphics.drawq(bgimg, aboutQuad, 410, 470)
	end
	
	if love.audio.getNumSources() == 0 then   --If the song stops, resume the song
		love.audio.play(mainMenuMusic)
	end
	
end
