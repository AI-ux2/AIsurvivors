-- npc.lua

require 'behaviors'
require 'health'
require 'inventory'

NPCSurvivor = {}
NPCSurvivor.__index = NPCSurvivor

function NPCSurvivor:new(name, x, y, personalityType)
    local personality = NPC_PERSONALITIES[personalityType] or NPC_PERSONALITIES[1] -- Default to first personality
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
        personality = personality,
        baseCombat = 10 * personality.combatBonus,
        baseResourceEfficiency = 10 * personality.resourceBonus,
        behaviorTree = BehaviorTree:new(self:setupBehaviorTree()),
    }
    setmetatable(npc, self)
    return npc
end

function NPCSurvivor:setupBehaviorTree()
    local searchForFood = BehaviorNode:new(function(npc)
        if npc.food < npc.hungerThreshold then
            print(npc.name .. " is searching for food.")
            npc:searchForFood()
            npc.state = State.EATING
            return "completed"
        end
        return "failed"
    end)

    local eatFood = BehaviorNode:new(function(npc)
        if npc.food > 0 then
            print(npc.name .. " is eating food.")
            npc.food = npc.food - 1
            npc.state = State.DETECTING_ZOMBIES
            return "completed"
        end
        return "failed"
    end)

    local detectZombies = BehaviorNode:new(function(npc)
        print(npc.name .. " is detecting zombies.")
        npc:detectNearbyZombies()
        if #npc.zombies > 0 then
            npc.state = State.FIGHTING
            return "completed"
        end
        return "failed"
    end)

    local fightZombies = BehaviorNode:new(function(npc)
        if #npc.zombies > 0 then
            for _, zombie in ipairs(npc.zombies) do
                npc:fight(zombie)
            end
            return "completed"
        end
        return "failed"
    end)

    local flee = BehaviorNode:new(function(npc)
        print(npc.name .. " is fleeing!")
        npc:flee()
        return "completed"
    end)

    -- Follow the leader logic
    local follow = BehaviorNode:new(function(npc)
        if npc.leader then
            npc:followLeader()
            return "completed"
        end
        return "failed"
    end)

    local sequence = BehaviorNode:new(function(npc)
        if npc.health < 30 then
            npc.state = State.FLEEING
            flee.execute(npc)
        elseif npc.state == State.SEARCHING_FOR_FOOD then
            searchForFood.execute(npc)
        elseif npc.state == State.EATING then
            eatFood.execute(npc)
        elseif npc.state == State.DETECTING_ZOMBIES then
            detectZombies.execute(npc)
        elseif npc.state == State.FIGHTING then
            fightZombies.execute(npc)
        elseif npc.state == State.FOLLOWING then
            follow.execute(npc)
        end
        return "completed"
    end)

    return sequence
end

function NPCSurvivor:searchForFood()
    print(self.name .. " found food!")
    self.food = self.food + 5 -- Increase food count
end

function NPCSurvivor:detectNearbyZombies()
    local allZombies = getZombiesInGame() -- Placeholder function to get all zombies
    self.zombies = {}

    for _, zombie in ipairs(allZombies) do
        local distance = self:getDistanceToZombie(zombie)
        if distance <= self.detectionRange then
            table.insert(self.zombies, zombie) -- Add to detected zombies
            print(self.name .. " detected a zombie at distance: " .. distance)
        end
    end
end

function NPCSurvivor:getDistanceToZombie(zombie)
    return math.sqrt((self.position.x - zombie.x)^2 + (self.position.y - zombie.y)^2)
end

function NPCSurvivor:fight(zombie)
    local baseDamage = self.baseCombat
    local damageToZombie = baseDamage
    if math.random() < self.criticalHitChance then
        damageToZombie = damageToZombie * 2 -- Critical hit doubles damage
        print(self.name .. " scored a critical hit!")
    end
    
    local damageToNPC = 10
    self:takeDamage(damageToNPC)

    print(self.name .. " attacks a zombie! Zombie takes " .. damageToZombie .. " damage.")
end

function NPCSurvivor:flee()
    print(self.name .. " is escaping the situation!")
    -- Implement pathfinding logic to a safe location if necessary
end

function NPCSurvivor:followLeader()
    if self.leader then
        local leaderPos = self.leader.position
        -- Use a simple movement towards the leader
        self.position.x = leaderPos.x -- Adjust with more complex pathfinding if necessary
        self.position.y = leaderPos.y
        print(self.name .. " is following the leader to (" .. self.position.x .. ", " .. self.position.y .. ")")
    end
end
