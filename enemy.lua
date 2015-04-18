function addEnemy(_x) -- _y) 
	--table.insert(enemies,{_x,_y})
	--x coordinate, y coordinat, enemy type
	table.insert(enemies,{_x,initialPlayerY - (trollman:getHeight()/2),math.ceil(math.random(4))})
end

function spawnEnemies()

	if (enemyCountdown > 0) then
		enemyCountdown = enemyCountdown - 1
	else
		if(enemyCount < maxEnemies) then
			enemyCount = enemyCount + 1
			addEnemy(((love.graphics.getWidth()/2) - (trollman:getWidth()/2)) + (randomNegative() * enemyOffset), ((love.graphics.getHeight()/2)  - (trollman:getHeight()/2)) + (randomNegative() *enemyOffset))
			enemyCountdown = initialCountdown * enemyCount
		end
	end
end

function handleEnemyMovement()

	for i, e in ipairs(enemies) do
		local xcollide = false
		local ycollide = false
		if (e[1] - ((trollman:getWidth()/2)) < (love.graphics.getWidth()/2) - (trollman:getWidth()) - 5) then --+ (trollman:getWidth()/2)
			e[1] = e[1] + enemySpeed
			--print(e[1])
		elseif (e[1] - ((trollman:getWidth()/2)) > (love.graphics.getWidth()/2) - (trollman:getWidth()) + 5) then --  - ((trollman:getWidth()/2))
			e[1] = e[1] - enemySpeed
			--print(e[1])
		else
			xcollide = true
		end
		if (e[2] - ((trollman:getHeight()/2)) < playerY -10) then
		--	e[2] = e[2] + enemySpeed
		elseif (e[2] - ((trollman:getHeight()/2)) > playerY +10) then
		--	e[2] = e[2] - enemySpeed
		else
			ycollide = true
		end
		-- if there is a collision
		if (xcollide and not jumping) then
			playerHealth = playerHealth - 1
			table.remove (enemies,i)
			enemyCount = enemyCount - 1
		end
		-- if the enemy is very far from the player and there is no chance of seeing the enemy (to prevent running away like a bitch)
		-- without this, it is possible to just run infinitely in one direction, and keep racking up points.
		if ((e[1] > 1000) or (e[1] < -1000)) then
			table.remove (enemies,i) --kill off this enemy
			enemyCountdown = enemyCountdown - 100 --make the next one spawn sooner
			enemyCount = enemyCount - 1 --decrease enemy count
		end
	end

end
