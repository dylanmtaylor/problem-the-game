function spawnWeapon(weaponChoice)
	randXSpawn = math.random(-300,1260)   --Spawning randoom number from 
	--weaponChoice(Axe/Gun), randXSpawn(random X Spawn), Y Coord
	table.insert(weaponArray,{weaponChoice,randXSpawn, 0})

end

function dropWeapon()     --Updating weapons position

	for i, e in ipairs(weaponArray) do
		if (e[3] < initialPlayerY - (trollman:getHeight()/2)) then
			e[3] = e[3] + enemySpeed
		elseif (e[3] == initialPlayerY - (trollman:getHeight()/2)) then
			--print("Y on line")
			weaponPickUp(i,e)
		elseif (e[3] >= initialPlayerY - (trollman:getHeight()/2)) then
			--print("Y past line")
			e[3] = initialPlayerY - (trollman:getHeight()/2)	
			weaponPickUp(i,e)
		end	
	end
		
end

function weaponPickUp(i,e)  --Removes weapon if picked up
	--print("pickup")
	if ((e[2] - ((trollman:getWidth()/2)) > (love.graphics.getWidth()/2) - (trollman:getWidth()) - 15) and 
		((e[2] - ((trollman:getWidth()/2)) < (love.graphics.getWidth()/2) - (trollman:getWidth()) + 15))) then
		if (e[1] == 1) then
			hasGun = false
			hasAxe = true
			table.remove(weaponArray,i)
		else			
			hasAxe = false
			hasGun = true
			table.remove(weaponArray,i)
		end
	end
end

