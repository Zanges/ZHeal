local addonName, addonTable = ...
local Media = addonTable.Media
local Utility = addonTable.Utility
local LSM = LibStub("LibSharedMedia-3.0")


function addonTable.CreateStatusBar(Name, Parent, AnchorPoint, Offset, BGOffset, Width, Height, RelativeTo, WidthAbsolut, HeightAbsolut, OffsetSizeW, OffsetSizeH, FrequentUpdates, NameIsOverride)
    Offset = Offset or 0
    BGOffset = BGOffset or 0
    RelativeTo = RelativeTo or Parent
    WidthAbsolut = WidthAbsolut or 0
    HeightAbsolut = HeightAbsolut or 0
    OffsetSizeW = OffsetSizeW or Offset
    OffsetSizeH = OffsetSizeH or Offset
    FrequentUpdates = FrequentUpdates or true
    NameIsOverride = NameIsOverride or false
    if (not NameIsOverride) then
        Name = Parent:GetName() .. "_" .. Name
    end
    
	local StatusBar = CreateFrame("StatusBar", Name, Parent)
    StatusBar:SetStatusBarTexture(LSM:Fetch("statusbar", "Sleek"))

    Utility:SetPercentualWidth(StatusBar, Width, RelativeTo, WidthAbsolut, OffsetSizeW)
    Utility:SetPercentualHeight(StatusBar, Height, RelativeTo, HeightAbsolut, OffsetSizeH)

    if AnchorPoint == "TOPLEFT" then
        StatusBar:SetPoint(AnchorPoint, Offset, -Offset)
    elseif AnchorPoint == "TOP" then
        StatusBar:SetPoint(AnchorPoint, 0, -Offset)
    elseif AnchorPoint == "TOPRIGHT" then
        StatusBar:SetPoint(AnchorPoint, -Offset, -Offset)
    elseif AnchorPoint == "LEFT" then
        StatusBar:SetPoint(AnchorPoint, Offset, 0)
    elseif AnchorPoint == "CENTER" then
        StatusBar:SetPoint(AnchorPoint)
    elseif AnchorPoint == "RIGHT" then
        StatusBar:SetPoint(AnchorPoint, -Offset, 0)
    elseif AnchorPoint == "BOTTOMLEFT" then
        StatusBar:SetPoint(AnchorPoint, Offset, Offset)
    elseif AnchorPoint == "BOTTOM" then
        StatusBar:SetPoint(AnchorPoint, 0, -Offset)
    elseif AnchorPoint == "BOTTOMRIGHT" then
        StatusBar:SetPoint(AnchorPoint, -Offset, Offset)
    end

	StatusBar.frequentUpdates = true

	local BG = StatusBar:CreateTexture(nil, "BACKGROUND")
	BG:SetTexture(LSM:Fetch("statusbar", "Sleek"))
	BG:SetPoint("TOPLEFT", -BGOffset, BGOffset)
	BG:SetPoint("BOTTOMRIGHT", BGOffset, -BGOffset)

    return StatusBar, BG
end