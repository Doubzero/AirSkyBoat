-----------------------------------
-- Dulling Arrow
-- Description: Lowers enemy's INT. Chance of lowering INT varies with TP.
-- Type: Physical
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    mob:messageBasic(xi.msg.basic.READIES_WS, 0, 165)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1.1, 1.2, 1.3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if (math.random(1, 100) < skill:getTP()/3) then
        target:addStatusEffect(xi.effect.INT_DOWN, 10, 0, 120)
    end

    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    return dmg
end

return mobskill_object