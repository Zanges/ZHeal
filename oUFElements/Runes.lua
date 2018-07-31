local addonName, addonTable = ...
local Media = addonTable.Media
local Utility = addonTable.Utility
local LSM = LibStub("LibSharedMedia-3.0")


function addonTable.AddRunes(self, width, height, spacing, Alpha)
	local runes = {}
	local maxRunes = 6
    local barWidth = width
    width = (width - (maxRunes + 1) * spacing) / maxRunes
    spacing = width + spacing
    local offset = (barWidth / 2) - (width / 2)
    for i = 1, maxRunes do
		local rune = CreateFrame("StatusBar", nil, self)
		rune:SetSize(width, height)
		rune:SetPoint("CENTER", NamePlatePlayerResourceFrame, ((i - 1) * spacing + 1) - offset, -10)
		rune:SetStatusBarTexture(LSM:Fetch("background", "Solid"))
        rune:SetAlpha(Alpha)
    	local bg = rune:CreateTexture(nil, "BACKGROUND")
		bg:SetTexture(LSM:Fetch("background", "Solid"))
		bg:SetAllPoints()
		bg.multiplier = 1/3
        rune.bg = bg
		runes[i] = rune
	end
    runes.colorSpec = true
     
	self.Runes = runes
end