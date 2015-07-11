require('NPCs/MainCreationMethods');
require('NPCs/ProfessionClothing');

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

    local origBurgler = ProfessionFactory.getProfession("burglar");

    local burglar = ProfessionFactory.addProfession("burglar", getText("UI_prof_Burglar"), "Prof_nk_Burglar", origBurgler:getCost()-2);
        for k,v in pairs(transformIntoKahluaTable(origBurgler:getXPBoostMap())) do
            burglar:addXPBoost(k, v);
        end
        burglar:setFreeTraitStack(origBurgler:getFreeTraitStack());
        burglar:addFreeTrait("nimblefingers");
        burglar:addFreeTrait("NightOwl");

        burglar:setDescription(origBurgler:getDescription().." <LINE> "..getText("UI_trait_nimblefingers").." <LINE> "..getText("UI_trait_nightowl"));
end

---
-- Set custom clothing and clothing colors for this
-- profession.
--
local function initClothing()
    local clothes = {
        male = {
            topPal = "Shirt_White",
            top = "Shirt",
            bottomPal = "Trousers_White",
            bottom = "Trousers",
            topCol = {
                r = 0.1,
                g = 0.1,
                b = 0.1,
            },
            bottomCol = {
                r = 0.1,
                g = 0.1,
                b = 0.1,
            },
        },
        female = {
            topPal = "Shirt_White",
            top = "Shirt",
            bottomPal = "Trousers_White",
            bottom = "Trousers",
            topCol = {
                r = 0.1,
                g = 0.1,
                b = 0.1,
            },
            bottomCol = {
                r = 0.1,
                g = 0.1,
                b = 0.1,
            },
        },
    }
    ProfessionClothing.rm_Burglar = clothes;
end

-- ------------------------------------------------
-- Game Hooks
-- ------------------------------------------------

Events.OnGameBoot.Add(initTraits);
Events.OnGameBoot.Add(initProfessions);
Events.OnGameBoot.Add(initClothing);
