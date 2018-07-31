local addonName, addonTable = ...
local TradeTweaksModule = ZTweaks:NewModule("TradeTweaksModule")
local Media = addonTable.Media


function TradeTweaksModule:OnInitialize()
    local ButtonHeight = 18
    local NumButtons = 5
    local Spacing = 3
    local Width = 90
    local Height = ((ButtonHeight + Spacing) * NumButtons) - Spacing
    local TradeTweaksFrame = CreateFrame("Frame", addonName .. "_TradeTweaksFrame", TradeFrame)
    TradeTweaksFrame:SetWidth(Width)
	TradeTweaksFrame:SetHeight(Height)
	TradeTweaksFrame:SetPoint("TOPLEFT", TradeFrame, "TOPRIGHT")
	TradeTweaksFrame:SetBackdrop(Media.Assets.BACKDROP)
	TradeTweaksFrame:SetBackdropBorderColor(Media:Grayscale(0.4))
    TradeTweaksFrame:SetBackdropColor(Media:Grayscale(0.15))
    
    TradeTweaksModule:CreateButton(TradeTweaksFrame, 100, Width, ButtonHeight, Spacing, 1)
    TradeTweaksModule:CreateButton(TradeTweaksFrame, 1000, Width, ButtonHeight, Spacing, 2)
    TradeTweaksModule:CreateButton(TradeTweaksFrame, 5000, Width, ButtonHeight, Spacing, 3)
    TradeTweaksModule:CreateButton(TradeTweaksFrame, 25000, Width, ButtonHeight, Spacing, 4)
    TradeTweaksModule:CreateButton(TradeTweaksFrame, 100000, Width, ButtonHeight, Spacing, 5)
end

function TradeTweaksModule:OnEnable()
	
end

function TradeTweaksModule:OnDisable()
	
end

function TradeTweaksModule:ModifyTradeMoney(Amount, Remove)
    Remove = Remove or false
    local Curr = GetPlayerTradeMoney()
    Curr = Curr or 0
    Amount = Amount * 10000
    if Remove then
        if Curr < Amount then
            return false
        else
            SetTradeMoney(Curr - Amount)
            _G["TradePlayerInputMoneyFrameGold"]:SetText(Curr - Amount)
            return true
        end
    else
        SetTradeMoney(Curr + Amount)
        
        _G["TradePlayerInputMoneyFrameGold"]:SetText(Curr + Amount)
        TradeFrame_UpdateMoney()
        return true
    end
end

function TradeTweaksModule:CreateButton(Parent, Amount, Width, Height, Spacing, Num)
    local Btn = CreateFrame("Button", nil, Parent)
    Btn:SetWidth(Width)
    Btn:SetHeight(Height)
    Btn:SetPoint("TOPLEFT", 0, -((Num - 1) * (Height + Spacing)))
    local FS = Btn:CreateFontString()
	FS:SetFont("Fonts\\FRIZQT__.TTF", 16)
    FS:SetText(Amount .. " G")
    Btn:SetFontString(FS)
	Btn:RegisterForClicks("AnyUp")
	Btn:SetScript("OnClick", function (self, button, down)
        if (button == "LeftButton") then
            ZTweaks:GetModule("TradeTweaksModule"):ModifyTradeMoney(Amount)
        elseif (button == "RightButton") then
            ZTweaks:GetModule("TradeTweaksModule"):ModifyTradeMoney(Amount, true)
        end
    end)
end
