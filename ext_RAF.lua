--========================================
-- 战友招募
--========================================
local addonName, nameSpace = ...
if not nameSpace.Modules then
    nameSpace.Modules = {}
end
local Modules = nameSpace.Modules
local ExtRAF = CreateFrame("Frame")
Modules["ExtRAFModule"] = ExtRAF
tinsert(Modules, ExtRAF)