--set up local arrays
local combats = {}

--Create the areas we want to iterate through
--Since there is a very specific way we want to play the patterns of this effect we have to create multiple areas and iterate through them
local areas = {
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 1, 0, 0, 0, 0, 0},
        {1, 0, 0, 2, 0, 0, 1},
        {0, 1, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 1, 0, 0, 0},
    },
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 1, 0, 0, 0, 1, 0},
        {1, 0, 0, 2, 0, 0, 1},
        {0, 1, 0, 1, 0, 1, 0},
        {0, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 1, 0, 0, 0},
    },
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 1, 0},
        {1, 0, 1, 2, 1, 0, 1},
        {0, 0, 0, 1, 0, 1, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
    },
    {
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 1, 0, 0, 0},
        {1, 0, 1, 2, 1, 0, 1},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
    },
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 1, 0, 0, 0, 0, 0},
        {1, 0, 1, 2, 1, 0, 1},
        {0, 1, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 1, 0, 0, 0},
    },
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 1, 0},
        {1, 0, 1, 2, 1, 0, 1},
        {0, 0, 0, 1, 0, 1, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
    },
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {1, 0, 1, 2, 1, 0, 1},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
    },
    {
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 1, 0, 0, 0},
        {1, 0, 1, 2, 1, 0, 1},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
    },
    {
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 1, 0, 1, 0, 0, 0},
        {1, 0, 1, 2, 1, 0, 1},
        {0, 1, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 1, 0, 0, 0},
    },
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 1, 0, 0, 0, 1, 0},
        {1, 0, 1, 2, 1, 0, 1},
        {0, 1, 0, 1, 0, 1, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 1, 0, 0, 0},
    },
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 1, 0},
        {0, 0, 1, 2, 1, 0, 0},
        {0, 0, 0, 1, 0, 1, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
    },
    {
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 1, 2, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
    },
}

--Create combat object and set its parameters
local function addCombat(area)
    local combat = Combat()
    combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
    combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
    combat:setArea(createCombatArea(area))

    function onGetFormulaValues(player, level, magicLevel)
        local min = (level / 5) + (magicLevel * 5.5) + 25
        local max = (level / 5) + (magicLevel * 11) + 50
        return -min, -max
    end
    combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
    return combat
end

--Create a combat for each aarea and add it to combats table
for i = 1, #areas do
    local combat = addCombat(areas[i])
    table.insert(combats, combat)
end


function onCastSpell(creature, variant)
    --Iterate through combats, addEvent to call each combat with a delay of 300 between each one
    for i = 1, #combats do
        addEvent(function() 
            combats[i]:execute(creature, variant) --Execute combat based on index 
        end, 300 * i)
    end
end