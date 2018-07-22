local addonName, addonTable = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local MouseLookModule


BINDING_HEADER_ZTWEAKS = addonName
BINDING_NAME_ZTWEAKS_MOUSEMODE = L["Mouse Mode"]


function ZTweaks:InitBindingsModules()
	MouseLookModule = self:GetModule("MouseLookModule")
end

function ZTweaks:MouseModeFunction()
	if (ZTweaks.db.profile.modules.enabled.mouselook) then
		MouseLookModule:ToggleMouseMode()
	end
end