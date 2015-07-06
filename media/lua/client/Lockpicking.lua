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

-- General mod info
local MOD_ID = "RMLockpicking";
local MOD_NAME = "Lockpicking";
local MOD_VERSION = "1.0.0";
local MOD_AUTHOR = "RoboMat";
local MOD_DESCRIPTION = "Adds lock-picking and door-breaking mechanics to the game.";
local MOD_URL = "http://theindiestone.com/forums/index.php/topic/33-"

local debugItems = false;

---
-- Add some items to the player's inventory for testing purposes.
--
local function giveItems()
	if debugItems then
		local player = getSpecificPlayer(0);
		player:getInventory():AddItem("Base.Crowbar");
		local cr = player:getInventory():AddItem("Base.Crowbar");
		cr:setCondition(0);
		player:getInventory():AddItem("Base.Screwdriver");
		local sc = player:getInventory():AddItem("Base.Screwdriver");
		sc:setCondition(0);
		player:getInventory():AddItem("Lockpicking.BobbyPin");
		player:getInventory():AddItem("Lockpicking.BobbyPin2");

		player:getInventory():AddItem("Base.Paperclip");
	end
end

-- ------------------------------------------------
-- Game hooks
-- ------------------------------------------------

Events.OnGameStart.Add(giveItems);

--==================================================================================================
-- Created 15.07.13 - 16:58                                                                        =
--==================================================================================================
