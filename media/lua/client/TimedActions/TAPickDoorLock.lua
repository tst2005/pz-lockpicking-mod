require('TimedActions/ISBaseTimedAction');
require('luautils');

-- ------------------------------------------------
-- Global Variables
-- ------------------------------------------------

TAPickDoorLock = ISBaseTimedAction:derive("TAPickDoorLock");

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local BASE_CHANCE = 14;

-- ------------------------------------------------
-- Local Functions
-- ------------------------------------------------

---
-- This function modifies the chance of picking the lock successfully.
-- The higher the chance value, the higher is the chance of success.
-- @param - The player trying to break the lock.
-- @param - The lock difficulty.
--
local function calculateChance(player, lockLevel)
    local chance = BASE_CHANCE - lockLevel;

    -- Calculate the panic modifier. Panic in PZ is stored as a float ranging
    -- from 0 to 100. We devide it by ten and then round it to have a "integer".
    local panicModifier = math.floor((player:getStats():getPanic() / 10) + 0.5);
    chance = chance - panicModifier;

    if player:HasTrait('nimblefingers') then
        chance = chance + 4;
    end
    if player:HasTrait('KeenHearing') then
        chance = chance + 2;
    elseif player:HasTrait('HardOfHearing') then
        chance = chance - 2;
    end
    if player:HasTrait('Lucky') then
        chance = chance + 2;
    elseif player:HasTrait('Unlucky') then
        chance = chance - 3;
    end

    return math.max(2, chance);
end

-- ------------------------------------------------
-- Public Functions
-- ------------------------------------------------

---
-- The condition which tells the timed action if it
-- is still valid.
--
function TAPickDoorLock:isValid()
    local player = self.character;
    local prim = player:getPrimaryHandItem():getName();
    local scnd = player:getSecondaryHandItem():getName();

    return prim == Translator.getDisplayItemName("Screwdriver") and scnd == Translator.getDisplayItemName("Bobby Pin");
end

---
-- Stops the Timed Action.
--
function TAPickDoorLock:stop()
    if self.sound then
        self.sound:stop();
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
    local chance = calculateChance(player, modData.lockLevel);

    self.sound:stop();

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

    if ZombRand(chance) == 0 then
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
-- @param character - The player to pick the lock.
-- @param object - The door to pick.
-- @param time - The time it takes to pick the lock.
-- @param storedPrimItem - The primary item that was equipped before starting the TA.
-- @param storedScndItem - The secondary item that was equipped before starting the TA.
--
function TAPickDoorLock:new(character, object, time, storedPrimItem, storedScndItem)
    local o = {};
    setmetatable(o, self);
    self.__index = self;
    o.character = character;
    o.object = object;
    o.storedPrim = storedPrimItem;
    o.storedScnd = storedScndItem;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    o.maxTime = time;
    return o;
end
