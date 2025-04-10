-- debugging.lua

function logHealth(npc)
    print(npc.name .. "'s current health is: " .. npc.health)
end

function logPositionalData(npc)
    print(npc.name .. " is located at: (" .. npc.position.x .. ", " .. npc.position.y .. ")")
end
