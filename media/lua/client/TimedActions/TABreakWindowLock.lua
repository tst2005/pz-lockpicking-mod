require('TimedActions/ISBaseTimedAction');

-- ------------------------------------------------
-- Local Variables
-- ------------------------------------------------

-- Access the mod utils.
require('luautils');

-- ------------------------------------------------
-- Global Variables
-- ------------------------------------------------

TABreakWindowLock = ISBaseTimedAction:derive("TABreakWindowLock");

-- ------------------------------------------------
-- Functions
-- ------------------------------------------------

---
-- The condition which tells the timed action if it
-- is still valid.
--
function TABreakWindowLock:isValid()
    local prim = self.character:getPrimaryHandItem();

    if prim:getName() ==  Translator.getDisplayItemName("Crowbar") then
        return true;
    else
        return false;
    end
end

---
-- Stops the Timed Action.
--
function TABreakWindowLock:stop()
    luautils.equipItems(self.character, self.storedPrim);
    ISBaseTimedAction.stop(self);
end

---
-- Is called when the time has passed.
--
function TABreakWindowLock:perform()
    local window = self.object;
    local player = self.character;
    local weapon = player:getPrimaryHandItem();
    local chance;

    if player:HasTrait("nimblefingers") then
        chance = 14;
    else
        chance = 12;
    end

    if ZombRand(chance) == 0 then
        -- We store the original door damage in a temporary variable.
        -- Then we set it to a high level to make sure the window is smashed.
        -- Finally we reset it to its original value.
        local temp = weapon:getDoorDamage();
        weapon:setDoorDamage(100);
        window:WeaponHit(player, weapon);
        weapon:setDoorDamage(temp);

        -- Add sound to the world so zombies get attracted.
        addSound(window, window:getSquare():getX(), window:getSquare():getY(), window:getSquare():getZ(), 12, 20);
    else
        -- Play custom mod-sound.
        getSoundManager():PlayWorldSound("rm_forceWindow2", false, window:getSquare(), 0, 10, 20, true);
        addSound(window, window:getSquare():getX(), window:getSquare():getY(), window:getSquare():getZ(), 8, 20);

        -- Unlock window & open it.
        window:setIsLocked(false);
        window:ToggleWindow(player);

        -- Make window unusable.
        window:setPermaLocked(true);
    end

    -- Add exhaustion to the character when he breaks a lock and damage his weapons.
    player:getStats():setEndurance(player:getStats():getEndurance() + 0.3);
    luautils.weaponLowerCondition(weapon, player, false);

    -- Re-equip the previous items after completing the action.
    luautils.equipItems(player, self.storedPrim);

    -- Remove Timed Action from stack.
    ISBaseTimedAction.perform(self);
end

---
-- Constructor
--
function TABreakWindowLock:new(_player, _window, _time, _storePrim)
    local o = {};
    setmetatable(o, self);
    self.__index = self;
    o.character = _player;
    o.object = _window;
    o.storedPrim = _storePrim;
    o.stopOnWalk = false;
    o.stopOnRun = false;
    o.maxTime = _time;
    return o;
end

--==================================================================================================
-- Created 20.09.13 - 12:34                                                                        =
--==================================================================================================
