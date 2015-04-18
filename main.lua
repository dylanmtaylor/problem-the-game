--[[
 main.lua
 GDC Game - Group 5
  Group: Rob, Steve, Chuck, Dylan, Chris, Sam
]]--

require("resourceControl")   
require("mainMenu")
require("optionMenu")
require("creditScreen")
require("pixeleffects")
require("game")

gameState = 0;   --Current game state stored as global variable, easy access.  0-MainMenu 9001-credits
function love.load()

	mainMenuResources()   --Loads the resources necessary for main menu   --resourceControl.lua
	creditScreenResources()  --Loads the resources necessary for the credits screen   --resourceControl.lua
	gameResources()
end

function love.update(dt)

	if gameState == 9001 then   --updating the screen effects of the credit menu  --credutMenu.lua
		creditScreenUpdate()
	elseif gameState == 9003 then --updating the game  --game.lua
		gameUpdate(dt)
	end

end

function love.draw()

	if gameState == 0  then
		mainMenuDraw()     --Function to draw main menu stuff  --mainMenu.lua
	elseif gameState == 9001 then
		creditsMenuDraw()   --Function to draw the credit menu stuff --creditScreen.lua
	elseif gameState == 9002 then   
		optionMenuDraw()   --function to draw the option menu stuff --optionScreen.lua
	elseif gameState == 9003 then 
		gameDraw() --function to draw the game -- game.lua
	end

end

function love.keypressed(key)

	if gameState == 0 then
		mainMenuKeys(key)     --Function to use key maps for main menu --mainMenu.lua
	elseif gameState == 9001 then
		exitCreditScreen() --Function to use key maps from credits menu, any key exits the credits screen.  --creditScreen.lua
	elseif gameState == 9002 then
		optionScreenKeys(key)   --Function to map user keys to the option pane map   --optionMenu.lua
	elseif gameState == 9003 then
		gameKeys(key)   --Function to map user keys to the game   --game.lua
	end

end
