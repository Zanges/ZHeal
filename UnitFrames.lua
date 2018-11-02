local addonName, addonTable = ...
local oUF = addonTable.oUF
local UnitFramesModule = ZHeal:NewModule("UnitFramesModule")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local Media = addonTable.Media
local Utility = addonTable.Utility
local LSM = LibStub("LibSharedMedia-3.0")
local disableBlizzard = oUF.DisableBlizzard
local LAB = LibStub("LibActionButton-1.0")


local playerClass = addonTable.playerClass 
local buttonIndex = 0
local HealButtonsPlayer = {}
local HealButtonsParty = {}


function UnitFramesModule:OnInitialize()
	
end

function UnitFramesModule:OnEnable()
    UnitFramesModule:CreateUnitFrames()
    UnitFramesModule:UpdateButtons(ZHeal.db.class.healButtonSpells)
end

function UnitFramesModule:OnDisable()
	
end

local DisableFrames = {  }

function oUF:DisableBlizzard(unit)
    if unit and DisableFrames[unit] then 
        return disableBlizzard(self, unit)
    end
end

local UnitFramesStyle = function(self, unit)
    -- Shared layout code.
    --self.colors = Media.Colors
    self:SetBackdrop(Media.Assets.BACKDROP)
    self:SetBackdropBorderColor(Media:Grayscale(0.4))
    self:SetBackdropColor(Media:Grayscale(0.15))
    self:SetSize(ZHeal.db.profile.unitWidth, ((ZHeal.db.profile.unitWidth + ZHeal.db.profile.buttonSpacing) * ZHeal.db.class.numButtons))
    local HealthBar, HealthBG = addonTable.AddVerticalHealthBar(self, self, "BOTTOMLEFT", 2, 0, 0.8, 1)
    local PowerBar, PowerBG = addonTable.AddVerticalPowerBar(self, self, "BOTTOMRIGHT", 2, 0, 0.2, 1)
end

oUF:RegisterStyle(addonName .. "UnitFrames", UnitFramesStyle)

function UnitFramesModule:CreateUnitFrames()
    local PositionFrame = CreateFrame("Frame", addonName .. "_UnitFrames_PositionFrame")
    UnitFramesModule.PositionFrame = PositionFrame
    PositionFrame:SetPoint("CENTER", ZHeal.db.profile.positionX, ZHeal.db.profile.positionY)
    PositionFrame:SetSize(10, 10)
    PositionFrame:Show()

    local groupType = Utility:GetGroupType()
    oUF:SetActiveStyle(addonName .. "UnitFrames")
        
    if groupType == "SOLO" then
        local UnitFramesPlayer = UnitFramesModule:CreatePlayer()
        UnitFramesPlayer:SetPoint("CENTER", addonName .. "_UnitFrames_PositionFrame")
    elseif groupType == "PARTY" then
        UnitFramesPlayer = UnitFramesModule:CreatePlayer()
        UnitFramesPlayer:SetPoint("CENTER", addonName .. "_UnitFrames_PositionFrame", "CENTER", -90, 0)

        local UnitFramesParty = UnitFramesModule:CreateParty()
        UnitFramesParty:SetPoint("CENTER", addonName .. "_UnitFrames_PositionFrame", "CENTER", -40, 0)
    elseif groupType == "RAID" then
        
    end
end

function UnitFramesModule:CreateHealButton(Header, Index, Target, Parent)
    local Size = ZHeal.db.profile.unitWidth
    local Spacing = ZHeal.db.profile.buttonSpacing

    local button = LAB:CreateButton(buttonIndex, "ZHeal_Button" .. buttonIndex, Header)
    local y = (Size * (Index - 1)) + Spacing

    button:SetPoint("BOTTOM", Parent, "BOTTOM", 0, y)
    button:SetSize(Size - Spacing, Size - Spacing)
    button:Show()

    button:SetAttribute("unit", Target)

    button:AddToMasque(LibStub("Masque"):Group(addonName, addonName))
    buttonIndex = buttonIndex + 1
    return button
end

function UnitFramesModule:CreatePlayer()
    local UnitFramesPlayer = oUF:Spawn("player", addonName .. "_UnitFrames_Player")
    UnitFramesPlayer:SetScript("OnEnter", ZHeal_Player_OnEnter)
    UnitFramesPlayer:SetScript("OnLeave", ZHeal_Player_OnLeave)

    CreateFrame("Frame", "ZHeal_ButtonHeader_Player", UIParent, "SecureHandlerStateTemplate")

    local limit = ZHeal.db.class.numButtons
    if limit == nil then
        limit = 5
    end
    for i = 1, limit do
        HealButtonsPlayer[i] = UnitFramesModule:CreateHealButton(ZHeal_ButtonHeader_Player, i, "player", UnitFramesPlayer)
    end
    return UnitFramesPlayer
end

function ZHeal_Player_OnEnter(self)
    for _,v in ipairs(HealButtonsPlayer) do
        v:Show()
    end
end

function ZHeal_Player_OnLeave(self)
    for _,v in ipairs(HealButtonsPlayer) do
        v:Hide()
    end
end

function UnitFramesModule:CreateParty()
    local party = oUF:SpawnHeader(
		nil, nil, "party",
		"showParty", true,
		"maxColumns", 4,
		"unitsPerColumn", 1,
		"columnAnchorPoint", "LEFT",
		"columnSpacing", 0,
		"oUF-initialConfigFunction", [[
			self:SetWidth(120)
			self:SetHeight(32)
		]]
	)
	party:SetPoint("CENTER", addonName .. "_UnitFrames_PositionFrame", "CENTER", 140, 0)
    
    CreateFrame("Frame", "ZHeal_ButtonHeader_Party", UIParent, "SecureHandlerStateTemplate")

    local limit = ZHeal.db.class.numButtons
    if limit == nil then
        limit = 5
    end
    for n = 1, 4 do
        HealButtonsParty[n] = {}
        if _G["oUF_ZHealUnitFramesPartyUnitButton" .. n] ~= nil then
            for i = 1, limit do
                HealButtonsParty[n][i] = UnitFramesModule:CreateHealButton(ZHeal_ButtonHeader_Player, i, "party" .. n, "oUF_ZHealUnitFramesPartyUnitButton" .. n)
            end
        end
    end
    
    return party
end

function UnitFramesModule:GetHealButtonPlayerArray()
    return HealButtonsPlayer
end

function UnitFramesModule:GetHealButtonPlayerSpellArray()
    local array = {}
    for i,v in ipairs(HealButtonsPlayer) do
        array[i] = v:GetSpellId()
    end
    return array
end

function UnitFramesModule:UpdateButtons(spellArray)
    -- player
    for i,v in ipairs(HealButtonsPlayer) do
        if spellArray[i] ~= nil then
            v:SetState(0, "spell", spellArray[i])
        else
            v:SetState(0, nil)
        end
    end

    -- party
    for n,t in ipairs(HealButtonsParty) do
        if t ~= nil then
            for i,v in ipairs(HealButtonsParty[n]) do
                if spellArray[i] ~= nil then
                    v:SetState(0, "spell", spellArray[i])
                else
                    v:SetState(0, nil)
                end
            end
        else
            
        end
        
    end
    

    -- raid

end