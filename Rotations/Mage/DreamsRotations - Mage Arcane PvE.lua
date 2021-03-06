--------------------------------
-- DreamsRotation - Mage Arcane PvE
-- Version - 1.0.3
-- Author - Dreams
--------------------------------
-- Changelog
-- 1.0.0 Initial release
-- 1.0.1 Added Auto Target
-- 1.0.2 Added GUI
-- 1.0.3 Improved overall rotation
--------------------------------
local ni = ...

local items = {
    settingsfile = "DreamsRotations - Mage Arcane PvE.json",
    {
        type = "title",
        text = "|cffff00ffDreamsRotation |cffffffff- Arcane Mage PvE",
    },
    {
        type = "separator",
    },
    {
        type = "title",
        text = "|cff71C671Main Settings",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(1953)) .. ":26:26\124t Use Auto Target",
        tooltip = "Use the Auto Target feature if you in combat it will Auto Target the closest enemy around you",
        enabled = true,
        key = "autotarget",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(43046)) .. ":26:26\124t Use Molten Armor",
        tooltip = "Use Molten Armor if not active",
        enabled = true,
        key = "moltenarmor",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(43002)) .. ":26:26\124t Use Arcane Brilliance",
        tooltip = "Use Arcane Brilliance if not active",
        enabled = true,
        key = "arcanebrilliance",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(42985)) .. ":26:26\124t Use Conjure Mana Gem",
        tooltip = "Use Conjure Mana Gem if you have no mana sapphire left and out of combat",
        enabled = true,
        key = "conjuremanagem",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(42985)) .. ":26:26\124t Use Mana Sapphire at Mana %",
        tooltip = "Use Mana Sapphire at mana percentage",
        enabled = true,
        value = 85,
        key = "manasapphire",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(12051)) .. ":26:26\124t Use Evocation at Mana %",
        tooltip = "Use Evocation at mana percentage",
        enabled = true,
        value = 20,
        key = "evocation",
    },
    {
        type = "separator",
    },
    {
        type = "title",
        text = "|cff71C671Rotation Settings",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(42897)) .. ":26:26\124t Use Arcane Blast",
        tooltip = "Use Arcane Blast",
        enabled = true,
        key = "arcaneblast",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(12472)) .. ":26:26\124t Use Icy Veins at Arcane Blast stacks",
        tooltip = "Use Icy Veins if your target is a boss and has the amount of the defined Arcane Blast stacks",
        enabled = true,
        value = 3,
        key = "icyveins",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(55342)) .. ":26:26\124t Use Mirror Image at Arcane Blast stacks",
        tooltip = "Use Mirror Image if your target is a boss and has the amount of the defined Arcane Blast stacks",
        enabled = true,
        value = 3,
        key = "mirrorimage",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(12042)) .. ":26:26\124t Use Arcane Power at Arcane Blast stacks",
        tooltip = "Use Arcane Power if your target is a boss and has the amount of the defined Arcane Blast stacks",
        enabled = true,
        value = 3,
        key = "arcanepower",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(12043)) .. ":26:26\124t Use Presence of Mind at Arcane Blast stacks",
        tooltip = "Use Presence of Mind if your target is a boss and has the amount of the defined Arcane Blast stacks",
        enabled = true,
        value = 1,
        key = "presenceofmind",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(42846)) .. ":26:26\124t Use Arcane Missiles at Arcane Blast stacks",
        tooltip = "Use Arcane Missiles and has the amount of the defined Arcane Blast stacks",
        enabled = true,
        value = 4,
        key = "arcanemissiles",
    },
}

local function GetSetting(name)
    for k, v in ipairs(items) do
        if v.type == "entry"
        and v.key ~= nil
        and v.key == name then
            return v.value, v.enabled
        end
    end
end

local function onload()
    ni.GUI.AddFrame("DreamsRotations - Mage Arcane PvE", items);
end

local function onunload()
    ni.GUI.DestroyFrame("DreamsRotations - Mage Arcane PvE");
end

-- Spells
local MoltenArmor = GetSpellInfo(43046)
local ArcaneBrilliance = GetSpellInfo(43002)
local ConjureManaGem = GetSpellInfo(42985)
local Evocation = GetSpellInfo(12051)
local IcyVeins = GetSpellInfo(12472)
local MirrorImage = GetSpellInfo(55342)
local ArcanePower = GetSpellInfo(12042)
local PresenceOfMind = GetSpellInfo(12043)
local ArcaneMissiles = GetSpellInfo(42846)
local ArcaneMissilesBuff = GetSpellInfo(44401)
local ArcaneBlast = GetSpellInfo(42897)
local ArcaneBlastStacks = GetSpellInfo(36032)

-- Items
local ManaSapphire = GetItemInfo(33312)
local ArcanePowder = GetItemInfo(17020)
local Food = GetSpellInfo(45548)
local Drink = GetSpellInfo(57073)

local queue = {
    "Molten Armor",
    "Arcane Brilliance",
    "Conjure Mana Gem",
    "Pause Rotation",
    "Auto Target",
    "Mana Sapphire",
    "Evocation",
    "Arcane Power",
    "Icy Veins",
    "Mirror Image",
    "Presence of Mind",
    "Arcane Missiles",
    "Arcane Blast",
}

