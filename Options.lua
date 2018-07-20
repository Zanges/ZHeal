local addonName, addonTable = ...
local Options = ZTweaks:NewModule("Options")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

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
					end,
					get = function(info)
						return ZTweaks.db.profile.modules.enabled.mouselook
					end,
				},
			},
		},
    },
}

local defaults = {
	profile = {
		modules = {
			enabled = {
				mouselook = true
			}
		}
	}
}

function Options:OnInitialize()
	ZTweaks.db = LibStub("AceDB-3.0"):New("ZTweaksDB", defaults, true)
	
	options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(ZTweaks.db)
	LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, options, {"ztweaks", "zt"})
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName)
end