local addonName, addonTable = ...
local Media = addonTable.Media
local Utility = addonTable.Utility
local LSM = LibStub("LibSharedMedia-3.0")


local function PostUpdateCast(castbar, unit, name)
	if(castbar.notInterruptible and UnitCanAttack('player', unit)) then
		castbar:SetStatusBarColor(0.69, 0.31, 0.31)
	else
		castbar:SetStatusBarColor(0.77, 0.88, 0.33)
	end
end

function addonTable.AddCastBar(self, unit, vertical, Alpha)
	local castbar = CreateFrame("StatusBar", nil, self)
	castbar:SetStatusBarTexture(LSM:Fetch("background", "Solid"))
	castbar:SetStatusBarColor(0.77, 0.88, 0.33)
    castbar:SetAllPoints(self)--.Overlay)
    castbar:SetAlpha(Alpha)

    if vertical == true then
        castbar:SetOrientation("VERTICAL")
    end

    castbar.PostCastStart = PostUpdateCast
	castbar.PostChannelStart = PostUpdateCast
	castbar.PostCastInterruptible = PostUpdateCast
	castbar.PostCastNotInterruptible = PostUpdateCast

    self.Castbar = castbar
    return castbar
end