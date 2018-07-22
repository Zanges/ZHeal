local addonName, addonTable = ...
addonTable.Media = ZTweaks:NewModule("Media")
local Media = addonTable.Media
local LSM = LibStub("LibSharedMedia-3.0")


LSM:Register("border", "White Square 1px", [[Interface\AddOns\ZTweaks\Assets\Textures\Border1px.tga]])
LSM:Register("statusbar", "Sleek", [[Interface\AddOns\ZTweaks\Assets\Textures\SleekTexture.tga]])

Media.Colors = setmetatable({
	disconnected = { 0.42, 0.37, 0.32 },
	smooth = setmetatable({
		0.69, 0.31, 0.31,
		0.71, 0.43, 0.27,
		0.17, 0.17, 0.24,
	}, { __index = oUF.colors.smooth }),
	tapped = { 0.42, 0.37, 0.32 },
}, { __index = oUF.colors })

Media.Assets = {
    -- Media.Assets.BACKDROP
	BACKDROP = {
        bgFile = LSM:Fetch("background", "Solid"),
        edgeFile = LSM:Fetch("border", "White Square 1px"),
        tile = true,
        tileSize = 8,
        edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    },
}

function Media:Grayscale(Gradiant, Alpha)
    Alpha = Alpha or 1
    return Gradiant, Gradiant, Gradiant, Alpha
end