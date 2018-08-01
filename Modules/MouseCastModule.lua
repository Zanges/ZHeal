local addonName, addonTable = ...
local MouseCastModule = ZTweaks:NewModule("MouseCastModule")
local Utility = addonTable.Utility
local Media = addonTable.Media


MouseCastModule.MarkerID = 1

function MouseCastModule:OnInitialize()
    local ZTweaksMouseCastBindingHandler = CreateFrame("BUTTON", "ZTweaksMouseCastBindingHandler", UIParent, "SecureHandlerMouseUpDownTemplate, SecureActionButtonTemplate")

    local MouseCastContainerSize = ZTweaks.db.profile.modules.mousecast.size
    local MouseCastMarkerSize = (ZTweaks.db.profile.modules.mousecast.size / 5)
    local MouseCastContainer = CreateFrame("Frame", "ZTweaksMouseCastContainer", UIParent, "SecureHandlerShowHideTemplate, SecureFrameTemplate")
    MouseCastContainer:SetWidth(MouseCastContainerSize)
    MouseCastContainer:SetHeight(MouseCastContainerSize)
    MouseCastContainer:SetAttribute("ContainerSize", MouseCastContainerSize)
    MouseCastContainer:SetAttribute("MarkerSize", MouseCastMarkerSize)
    MouseCastContainer:SetPoint("CENTER")
    MouseCastContainer:SetAttribute("GameWidth", GetScreenWidth())
    MouseCastContainer:SetAttribute("GameHeight", GetScreenHeight())
    MouseCastContainer:Hide()

    local Helper = CreateFrame("Frame", nil , UIParent, "SecureFrameTemplate")

    local currentSpec = GetSpecialization()
    for ix = 1, 5 do
		for iy = 1, 5 do
            local SpellID = ZTweaks.db.char.modules.mousecast.abilityList[currentSpec][ix][iy]
            local btn
            if SpellID ~= nil and SpellID ~= 0 then
                MouseCastModule:CreateMarker(SpellID, MouseCastContainer, MouseCastMarkerSize, nil, 0.4, (ix - 1) * MouseCastMarkerSize, (iy - 1) * MouseCastMarkerSize)
			end
            Helper:SetAttribute("AbilityList" .. ix .. iy, GetSpellInfo(SpellID))
            Helper:SetAttribute("AbilityButton" .. ix .. iy, btn)
		end
    end

    Helper:SetAttribute("useMouseOver", ZTweaks.db.char.modules.mousecast.usemouseover[GetSpecialization()])
    
    ZTweaksMouseCastBindingHandler:SetFrameRef("MouseCastContainer", MouseCastContainer)
    ZTweaksMouseCastBindingHandler:SetFrameRef("Helper", Helper)
    ZTweaksMouseCastBindingHandler:SetFrameRef("MousePositionFrame", UIParent)

    ZTweaksMouseCastBindingHandler:Execute([[
        MouseCastContainer = self:GetFrameRef("MouseCastContainer")
        MousePositionFrame = self:GetFrameRef("MousePositionFrame")
        Helper = self:GetFrameRef("Helper")
    ]])

    ZTweaksMouseCastBindingHandler:SetAttribute("_onmousedown", [=[
        if button ~= "HideOnlyButton" then
            if Helper:GetAttribute("useMouseOver") then
                self:SetAttribute("type", "focus")
                self:SetAttribute("focus", "mouseover")
            end

            local GameWidth = MouseCastContainer:GetAttribute("GameWidth")
            local GameHeight = MouseCastContainer:GetAttribute("GameHeight")
            local xPerc, yPerc = MousePositionFrame:GetMousePosition()
            local x, y = xPerc * GameWidth, yPerc * GameHeight

            MouseCastContainer:ClearAllPoints()
            MouseCastContainer:SetPoint("CENTER", MousePositionFrame, "BOTTOMLEFT", x, y)

            MouseCastContainer:Show()
        end
    ]=])
    ZTweaksMouseCastBindingHandler:SetAttribute("_onmouseup", [=[
        local MouseCastContainerSize = MouseCastContainer:GetAttribute("ContainerSize")
        local MouseCastMarkerSize = MouseCastContainer:GetAttribute("MarkerSize")
        local xPerc, yPerc = MouseCastContainer:GetMousePosition()
        if xPerc ~= nil and yPerc ~= nil then
            local x, y = xPerc * MouseCastContainerSize, yPerc * MouseCastContainerSize

            local ix = floor(x / MouseCastMarkerSize) + 1
            local iy = floor(y / MouseCastMarkerSize) + 1
            local Spell = Helper:GetAttribute("AbilityList" .. ix .. iy)
            
            if Spell ~= nil then
                if Helper:GetAttribute("useMouseOver") and UnitExists("focus") then
                    self:SetAttribute("type", "spell")
                    self:SetAttribute("spell", Spell)
                    --self:SetAttribute("unit", "focus")
                else
                    self:SetAttribute("type", "spell")
                    self:SetAttribute("spell", Spell)
                end
            end
        end

        MouseCastContainer:Hide()
    ]=])
    
    MouseCastContainer:SetAttribute("_onshow", [=[
        self:SetBindingClick(true, "BUTTON1", "ZTweaksMouseCastBindingHandler", "HideOnlyButton")	
    ]=])
    MouseCastContainer:SetAttribute("_onhide", [=[
        self:ClearBindings()
    ]=])

    if ZTweaks.db.profile.modules.mousecast.key ~= nil then
        SetOverrideBindingClick(ZTweaksMouseCastBindingHandler, true, ZTweaks.db.profile.modules.mousecast.key, ZTweaksMouseCastBindingHandler:GetName())
    end
