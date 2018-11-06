local addonName, addonTable = ...
local Media = addonTable.Media
local Utility = addonTable.Utility
local LSM = LibStub("LibSharedMedia-3.0")


function addonTable.AddHealthPrediction(self)
    local myBar = CreateFrame("StatusBar", nil, self.Health)
    myBar:SetPoint("TOP")
    myBar:SetPoint("BOTTOM")
    myBar:SetPoint("LEFT", self.Health:GetStatusBarTexture(), "RIGHT")
    myBar:SetWidth(200)

    local otherBar = CreateFrame("StatusBar", nil, self.Health)
    otherBar:SetPoint("TOP")
    otherBar:SetPoint("BOTTOM")
    otherBar:SetPoint("LEFT", myBar:GetStatusBarTexture(), "RIGHT")
    otherBar:SetWidth(200)

    local absorbBar = CreateFrame("StatusBar", nil, self.Health)
    absorbBar:SetPoint("TOP")
    absorbBar:SetPoint("BOTTOM")
    absorbBar:SetPoint("LEFT", otherBar:GetStatusBarTexture(), "RIGHT")
    absorbBar:SetWidth(200)

    local healAbsorbBar = CreateFrame("StatusBar", nil, self.Health)
    healAbsorbBar:SetPoint("TOP")
    healAbsorbBar:SetPoint("BOTTOM")
    healAbsorbBar:SetPoint("RIGHT", self.Health:GetStatusBarTexture())
    healAbsorbBar:SetWidth(200)
    healAbsorbBar:SetReverseFill(true)

    local overAbsorb = self.Health:CreateTexture(nil, "OVERLAY")
    overAbsorb:SetPoint("TOP")
    overAbsorb:SetPoint("BOTTOM")
    overAbsorb:SetPoint("LEFT", self.Health, "RIGHT")
    overAbsorb:SetWidth(10)

	local overHealAbsorb = self.Health:CreateTexture(nil, "OVERLAY")
    overHealAbsorb:SetPoint("TOP")
    overHealAbsorb:SetPoint("BOTTOM")
    overHealAbsorb:SetPoint("RIGHT", self.Health, "LEFT")
    overHealAbsorb:SetWidth(10)
    
    self.HealthPrediction = {
        myBar = myBar,
        otherBar = otherBar,
        absorbBar = absorbBar,
        healAbsorbBar = healAbsorbBar,
        overAbsorb = overAbsorb,
        overHealAbsorb = overHealAbsorb,
        maxOverflow = 1.0,
        frequentUpdates = true,
    }
end

function addonTable.AddVerticalHealthPrediction(self)
    local myBar = CreateFrame("StatusBar", nil, self.Health)
    myBar:SetPoint("LEFT")
    myBar:SetPoint("RIGHT")
    myBar:SetPoint("BOTTOM", self.Health:GetStatusBarTexture(), "TOP")
    myBar:SetHeight(self.Health:GetHeight())
    myBar:SetOrientation("VERTICAL")
    myBar:SetStatusBarTexture(LSM:Fetch("background", "Solid"))
    myBar:SetStatusBarColor(0.08, 0.7, 0.2)

    local otherBar = CreateFrame("StatusBar", nil, self.Health)
    otherBar:SetPoint("LEFT")
    otherBar:SetPoint("RIGHT")
    otherBar:SetPoint("BOTTOM", self.Health:GetStatusBarTexture(), "TOP")
    otherBar:SetHeight(self.Health:GetHeight())
    otherBar:SetOrientation("VERTICAL")
    otherBar:SetStatusBarTexture(LSM:Fetch("background", "Solid"))
    otherBar:SetStatusBarColor(0.08, 0.3, 0.68)

    local absorbBar = CreateFrame("StatusBar", nil, self.Health)
    absorbBar:SetPoint("LEFT")
    absorbBar:SetPoint("RIGHT")
    absorbBar:SetPoint("BOTTOM", self.Health:GetStatusBarTexture(), "TOP")
    absorbBar:SetHeight(self.Health:GetHeight())
    absorbBar:SetOrientation("VERTICAL")
    absorbBar:SetStatusBarTexture(LSM:Fetch("background", "Solid"))
    absorbBar:SetStatusBarColor(0.15, 0.7, 0.95)

    local healAbsorbBar = CreateFrame("StatusBar", nil, self.Health)
    healAbsorbBar:SetPoint("LEFT")
    healAbsorbBar:SetPoint("RIGHT")
    healAbsorbBar:SetPoint("TOP", self.Health:GetStatusBarTexture())
    healAbsorbBar:SetHeight(self.Health:GetHeight())
    healAbsorbBar:SetReverseFill(true)
    healAbsorbBar:SetOrientation("VERTICAL")
    healAbsorbBar:SetStatusBarTexture(LSM:Fetch("background", "Solid"))
    healAbsorbBar:SetStatusBarColor(0.6, 0.04, 0.4)

    local overAbsorb = self.Health:CreateTexture(nil, "OVERLAY")
    overAbsorb:SetPoint("LEFT")
    overAbsorb:SetPoint("RIGHT")
    overAbsorb:SetPoint("TOP", self.Health:GetStatusBarTexture())
    overAbsorb:SetHeight(self.Health:GetHeight())

	local overHealAbsorb = self.Health:CreateTexture(nil, "OVERLAY")
    overHealAbsorb:SetPoint("LEFT")
    overHealAbsorb:SetPoint("RIGHT")
    overHealAbsorb:SetPoint("TOP", self.Health:GetStatusBarTexture())
    overHealAbsorb:SetHeight(self.Health:GetHeight())
    
    self.HealthPrediction = {
        myBar = myBar,
        otherBar = otherBar,
        absorbBar = absorbBar,
        healAbsorbBar = healAbsorbBar,
        overAbsorb = overAbsorb,
        overHealAbsorb = overHealAbsorb,
        maxOverflow = 1.0,
        frequentUpdates = true,
    }
end