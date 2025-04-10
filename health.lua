-- health.lua

function NPCSurvivor:takeDamage(damage)
    self.health = self.health - damage
    print(self.name .. " takes " .. damage .. " damage. Current health: " .. self.health)

    if self.health < 0 then
        self:die()
    end
end

function NPCSurvivor:die()
    print(self.name .. " has died!")
    -- Handle death logic
end

function NPCSurvivor:treatInjury()
    if self.health < 100 then
        self.health = 100
        print(self.name .. " has treated their injuries.")
    end
end
