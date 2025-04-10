-- settings.lua

MAX_NPCS = 10
SPAWN_RADIUS = 1000
SAFE_ZONES = {
    { x = 50, y = 50 },
    { x = 200, y = 200 },
    { x = 400, y = 400 },
}

NPC_PERSONALITIES = {
    { name = "Aggressive", combatBonus = 1.2 },
    { name = "Passive", combatBonus = 0.8 },
    { name = "Helpful", resourceBonus = 1.5 },
    { name = "Selfish", resourceBonus = 0.5 },
}
