function closest()
	local minimum = 9999999
	enemy = 1
	for i, e in ipairs(enemies) do
		if((math.abs(e[1] - 480-256)) < minimum) then
			local minimum = (math.abs(e[1] - 480-256))
			enemy = i
		end
	end
	print("enemy is set to " .. enemy)
	return enemy
end

function attackAxe(index)
	print("attack with axe; index is equal to " .. index  .. "; location: " .. enemies[index][1] .. "; playerX: " .. playerX)
	if((math.abs(enemies[index][1]) - 480) < 50) then
		if(flip and (enemies[index][1]) > 480-256) then
			table.remove (enemies,index)
			enemyCount = enemyCount - 1
			enemiesKilled = enemiesKilled + 1
			score = score + 100
		end
		if((not flip) and (enemies[index][1] < 480-256)) then
			table.remove (enemies,index)
			enemyCount = enemyCount - 1
			enemiesKilled = enemiesKilled + 1
			score = score + 100
		end
	end
end

function attackGun(index)
	print("attack with gun; index is equal to " .. index)
	if(flip and (enemies[index][1]) > 480-256) then
		table.remove (enemies,index)
		enemyCount = enemyCount - 1
		enemiesKilled = enemiesKilled + 1
		score = score + 100
	end
	if((not flip) and (enemies[index][1] < 480-256)) then
		table.remove (enemies,index)
		enemyCount = enemyCount - 1
		enemiesKilled = enemiesKilled + 1
		score = score + 100
	end
end