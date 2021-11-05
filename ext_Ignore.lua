--========================================
-- 屏蔽列表的扩展。
-- 屏蔽列表的功能相对简单，也不是那么重要。
-- 可以尝试将列表中的名称颜色设置成其职业颜色。
--========================================
local addonName, nameSpace = ...
if not nameSpace.Modules then
    nameSpace.Modules = {}
end
local Modules = nameSpace.Modules
local ExtIgnore = CreateFrame("Frame")
Modules["ExtIgnoreModule"] = ExtIgnore
tinsert(Modules, ExtIgnore)

-- IgnoreListFrame
-- IgnoreListFrameScrollFrame 继承自 FriendsFrameScrollFrame
function ExtIgnore:ini_IgnoreFrame()
    local scrollFrame = IgnoreListFrameScrollFrame
    scrollFrame:SetWidth(655)
end

ExtIgnore:ini_IgnoreFrame()