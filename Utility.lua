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

function Utility:ThrowError(Check, Msg)
    assert(Check, addonName .. ": " .. Msg)
end

function Utility:ThrowWrongParamError(Check, Prefix, ParamName, ParamValue, AllowedValues)
    if (Prefix) then
        Utility:ThrowError(Check, "<" .. Prefix .. "> Parameter: " .. ParamName .. " = " .. ParamValue .." | Parameter has to match: " .. AllowedValues)
    else
        Utility:ThrowError(Check, "Parameter: " .. ParamName .. " = " .. ParamValue .." | Parameter has to match: " .. AllowedValues)
    end
end

function Utility:OneDimMatrix(SizeD1, InitialValue, SaveIn)
    local Matrix = {}
    for id1 = 1, SizeD1 do
        Matrix[id1] = InitialValue
    end
    if SaveIn == nil then
        SaveIn = Matrix
    else
        for id1 = 1, SizeD1 do
            if SaveIn[id1] == nil then
                SaveIn[id1] = InitialValue
            end
        end
    end
    return SaveIn
end

function Utility:TwoDimMatrix(SizeD1, SizeD2, InitialValue, SaveIn)
    local Matrix = {}
    for id1 = 1, SizeD1 do
        Matrix[id1] = {}
        for id2 = 1, SizeD2 do
            Matrix[id1][id2] = InitialValue
        end
    end
    if SaveIn == nil then
        SaveIn = Matrix
    else
        for id1 = 1, SizeD1 do
            if SaveIn[id1] == nil then
                SaveIn[id1] = Matrix[id1]
            end
            for id2 = 1, SizeD1 do
                if SaveIn[id1][id2] == nil then
                    SaveIn[id1][id2] = InitialValue
                end
            end
        end
    end
    return SaveIn
end

function Utility:ThreeDimMatrix(SizeD1, SizeD2, SizeD3, InitialValue, SaveIn)
    local Matrix = {}
    for id1 = 1, SizeD1 do
        Matrix[id1] = {}
        for id2 = 1, SizeD2 do
            Matrix[id1][id2] = {}
            for id3 = 1, SizeD3 do
                Matrix[id1][id2][id3] = InitialValue
            end
        end
    end
    if SaveIn == nil then
        SaveIn = Matrix
    else
        for id1 = 1, SizeD1 do
            if SaveIn[id1] == nil then
                SaveIn[id1] = Matrix[id1]
            end
            for id2 = 1, SizeD2 do
                if SaveIn[id1][id2] == nil then
                    SaveIn[id1][id2] = Matrix[id1][id2]
                end
                for id3 = 1, SizeD3 do
                    if SaveIn[id1][id2][id3] == nil then
                        SaveIn[id1][id2][id3] = InitialValue
                    end
                end
            end
        end
    end
    return SaveIn
end

function Utility:VerticalText(string)
    if not string then
        return ""
    end
    local ReturnString = ""
    for i=1, strlen(string) do
        ReturnString = ReturnString .. strsub(string, i, i) .. "\n"
    end
    return ReturnString
end

-- From: https://wow.gamepedia.com/ChunkSplit
function Utility:ChunkSplit(string, length, endChars)
    if not string then
        return {}
    end
    -- Sanity check: make sure length is an integer.
    length = floor(tonumber(length))
    if not length then
        length = 1
    end
    if not endChars then
        endChars = "\n"
    end
    local Table = {}
    for i=1, strlen(string), length do
        table.insert(Table, strsub(string, i, i + length) .. endChars)
    end
    return Table
end

function Utility:Truncate(number, decimals)
    if number == 0 then
        return number
    end
    
    return number - (number % (0.1 ^ decimals))
end