require 'npc'
require 'behaviors'
require 'pathfinding'
require 'combat'
require 'environment'
require 'settings'
require 'events'
require 'relationships'
require 'inventory'
require 'quests'
require 'factions'
require 'group_behaviors'
require 'stealth'
require 'health'

local MAX_NPCS = 10 -- Move configurable values to constants
local SPAWN_RADIUS = 50

function spawnNPCs()
    globalNPCList = {} -- Ensure the NPC list is initialized globally
    for i = 1, MAX_NPCS do
        local safeZone = SAFE_ZONES[math.random(1, #SAFE_ZONES)]
        local randomX = safeZone.x + math.random(-SPAWN_RADIUS, SPAWN_RADIUS)
        local randomY = safeZone.y + math.random(-SPAWN_RADIUS, SPAWN_RADIUS)

        local personalityType = math.random(1, #NPC_PERSONALITIES)
        local survivor = NPCSurvivor:new("Survivor" .. i, randomX, randomY, personalityType)
        table.insert(globalNPCList, survivor)

        if i == 1 then
            survivor.isLeader = true
        end
    end
end

function onGameStart()
    spawnNPCs()

    Events.OnTick.Add(function()
        for _, npc in ipairs(globalNPCList) do
            if npc and npc.behaviorTree then
                npc.behaviorTree:run(npc)
            end
        end
    end)
end

Events.OnGameStart.Add(onGameStart)
