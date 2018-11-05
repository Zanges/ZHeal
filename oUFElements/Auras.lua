local addonName, addonTable = ...
local Media = addonTable.Media
local Utility = addonTable.Utility
local LSM = LibStub("LibSharedMedia-3.0")


local function AuraOnEnter(aura)
	if (not aura:IsVisible()) then return end

	GameTooltip:SetOwner(aura, "ANCHOR_BOTTOMRIGHT")
	aura:UpdateTooltip()
end

local function AuraOnLeave(aura)
	GameTooltip:Hide()
end

local function UpdateAuraTooltip(aura)
	GameTooltip:SetUnitAura(aura:GetParent().__owner.unit, aura:GetID(), aura.filter)
end

local function CreateAura(auras, index)
    local button = CreateFrame("Button", auras:GetName() .. index, auras)

	local icon = button:CreateTexture(nil, "BORDER")
	icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	icon:SetAllPoints()
	button.icon = icon

    local count = button:CreateFontString(nil, "OVERLAY")
    count:SetFont(ZHeal.db.profile.textFont, 12, "OUTLINE")
	count:SetPoint("BOTTOMRIGHT", -1, 1)
    button.count = count
    
    if auras.useTimer then
        local timer = button:CreateFontString(nil, "OVERLAY")
        timer:SetFont(ZHeal.db.profile.textFont, 16, "OUTLINE")
        timer:SetPoint("CENTER", 0,0)
        timer:SetJustifyH("CENTER")
        timer:SetJustifyV("CENTER")
        button.timer = timer
    else
        local cooldown = CreateFrame("Cooldown", nil, button, "CooldownFrameTemplate")
        cooldown:SetAllPoints()
        cooldown:SetReverse(true)
        button.cd = cooldown
    end
    
    

    

	button.UpdateTooltip = UpdateAuraTooltip
	button:SetScript("OnEnter", AuraOnEnter)
	button:SetScript("OnLeave", AuraOnLeave)

	return button
end

local function CustomFilterBuffs(unit, button, name, rank, icon, count, dispelType, duration, expires, caster, isStealable, nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, casterIsPlayer, nameplateShowAll, timeMod, value1, value2, value3)
    local ShouldHide = false

    if duration > (5 * 60) then -- Duration over 5 Min -> Hide
        ShouldHide = true
    end
    if duration == 0 then       -- Duration 0 = Buff has no Duration, Unit is phased or out of Range -> Hide
        ShouldHide = true
    end
    if not casterIsPlayer then  -- not cast by Player -> Hide
        ShouldHide = true
    end

    if ShouldHide then
        return false
    else
        return true
    end
end

local function CustomFilterDebuffs(unit, button, name, rank, icon, count, dispelType, duration, expires, caster, isStealable, nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, casterIsPlayer, nameplateShowAll, timeMod, value1, value2, value3)
    local ShouldHide = false

    if spellID == 57724 then
        ShouldHide = true
    end

    if ShouldHide then
        return false
    else
        return true
    end
end

local function PostUpdateAura(auras, unit, aura, index, offset)
	local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, isCastByPlayer, nameplateShowAll, timeMod, value1, value2, value3 = UnitAura(unit, index, aura.filter)
    if aura.timer then
        if (duration and duration > 0) then
            local timeLeft = expirationTime - GetTime()
            aura.timer:SetText((timeLeft > 0) and Utility:FormatTime(timeLeft))
        else
            aura.timer:SetText()
        end
    end
end

local function CreateAuras(self, unit, nameSuffix)
	local auras = CreateFrame("Frame", self:GetName() .. "_" .. nameSuffix, self)
	auras.spacing = 2
	auras.size = ((ZHeal.db.profile.unitWidth / 2) - (auras.spacing / 2))
	auras:SetSize(2 * (auras.size + auras.spacing), 6 * (auras.size + auras.spacing))
    auras.num = 12
	auras.CreateIcon = CreateAura
    auras.PostUpdateIcon = PostUpdateAura
    auras.useTimer = false

	return auras
end

function addonTable.AddBuffs(self, unit)
    local buffs = CreateAuras(self, unit, "Buffs")
    
	buffs.showBuffType = true
    buffs:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
    buffs.initialAnchor = "BOTTOMLEFT"
	buffs["growth-y"] = "UP"
    buffs["growth-x"] = "RIGHT"
    buffs.CustomFilter = CustomFilterBuffs

	self.Buffs = buffs
end

function addonTable.AddDebuffs(self, unit)
	local debuffs = CreateAuras(self, unit, "debuffs")
    
	debuffs.showBuffType = true
    debuffs:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -1)
    debuffs.initialAnchor = "TOPLEFT"
	debuffs["growth-y"] = "DOWN"
    debuffs["growth-x"] = "RIGHT"
    debuffs.CustomFilter = CustomFilterDebuffs

	self.Debuffs = debuffs
end