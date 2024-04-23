
local steps = 5

function getTargetTile(creature, steps, variant)
    local positions = {} -- Reset positions 
    local currentPos = creature:getPosition() --Store current position as player start position
    local currentSteps = 0 --Variable to store the number of steps (tiles) that player can move
	--we start by checking every possible tile between player and the dash distance and store the successful ones in a table
    while currentSteps < steps do 
        currentSteps = currentSteps + 1 --Add a step and check if the next position is a tile, and is walkable
        currentPos:getNextPosition(creature:getDirection(), 1) --This stores the next position in currentPos

        --if the next position is not a tile || not walkable we break out of the while loop
        local tile = currentPos and Tile(currentPos)
        if not tile or not  tile:isWalkable() then
            break
        end
        --else we create a position with the values of the calculated currentPos and insert it into positions table in its respective index 
        positions[currentSteps] = Position(currentPos.x, currentPos.y, currentPos.z)
    end

    --When we break out of the while loop or go through all the successful steps, we iterate through the successful positions and addEvent to move the player 1 tile at a time with a delay
    for i = 1, #positions do
        addEvent(function()
            creature:teleportTo(positions[i]) --teleports the player to the position with 100 ms between each move
        end, 100 * i)
    end

end

function onCastSpell(creature, variant)
    getTargetTile(creature, steps, variant)
end
