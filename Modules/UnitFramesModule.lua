local addonName, addonTable = ...
local UnitFramesModule = ZTweaks:NewModule("UnitFramesModule")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local Media = addonTable.Media
local Utility = addonTable.Utility
local LSM = LibStub("LibSharedMedia-3.0")
local disableBlizzard = oUF.DisableBlizzard


local UnitFramesPlayer, UnitFramesTarget, HUDPlayer, HUDTarget

local playerClass = addonTable.playerClass


function UnitFramesModule:OnInitialize()
	
end

function UnitFramesModule:OnEnable()
	local oUFVersion = GetAddOnMetadata("oUF", "version")
    if(not oUFVersion:find("project%-version")) then
        local major, minor, rev = strsplit(".", oUFVersion)
        oUFVersion = major * 1000 + minor * 100 + rev

        assert(oUFVersion >= 8000, addonName .. ": Unit Frames requires oUF version >= 8.0.0")
    end
end

function UnitFramesModule:OnDisable()
	
end

local UnitFramesStyle = function(self, unit)
    -- Shared layout code.
    self.colors = Media.Colors
    self:SetBackdrop(Media.Assets.BACKDROP)
	self:SetBackdropBorderColor(Media:Grayscale(0.4))
    self:SetBackdropColor(Media:Grayscale(0.15))
    
    -- Unit specific layout code.
    if (unit == "player" or unit == "target") then
        self:SetSize(240, 60)

        local HealthBar, HealthBG = addonTable.AddHealthBar(self, self, "TOPLEFT", 4, 0, 1, 0.6)
        local PowerBar, PowerBG = addonTable.AddPowerBar(self, self, "BOTTOMLEFT", 4, 0, 1, 0.4)
    end
end

local HUDStyle = function(self, unit)
    -- Shared layout code.
    self.colors = Media.Colors

    local CastBar = addonTable.AddCastBar(self, unit, true, 1)

    -- Unit specific layout code.
    if (unit == "player" or unit == "target") then
        self:SetSize(14, 180)
    end

    if (unit == "player") then
        local HealthBar, HealthBG = addonTable.AddVerticalHealthBar(self, self, "BOTTOMLEFT", 0, 0, 0.4, 1, nil, nil, nil, nil, nil, 0.4)
        local PowerBar, PowerBG = addonTable.AddVerticalPowerBar(self, self, "BOTTOMRIGHT", 0, 0, 0.5, 1, nil, nil, nil, nil, nil, 0.4)

        addonTable.AddClassPower(self, 180, 16, 2, 0.4)
        addonTable.AddPowerPrediction(self)
        if (playerClass == "DEATHKNIGHT") then
			addonTable.AddRunes(self, 180, 16, 2, 0.4)
		end
    elseif (unit == "target") then
        local HealthBar, HealthBG = addonTable.AddVerticalHealthBar(self, self, "BOTTOMRIGHT", 0, 0, 0.4, 1, nil, nil, nil, nil, nil, 0.4)
        local PowerBar, PowerBG = addonTable.AddVerticalPowerBar(self, self, "BOTTOMLEFT", 0, 0, 0.5, 1, nil, nil, nil, nil, nil, 0.4)
    end
end

