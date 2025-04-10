BehaviorTree = {}
BehaviorTree.__index = BehaviorTree

function BehaviorTree:new(root)
    return setmetatable({ root = root }, self)
end

function BehaviorTree:run(npc)
    if self.root then
        self.root:execute(npc)
    end
end

BehaviorNode = {}
BehaviorNode.__index = BehaviorNode

function BehaviorNode:new(executeFunction)
    return setmetatable({ execute = executeFunction }, self)
end

SequenceNode = {}
SequenceNode.__index = SequenceNode

function SequenceNode:new(children)
    return setmetatable({ children = children }, self)
end

function SequenceNode:execute(npc)
    for _, child in ipairs(self.children) do
        if child:execute(npc) == "failed" then
            return "failed"
        end
    end
    return "completed"
end

FallbackNode = {}
FallbackNode.__index = FallbackNode

function FallbackNode:new(children)
    return setmetatable({ children = children }, self)
end

function FallbackNode:execute(npc)
    for _, child in ipairs(self.children) do
        if child:execute(npc) == "completed" then
            return "completed"
        end
    end
    return "failed"
end
