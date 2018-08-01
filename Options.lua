local addonName, addonTable = ...
local Options = ZTweaks:NewModule("Options", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local Media = addonTable.Media
local Utility = addonTable.Utility


local options = {
    name = addonName,
    handler = ZTweaks,
    type = "group",
    args = {
		mouselook = {
			name = "Mouselook",
			order = 10,
			type = "group",
			args = {
				moduleEnabled = {
					type = "toggle",
					name = "Mouselook Module Enabled",
					set = function(info, input)
						ZTweaks.db.profile.modules.enabled.mouselook = input
						ZTweaks:GetModule("MouseLookModule"):SetEnabledState(input)
					end,
					get = function(info)
						return ZTweaks.db.profile.modules.enabled.mouselook
					end,
				},
			},
		},
		unitframes = {
			name = "Unit Frames",
			order = 20,
			type = "group",
			args = {
				enabled = {
					type = "toggle",
					name = "Unit Frames Module Enabled",
					set = function(info, input)
						ZTweaks.db.profile.modules.enabled.unitframes = input
					end,
					get = function(info)
						return ZTweaks.db.profile.modules.enabled.unitframes
					end,
				},
			},
		},
		hud = {
			name = "HUD",
			order = 21,
			type = "group",
			args = {
				enabled = {
					type = "toggle",
					name = "HUD Module Enabled",
					set = function(info, input)
						ZTweaks.db.profile.modules.enabled.hud = input
					end,
					get = function(info)
						return ZTweaks.db.profile.modules.enabled.hud
					end,
				},
			},
		},
		mousecast = {
			name = "Mouse Cast",
			order = 30,
			type = "group",
			args = {
				enabled = {
					type = "toggle",
					name = "Mouse Cast Module Enabled",
					set = function(info, input)
						ZTweaks.db.profile.modules.enabled.mousecast = input
						ZTweaks:GetModule("MouseCastModule"):SetEnabledState(input)
					end,
					get = function(info)
						return ZTweaks.db.profile.modules.enabled.mousecast
					end,
				},
				key = {
					type = "keybinding",
					name = "Key",
					set = function(info, input)
						ZTweaks.db.profile.modules.mousecast.key = input
					end,
					get = function(info)
						return ZTweaks.db.profile.modules.mousecast.key
					end,
				},
				size = {
					type = "range",
					name = "Size",
					min = 50,
					max = 1000,
					step = 50,
					set = function(info, input)
						ZTweaks.db.profile.modules.mousecast.size = input
					end,
					get = function(info)
						return ZTweaks.db.profile.modules.mousecast.size
					end,
				},
				spell = {
					type = "execute",
					name = "Spell",
					func = function()
						ZTweaks:GetModule("Options"):OpenSpellBindUI()
					end,
				},
				usemouseover = {
					type = "toggle",
					name = "Use Mouseover",
					set = function(info, input)
						ZTweaks.db.char.modules.mousecast.usemouseover[GetSpecialization()] = input
					end,
					get = function(info)
						return ZTweaks.db.char.modules.mousecast.usemouseover[GetSpecialization()]
					end,
				},
			},
		},
		tradetweaks = {
			name = "Trade Tweaks",
			order = 60,
			type = "group",
			args = {
				enabled = {
					type = "toggle",
					name = "Trade Tweaks Module Enabled",
					set = function(info, input)
						ZTweaks.db.profile.modules.enabled.tradetweaks = input
						ZTweaks:GetModule("TradeTweaksModule"):SetEnabledState(input)
					end,
					get = function(info)
						return ZTweaks.db.profile.modules.enabled.tradetweaks
					end,
				},
			},
		},
    },
}

Options.SpellNameDisplay = options.args.mousecast.args.spell.name

local defaults = {
	profile = {
		modules = {
			enabled = {
				mouselook = true,
				unitframes = false,
				hud = true,
				mousecast = true,
				tradetweaks = true,
			},
			mousecast = {
				key = nil,
				size = 250,
			},
		},
	},
	char = {
		modules = {
			mousecast = {
				usemouseover = {
					[1] = false,
					[2] = false,
					[3] = false,
					[4] = false,
				},
				abilityList = {
					[1] = {
							[1] = {
								[1] = nil,
								[2] = nil,
								[3] = nil,
								[4] = nil,
								[5] = nil,
							},
							[2] = {
								[1] = nil,
								[2] = nil,
								[3] = nil,
								[4] = nil,
								[5] = nil,
							},
							[3] = {
								[1] = nil,
								[2] = nil,
								[3] = nil,
								[4] = nil,
								[5] = nil,
							},
							[4] = {
								[1] = nil,
								[2] = nil,
								[3] = nil,
								[4] = nil,
								[5] = nil,
							},
							[5] = {
								[1] = nil,
								[2] = nil,
								[3] = nil,
								[4] = nil,
								[5] = nil,
							},
					},
					[2] = {
						[1] = {
							[1] = nil,
							[2] = nil,
							[3] = nil,
							[4] = nil,
							[5] = nil,
						},
						[2] = {
							[1] = nil,
							[2] = nil,
							[3] = nil,
							[4] = nil,
							[5] = nil,
						},
						[3] = {
							[1] = nil,
							[2] = nil,
							[3] = nil,
							[4] = nil,
							[5] = nil,
						},
						[4] = {
							[1] = nil,
							[2] = nil,
							[3] = nil,
							[4] = nil,
							[5] = nil,
						},
						[5] = {
							[1] = nil,
							[2] = nil,
							[3] = nil,
							[4] = nil,
							[5] = nil,
						},
					},
					[3] = {
						[1] = {
							[1] = nil,
							[2] = nil,
							[3] = nil,
							[4] = nil,
							[5] = nil,
						},
						[2] = {
							[1] = nil,
							[2] = nil,
							[3] = nil,
							[4] = nil,
							[5] = nil,
						},
						[3] = {
							[1] = nil,
							[2] = nil,
							[3] = nil,
							[4] = nil,
							[5] = nil,
						},
						[4] = {
							[1] = nil,
							[2] = nil,
							[3] = nil,
							[4] = nil,
							[5] = nil,
						},
						[5] = {
							[1] = nil,
							[2] = nil,
							[3] = nil,
							[4] = nil,
							[5] = nil,
						},
					},
					[4] = {
						[1] = {
							[1] = nil,
							[2] = nil,
							[3] = nil,
							[4] = nil,
							[5] = nil,
						},
						[2] = {
							[1] = nil,
							[2] = nil,
							[3] = nil,
							[4] = nil,
							[5] = nil,
						},
						[3] = {
							[1] = nil,
							[2] = nil,
							[3] = nil,
							[4] = nil,
							[5] = nil,
						},
						[4] = {
							[1] = nil,
							[2] = nil,
							[3] = nil,
							[4] = nil,
							[5] = nil,
						},
						[5] = {
							[1] = nil,
							[2] = nil,
							[3] = nil,
							[4] = nil,
							[5] = nil,
						},
					},
				},
			},
		},
	},
}

local SpellBindUI
local SpellBindUIIconList = {}

function Options:OnInitialize()
	ZTweaks.db = LibStub("AceDB-3.0"):New("ZTweaksDB", defaults, true)
	
	options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(ZTweaks.db)
	LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, options, {"ztweakscmd"})
	Options:RegisterChatCommand("zt", "OpenStandaloneConfig")
	Options:RegisterChatCommand("ztweaks", "OpenStandaloneConfig")
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName)

	ZTweaks:GetModule("MouseLookModule"):SetEnabledState(ZTweaks.db.profile.modules.enabled.mouselook)
	ZTweaks:GetModule("MouseCastModule"):SetEnabledState(ZTweaks.db.profile.modules.enabled.mousecast)
	ZTweaks:GetModule("TradeTweaksModule"):SetEnabledState(ZTweaks.db.profile.modules.enabled.tradetweaks)

	Options:CreateSpellBindUI(40, 5, 10, 10, -100, -150)
	Options:UpdateSpellBindUI()
