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

require('Items/SuburbsDistributions');

-- ------------------------------------------------
-- Local Functions
-- ------------------------------------------------

local function initLootDistribution()
	-- Bobby Pin
	table.insert(SuburbsDistributions["all"]["bin"].items, "Lockpicking.BobbyPin");
	table.insert(SuburbsDistributions["all"]["bin"].items, 1);
	table.insert(SuburbsDistributions["all"]["counter"].items, "Lockpicking.BobbyPin");
	table.insert(SuburbsDistributions["all"]["counter"].items, 1);
	table.insert(SuburbsDistributions["all"]["inventorymale"].items, "Lockpicking.BobbyPin");
	table.insert(SuburbsDistributions["all"]["inventorymale"].items, 1);
	table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "Lockpicking.BobbyPin");
	table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 2);
	table.insert(SuburbsDistributions["all"]["desk"].items, "Lockpicking.BobbyPin");
	table.insert(SuburbsDistributions["all"]["desk"].items, 3);
	table.insert(SuburbsDistributions["all"]["filingcabinet"].items, "Lockpicking.BobbyPin");
	table.insert(SuburbsDistributions["all"]["filingcabinet"].items, 1);
	table.insert(SuburbsDistributions["all"]["officedrawers"].items, "Lockpicking.BobbyPin");
	table.insert(SuburbsDistributions["all"]["officedrawers"].items, 1);
	table.insert(SuburbsDistributions["kitchen"]["counter"].items, "Lockpicking.BobbyPin");
	table.insert(SuburbsDistributions["kitchen"]["counter"].items, 1);
	table.insert(SuburbsDistributions["bathroom"]["all"].items, "Lockpicking.BobbyPin");
	table.insert(SuburbsDistributions["bathroom"]["all"].items, 2);
	table.insert(SuburbsDistributions["shed"]["counter"].items, "Lockpicking.BobbyPin");
	table.insert(SuburbsDistributions["shed"]["counter"].items, 1);
	table.insert(SuburbsDistributions["shed"]["other"].items, "Lockpicking.BobbyPin");
	table.insert(SuburbsDistributions["shed"]["other"].items, 1);
	table.insert(SuburbsDistributions["motelbedroom"]["wardrobe"].items, "Lockpicking.BobbyPin2");
	table.insert(SuburbsDistributions["motelbedroom"]["wardrobe"].items, 1);

	-- Bobby Pin2
	table.insert(SuburbsDistributions["all"]["bin"].items, "Lockpicking.BobbyPin2");
	table.insert(SuburbsDistributions["all"]["bin"].items, 1);
	table.insert(SuburbsDistributions["all"]["counter"].items, "Lockpicking.BobbyPin2");
	table.insert(SuburbsDistributions["all"]["counter"].items, 1);
	table.insert(SuburbsDistributions["all"]["inventorymale"].items, "Lockpicking.BobbyPin2");
	table.insert(SuburbsDistributions["all"]["inventorymale"].items, 1);
	table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "Lockpicking.BobbyPin2");
	table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 2);
	table.insert(SuburbsDistributions["all"]["desk"].items, "Lockpicking.BobbyPin2");
	table.insert(SuburbsDistributions["all"]["desk"].items, 3);
	table.insert(SuburbsDistributions["all"]["filingcabinet"].items, "Lockpicking.BobbyPin2");
	table.insert(SuburbsDistributions["all"]["filingcabinet"].items, 1);
	table.insert(SuburbsDistributions["all"]["officedrawers"].items, "Lockpicking.BobbyPin2");
	table.insert(SuburbsDistributions["all"]["officedrawers"].items, 1);
	table.insert(SuburbsDistributions["kitchen"]["counter"].items, "Lockpicking.BobbyPin2");
	table.insert(SuburbsDistributions["kitchen"]["counter"].items, 1);
	table.insert(SuburbsDistributions["bathroom"]["all"].items, "Lockpicking.BobbyPin2");
	table.insert(SuburbsDistributions["bathroom"]["all"].items, 2);
	table.insert(SuburbsDistributions["shed"]["counter"].items, "Lockpicking.BobbyPin2");
	table.insert(SuburbsDistributions["shed"]["counter"].items, 1);
	table.insert(SuburbsDistributions["shed"]["other"].items, "Lockpicking.BobbyPin2");
	table.insert(SuburbsDistributions["shed"]["other"].items, 1);
	table.insert(SuburbsDistributions["motelbedroom"]["wardrobe"].items, "Lockpicking.BobbyPin2");
	table.insert(SuburbsDistributions["motelbedroom"]["wardrobe"].items, 1);

	-- Screwdriver
	table.insert(SuburbsDistributions["policestorage"]["metal_shelves"].items, "Base.Screwdriver");
	table.insert(SuburbsDistributions["policestorage"]["metal_shelves"].items, 3);
	table.insert(SuburbsDistributions["zippeestore"]["crate"].items, "Base.Screwdriver");
	table.insert(SuburbsDistributions["zippeestore"]["crate"].items, 1);
	table.insert(SuburbsDistributions["fossoil"]["crate"].items, "Base.Screwdriver");
	table.insert(SuburbsDistributions["fossoil"]["crate"].items, 2);
	table.insert(SuburbsDistributions["all"]["crate"].items, "Base.Screwdriver");
	table.insert(SuburbsDistributions["all"]["crate"].items, 1);
	table.insert(SuburbsDistributions["all"]["inventorymale"].items, "Base.Screwdriver");
	table.insert(SuburbsDistributions["all"]["inventorymale"].items, 2);
	table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "Base.Screwdriver");
	table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 1);
end

-- ------------------------------------------------
-- Game hooks
-- ------------------------------------------------

Events.OnGameBoot.Add(initLootDistribution);

--==================================================================================================
-- Created 14.07.13 - 16:02                                                                        =
--==================================================================================================