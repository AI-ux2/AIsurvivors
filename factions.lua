-- factions.lua

Faction = {}
Faction.__index = Faction

function Faction:new(name)
    return setmetatable({ name = name, members = {} }, self)
end

function Faction:addMember(npc)
    table.insert(self.members, npc)
    npc.faction = self.name
end

function Faction:removeMember(npc)
    for i, member in ipairs(self.members) do
        if member == npc then
            table.remove(self.members, i)
            npc.faction = nil
            break
        end
    end
end
