local addonName, addonTable = ...
local Media = addonTable.Media
local Utility = addonTable.Utility
local LSM = LibStub("LibSharedMedia-3.0")


function addonTable.AddHealthBar(self, Parent, AnchorPoint, Offset, BGOffset, Width, Height, RelativeTo, WidthAbsolut, HeightAbsolut, OffsetSizeW, OffsetSizeH, FrequentUpdates)
    local HealthBar, BG = addonTable.CreateStatusBar("HealthBar", Parent, AnchorPoint, Offset, BGOffset, Width, Height, RelativeTo, WidthAbsolut, HeightAbsolut, OffsetSizeW, OffsetSizeH, FrequentUpdates)
    
    HealthBar.colorTapping = true
	HealthBar.colorDisconnected = true
    HealthBar.colorSmooth = true
    
    self.Health = HealthBar
    return HealthBar, BG
end