local addonName, addonTable = ...
local Media = addonTable.Media
local Utility = addonTable.Utility


function addonTable.AddRaidTargetIndicator(self, unit, size, xOffset, yOffset, anchorPoint, anchorTo)
    anchorTo = anchorTo or anchorPoint

    local RaidTargetIndicator = self.Health:CreateTexture(nil, "OVERLAY")
    RaidTargetIndicator:SetSize(size, size)
    RaidTargetIndicator:SetPoint(anchorPoint, self, anchorTo, xOffset, yOffset)
    
    self.RaidTargetIndicator = RaidTargetIndicator
end

function addonTable.AddGroupRoleIndicator(self, unit, size, xOffset, yOffset, anchorPoint, anchorTo)
    anchorTo = anchorTo or anchorPoint

    local GroupRoleIndicator = self.Health:CreateTexture(nil, "OVERLAY")
    GroupRoleIndicator:SetSize(size, size)
    GroupRoleIndicator:SetPoint(anchorPoint, self, anchorTo, xOffset, yOffset)
    
    self.GroupRoleIndicator = GroupRoleIndicator
end