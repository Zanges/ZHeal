local addonName, addonTable = ...
local Media = addonTable.Media
local Utility = addonTable.Utility
local LSM = LibStub("LibSharedMedia-3.0")


function addonTable.AddHealthBar(self, Parent, AnchorPoint, Offset, BGOffset, Width, Height, RelativeTo, WidthAbsolut, HeightAbsolut, OffsetSizeW, OffsetSizeH, Alpha, AlphaBG, FrequentUpdates)
    local HealthBar, BG = addonTable.CreateStatusBar("HealthBar", Parent, AnchorPoint, Offset, BGOffset, Width, Height, RelativeTo, WidthAbsolut, HeightAbsolut, OffsetSizeW, OffsetSizeH, Alpha, AlphaBG, FrequentUpdates)
    
    HealthBar.colorTapping = true
	HealthBar.colorDisconnected = true
    HealthBar.colorSmooth = true
    
    BG.multiplier = 1/3

    HealthBar.bg = BG
    self.Health = HealthBar
    return HealthBar, BG
end

function addonTable.AddVerticalHealthBar(self, Parent, AnchorPoint, Offset, BGOffset, Width, Height, RelativeTo, WidthAbsolut, HeightAbsolut, OffsetSizeW, OffsetSizeH, Alpha, AlphaBG, FrequentUpdates)
    local HealthBar, BG = addonTable.CreateVerticalStatusBar("HealthBar", Parent, AnchorPoint, Offset, BGOffset, Width, Height, RelativeTo, WidthAbsolut, HeightAbsolut, OffsetSizeW, OffsetSizeH, Alpha, AlphaBG, FrequentUpdates)
    
    HealthBar.colorTapping = true
	HealthBar.colorDisconnected = true
    HealthBar.colorSmooth = true
    
    BG.multiplier = 1/3
    HealthBar.bg = BG
    
    self.Health = HealthBar
    return HealthBar, BG
end