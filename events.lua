-- events.lua

Events = {}
Events.triggers = {}

function Events.trigger(event_name, ...)
    if Events.triggers[event_name] then
        for _, callback in ipairs(Events.triggers[event_name]) do
            callback(...)
        end
    end
end

function Events.on(event_name, callback)
    if not Events.triggers[event_name] then
        Events.triggers[event_name] = {}
    end
    table.insert(Events.triggers[event_name], callback)
end

-- Example Event Response
Events.on("playerMakeNoise", function(...)
    -- Notify NPCs to investigate
    print("NPCs are alerted!")
end)
