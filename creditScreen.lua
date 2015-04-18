function creditScreenUpdate() 
		-- mousex = love.mouse.getX()
		-- mousey = love.mouse.getY()
		-- fx.lightrays:send( "lightPositionOnScreen", {(960-mousex)/960,1-(640-mousey)/640}  )
		fx.lightrays:send( "lightPositionOnScreen", {(960-math.random(1,960))/960,(640-math.random(1,640))/640}  )	
	if love.audio.getNumSources() == 0 then   --If the song stops, resume the song
		love.audio.play(mainMenuMusic)
	end
end

function exitCreditScreen()
		love.graphics.clear() --clear screen
		love.graphics.setPixelEffect() --We need to remove the effects before returning to the menu
		gameState = 0 --return to main menu on next draw
end

function creditsMenuDraw() 
		love.graphics.clear()
		love.graphics.setPixelEffect(fx.lightrays)
		love.graphics.draw(csbgimg, 0,0)
		love.graphics.setPixelEffect()
		love.graphics.draw(credits, 0,0)
end
