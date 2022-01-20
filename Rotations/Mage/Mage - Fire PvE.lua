--------------------------------
-- Mage - Fire PvE
-- Version - 1.0.0
-- Author - Dreams
--------------------------------
-- Changelog
-- 1.0.0 Initial release
--------------------------------
local ni = ...

local queue = {
    "Molten Armor",
    "Arcane Brilliance",
    "Conjure Mana Gem",
    "Pause",
    "Mana Sapphire",
    "Evocation",
    "Fireblast",
    "Living Bomb",
    "Pyroblast",
    "Mirror Image",
    "Combustion",
    "Fireball",
}

local abilities = {
    ["Molten Armor"] = function()
        if ni.spell.available("Molten Armor")
        and not ni.unit.buff("player", "Molten Armor") then
            ni.spell.cast("Molten Armor", "player")
        end
    end,

    ["Arcane Brilliance"] = function()
        if ni.spell.available("Arcane Brilliance")
        and not ni.unit.buff("player", "Arcane Brilliance")
        and ni.player.hasitem(17020) then
            ni.spell.cast("Arcane Brilliance", "player")
        end
    end,

    ["Conjure Mana Gem"] = function()
        if ni.spell.available("Conjure Mana Gem")
        and not ni.player.hasitem(33312)
        and not UnitAffectingCombat("player") then
            ni.spell.cast("Conjure Mana Gem", "player")
        end
    end,

    ["Pause"] = function()
        if IsMounted()
        or not UnitAffectingCombat("player")
        or not UnitExists("target")
        or UnitIsDeadOrGhost("player") then
            return true;
        end
    end,

    ["Mana Sapphire"] = function()
        if ni.player.itemcd(33312) == 0
        and ni.player.power() <= 85 then
            ni.player.useitem(33312)
        end
    end,

    ["Evocation"] = function()
        if ni.spell.available("Evocation")
        and UnitAffectingCombat("player")
        and ni.player.power() <= 10
        and not ni.unit.ismoving("player") then
            ni.spell.cast("Evocation", "player")
        end
    end,

    ["Fireblast"] = function()
        if ni.spell.available("Fireblast")
        and ni.player.ismoving() then
            ni.spell.cast("Fireblast", "target")
        end
    end,

    ["Living Bomb"] = function()
        if ni.spell.available("Living Bomb", "target")
        and not ni.unit.debuff("target", 55360, "player")
        and not ni.unit.ischanneling("player") then
            ni.spell.cast("Living Bomb", "target")
        end
    end,

    ["Pyroblast"] = function()
        if ni.spell.available("Pyroblast", "target")
        and ni.unit.buff("player", 48108, "player")
        and not ni.unit.ischanneling("player") then
            ni.spell.cast("Pyroblast", "target")
        end
    end,

    ["Mirror Image"] = function()
        if ni.spell.available("Mirror Image")
        and ni.unit.isboss("target")
        and not ni.unit.ischanneling("player") then
            ni.spell.cast("Mirror Image", "player")
        end
    end,

    ["Combustion"] = function()
        if ni.spell.available("Combustion")
        and ni.unit.isboss("target")
        and not ni.unit.ischanneling("player") then
            ni.spell.cast("Combustion", "player")
        end
    end,

    ["Fireball"] = function()
        if ni.spell.available("Fireball", "target")
        and not ni.unit.ischanneling("player") then
            ni.spell.cast("Fireball", "target")
        end
    end,
}

ni.bootstrap.rotation("Mage - Fire PvE", queue, abilities)
