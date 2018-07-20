local addonName, addonTable = ...
ZTweaks = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local OptionsModule, MouseLookModule

ZTweaks.wasMouselooking = false

function ZTweaks:OnInitialize()
	ZTweaks:InitBindingsModules()
	Options = self:GetModule("Options")
	MouseLookModule = self:GetModule("MouseLookModule")
end

function ZTweaks:OnEnable()
	
end

function ZTweaks:OnDisable()
	
end