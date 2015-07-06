--==================================================================================================
-- Copyright (C) 2014 by RoboMat                                                                   =
--                                                                                                 =
-- Permission is hereby granted, free of charge, to any person obtaining a copy                    =
-- of this software and associated documentation files (the "Software"), to deal                   =
-- in the Software without restriction, including without limitation the rights                    =
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell                       =
-- copies of the Software, and to permit persons to whom the Software is                           =
-- furnished to do so, subject to the following conditions:                                        =
--                                                                                                 =
-- The above copyright notice and this permission notice shall be included in                      =
-- all copies or substantial portions of the Software.                                             =
--                                                                                                 =
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR                      =
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,                        =
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE                     =
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER                          =
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,                   =
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN                       =
-- THE SOFTWARE.                                                                                   =
--==================================================================================================

require('TimedActions/ISBaseTimedAction');

-- ------------------------------------------------
-- Local Variables
-- ------------------------------------------------

-- Access the mod utils.
require('luautils');

-- ------------------------------------------------
-- Global Variables
-- ------------------------------------------------

TABreakDoorLock = ISBaseTimedAction:derive("TABreakDoorLock");

-- ------------------------------------------------
-- Functions
-- ------------------------------------------------

---
-- The condition which tells the timed action if it
-- is still valid.
--
function TABreakDoorLock:isValid()
    local prim = self.character:getPrimaryHandItem();

    if prim:getName() == Translator.getDisplayItemName("Crowbar") then
        return true;
    else
        return false;
    end
end

---
-- Stops the Timed Action and re-equips the previous
-- used items.
--
function TABreakDoorLock:stop()
    luautils.equipItems(self.character, self.storedPrim, self.storedScnd);
    ISBaseTimedAction.stop(self);
end

---
-- Is called when the time has passed.
--
function TABreakDoorLock:perform()
    local door = self.object;
    local tile = door:getSquare();
    local player = self.character;
    local item = player:getPrimaryHandItem();
    local chance;

    if player:HasTrait("nimblefingers") then
        chance = 12;
    else
        chance = 8;
    end

    -- Check if breaking the lock is successful.
    if ZombRand(chance) == 0 then
        -- Play world sound and add an attraction point for that sound to the world.
        getSoundManager():PlayWorldSound("sledgehammer", false, tile, 0, 20, 30, true);
        addSound(door, tile:getX(), tile:getY(), tile:getZ(), 15, 30);
    else
        -- Play world sound and add an attraction point for that sound to the world.
        getSoundManager():PlayWorldSound("crackwood", false, tile, 0, 10, 30, true);
        addSound(door, tile:getX(), tile:getY(), tile:getZ(), 10, 30);

        -- Open the door (silent).
        door:ToggleDoorSilent();
    end

    -- Damage weapon and update player stats.
    luautils.weaponLowerCondition(item, player, false);
    player:getStats():setEndurance(player:getStats():getEndurance() + 0.7);

    -- Re-equip the previous items after completing the action.
    luautils.equipItems(self.character, self.storedPrim, self.storedScnd);

    -- Remove Timed Action from stack.
    ISBaseTimedAction.perform(self);
end

---
-- Constructor
--
function TABreakDoorLock:new(_character, _object, _time, _primItem, _scndItem)
    local o = {};
    setmetatable(o, self);
    self.__index = self;
    o.character = _character;
    o.object = _object;
    o.storedPrim = _primItem;
    o.storedScnd = _scndItem;
    o.stopOnWalk = false;
    o.stopOnRun = false;
    o.maxTime = _time;
    return o;
end

--==================================================================================================
-- Created 23.09.13 - 12:35                                                                        =
--==================================================================================================
