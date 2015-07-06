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

-- Access the mod utils.
require('luautils')

-- ------------------------------------------------
-- Local Functions
-- ------------------------------------------------

---
-- Checks if the window is valid for opening.
-- @param _window - The window to check.
--
local function isValidWindow(_window)
	local window = _window;

	if window == nil then
		return false;
	elseif window:IsOpen() then
		return false;
	elseif window:isSmashed() or window:isDestroyed() then
		return false;
	elseif not window:isLocked() then
		return false;
	elseif window:IsOpen() and window:isPermaLocked() then
		return false;
	elseif window:getBarricade() ~= 0 then
		return false;
	else
		return true;
	end
end

-- ------------------------------------------------
-- Create Timed Actions
-- ------------------------------------------------

---
-- Walks to the window, equips the item and then performs the
-- timed action to break open the window's lock.
-- @param _worldobjects - List of all clicked objects.
-- @param _window - The window to break open.
-- @param _player - The burglar.
--
local function forceWindow(_worldobjects, _window, _player)
	local time = 25;
	local player = _player;
	local window = _window;

	if luautils.walkToObject(player, window) then
		local storePrim = luautils.equipItems(player, "Base.Crowbar");
		ISTimedActionQueue.add(TABreakWindowLock:new(player, window, time, storePrim));
	end
end

---
-- Creates a new context menu entry for windows.
-- @param _player - The player that clicks on the window.
-- @param _context - The context menu to work with.
-- @param _worldobjects - A table containing all clicked objects.
--
local function createMenuEntries(_player, _context, _worldobjects)
	local window;

	-- Checks if the player has clicked on a window
	for _, object in ipairs(_worldobjects) do
		if instanceof(object, "IsoWindow") then
			window = object;
			break;
		end
	end

	-- Checks if the window is valid
	if not isValidWindow(window) then
		return;
	end

	-- Create the context menus.
	local player = getSpecificPlayer(_player);
	local inventory = player:getInventory();
	local context = _context;

	-- Breaking the lock
	if inventory:contains("Crowbar") then
		local prim = player:getInventory():FindAndReturn("Base.Crowbar");

		if not prim or prim:getCondition() <= 0 then
			print("No valid crowbar");
		else
			context:addOption(Lockpicking_Text.contextBreakWindowLock, _worldobjects, forceWindow, window, player);
		end
	end
end

-- ------------------------------------------------
-- Game hooks
-- ------------------------------------------------
Events.OnFillWorldObjectContextMenu.Add(createMenuEntries);

--==================================================================================================
-- Created 20.08.13 - 12:26                                                                        =
--==================================================================================================