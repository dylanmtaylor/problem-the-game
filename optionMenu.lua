--[[
 optionMenu.lua
 GDC Game - Group 5
  Group: Rob, Steve, Chuck, Dylan, Chris, Sam
]]--

function optionMenuDraw()   --Drawining the option menu
	love.graphics.clear()
	love.graphics.draw(bgimg, miniLogo,  430, 10)
end


function optionScreenKeys(key)  --Mapping keys for the options menu

	if key == "backspace" then
		gameState = 0
	end

end
