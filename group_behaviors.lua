-- group_behaviors.lua

function NPCSurvivor:gatherResources()
    print(self.name .. " is gathering resources as a group.")
    -- Implement gathering logic, different behaviors based on group size
end

function NPCSurvivor:performGroupActivity(activity)
    print(self.name .. " participates in group activity: " .. activity)
end
