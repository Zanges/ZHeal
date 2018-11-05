local addonName, addonTable = ...
local Media = addonTable.Media
local Utility = addonTable.Utility
local LSM = LibStub("LibSharedMedia-3.0")


function addonTable.AddNameText(parent, unit, font, fontSize, xOffset, yOffset, anchorPoint, anchorTo)
    local Name
    if (UnitIsPlayer(unit)) then
        Name = Utility:ClassColorVerticalText(select(2, UnitClass(unit)), strupper(UnitName(unit)), ZHeal.db.profile.nameMaxLength)
    end

    local NameText = CreateFrame("Frame", nil, parent)

    local FS = NameText:CreateFontString()
    FS:SetFont(font, fontSize, "OUTLINE")
    FS:SetText(Name)

    NameText:SetSize(FS:GetWidth(), FS:GetHeight())

    FS:SetPoint("CENTER")
    NameText:SetPoint(anchorPoint, parent, anchorTo or anchorPoint, xOffset, yOffset)

    NameText.FontString = FS
    parent.NameText = NameText
    return NameText
end

function addonTable.AddHealthText(parent, unit, font, fontSize, xOffset, yOffset, anchorPoint, anchorTo)
    local HealthText = CreateFrame("Frame", nil, parent)
    local fontSizeNormal = fontSize
    local fontSizeDead = fontSize
    if fontSizeNormal > 4 then
        fontSizeDead = fontSize - 4
    end

    local FS = HealthText:CreateFontString()
    FS:SetFont(font, fontSize, "OUTLINE")
    FS:SetText(100.0)

    HealthText:SetSize(FS:GetWidth(), FS:GetHeight())

    FS:SetPoint("CENTER")
    FS:SetJustifyH("CENTER")
    HealthText:SetPoint(anchorPoint, parent, anchorTo or anchorPoint, xOffset, yOffset)

    HealthText:RegisterEvent("UNIT_HEALTH")
    local function eventHandler(self, event, ...)
        if event == "UNIT_HEALTH" then
            if UnitIsDeadOrGhost(unit) then
                FS:SetText("DEAD")
                FS:SetFont(font, fontSizeDead, "OUTLINE")
            else
                local HP = (UnitHealth(unit) / UnitHealthMax(unit)) * 100
                FS:SetText(Utility:Truncate(HP, 1))
                FS:SetFont(font, fontSizeNormal, "OUTLINE")
            end
        end
    end
    HealthText:SetScript("OnEvent", eventHandler)

    FS:SetTextColor(ZHeal.db.profile.textColorHealth["R"], ZHeal.db.profile.textColorHealth["G"], ZHeal.db.profile.textColorHealth["B"], 1)

    HealthText.FontString = FS
    parent.HealthText = HealthText
    return HealthText
end

function addonTable.AddTexts(parent, unit, font, fontSizeName, xOffsetName, yOffsetName, anchorPointName, anchorNameTo, fontSizeHealth, xOffsetHealth, yOffsetHealth, anchorPointHealth, anchorHealthTo)
    local NameText = addonTable.AddNameText(parent, unit, font, fontSizeName, xOffsetName, yOffsetName, anchorPointName, anchorNameTo)
    local HealthText = addonTable.AddHealthText(parent, unit, font, fontSizeHealth, xOffsetHealth, yOffsetHealth, anchorPointHealth, anchorHealthTo)
    
    return NameText, HealthText
end
