function logHealth(npc)
    print(npc.name .. "'s current health is: " .. npc.health)
end

function logPositionalData(npc)
    print(npc.name .. " is located at: (" .. npc.position.x .. ", " .. npc.position.y .. ")")
end

function toggleDebugMode(isDebug)
    DEBUG_MODE = isDebug
end

function Inventory:listItems()
    for name, item in pairs(self.items) do
        print(item.quantity .. " x " .. name .. " (" .. item.type .. ")")
    end
end
