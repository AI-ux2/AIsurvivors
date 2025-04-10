-- inventory.lua

Item = {}
Item.__index = Item

function Item:new(name, type, quantity)
    return setmetatable({ name = name, type = type, quantity = quantity }, self)
end

Inventory = {}
Inventory.__index = Inventory

function Inventory:new()
    return setmetatable({ items = {} }, self)
end

function Inventory:addItem(item)
    if self.items[item.name] then
        self.items[item.name].quantity = self.items[item.name].quantity + item.quantity
    else
        self.items[item.name] = item
    end
    print(item.quantity .. " " .. item.name .. " added to inventory.")
end

function Inventory:removeItem(itemName, quantity)
    if self.items[itemName] then
        if self.items[itemName].quantity >= quantity then
            self.items[itemName].quantity = self.items[itemName].quantity - quantity
            if self.items[itemName].quantity == 0 then
                self.items[itemName] = nil
            end
            print(quantity .. " " .. itemName .. " removed from inventory.")
        else
            print("Not enough " .. itemName .. " to remove.")
        end
    else
        print(itemName .. " does not exist in inventory.")
    end
end

function Inventory:tradeItem(otherInventory, itemName, quantity)
    if self.items[itemName] and self.items[itemName].quantity >= quantity then
        otherInventory:addItem(Item:new(itemName, self.items[itemName].type, quantity))
        self:removeItem(itemName, quantity)
    else
        print("Not enough items to trade.")
    end
end

function Inventory:listItems()
    for name, item in pairs(self.items) do
        print(item.quantity .. " x " .. name .. " (" .. item.type .. ")")
    end
end