end

function Options:OpenStandaloneConfig()
	LibStub("AceConfigDialog-3.0"):Open(addonName)
end

function Options:CreateSpellBindUI(ButtonSize, ButtonDistance, FrameBufferX, FrameBufferY, X, Y)
	local Width = (ButtonSize * 5) + (ButtonDistance * 4) + (FrameBufferX * 2)
	local Height = (ButtonSize * 5) + (ButtonDistance * 4) + (FrameBufferY * 2) + 20
	SpellBindUI = CreateFrame("Frame", addonName .. "SpellBindUI")
	SpellBindUI:SetWidth(Width)
	SpellBindUI:SetHeight(Height)
	SpellBindUI:SetPoint("TOPRIGHT", X, Y)
	SpellBindUI:SetBackdrop(Media.Assets.BACKDROP)
	SpellBindUI:SetBackdropBorderColor(Media:Grayscale(0.4))
	SpellBindUI:SetBackdropColor(Media:Grayscale(0.15))
	SpellBindUI:SetMovable(true)
	SpellBindUI:EnableMouse(true)
	SpellBindUI:RegisterForDrag("LeftButton")
	SpellBindUI:SetScript("OnDragStart", SpellBindUI.StartMoving)
	SpellBindUI:SetScript("OnDragStop", SpellBindUI.StopMovingOrSizing)
	
	local Close = CreateFrame("Button", nil, SpellBindUI)
	Close:SetWidth(16)
	Close:SetHeight(16)
	Close:SetPoint("TOPRIGHT")
	local FS = Close:CreateFontString()
	FS:SetFont("Fonts\\FRIZQT__.TTF", 16) --LibStub("LibSharedMedia-3.0"):Fetch("Friz Quadrata TT")
	FS:SetText("X")
	Close:SetFontString(FS)
	Close:RegisterForClicks("AnyUp")
	Close:SetScript("OnClick", function (self, button, down)
		self:GetParent():Hide()
	end)

	for spec = 1, 4 do
		SpellBindUIIconList[spec] = {}
		for ix = 1, 5 do
			SpellBindUIIconList[spec][ix] = {}
			for iy = 1, 5 do
				local Icon = CreateFrame("Button", nil, SpellBindUI)
				Icon:SetWidth(ButtonSize)
				Icon:SetHeight(ButtonSize)
				local X = ((ButtonSize + ButtonDistance) * (ix - 1)) + FrameBufferX
				local Y = ((ButtonSize + ButtonDistance) * (iy - 1)) + FrameBufferY
				Icon:SetPoint("BOTTOMLEFT", X, Y)
				local IconTexture = Icon:CreateTexture(nil, "ARTWORK")
				IconTexture:SetAllPoints()
		
				SpellBindUIIconList[spec][ix][iy] = IconTexture

				Icon:RegisterForClicks("AnyUp")
				Icon:SetScript("OnClick", function (self, button, down)
					local currentSpec = GetSpecialization()
					if button == "LeftButton" then
						if CursorHasSpell() then
							local _, _, _, SpellID = GetCursorInfo()
							ZTweaks.db.char.modules.mousecast.abilityList[currentSpec][ix][iy] = SpellID
							ClearCursor()
							ZTweaks:GetModule("Options"):UpdateSpellBindUI()
						end
					elseif button == "RightButton" then
						ZTweaks.db.char.modules.mousecast.abilityList[currentSpec][ix][iy] = 0
						ZTweaks:GetModule("Options"):UpdateSpellBindUI()
					end
				end)
			end
		end
	end

	SpellBindUI:Hide()
end

function Options:OpenSpellBindUI()
	SpellBindUI:Show()
end

function Options:UpdateSpellBindUI()
	local currentSpec = GetSpecialization()
	for ix = 1, 5 do
		for iy = 1, 5 do
			local Texture
			local SpellID = ZTweaks.db.char.modules.mousecast.abilityList[currentSpec][ix][iy]
			if SpellID ~= nil and SpellID ~= 0 then
				Texture = GetSpellTexture(SpellID)
			else
				Texture = Media.QuestionMark
			end
			SpellBindUIIconList[currentSpec][ix][iy]:SetTexture(Texture)
		end
	end
end