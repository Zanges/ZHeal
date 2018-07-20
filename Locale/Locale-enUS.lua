local addonName, addonTable = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "enUS", true)

if L then
	-- Static
	L["Mouse Mode"] = "Mouse Mode"

	-- Dynamic
	L["X: 'Hello Y'"] = function(X,Y)
		return X .. ": 'Hello " .. Y .. "'"
	end
end