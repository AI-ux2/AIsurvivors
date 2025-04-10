-- quests.lua

Quest = {}
Quest.__index = Quest

function Quest:new(name, description)
    return setmetatable({ name = name, description = description, completed = false }, self)
end

function Quest:complete()
    self.completed = true
    print(self.name .. " has been completed!")
end

function NPCSurvivor:requestQuest()
    local quest = Quest:new("Find Food", "Please bring me some food!")
    print(self.name .. " requests a quest: " .. quest.description)
    return quest
end
