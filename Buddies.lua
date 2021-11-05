--========================================
-- 移植MyBuddies插件，原作者是Kyhze。
-- 这部分其实还没有进行充分的测试，
-- 但我想它应该可以运行得很好。
-- 后续会试着添加其它的功能。
--========================================
-- 内存占用：最高6KiB，最低5KiB
--========================================
local addonName, nameSpace = ...
if not nameSpace.Modules then
    nameSpace.Modules = {}
end
local Modules = nameSpace.Modules
local Buddies = CreateFrame("Frame")
Modules["BuddiesModule"] = Buddies
tinsert(Modules, Buddies)

-- Buddies按钮的初始化
function Buddies:ini_BuddiesButton()

    -- 好友数量按钮
    local FriendsNumButton = CreateFrame("Button", "ExtUIFriendsNumButton", FriendsListFrame)
    FriendsNumButton:SetSize(70, 22)
    FriendsNumButton:SetPoint("TOPRIGHT", -10, -58)
    -- 好友数量按钮的背景
    FriendsNumButton.buttonBG = FriendsNumButton:CreateTexture("ExtUIFriendsNumButtonBG", "BACKGROUND")
    FriendsNumButton.buttonBG:SetAllPoints(true)
    FriendsNumButton.buttonBG:SetTexture("Interface\\FriendsFrame\\battlenet-friends-main")
    FriendsNumButton.buttonBG:SetTexCoord(0.00390625, 0.74609375, 0.00195313, 0.05859375)
    -- 好友数量按钮的文字
    FriendsNumButton.buttonFontString = FriendsNumButton:CreateFontString("ExtUIFriendsNumButtonFontString", "ARTWORK", "GameFontNormal")
    FriendsNumButton.buttonFontString:SetPoint("CENTER")
    FriendsNumButton.buttonFontString:SetTextColor(0.345, 0.667, 0.867)
    -- 好友数量按钮的特殊更新函数
    function FriendsNumButton:funUpdate()
        local bnetCount = BNGetNumFriends().."|cff416380/200|r"
        self.buttonFontString:SetText(bnetCount)
    end
    -- 好友数量按钮的脚本
    function FriendsNumButton:eventHandler(event, ...)
        if event == "BN_FRIEND_LIST_SIZE_CHANGED" then
            self:funUpdate()
        end
    end
    function FriendsNumButton:showHandler()
        self:funUpdate()
    end
    FriendsNumButton:SetScript("OnShow",FriendsNumButton.showHandler)
    FriendsNumButton:SetScript("OnEvent", FriendsNumButton.eventHandler)
    FriendsNumButton:RegisterEvent("BN_FRIEND_LIST_SIZE_CHANGED") -- 注册好友数量大小更新事件

    -- 屏蔽数量按钮
    local IgnoreNumButton = CreateFrame("Button", "IgnoreNumFrame", IgnoreListFrame)
    IgnoreNumButton:SetSize(70, 22)
    IgnoreNumButton:SetPoint("TOPRIGHT", -10, -58)
    -- 屏蔽数量按钮的背景
    IgnoreNumButton.buttonBG = IgnoreNumButton:CreateTexture("ExtUIIgnoreNumButtonBG", "BACKGROUND")
    IgnoreNumButton.buttonBG:SetAllPoints(true)
    IgnoreNumButton.buttonBG:SetTexture("Interface\\FriendsFrame\\battlenet-friends-main")
    IgnoreNumButton.buttonBG:SetTexCoord(0.00390625, 0.74609375, 0.00195313, 0.05859375)
    -- 屏蔽数量按钮的文字
    IgnoreNumButton.buttonFontString = IgnoreNumButton:CreateFontString("ExtUIIgnoreNumButtonFontString", "ARTWORK", "GameFontNormal")
    IgnoreNumButton.buttonFontString:SetPoint("CENTER")
    IgnoreNumButton.buttonFontString:SetTextColor(0.345, 0.667, 0.867)
    -- 好友数量按钮的特殊更新函数
    IgnoreNumButton.funUpdate = function ()
        local IgnoreCount = C_FriendList.GetNumIgnores().."|cff416380/50|r"
        IgnoreNumButton.buttonFontString:SetText(IgnoreCount)
    end
    -- 屏蔽数量按钮的脚本
    function IgnoreNumButton:eventHandler(event, ...)
        if  event == "IGNORELIST_UPDATE" then
            self:funUpdate()
        end
    end
    function IgnoreNumButton:showHandler()
        self:funUpdate()
    end
    IgnoreNumButton:SetScript("OnShow",IgnoreNumButton.showHandler)
    IgnoreNumButton:SetScript("OnEvent", IgnoreNumButton.eventHandler)
    IgnoreNumButton:RegisterEvent("IGNORELIST_UPDATE") -- 注册屏蔽数量大小更新事件
end

function Buddies:event_Handler(event, ...)
	if event == "PLAYER_LOGIN" then
        if IsAddOnLoaded("MyBuddies") then
            return
        end
        self:ini_BuddiesButton() -- 初始化被放在了加载之后，因为需要判断MyBuddies插件是否被加载。
	end
end

Buddies:SetScript("OnEvent", Buddies.event_Handler)
Buddies:RegisterEvent("PLAYER_LOGIN")