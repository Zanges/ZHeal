local addonName, addonTable = ...
local MouseLookModule = ZTweaks:NewModule("MouseLookModule")

local IsMouselooking = _G.IsMouselooking
local MouselookStart, MouselookStop = _G.MouselookStart, _G.MouselookStop

function MouseLookModule:SetOverrideBindings()
	_G.SetMouselookOverrideBinding("BUTTON1", GetBindingByKey("W"))
	_G.SetMouselookOverrideBinding("BUTTON2", GetBindingByKey("S"))
end

function MouseLookModule:ClearOverrideBindings()
	_G.SetMouselookOverrideBinding("BUTTON1")
	_G.SetMouselookOverrideBinding("BUTTON2")
end

function MouseLookModule:ToggleMouseMode()
    if IsMouselooking() then
        MouselookStop()
        ZTweaks.wasMouselooking = false
    else
        MouselookStart()
    end
end

function MouseLookModule:OnInitialize()
	self:SetEnabledState(ZTweaks.db.profile.modules.enabled.mouselook)
end

function MouseLookModule:OnEnable()
	self:SetOverrideBindings()
end

function MouseLookModule:OnDisable()
	MouseLookModule:ClearOverrideBindings()
end