local addonName, addonTable = ...
addonTable.Utility = ZTweaks:NewModule("Utility")
local Utility = addonTable.Utility


function Utility:SetPercentualHeight(Frame, Height, RefFrame, MinAbs, Offset)
    RefFrame = RefFrame or Frame:GetParent()
    MinAbs = MinAbs or 0
    local RefHeight = RefFrame:GetHeight()
    local TargetHeight = RefHeight * Height
    TargetHeight = math.max(TargetHeight, MinAbs)
    TargetHeight = TargetHeight - (2 * Offset)
    Frame:SetHeight(TargetHeight)
end

function Utility:SetPercentualWidth(Frame, Width, RefFrame, MinAbs, Offset)
    RefFrame = RefFrame or Frame:GetParent()
    MinAbs = MinAbs or 0
    local RefWidth = RefFrame:GetWidth()
    local TargetWidth = RefWidth * Width
    TargetWidth = math.max(TargetWidth, MinAbs)
    TargetWidth = TargetWidth - (2 * Offset)
    Frame:SetWidth(TargetWidth)
end

function Utility:Debug(Msg, DebugLevel, Sender)
    DebugLevel = DebugLevel or 1

    if (Sender ~= nil) then
        --Msg = Sender .. ": " .. Msg
    end
    
    ZTweaks:Print(Msg)
end

function Utility:ThrowError(Msg)
    assert(false, addonName .. ": " .. Msg)
end

function Utility:ThrowWrongParamError(Prefix, FunctionSyntax, ParamName, ParamValue, AllowedValues)
    if (Prefix) then
        Utility:ThrowError("<" .. Prefix .. "> Func: " .. FunctionSyntax .. " | Parameter: " .. ParamName .. " = " .. ParamValue .." | Parameter has to match: " .. AllowedValues)
    else
        Utility:ThrowError("Func: " .. FunctionSyntax .. " | Parameter: " .. ParamName .. " = " .. ParamValue .." | Parameter has match: " .. AllowedValues)
    end
end