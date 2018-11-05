local addonName, addonTable = ...
local Media = addonTable.Media
local Utility = addonTable.Utility
local LSM = LibStub("LibSharedMedia-3.0")


function addonTable.AddDispel(self, unit)
	local Dispellable = {}

	local Texture = self:CreateTexture(nil, "OVERLAY")
    Texture:SetTexture(LSM:Fetch(LSM.MediaType.BACKGROUND, "Blizzard Low Health"))
	Texture:SetBlendMode("ADD")
	Texture:SetAllPoints()
	Dispellable.dispelTexture = Texture

    self.Dispellable = Dispellable
    --self.Dispellable.dispelTexture:Hide()
end