end

function MouseCastModule:OnEnable()
    
end

function MouseCastModule:OnDisable()
	
end

function MouseCastModule:CreateMarker(SpellID, Parent, Size, IconOffset, Alpha, X, Y)
    Size = Size or 32
    IconOffset = IconOffset or 0

    local Name = addonName .. "_MouseCastMarker" .. MouseCastModule.MarkerID
    local IconSize = Size
    if IconOffset ~= 0 then
        IconSize = Size - (2 * IconOffset)
    end
    if SpellID == 0 then
        SpellID = nil
    end
    

    local Marker = CreateFrame("Frame", Name, Parent)
    Marker:SetWidth(Size)
    Marker:SetHeight(Size)
    Marker:SetPoint("BOTTOMLEFT", X, Y)

    local Icon = CreateFrame("Frame", Name .. "_Icon", Marker)
    Icon:SetWidth(IconSize)
    Icon:SetHeight(IconSize)
    Icon:SetAlpha(Alpha)
    Icon:SetPoint("CENTER")
    local IconTexture = Icon:CreateTexture(Name .. "_IconTexture", "ARTWORK")
    IconTexture:SetTexture(GetSpellTexture(SpellID))
    IconTexture:SetWidth(IconSize)
    IconTexture:SetHeight(IconSize)
    IconTexture:SetPoint("CENTER")

    local Cooldown = CreateFrame("Cooldown", Name .. "_Cooldown", Icon, "CooldownFrameTemplate")
    Cooldown:SetWidth(IconSize)
    Cooldown:SetHeight(IconSize)
    Cooldown:SetPoint("CENTER")
    Cooldown:RegisterEvent("COMBAT_LOG_EVENT")
    Cooldown:RegisterEvent("SPELL_UPDATE_COOLDOWN")
    Cooldown:SetScript("OnEvent", function(self, event, ...)
        if event == "COMBAT_LOG_EVENT" or event == "SPELL_UPDATE_COOLDOWN" then
            local start, duration = GetSpellCooldown(SpellID)
            self:SetCooldown(start, duration)
        end
        
    end)
    
    Marker:Show()
    Icon:Show()
    IconTexture:Show()
    Cooldown:Show()

    MouseCastModule.MarkerID = MouseCastModule.MarkerID + 1
    return Marker
end