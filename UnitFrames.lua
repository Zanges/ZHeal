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
local HealButtonsRaid = {}


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
    self:SetSize(ZHeal.db.profile.unitWidth, (ZHeal.db.profile.unitWidth  * ZHeal.db.class.numButtons) - (ZHeal.db.profile.buttonSpacing  * (ZHeal.db.class.numButtons - 1)))
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
        local UnitFramesRaid = UnitFramesModule:CreateRaid()
        UnitFramesRaid:SetPoint("CENTER", addonName .. "_UnitFrames_PositionFrame", "CENTER", -280, 0)
    end
end

function UnitFramesModule:CreateHealButton(Header, Index, Target, FadeTable, Parent)
    local Spacing = ZHeal.db.profile.buttonSpacing
    local Size = ZHeal.db.profile.unitWidth - Spacing * 2

    local button = LAB:CreateButton(buttonIndex, "ZHeal_Button" .. buttonIndex, Header)
    local y = ((Size + Spacing) * (Index - 1)) + Spacing 

    button:SetPoint("BOTTOM", Parent, "BOTTOM", 0, y)
    button:SetSize(Size, Size)

    button:SetAttribute("unit", Target)

    button:AddToMasque(LibStub("Masque"):Group(addonName, addonName))
    buttonIndex = buttonIndex + 1

    table.insert(FadeTable, button)

    return button
end

function UnitFramesModule:CreatePlayer()
    local UnitFramesPlayer = oUF:Spawn("player", addonName .. "_UnitFrames_Player")
    
    local header = CreateFrame("Frame", "ZHeal_ButtonHeader_Player", UnitFramesPlayer, "SecureHandlerStateTemplate")
    header:SetFrameLevel(8)

    local FadeTable = {}
    for i = 1, ZHeal.db.class.numButtons do
        HealButtonsPlayer[i] = UnitFramesModule:CreateHealButton(header, i, "player", FadeTable, UnitFramesPlayer)
    end

    local FadeHandlerFrame = CreateFrame("Frame", "ZHeal_FadeHandlerFrame_Player", UnitFramesPlayer)
    FadeHandlerFrame:SetAllPoints(UnitFramesPlayer)
    FadeHandlerFrame:SetScript("OnUpdate", function(self)
        if MouseIsOver(self) then
            for _,b in ipairs(FadeTable) do
                if not b:IsVisible() then
                    b:Show()
                end
            end
        else
            for _,b in ipairs(FadeTable) do
                if b:IsVisible() then
                    b:Hide()
                end
            end
        end
    end)

    return UnitFramesPlayer
end

function UnitFramesModule:CreateParty()
    local party = oUF:SpawnHeader(
		nil, nil, "party",
		"showParty", true,
		"maxColumns", 4,
		"unitsPerColumn", 1,
		"columnAnchorPoint", "LEFT",
		"columnSpacing", 2,
		"oUF-initialConfigFunction", [[
			
		]]
	)
	party:SetPoint("CENTER", addonName .. "_UnitFrames_PositionFrame", "CENTER", 140, 0)
    
    local header = CreateFrame("Frame", "ZHeal_ButtonHeader_Party", UnitFramesPlayer, "SecureHandlerStateTemplate")
    header:SetFrameLevel(8)

    for n = 1, 4 do
        if _G["oUF_ZHealUnitFramesPartyUnitButton" .. n] ~= nil then
            local FadeTable = {}
            HealButtonsParty[n] = {}
            for i = 1, ZHeal.db.class.numButtons do
                HealButtonsParty[n][i] = UnitFramesModule:CreateHealButton(header, i, "party" .. n, FadeTable, "oUF_ZHealUnitFramesPartyUnitButton" .. n)
            end
            local FadeHandlerFrame = CreateFrame("Frame", "ZHeal_FadeHandlerFrame_Party_" .. n, _G["oUF_ZHealUnitFramesPartyUnitButton" .. n])
            FadeHandlerFrame:SetAllPoints("oUF_ZHealUnitFramesPartyUnitButton" .. n)
            FadeHandlerFrame:SetScript("OnUpdate", function(self)
                if MouseIsOver(self) then
                    for _,b in ipairs(FadeTable) do
                        if not b:IsVisible() then
                            b:Show()
                        end
                    end
                else
                    for _,b in ipairs(FadeTable) do
                        if b:IsVisible() then
                            b:Hide()
                        end
                    end
                end
            end)
        end
    end
    
    return party
end

function UnitFramesModule:CreateRaid()
    local raid = oUF:SpawnHeader(
		nil, nil, "raid",
		"showRaid", true,
		"maxColumns", 40,
		"unitsPerColumn", 1,
		"columnAnchorPoint", "LEFT",
		"columnSpacing", 2,
		"oUF-initialConfigFunction", [[
			
		]]
	)
	raid:SetPoint("CENTER", addonName .. "_UnitFrames_PositionFrame", "CENTER", 140, 0)
    
    local header = CreateFrame("Frame", "ZHeal_ButtonHeader_Raid", UnitFramesPlayer, "SecureHandlerStateTemplate")
    header:SetFrameLevel(8)

    for n = 1, 4 do
        if _G["oUF_ZHealUnitFramesRaidUnitButton" .. n] ~= nil then
            local FadeTable = {}
            HealButtonsRaid[n] = {}
            for i = 1, ZHeal.db.class.numButtons do
                HealButtonsRaid[n][i] = UnitFramesModule:CreateHealButton(header, i, "raid" .. n, FadeTable, "oUF_ZHealUnitFramesRaidUnitButton" .. n)
            end
            local FadeHandlerFrame = CreateFrame("Frame", "ZHeal_FadeHandlerFrame_Raid_" .. n, _G["oUF_ZHealUnitFramesRaidUnitButton" .. n])
            FadeHandlerFrame:SetAllPoints("oUF_ZHealUnitFramesRaidUnitButton" .. n)
            FadeHandlerFrame:SetScript("OnUpdate", function(self)
                if MouseIsOver(self) then
                    for _,b in ipairs(FadeTable) do
                        if not b:IsVisible() then
                            b:Show()
                        end
                    end
                else
                    for _,b in ipairs(FadeTable) do
                        if b:IsVisible() then
                            b:Hide()
                        end
                    end
                end
            end)
        end
    end
    
    return raid
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
        end 
    end

    -- raid
    for n,t in ipairs(HealButtonsRaid) do
        if t ~= nil then
            for i,v in ipairs(HealButtonsRaid[n]) do
                if spellArray[i] ~= nil then
                    v:SetState(0, "spell", spellArray[i])
                else
                    v:SetState(0, nil)
                end
            end
        end 
    end
end