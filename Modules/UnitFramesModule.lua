local addonName, addonTable = ...
local UnitFramesModule = ZTweaks:NewModule("UnitFramesModule")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local Media = addonTable.Media
local LSM = LibStub("LibSharedMedia-3.0")


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

local UnitSpecific = {
	player = function(self)
		-- Player specific layout code.
	end,
    
    party = function(self)
        -- Party specific layout code.
    end,

    
    pet = function(self)
        -- Pet specific layout code.
    end,

    focus = function(self)
        -- Focus specific layout code.
    end,
}

local Shared = function(self, unit)
    -- Shared layout code.
    self.colors = Media.Colors
    self:SetBackdrop(Media.Assets.BACKDROP)
	self:SetBackdropBorderColor(Media:Grayscale(0.4))
	self:SetBackdropColor(Media:Grayscale(0.15))
    self:SetSize(240, 60)
	local HealthBar, HealthBG = addonTable.AddHealthBar(self, self, "TOPLEFT", 4, 0, 1, 0.6)
	local PowerBar, PowerBG = addonTable.AddPowerBar(self, self, "BOTTOMLEFT", 4, 0, 1, 0.4)

    -- Multiple Unit specific layout code.
    if (unit == "player" or unit == "target") then
        
    end

    -- Add Unit specific layout code.
	if(UnitSpecific[unit]) then
		return UnitSpecific[unit](self)
	end
end

oUF:RegisterStyle(addonName .. "UnitFrames", Shared)
oUF:Factory(function(self)
    self:SetActiveStyle(addonName .. "UnitFrames")

    self:Spawn("player", addonName .. "UnitFrames_Player"):SetPoint("CENTER", -210, 215)
    self:Spawn("target", addonName .. "UnitFrames_Target"):SetPoint("CENTER", 210, 215)
end)