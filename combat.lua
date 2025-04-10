function NPCSurvivor:fight(zombie)
    local damageToZombie = math.random(15, 25)
    if math.random() < self.criticalHitChance then
        damageToZombie = damageToZombie * 2
    end

    local damageToNPC = math.random(5, 10)
    self.health = self.health - damageToNPC

    if self.health <= 0 then
        self:die()
    end
end
