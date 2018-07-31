local addonName, addonTable = ...
local ActionBarModule = ZTweaks:NewModule("ActionBarModule")
local Utility = addonTable.Utility
local LAB = LibStub("LibActionButton-1.0")


ActionBarModule.Buttons = {}


function ActionBarModule:OnInitialize()
    local ZTweaksActionBarHeader = CreateFrame("Frame", "ZTweaksActionBarHeader", UIParent, "SecureHandlerStateTemplate")
    RegisterStateDriver(ZTweaksActionBarHeader, "page", "[mod:alt]2;1")
    ZTweaksActionBarHeader:SetAttribute("_onstate-page", [[
        self:SetAttribute("state", newstate)
        control:ChildUpdate("state", newstate)
    ]])

    local ButtonConfig = {
        outOfRangeColoring = "button",
        tooltip = "enabled",
        showGrid = true,
        colors = {
            range = { 0.8, 0.1, 0.1 },
            mana = { 0.5, 0.5, 1.0 }
        },
        hideElements = {
            macro = false,
            hotkey = false,
            equipped = false,
        },
        keyBoundTarget = false,
        clickOnDown = false,
        flyoutDirection = "UP",
    }
    
    ActionBarModule.Buttons["button"] = LAB:CreateButton(1, "Test1", ZTweaksActionBarHeader, ButtonConfig)
    
    ActionBarModule.Buttons["button"]:SetPoint("CENTER", UIParent)
    ActionBarModule.Buttons["button"]:Show()
    ActionBarModule.Buttons["button"]:SetState(1, "action", 1)
    ActionBarModule.Buttons["button"]:SetState(2, "action", 2)
    
end

function ActionBarModule:OnEnable()
    
end

function ActionBarModule:OnDisable()
	
end