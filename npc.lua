-- npc.lua

require 'behaviors'

NPCSurvivor = {}
NPCSurvivor.__index = NPCSurvivor

function NPCSurvivor:new(name, x, y)
    local npc = {
        name = name,
        health = 100,
        food = 0,
        hungerThreshold = 20,
        position = { x = x, y = y },
        detectionRange = 50,
        zombies = {},
        state = State.SEARCHING_FOR_FOOD,
        leader = nil,
        followers = {},
        weapon = nil,
        criticalHitChance = 0.2, -- 20% chance for a critical hit
        path = {}, -- Stores the path for movement
    }
    setmetatable(npc, self)
    npc.behaviorTree = BehaviorTree:new(npc:setupBehaviorTree())
    return npc
end

-- (Include all other NPC methods here, such as setupBehaviorTree, searchForFood, detectNearbyZombies, etc.)
