require("enemy")
require("attack")
require("weapon")

function initGame() --run when game option is selected in the main menu
	playerX = 0
	initialPlayerY = 425
	playerY = initialPlayerY
	delta = 150
	runFrame = 0.0
	jumping = false
	jumpLeft = 0.0
	jumpStep = .04 
	jumpAmount = 350 -- this should remain constant.
	flip = false --when we are heading to the right, we want our troll guy to be facing the other way.
	score = 0.0
	playerHealth = 5
	enemies = {}
	enemyCount = 0
	initialCountdown = 100
	enemiesKilled = 0
	enemyCountdown = initialCountdown --countdown until enemy is spawned. Starts low, will become higher later.
	enemyOffset = 500 --how close we spawn the enemy to the player. the lower this value is, the harder the game becomes.
	enemySpeed = 1 --This is how fast enemies will move. Making this higher than player speed makes game nearly impossible to survive.
	maxEnemies = 20 --limit how many enemies we will have chasing after the player at once. The more the merrier...?
	hasAxe = false
	hasGun = false
	weaponArray = {}
	weaponNum = 0
	enableCheats = true
end

function gameDraw()
  		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight()) --because we want a white background
		if (playerHealth > 0) then
			love.graphics.draw(bg, 0, 0)
		   if flip then
			love.graphics.draw(trollman, (love.graphics.getWidth()/2) + (trollman:getWidth()/2), playerY - (trollman:getHeight()/2), 0, -1, 1)
		   else
			love.graphics.draw(trollman, (love.graphics.getWidth()/2) - (trollman:getWidth()/2), playerY - (trollman:getHeight()/2), 0, 1, 1)
		   end

		   	for i, e in ipairs(enemies) do --it is worth mentioning that lua tables start with an index of 1, not 0. took me a while to figure that one out.
				if (e[1] - ((trollman:getWidth()/2)) < (love.graphics.getWidth()/2) - (trollman:getWidth()) - 5) then
 					love.graphics.draw(enemy_images[e[3]-1], (love.graphics.getWidth()/2) + e[1], e[2] - 55, 0, -1, 1)
				else
 					love.graphics.draw(enemy_images[e[3]-1], e[1], e[2] - 55, 0, 1, 1)
 				end
			end

			for i, e in ipairs(weaponArray) do   --Weapon spawning animation
				if (e[1] == 1) then
 					love.graphics.draw(axe, e[2], e[3])
 				end
				if (e[1] == 2) then
 					love.graphics.draw(gun, e[2], e[3])
 				end
			end		

			--need to draw the HUD last so that they are on top
			love.graphics.setColor(0, 0, 0, 120)
			love.graphics.rectangle("fill", 6, 10, 330, 120) --because we want a white background
			love.graphics.setColor(160, 160, 160, 240)
			love.graphics.print("HEALTH:" .. gimmeHealth(playerHealth),16,15)
			love.graphics.print("SCORE: " .. string.format("%07d",score),16,50)
			love.graphics.print("SPAWN IN: " .. enemyCountdown,16,85)
		else
			love.graphics.print("YOU ARE DEAD. :(", 275, 200)
			love.graphics.print("ENEMIES KILLED: " .. string.format("%5d",enemiesKilled), 245, 290)
			love.graphics.print("FINAL SCORE: " .. string.format("%7d",score), 245, 350)
			love.graphics.print("PRESS ENTER TO RESPAWN.", 200, 450)
		end
end

function gimmeHealth(playerHealth)
  --this is somewhat poorly coded, but it works. 
  local formatted = ""
  local amount = 0
  while amount < playerHealth do
  	formatted = formatted .. "*"
  	amount = amount + 1
  end
  return formatted

end

function randomSpawnWeapon() 
	local n = math.random()
	if (n < .0009) then -- .09 % spawn rate
		local w = math.random() 
			if (w > .25) then
				spawnWeapon(1) -- axe
			else
				spawnWeapon(2) -- gun
			end		
	end
end

