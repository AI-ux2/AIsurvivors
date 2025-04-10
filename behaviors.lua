-- behaviors.lua

BehaviorTree = {}
BehaviorTree.__index = BehaviorTree

function BehaviorTree:new(root)
    local obj = { root = root }
    setmetatable(obj, self)
    return obj
end

function BehaviorTree:run(npc)
    if self.root then
        self.root:execute(npc)
    end
end

BehaviorNode = {}
BehaviorNode.__index = BehaviorNode

function BehaviorNode:new(executeFunction)
    local node = { execute = executeFunction }
    setmetatable(node, self)
    return node
end

-- Define NPC behavior methods outside of NPCSurvivor here
-- Implement function definitions for detecting zombies, fighting, etc.
