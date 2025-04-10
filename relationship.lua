-- relationships.lua

Relationships = {}

function Relationships.new()
    return {
        friendships = {},
        hostilities = {},
    }
end

function Relationships:addFriend(npc1, npc2)
    self.friendships[npc1.name] = npc2.name
    print(npc1.name .. " and " .. npc2.name .. " are now friends!")
end

function Relationships:addHostility(npc1, npc2)
    self.hostilities[npc1.name] = npc2.name
    print(npc1.name .. " is hostile towards " .. npc2.name .. "!")
end
