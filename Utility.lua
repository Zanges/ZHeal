local addonName, addonTable = ...
addonTable.Utility = ZHeal:NewModule("Utility")
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
    
    ZHeal:Print(Msg)
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

function Utility:GetGroupType()
    if UnitInRaid("player") then
        return "RAID"
    elseif UnitInParty("player") then
        return "PARTY"
    end
    return "SOLO"
end

function Utility:ClassColorText(Class, InputText)
    local Text
    local Color = {}

    if Class then
        Color["R"], Color["G"], Color["B"] = GetClassColor(Class)
    end
    
    Text = format('|cff%02x%02x%02x%s|r', Color["R"] * 255, Color["G"] * 255, Color["B"] * 255, tostring(InputText))
    return Text
end

function Utility:ClassColorVerticalText(Class, InputText, MaxLength)
    MaxLength = MaxLength or 10000
    local Text
    local Color = {}
    local ReturnString = ""

    if Class then
        Color["R"], Color["G"], Color["B"] = GetClassColor(Class)
    end
    
    Text = tostring(InputText)
    local ColorCode = format("ff%02x%02x%02x", Color["R"] * 255, Color["G"] * 255, Color["B"] * 255)
    
    local Length = strlen(Text)
    if Length > MaxLength then
        for i=1, MaxLength do
            ReturnString = ReturnString .. "|c" .. ColorCode .. strsub(Text, i, i) .. "|r\n"
        end
        ReturnString = ReturnString .. "|c" .. ColorCode .. "...|r\n"
    else
        for i=1, Length do
            ReturnString = ReturnString .. "|c" .. ColorCode .. strsub(Text, i, i) .. "|r\n"
        end
    end
    
    return ReturnString
end

function Utility:GetOverallSize(objSize, objSpacing, objNumber)
    return ((objSize * objNumber) + (objSpacing * (objNumber - 1)))
end

function Utility:FormatTime(seconds)    -- from oUF_Layout [https://github.com/Rainrider/oUF_Layout]
	local day, hour, minute = 86400, 3600, 60
	if (seconds >= day) then
		return string.format('%dd', math.floor(seconds/day + 0.5))
	elseif (seconds >= hour) then
		return string.format('%dh', math.floor(seconds/hour + 0.5))
	elseif (seconds >= minute) then
		if (seconds <= minute * 5) then
			return string.format('%d:%02d', math.floor(seconds/minute), seconds % minute)
		end
		return string.format('%dm', math.floor(seconds/minute + 0.5))
	else
		return string.format('%d', seconds)
	end
end
