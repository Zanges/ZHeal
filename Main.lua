local addonName, addonTable = ...
ZHeal = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local Options, Utility


addonTable.playerClass = select(2, UnitClass('player'))


function ZHeal:OnInitialize()
	Options = self:GetModule("Options")
	Utility = self:GetModule("Utility")
end

function ZHeal:OnEnable()
	
end

function ZHeal:OnDisable()
	
end