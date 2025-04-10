-- stealth.lua

function NPCSurvivor:enterStealthMode()
    self.isStealthy = true
    print(self.name .. " is now in stealth mode.")
end

function NPCSurvivor:exitStealthMode()
    self.isStealthy = false
    print(self.name .. " has exited stealth mode.")
end
