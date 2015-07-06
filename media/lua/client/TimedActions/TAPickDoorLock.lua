require('TimedActions/ISBaseTimedAction');

-- ------------------------------------------------
-- Local Variables
-- ------------------------------------------------

-- Access the mod utils.
require('luautils');

-- ------------------------------------------------
-- Global Variables
-- ------------------------------------------------

TAPickDoorLock = ISBaseTimedAction:derive("TAPickDoorLock");

-- ------------------------------------------------
-- Functions
-- ------------------------------------------------

---
-- The condition which tells the timed action if it
-- is still valid.
--
function TAPickDoorLock:isValid()
    local player = self.character;
    local prim = player:getPrimaryHandItem();
    local scnd = player:getSecondaryHandItem();

    if prim:getName() == Translator.getDisplayItemName("Screwdriver") and scnd:getName() == Translator.getDisplayItemName("Bobby Pin") then
        return true;
    else
        return false;
    end
end

---
-- Stops the Timed Action.
--
function TAPickDoorLock:stop()
    if self.sound then
        getSoundManager():StopSound(self.sound);
    end

    luautils.equipItems(self.character, self.storedPrim, self.storedScnd);
    ISBaseTimedAction.stop(self);
end

---
-- Starts the Timed Action.
--
function TAPickDoorLock:start()
    self.sound = getSoundManager():PlayWorldSound("rm_loud_Lockpicking", false, self.object:getSquare(), 0, 10, 1, true);
end

---
-- Is called when the time has passed.
--
function TAPickDoorLock:perform()
    local player = self.character;
    local prim = player:getPrimaryHandItem();
    local scnd = player:getSecondaryHandItem();
    local door = self.object;
    local modData = door:getModData();
    local chance;

    -- Burglar Trait affects chances of successfully picking the lock.
    if player:HasTrait("nimblefingers") then
        chance = 16 - modData.lockLevel;
    else
        chance = 12 - modData.lockLevel;
    end

    -- Calculate the chance for successfully picking the lock
    if ZombRand(chance) == 0 then
        -- Save "broken lock" state in ModData
        modData.lockLevel = 6;
        door:setKeyId(10000002); -- invalidate keyId so the players key can no longer be used
        -- setKeyId is between 0 and 10000000
        getSoundManager():PlayWorldSound("doorlocked", door:getSquare(), 0, 10, 1, true);
    else
        door:ToggleDoorSilent();
        getSoundManager():PlayWorldSound("dooropen", door:getSquare(), 0, 10, 1, true);
    end

    -- Damage the items based on the conditionLowerChance.
    luautils.weaponLowerCondition(prim, player, true);

    if ZombRand(15) == 0 then
        player:Say(getText("UI_Text_BobbyStuck"));
        player:setSecondaryHandItem(nil); -- Remove Item from hand.
        scnd:getContainer():Remove(scnd); -- Remove Item from inventory.
    end

    -- Re-equip the previous items
    luautils.equipItems(self.character, self.storedPrim, self.storedScnd);

    -- remove Timed Action from stack
    ISBaseTimedAction.perform(self);
end

---
-- Constructor
--
-- @param _character - The player to pick the lock.
-- @param _object - The door to pick.
-- @param _time - The time it takes to pick the lock.
-- @param _storedPrimItem - The primary item that was equipped before starting the TA.
-- @param _storedScndItem - The secondary item that was equipped before starting the TA.
--
function TAPickDoorLock:new(_character, _object, _time, _storedPrimItem, _storedScndItem)
    local o = {};
    setmetatable(o, self);
    self.__index = self;
    o.character = _character;
    o.object = _object;
    o.storedPrim = _storedPrimItem;
    o.storedScnd = _storedScndItem;
    o.sound = nil;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    o.maxTime = _time;
    o.sound = nil;
    return o;
end

--==================================================================================================
-- Created 15.07.13 - 17:14                                                                        =
--==================================================================================================
