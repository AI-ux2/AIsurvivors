-- main.lua

-- Load other modules
require 'npc'
require 'behaviors'
require 'pathfinding'
require 'combat'
require 'environment'
require 'settings'

-- Function to spawn a new NPC at random safe locations
function spawnNPCs()
    local numNPCs = 0
    while numNPCs < MAX_NPCS do
        local safeZone = SAFE_ZONES[math.random(1, #SAFE_ZONES)]
        local randomX = safeZone.x + math.random(-SPAWN_RADIUS, SPAWN_RADIUS)
        local randomY = safeZone.y + math.random(-SPAWN_RADIUS, SPAWN_RADIUS)

        local survivor = NPCSurvivor:new("Survivor" .. numNPCs + 1, randomX, randomY)
        print(survivor.name .. " spawned at (" .. survivor.position.x .. ", " .. survivor.position.y .. ")")

        -- For this implementation, assign a random leader to the first NPC
        if numNPCs == 1 then
            survivor.leader = survivor -- The first NPC becomes a leader
        end
        numNPCs = numNPCs + 1
    end
end

-- Game start hook to create and manage the NPCs
function onGameStart()
    spawnNPCs() -- Spawn NPCs on game start

    -- Automatically manage the behavior of all spawned NPCs
    Events.OnGameStart.Add(function()
        while true do
            -- Uncomment when tracking NPCs
            -- for _, npc in ipairs(globalNPCList) do
            --     npc.behaviorTree:run(npc)
            -- end
            coroutine.yield() -- Allow other game processes to continue
        end
    end)
end

-- Hook into the game's start event
Events.OnGameStart.Add(onGameStart)
