local addonName, addonTable = ...
local Media = addonTable.Media
local Utility = addonTable.Utility
local LSM = LibStub("LibSharedMedia-3.0")


function addonTable.AddPowerPrediction(self)
	local mainBar = CreateFrame("StatusBar", nil, self.Power)
	mainBar:SetStatusBarTexture(LSM:Fetch("background", "Solid"))
	mainBar:SetStatusBarColor(0, 0, 1, 0.5)
	mainBar:SetReverseFill(true)
	mainBar:SetSize(230, 15)
	mainBar:SetPoint("TOP", self.Power:GetStatusBarTexture())
 	self.PowerPrediction = {
		mainBar = mainBar,
	}
end