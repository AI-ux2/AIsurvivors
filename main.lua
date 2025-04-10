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

function spawnNPCs()
    globalNPCList = {} -- Global table to track NPCs
    local numNPCs = 0
    while numNPCs < MAX_NPCS do
        local safeZone = SAFE_ZONES[math.random(1, #SAFE_ZONES)]
        local randomX = safeZone.x

function Inventory:listItems()
    for name, item in pairs(self.items) do
        print(item.quantity .. " x " .. name .. " (" .. item.type .. ")")
    end
end
