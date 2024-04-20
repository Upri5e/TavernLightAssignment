--Q1 - Fix or improve the implementation of the below methods
local function releaseStorage(player) --This is not safe, player might be nil before this is called
	player:setStorageValue(1000, -1)
end

function onLogout(player)
	if player:getStorageValue(1000) == 1 then -- If for whatever reason this storage key gets to be 0 || > 1 then it will never release storage
		addEvent(releaseStorage, 1000, player) 
	end
	return true
end

--A1
--In order to releaseStorage of a player we need to make sure we do so before the player logsout. We also need to change the parameter from player
	--object to a playerId, that would avoid any problems if the player was removed.
local function releaseStorage(playerId) --we change the function argument to playerId to avoid sendin a nil object
	local player = Player(playerId) --we try to get player from playerId, if doesnt exist we exit the function
	if not player then
		return
	end
	player:setStorageValue(1000, -1) --reset player storage value
end
function onLogout(player)
	if player:getStorageValue(1000) >= 0 then -- The storage key should release if it has a value in it ( >= 0 )
		addEvent(function() 
			releaseStorage(playerId)
			--after the event executes and the storage is release, we call doRemoveCreature to logout the player
			doRemoveCreature(playerId)
		end, 1000)
		return false --we have to return false here so that the player doesnt logout before the event executes, we are handling loging out again above
	end
	return true
end

