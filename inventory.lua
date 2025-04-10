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
    self.items[item.name] = item
end

function Inventory:tradeItem(otherInventory, itemName, quantity)
    if self.items[itemName] and self.items[itemName].quantity >= quantity then
        otherInventory:addItem(Item:new(itemName, self.items[itemName].type, quantity))
        self.items[itemName].quantity = self.items[itemName].quantity - quantity
    else
        print("Not enough items to trade.")
    end
end
