-- combat.lua

function NPCSurvivor:fight(zombie)
    -- Simulate weapon use with critical hit chance
    local damageToZombie = 20
    if math.random() < self.criticalHitChance then
        damageToZombie = damageToZombie * 2 -- Critical hit doubles damage
        print(self.name .. " scored a critical hit!")
    end
    
    local damageToNPC = 10
    self.health = self.health - damageToNPC

    print(self.name .. " attacks a zombie! Zombie takes " .. damageToZombie .. " damage.")
    print(self.name .. " takes " .. damageToNPC .. " damage, health is now: " .. self.health)

    if self.health <= 0 then
        print(self.name .. " has been killed!")
    end
end