oUF:RegisterStyle(addonName .. "UnitFrames", UnitFramesStyle)
oUF:RegisterStyle(addonName .. "HUD", HUDStyle)
oUF:Factory(function(self)
    if ZTweaks.db.profile.modules.enabled.unitframes then
        self:SetActiveStyle(addonName .. "UnitFrames")

        UnitFramesPlayer = self:Spawn("player", addonName .. "UnitFrames_Player")
        UnitFramesPlayer:SetPoint("CENTER", -210, 215)

        UnitFramesTarget = self:Spawn("target", addonName .. "UnitFrames_Target")
        UnitFramesTarget:SetPoint("CENTER", 210, 215)
    end
    
    if ZTweaks.db.profile.modules.enabled.hud then
        self:SetActiveStyle(addonName .. "HUD")

        HUDPlayer = self:Spawn("player", addonName .. "HUD_Player")
        HUDPlayer:SetPoint("BOTTOMLEFT", NamePlatePlayerResourceFrame, "BOTTOMLEFT", -80, 0)
        UnitFramesModule:HealthText("player", HUDPlayer, -18, -4, 0.4)
        UnitFramesModule:PowerText("player", HUDPlayer, 18, -4, 0.4)
        
        HUDTarget = self:Spawn("target", addonName .. "HUD_Target")
        HUDTarget:SetPoint("BOTTOMRIGHT", NamePlatePlayerResourceFrame, "BOTTOMRIGHT", 80, 0)
        UnitFramesModule:HealthText("target", HUDTarget, 18, -4, 0.4)
        UnitFramesModule:PowerText("target", HUDTarget, -18, -4, 0.4)
    end
end)

local DontAutoDisableFrames = {
    player = true,
    target = true,
 }
  
 function oUF:DisableBlizzard(unit)
    if unit and not DontAutoDisableFrames[unit] then 
       return disableBlizzard(self, unit)
    end
 end

 function UnitFramesModule:HealthText(unit, parent, x, y, alpha)
    alpha = alpha or 1

    local HealthText = CreateFrame("Frame", nil, parent)
    HealthText:SetPoint("BOTTOM", x, y)
    HealthText:SetSize(1, 1)
    HealthText:SetAlpha(alpha)
    local FS = HealthText:CreateFontString()
	FS:SetFont("Fonts\\FRIZQT__.TTF", 16) --LibStub("LibSharedMedia-3.0"):Fetch("Friz Quadrata TT")
    local HP = (UnitHealth(unit) / UnitHealthMax(unit)) * 100
    FS:SetText(Utility:VerticalText(Utility:Truncate(HP, 1)))
    FS:SetPoint("BOTTOM")

    HealthText:RegisterEvent("UNIT_HEALTH")
    HealthText:RegisterEvent("PLAYER_TARGET_CHANGED")
    local function eventHandler(self, event, ...)
        if event == "UNIT_HEALTH" or event == "PLAYER_TARGET_CHANGED" then
            local HP = (UnitHealth(unit) / UnitHealthMax(unit)) * 100
            FS:SetText(Utility:VerticalText(Utility:Truncate(HP, 1)))
        end
    end
    HealthText:SetScript("OnEvent", eventHandler);
 end

 function UnitFramesModule:PowerText(unit, parent, x, y, alpha)
    alpha = alpha or 1

    local PowerText = CreateFrame("Frame", nil, parent)
    PowerText:SetPoint("BOTTOM", x, y)
    PowerText:SetSize(1, 1)
    PowerText:SetAlpha(alpha)
    local FS = PowerText:CreateFontString()
	FS:SetFont("Fonts\\FRIZQT__.TTF", 16) --LibStub("LibSharedMedia-3.0"):Fetch("Friz Quadrata TT")
    local HP = (UnitHealth(unit) / UnitHealthMax(unit)) * 100
    FS:SetText(Utility:VerticalText(Utility:Truncate(HP, 1)))
    FS:SetPoint("BOTTOM")

    PowerText:RegisterEvent("UNIT_POWER_UPDATE")
    PowerText:RegisterEvent("PLAYER_TARGET_CHANGED")
    local function eventHandler(self, event, ...)
        if event == "UNIT_POWER_UPDATE" or event == "PLAYER_TARGET_CHANGED" then
            local Power
            print(UnitPowerType(unit))
            if UnitPowerType(unit) == 0 then
                Power = (UnitPower(unit) / UnitPowerMax(unit)) * 100
            else
                Power = UnitPower(unit)
            end
            FS:SetText(Utility:VerticalText(Utility:Truncate(Power, 1)))
        end
    end
    PowerText:SetScript("OnEvent", eventHandler);
 end