-- environment.lua

function NPCSurvivor:openDoor(door)
    -- Implement door-opening logic
    print(self.name .. " opens the door.")
end

function NPCSurvivor:lootContainer(container)
    -- Implement looting logic
    print(self.name .. " loots the container.")
end

function NPCSurvivor:setBarricade(location)
    -- Implement barricade-setting logic
    print(self.name .. " sets up a barricade at " .. tostring(location.x) .. ", " .. tostring(location.y))
end
