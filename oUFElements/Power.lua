local addonName, addonTable = ...
local Media = addonTable.Media
local Utility = addonTable.Utility
local LSM = LibStub("LibSharedMedia-3.0")


function addonTable.AddPowerBar(self, Parent, AnchorPoint, Offset, BGOffset, Width, Height, RelativeTo, WidthAbsolut, HeightAbsolut, OffsetSizeW, OffsetSizeH, FrequentUpdates)
    local PowerBar, BG = addonTable.CreateStatusBar("PowerBar", Parent, AnchorPoint, Offset, BGOffset, Width, Height, RelativeTo, WidthAbsolut, HeightAbsolut, OffsetSizeW, OffsetSizeH, FrequentUpdates)
    
    PowerBar.colorPower = true
	PowerBar.colorClass = true
    PowerBar.colorReaction = true

    BG.multiplier = 1/3

    PowerBar.bg = BG
    self.Power = PowerBar
    return PowerBar, BG
end