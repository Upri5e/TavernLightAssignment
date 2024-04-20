--Q3 - Fix or improve the name and the implementation of the below method

function do_sth_with_PlayerParty(playerId, membername)
	player = Player(playerId) --This can be made local to avoid changing any global references of player
	--We should be checking if player exists to avoid any errors
	local party = player:getParty()
	--We should be checking if party exists (player is in a party) to avoid any errors
	for k,v in pairs(party:getMembers()) do
		if v == Player(membername) then --We can store Player(membername) locally to avoid executing it multiple times
			party:removeMember(Player(membername))
			--Should return when the player is removed to avoid going through all members
		end
	end
end

--A3
--Looks like we are trying to remove a player from a party if they are in the same party as the playerId(ref player). 
--Seeing that getMembers() does not include the party leader
	--we have 2 options: 
				--Remove player from party only if they are a member, and NOT the party leader
				--Remove player from party whether they are the party leader or a member
--I will be removing the player from the party if they are a member or the party leader
function removeFromPlayersParty(playerId, membername)
	--Get the ref player. If doesnt exist we return
	local player = Player(playerId)
	if not player then
		print("No player with id: " .. playerId .. "exists!")
		return 
	end
	
	--Get the party the ref player is in. If not in a party we return
	local party = player:getParty()
	if not party then
		print(player:getName() .. "is not in a party!")
		return 
	end
	
	--Get the player we want to remove from the party
	local memberToRemove = Player(membername)	
	
	--If the player we want to remove is the leader of the party our ref player is in, remove from the party and return
	--If we want the player to only be removed if they are a member of a party and not the leader, we comment the below code
	if party:getLeader():getName() == membername then
		return party:removeMember(memberToRemove)
	end
	
	--If player we want to remove is not the party leader, we check if they are a member of our ref player party
	local partyMembers = party:getMembers()
	for k,v in pairs(partyMembers) do
		if v == memberToRemove then --If player is a member of the party, remove member then return to avoide iterating through the rest of members
			return party:removeMember(memberToRemove)
		end
	end
	
	--If we reach this part of the code then the player we want to remove is not in the same party as our ref player
	print(membername .. " is not a member of a party")
end
