-- main.lua

-- Define the Behavior Tree class
BehaviorTree = {}
BehaviorTree.__index = BehaviorTree

function BehaviorTree:new(root)
    local obj = { root = root }
    setmetatable(obj, self)
    return obj
end

function BehaviorTree:run(npc)
    if self.root then
        return self.root:execute(npc)
    end
end

-- Define a basic Behavior Node class
BehaviorNode = {}
BehaviorNode.__index = BehaviorNode

function BehaviorNode:new(executeFunction)
    local node = { execute = executeFunction }
    setmetatable(node, self)
    return node
end

-- NPC Survivor class
NPCSurvivor = {}
NPCSurvivor.__index = NPCSurvivor

function NPCSurvivor:new(name, x, y)
    local npc = {
        name = name,
        health = 100,
        food = 0,
        hungerThreshold = 20,
        position = { x = x, y = y },
        detectionRange = 50, -- Range for detecting zombies
        zombies = {} -- Table to hold detected zombies
    }
    setmetatable(npc, self)
    npc.behaviorTree = BehaviorTree:new(npc:setupBehaviorTree())
    return npc
end

function NPCSurvivor:setupBehaviorTree()
    local findFood = BehaviorNode:new(function(npc)
        if npc.food < npc.hungerThreshold then
            print(npc.name .. " is searching for food.")
            npc:searchForFood()
            return "running"
        end
        return "completed"
    end)

    local eatFood = BehaviorNode:new(function(npc)
        if npc.food > 0 then
            print(npc.name .. " is eating food.")
            npc.food = npc.food - 1
            return "completed"
        end
        return "failed"
    end)

    local detectZombies = BehaviorNode:new(function(npc)
        npc:detectNearbyZombies()
        return "completed"
    end)

    local fightZombies = BehaviorNode:new(function(npc)
        if #npc.zombies > 0 then
            print(npc.name .. " is fighting zombies!")
            for _, zombie in ipairs(npc.zombies) do
                npc:fight(zombie)
            end
            return "completed"
        end
        return "failed"
    end)

    local sequence = BehaviorNode:new(function(npc)
        detectZombies.execute(npc) -- Detect zombies first
        if fightZombies.execute(npc) == "completed" then
            return "completed"
        elseif findFood.execute(npc) == "completed" then
            return eatFood.execute(npc)
        end
        return "failed"
    end)

    return sequence
end

function NPCSurvivor:searchForFood()
    -- Simple logic to simulate finding food
    print(self.name .. " found food!")
    self.food = self.food + 5 -- Increase food count
end

function NPCSurvivor:detectNearbyZombies()
    -- Get all zombie instances in the game
    local allZombies = getZombiesInGame() -- Placeholder function to get all zombies
    self.zombies = {} -- Reset detected zombies

    for _, zombie in ipairs(allZombies) do
        local distance = self:getDistanceToZombie(zombie)
        if distance <= self.detectionRange then
            table.insert(self.zombies, zombie) -- Add to detected zombies
            print(self.name .. " detected a zombie at distance: " .. distance)
        end
    end
end

function NPCSurvivor:getDistanceToZombie(zombie)
    -- Calculate distance to the zombie
    return math.sqrt((self.position.x - zombie.x)^2 + (self.position.y - zombie.y)^2)
end

function NPCSurvivor:fight(zombie)
    -- Basic combat logic when fighting a zombie
    print(self.name .. " attacks a zombie!")

    -- Simulate health damage to the NPC
    local damageToZombie = 20  -- Simplified damage to zombie (in a full system, reduce zombie health)
    local damageToNPC = 10      -- Damage NPC takes while attacking
    self.health = self.health - damageToNPC
    
    -- Check if the NPC is killed
    if self.health <= 0 then
        print(self.name .. " has been killed!")
    else
        print(self.name .. " takes " .. damageToNPC .. " damage, health is now: " .. self.health)
    end
end

-- Placeholder function to simulate getting all zombies in the game
function getZombiesInGame()
    -- In a full implementation, this would query the game world for existing zombie entities
    return {
        { x = 10, y = 20 }, { x = 15, y = 25 },
        { x = 40, y = 30 }, { x = 60, y = 70 }
    }
end

-- Game start hook to create and manage the NPC
function onGameStart()
    local survivor = NPCSurvivor:new("Survivor1", 0, 0)
    
    -- Simulating behavior tree execution in a game loop
    Events.OnGameStart.Add(function()
        while true do
            survivor.behaviorTree:run(survivor)
            coroutine.yield() -- Allow other game processes to continue
        end
    end)
end

-- Hook into the game's start event
Events.OnGameStart.Add(onGameStart)
