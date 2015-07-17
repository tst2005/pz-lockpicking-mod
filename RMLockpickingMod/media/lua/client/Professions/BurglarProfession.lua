require('NPCs/MainCreationMethods');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local BURGLAR_ID = 'burglar';

local REGION_MULDRAUGH_ID = 'Muldraugh, KY';
local REGION_MULDRAUGH_SPAWNS = {
    { worldX = 35, worldY = 34, posX = 134, posY = 208 }, -- Prison Cell
    { worldX = 35, worldY = 32, posX = 129, posY =  87 }, -- Knox Bank
    { worldX = 35, worldY = 32, posX = 183, posY =  64 }, -- House
    { worldX = 36, worldY = 33, posX = 121, posY = 232 }, -- House
    { worldX = 36, worldY = 33, posX =  65, posY = 258 }, -- Shack
    { worldX = 36, worldY = 34, posX =  13, posY = 162 }, -- Small house
    { worldX = 35, worldY = 35, posX = 266, posY =  46 }, -- Bar
    { worldX = 35, worldY = 35, posX = 175, posY = 116 }, -- Gas 2 Go
};

local REGION_WESTPOINT_ID = 'West Point, KY';
local REGION_WESTPOINT_SPAWNS = {
    { worldX = 39, worldY = 23, posX = 138, posY = 100 }, -- Nice house
    { worldX = 39, worldY = 23, posX =  93, posY =  93 }, -- Small shack
    { worldX = 40, worldY = 23, posX =  69, posY = 243 }, -- Fossoil
};

-- ------------------------------------------------
-- Functions
-- ------------------------------------------------

---
-- Create custom traits.
--
local function initTraits()
    TraitFactory.addTrait("nimblefingers", getText("UI_trait_nimblefingers"), 0, Lockpicking_Text.traitNimbleFingersDescription, true);
end

---
-- Create custom professions.
--
local function initProfessions()
    --Was originally just modifying existing profession to inject traits, however reinitializing and overwriting
    --the whole profession was the only way I could find to get the icon to actually change.
    --Wouldn't have been an issue if setIconPath also did the Java logic to reload the texture, but it doesn't so
    --this is the ugly workaround for that. Should still be update proof should the original Burlar change.

    local origBurgler = ProfessionFactory.getProfession(BURGLAR_ID);

        local burglar = ProfessionFactory.addProfession(BURGLAR_ID, getText("UI_prof_Burglar"), "Prof_nk_Burglar", origBurgler:getCost()-2);
        for k,v in pairs(transformIntoKahluaTable(origBurgler:getXPBoostMap())) do
            burglar:addXPBoost(k, v);
        end
        burglar:setFreeTraitStack(origBurgler:getFreeTraitStack());
        burglar:addFreeTrait("nimblefingers");
        burglar:addFreeTrait("NightOwl");

        burglar:setDescription(origBurgler:getDescription().." <LINE> "..getText("UI_trait_nimblefingers").." <LINE> "..getText("UI_trait_nightowl"));
end

---
-- Adds custom spawnpoints for Muldraugh and West Point.
-- @param regions - The vanilla spawns.
function OnSpawnRegionsLoaded(regions)
    for i = 1, #regions do
        if regions[i].name == REGION_MULDRAUGH_ID then
            print('Injecting custom spawnpoints for the burglar profession in ' .. REGION_MULDRAUGH_ID);
            regions[i].points[BURGLAR_ID] = REGION_MULDRAUGH_SPAWNS;
        elseif regions[i].name == REGION_WESTPOINT_ID then
            print('Injecting custom spawnpoints for the burglar profession in ' .. REGION_WESTPOINT_ID);
            regions[i].points[BURGLAR_ID] = REGION_WESTPOINT_SPAWNS;
        end
    end
end

-- ------------------------------------------------
-- Game Hooks
-- ------------------------------------------------

Events.OnGameBoot.Add(initTraits);
Events.OnGameBoot.Add(initProfessions);
Events.OnSpawnRegionsLoaded.Add(OnSpawnRegionsLoaded);
