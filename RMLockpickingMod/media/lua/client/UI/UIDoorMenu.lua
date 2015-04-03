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

require('luautils');

-- ------------------------------------------------
-- Local Functions
-- ------------------------------------------------

---
-- Tests if the door is open, locked or barricaded or inside of a house.
-- @param door - The door to check.
-- @return - False if it is open, barricaded or not locked.
--
local function isValidDoor(door)
    if not door then
        return false;
    elseif door:IsOpen() then
        return false;
    elseif not door:isLocked() then
        return false;
    elseif not door:getBarricade() == 0 then
        return false;
    --elseif not door:getSquare():getProperties():Is(IsoFlagType.exterior) then
        --print("Door is inside of house.");
        --return false;
    else
        return true;
    end
end

---
-- This function calculates the time it will take to break
-- the lock. Then it walks the player to the door, equips
-- the crowbar and starts the timed action to break the
-- lock.
-- @param worldObjects - List of all clicked items.
-- @param door - The door to open.
-- @param player - The active player.
--
local function breakLock(worldObjects, door, player)
    local modData = door:getModData();
    local time = 50 + (modData.lockLevel + 1) * 10;

    -- Traits affect the length of the lockbreaking.
    if player:HasTrait("nimblefingers") then
        time = 10;
    elseif player:HasTrait("Strong") or player:HasTrait("Handy") then
        time = time - ZombRand(30);
    elseif player:HasTrait("Weak") or player:HasTrait("Nimble") then
        time = time + ZombRand(40);
    end

    -- Walk to the door and start the Timed Action.
    if luautils.walkToObject(player, door) then
        local primItem, scndItem = luautils.equipItems(player, "Base.Crowbar");

        ISTimedActionQueue.add(TABreakDoorLock:new(player, door, time, primItem, scndItem));
    end
end

---
-- @param _worldObjects
-- @param _door
-- @param _player
--
local function pickLock(_worldObjects, _door, _player)
    local door = _door;
    local modData = door:getModData();

    -- If the lock is broken, we display a modal and end the function here.
    if modData.lockLevel == 6 then
        luautils.okModal(Lockpicking_Text.brokenLockModal, true);
        return;
    end

    local player = _player;
    local time = 150 + (modData.lockLevel + 1) * 10 + ZombRand(75);

    -- Traits affect the length of the lockpicking.
    if player:HasTrait("nimblefingers") then
        time = time - 50 - ZombRand(50);
    elseif player:HasTrait("Handy") then
        time = time - ZombRand(50);
    end

    if luautils.walkAdjWindowOrDoor(player, door:getSquare(), door) then
        -- Walk to the door and start the Timed Action.
        local primItem, scndItem = luautils.equipItems(player, "Base.Screwdriver", "Lockpicking.BobbyPin");

        ISTimedActionQueue.add(TAPickDoorLock:new(player, door, time, primItem, scndItem));
    end
end


---
-- Creates the context menu entries for lockpicking and
-- lockbreaking. If the selected door doesn't have a lockLevel
-- yet it assigns a random one to it.
-- @param _player - The player who clicked the door.
-- @param _context - The context menu.
-- @param _worldObjects - A list of clicked items.
--
local function createMenuEntries(_player, _context, _worldObjects)
    local door;
    local modData;

    -- Search through the table of clicked items.
    for _, object in ipairs(_worldObjects) do
        -- Look if the clicked item is of type door.
        if instanceof(object, "IsoDoor") or (instanceof(object, "IsoThumpable") and object:isDoor()) then
            door = object;
            break;
        end
    end

    -- Test if we have a valid door to open.
    if isValidDoor(door) == false then
        print("No valid door to open.");
        return false;
    else
        -- Load the doors mod data.
        modData = door:getModData();
        modData.lockLevel = modData.lockLevel or 0;

        -- If we have no lock level yet, assign one.
        if modData.lockLevel == 0 then
            modData.lockLevel = ZombRand(5) + 1;
        end
    end

    local player = getSpecificPlayer(_player);
    local inventory = player:getInventory();
    local context = _context;

    -- Add context option for breaking the lock.
    if inventory:contains("Crowbar") then
        local primItem = inventory:FindAndReturn("Crowbar");

        if not primItem or primItem:getCondition() <= 0 then
            print("No valid crowbar");
        else
            context:addOption(Lockpicking_Text.contextBreakDoorLock .. " (" .. Lockpicking_Text.lockLevels[modData.lockLevel] .. ")", _worldObjects, breakLock, door, player);
        end
    end

    -- Add context option for picking the lock.
    if inventory:contains("Screwdriver") and inventory:contains("BobbyPin") then
        local primItem = inventory:FindAndReturn("Screwdriver");
        local scndItem = inventory:FindAndReturn("BobbyPin");

        if not primItem or primItem:getCondition() <= 0 or not scndItem or scndItem:getCondition() <= 0 then
            print("No valid screwdriver / bobby pin");
        else
            context:addOption(Lockpicking_Text.contextPickDoorLock .. " (" .. Lockpicking_Text.lockLevels[modData.lockLevel] .. ")", _worldObjects, pickLock, door, player);
        end
    end
end

-- ------------------------------------------------
-- Game hooks
-- ------------------------------------------------

Events.OnFillWorldObjectContextMenu.Add(createMenuEntries);

--==================================================================================================
-- Created 15.07.13 - 17:14                                                                        =
--==================================================================================================