local abilities = {
    ["Molten Armor"] = function()
        local _, enabled = GetSetting("moltenarmor")
        if enabled then
            if ni.spell.available(MoltenArmor)
            and not ni.unit.buff("player", MoltenArmor) then
                ni.spell.cast(MoltenArmor)
                return true;
            end
        end
    end,

    ["Arcane Brilliance"] = function()
        local _, enabled = GetSetting("arcanebrilliance")
        if enabled then
            if ni.spell.available(ArcaneBrilliance)
            and not ni.unit.buff("player", ArcaneBrilliance)
            and ni.player.hasitem(ArcanePowder) then
                ni.spell.cast(ArcaneBrilliance)
                return true;
            end
        end
    end,

    ["Conjure Mana Gem"] = function()
        local _, enabled = GetSetting("conjuremanagem")
        if enabled then
            if ni.spell.available(ConjureManaGem)
            and not ni.player.hasitem(ManaSapphire)
            and not ni.player.ismoving("player")
            and not UnitAffectingCombat("player") then
                ni.spell.cast(ConjureManaGem)
                return true;
            end
        end
    end,

    ["Pause Rotation"] = function()
        if IsMounted()
        or UnitIsDeadOrGhost("player")
        or UnitIsDeadOrGhost("target")
        or UnitUsingVehicle("player")
        or UnitInVehicle("player")
        or not UnitAffectingCombat("player")
        or ni.unit.ischanneling("player")
        or ni.unit.iscasting("player")
        or ni.unit.buff("player", Food)
        or ni.unit.buff("player", Drink) then
            return true;
        end
    end,

    ["Auto Target"] = function()
        local _, enabled = GetSetting("autotarget")
        if enabled then
            if UnitAffectingCombat("player")
            and ((ni.unit.exists("target")
            and UnitIsDeadOrGhost("target")
            and not UnitCanAttack("player", "target"))
            or not ni.unit.exists("target")) then
                ni.player.runtext("/targetenemy")
                return true;
            end
        end
    end,

    ["Mana Sapphire"] = function()
        local value, enabled = GetSetting("manasapphire")
        if enabled then
            if ni.player.itemcd(ManaSapphire) == 0
            and ni.player.power() < value then
                ni.player.useitem(ManaSapphire)
                return true;
            end
        end
    end,

    ["Evocation"] = function()
        local value, enabled = GetSetting("evocation")
        if enabled then
            if ni.spell.available(Evocation)
            and ni.player.power() < value
            and not ni.unit.ismoving("player") then
                ni.spell.cast(Evocation)
                return true;
            end
        end
    end,

    ["Mirror Image"] = function()
        local value, enabled = GetSetting("mirrorimage")
        if enabled then
            if ni.spell.available(MirrorImage)
            and ni.unit.isboss("target")
            and ni.unit.debuffstacks("player", ArcaneBlastStacks) >= value then
                ni.spell.cast(MirrorImage)
                return true;
            end
        end
    end,

    ["Icy Veins"] = function()
        local value, enabled = GetSetting("icyveins")
        if enabled then
            if ni.spell.available(IcyVeins)
            and ni.unit.isboss("target")
            and ni.unit.debuffstacks("player", ArcaneBlastStacks) >= value then
                ni.spell.cast(IcyVeins)
                return true;
            end
        end
    end,

    ["Arcane Power"] = function()
        local value, enabled = GetSetting("arcanepower")
        if enabled then
            if ni.spell.available(ArcanePower)
            and ni.unit.isboss("target")
            and ni.unit.debuffstacks("player", ArcaneBlastStacks) >= value then
                ni.spell.cast(ArcanePower)
                return true;
            end
        end
    end,

    ["Presence of Mind"] = function()
        local value, enabled = GetSetting("presenceofmind")
        if enabled then
            if ni.spell.available(PresenceOfMind)
            and ni.unit.isboss("target")
            and ni.unit.debuffstacks("player", ArcaneBlastStacks) >= value then
                ni.spell.cast(PresenceOfMind)
                return true;
            end
        end
    end,

    ["Arcane Missiles"] = function()
        local value, enabled = GetSetting("arcanemissiles")
        if enabled then
            if ni.spell.available(ArcaneMissiles)
            and ni.unit.debuffstacks("player", ArcaneBlastStacks) == value
            and ni.spell.valid("target", ArcaneMissiles, true, true)
            and ni.unit.buff("player", ArcaneMissilesBuff)
            and not ni.unit.ismoving("player") then
                ni.spell.cast(ArcaneMissiles, "target")
                return true;
            end
        end
    end,

    ["Arcane Blast"] = function()
        local _, enabled = GetSetting("arcaneblast")
        if enabled then
            if ni.spell.available(ArcaneBlast)
            and ni.spell.valid("target", ArcaneBlast, true, true)
            and not ni.unit.ismoving("player") then
                ni.spell.cast(ArcaneBlast, "target")
                return true;
            end
        end
    end,
}
ni.bootstrap.profile("DreamsRotations - Mage Arcane PvE", queue, abilities, onload, onunload)