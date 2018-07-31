local addonName, addonTable = ...
ZTweaks = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local Options, Media, Utility, MouseLookModule, MouseCastModule, UnitFramesModule, TradeTweaksModule


addonTable.playerClass = select(2, UnitClass('player'))
ZTweaks.wasMouselooking = false


function ZTweaks:OnInitialize()
	ZTweaks:InitBindingsModules()
	Options = self:GetModule("Options")
	Media = self:GetModule("Media")
	Utility = self:GetModule("Utility")
	MouseLookModule = self:GetModule("MouseLookModule")
	MouseCastModule = self:GetModule("MouseCastModule")
	UnitFramesModule = self:GetModule("UnitFramesModule")
	UnitFramesModule = self:GetModule("TradeTweaksModule")

	SetCVar("nameplateShowSelf", 1)
	SetCVar("nameplatePersonalShowAlways", 1)
	SetCVar("nameplateSelfAlpha", 0)
end

function ZTweaks:OnEnable()
	
end

function ZTweaks:OnDisable()
	
end