function randomNegative() --returns either 1 or -1, randomly; useful for game logic
	local n = math.random()
	if (n > .5) then
		return 1
	else 
		return -1
	end
end

function gameUpdate(dt)

	-- make that music repeat
	if love.audio.getNumSources() == 0 then   --If the song stops, resume the song
		love.audio.play(mainMenuMusic)
	end

	if (playerHealth > 0) then -- don't do any of this stuff if the player is dead
		score = score + .01 -- we add points to the score just for surviving. this works out to roughly one point a second, or according to a stopwatch, every .8 seconds.
		randomSpawnWeapon() 
		updateAnimations(dt)
		handlePlayerMovement(dt)
		handleEnemyMovement(dt)
		spawnEnemies()
		handlePlayerDeath() --TODO
		dropWeapon()--weapon dropping animation
	end

end

function handlePlayerMovement(dt)

	--update jumping
	if (jumping) then
		jumpLeft = jumpLeft - jumpStep
		playerY = playerY + (jumpAmount * jumpStep)
		if (jumpLeft <= 0.0) then
			--playerY = playerY - jumpAmount
			jumping = false
		end
	end

	--simple up/down, left/right logic as well as logic to determine whether or not we are running
	if ((not hasAxe) and (not hasGun)) then
		trollman = running_images[math.floor(runFrame)]
	elseif(hasGun) then
		trollman = running_images_gun[math.floor(runFrame)]
	elseif(hasAxe) then
		trollman = running_images_axe[math.floor(runFrame)]
	end
    if love.keyboard.isDown("left") then
		flip = false
		-- conditional statement ensures that we don't draw outside the area of our background image
		--if X < 0 then
				playerX = playerX + (delta*dt)
				for i, e in ipairs(enemies) do
					e[1] = e[1] + (delta*dt)
				end
				for i, e in ipairs(weaponArray) do  --Adjusting weapons position
					e[2] = e[2] + (delta*dt)
				end

		--end  
    elseif love.keyboard.isDown("right") then
		flip = true
		-- conditional statement ensures that we don't draw outside the area of our background image
		--if X > (-1 * (bg:getWidth() - love.graphics.getWidth())) then
				playerX = playerX - (delta*dt)  
				for i, e in ipairs(enemies) do
					e[1] = e[1] - (delta*dt)
				end
				for i, e in ipairs(weaponArray) do   --Adjusting weapons position
					e[2] = e[2] - (delta*dt)
				end
		--end
	else
		if (hasAxe) then 
			trollman = idleaxe
		elseif (hasGun) then
			trollman = idlegun
		else
			trollman = idle
		end
	end

end

function updateAnimations(dt)

	--update running animation	
	if (runFrame < 1.9) then
		runFrame = runFrame + .1
	else
		runFrame = 0.0
	end
end

function handlePlayerDeath()

end

function gameKeys(key) -- key constants: https://love2d.org/wiki/KeyConstant

	if key == "backspace" then
		gameState = 0 
	elseif (key == " ") then
		if (enemyCount > 0) then
			if (hasGun) then
				attackGun(closest())
			elseif (hasAxe) then
				attackAxe(closest())
			end
		end
	elseif (key == "up") then -- (space bar)
		if (not jumping) then
			jumping = true
			jumpLeft = 1.0
			playerY = playerY - jumpAmount
		end
	elseif key == "delete" and enableCheats then
		if (playerHealth > 0) then
			playerHealth = playerHealth - 1
		end
	elseif key == "insert" and enableCheats then
		if (playerHealth < 5) then
			playerHealth = playerHealth + 1
		end
	elseif key == "pageup" and enableCheats then
		hasAxe = true
		hasGun = false
	elseif key == "pagedown" and enableCheats then
		hasAxe = false
		hasGun = true
	elseif key == "end" and enableCheats then
		hasAxe = false
		hasGun = false
	end
	if (playerHealth <= 0) then
		if (key == "return") then --if space is pressed while the player is dead, start a new game
			initGame()
		end
	end

end
