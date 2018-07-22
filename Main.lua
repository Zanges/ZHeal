local addonName, addonTable = ...
ZTweaks = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local Options, Media, Utility, MouseLookModule, UnitFramesModule


ZTweaks.wasMouselooking = false


function ZTweaks:OnInitialize()
	ZTweaks:InitBindingsModules()
	Options = self:GetModule("Options")
	Media = self:GetModule("Media")
	Utility = self:GetModule("Utility")
	MouseLookModule = self:GetModule("MouseLookModule")
	UnitFramesModule = self:GetModule("UnitFramesModule")
end

function ZTweaks:OnEnable()
	
end

function ZTweaks:OnDisable()
	
end