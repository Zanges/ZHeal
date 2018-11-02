local addonName, addonTable = ...
local Options = ZHeal:NewModule("Options", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local Utility = addonTable.Utility


local options = {
    name = addonName,
    handler = ZHeal,
    type = "group",
    args = {
        unitframes = {
            name = "Unitframes",
            order = 1,
            type = "group",
            args = {
                unitWidth = {
                    name = "Unitframes Width",
                    order = 10,
                    type = "range",
                    min = 10,
                    max = 200,
                    step = 1,
                    set = function(info, input)
						ZHeal.db.profile.unitWidth = input
					end,
					get = function(info)
						return ZHeal.db.profile.unitWidth
					end,
                },
                buttonSpacing = {
                    name = "Button Spacing",
                    order = 20,
                    type = "range",
                    min = 0,
                    max = 20,
                    step = 1,
                    set = function(info, input)
						ZHeal.db.profile.buttonSpacing = input
					end,
					get = function(info)
						return ZHeal.db.profile.buttonSpacing
					end,
                },
                positionX = {
                    name = "Position X",
                    order = 30,
                    type = "range",
                    min = -2000,
                    max = 2000,
                    step = 1,
                    set = function(info, input)
                        ZHeal.db.profile.positionX = input
                        _G[addonName .. "_UnitFrames_PositionFrame"]:SetPoint("CENTER", input, ZHeal.db.profile.positionY)
					end,
					get = function(info)
						return ZHeal.db.profile.positionX
					end,
                },
                positionY = {
                    name = "Position Y",
                    order = 30,
                    type = "range",
                    min = -2000,
                    max = 2000,
                    step = 1,
                    set = function(info, input)
                        ZHeal.db.profile.positionY = input
                        _G[addonName .. "_UnitFrames_PositionFrame"]:SetPoint("CENTER", ZHeal.db.profile.positionX, input)
					end,
					get = function(info)
						return ZHeal.db.profile.positionY
					end,
                },
            },
        },
        healButtons = {
            name = "Heal Buttons",
            order = 2,
            type = "group",
            args = {
                numButtons = {
                    name = "Button Count",
                    order = 10,
                    type = "range",
                    min = 1,
                    max = 32,
                    softMax = 12,
                    step = 1,
                    set = function(info, input)
						ZHeal.db.class.numButtons = input
					end,
					get = function(info)
						return ZHeal.db.class.numButtons
					end,
                },
                saveButtons = {
                    name = "Save",
                    order = 20,
                    type = "execute",
                    func = function()
                        local UnitFramesModule = ZHeal:GetModule("UnitFramesModule")
                        local array = UnitFramesModule:GetHealButtonPlayerSpellArray()

                        for i,v in ipairs(array) do
                            ZHeal.db.class.healButtonSpells[i] = v
                        end

                        UnitFramesModule:UpdateButtons(array)
                    end,
                },
            },
        },
    },
}

local defaults = {
	profile = {
        unitWidth = 40,
        buttonSpacing = 4,
        positionX = 0,
        positionY = 0,
	},
	char = {
        
    },
    class = {
        healButtonSpells = {},
        numButtons = 5,
    },
    global = {

    },
}

function Options:OnInitialize()
	ZHeal.db = LibStub("AceDB-3.0"):New("ZHealDB", defaults, true)
	
	options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(ZHeal.db)
	LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, options, {"ZHealcmd"})
	Options:RegisterChatCommand("ZHeal", "OpenStandaloneConfig")
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName)
end

function Options:OpenStandaloneConfig()
	LibStub("AceConfigDialog-3.0"):Open(addonName)
end