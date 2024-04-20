--Q2 - Fix or improve the implementation of the below method

function printSmallGuildNames(memberCount)
-- this method is supposed to print names of all guilds that have less than memberCount max members
	local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
	local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
	local guildName = result.getString("name")
	print(guildName)
end

--A2
--The previous function would only print out 1 guild name, if we want to print out all the small guild names, we would have to
	--iterate through all the rows we get in result
	--we also can just concatenate the sql select query with memberCount variable instead of formatting the string which is faster in our case
	--seeing that we are only concatenating one variable once, using string.format() would be better and faster if we want to do multiple
	--concatinations to our string.
function printSmallGuildNames(memberCount)
	--string concatenation is faster than string.format() when we are using a small number of strings
	local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < " .. memberCount 
	local resultId = db.storeQuery(selectGuildQuery)
	if resultId ~= false then --add a check if we have guilds in db before we start iterating through guilds
		--keep looping untill we manually break out of the while loop
		while true do 
			local guildName = result.getString(resultId, "name") --store the guild name from the current result into guildName
			print(guildName)
			--goes to the next row in result and breaks out of the loop if there is no next row ( result.next(resultId) == false )
			if not result.next(resultId) then 
				break
			end
		end
		--Clean up and free the global variable result. This should be freed up anytime we are done using it to avoid errors
		--when used elsewhere
		result.free(resultId) 
	else
		--Print a message when there are no guilds with less members than memberCount
		print("There are no guilds with less members than" .. memberCount)
	end
end