--========================================
-- 对爱不易插件的兼容
--========================================
local addonName, nameSpace = ...
if not nameSpace.Modules then
    nameSpace.Modules = {}
end
local Modules = nameSpace.Modules
local AbySupport = CreateFrame("Frame")
Modules["AbySupportModule"] = AbySupport
tinsert(Modules, AbySupport)


-- CLASS_ENG的定义属于爱不易
local CLASS_ENG = {}
for i=1, GetNumClasses() do
    local loc, eng = GetClassInfo(i)
    CLASS_ENG[loc] = eng
end

-- color_button的定义属于爱不易friends.lua中的friendsFrame()
local function color_button(button)
    local infoText
    local playerArea = GetRealZoneText()
    if(button:IsShown()) then
        if ( button.buttonType == FRIENDS_BUTTON_TYPE_WOW ) then
            local name, level, class, area, connected, status, note = GetFriendInfo(button.id)
            if(connected) then
                if(areaName == playerArea) then
                    infoText = format('|cff00ff00%s|r', area)
                end
            end
        elseif (button.buttonType == FRIENDS_BUTTON_TYPE_BNET) then
            local accountInfo = C_BattleNet.GetFriendAccountInfo(button.id);
            local gameInfo = accountInfo and accountInfo.gameAccountInfo
            if gameInfo and gameInfo.clientProgram == BNET_CLIENT_WOW and gameInfo.className then
                local class = CLASS_ENG[gameInfo.className]
                if accountInfo.gameAccountInfo.isOnline and gameInfo.areaName == playerArea then
                    if ShowRichPresenceOnly(accountInfo.gameAccountInfo.clientProgram, accountInfo.gameAccountInfo.wowProjectID, accountInfo.gameAccountInfo.factionName, accountInfo.gameAccountInfo.realmID) then
                        infoText = format('|cff00ff00%s|r', playerArea)
                    end
                end
                if class then
                    if gameInfo.wowProjectID == WOW_PROJECT_CLASSIC and WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC then
                        infoText = "|cffaa0303经典怀旧|r " .. gameInfo.areaName .. " " .. LEVEL .. gameInfo.characterLevel
                    elseif gameInfo.wowProjectID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC and WOW_PROJECT_ID ~= WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
                        infoText = "|cff03aa03TBC怀旧|r " .. gameInfo.areaName .. " " .. LEVEL .. gameInfo.characterLevel
                    end
                end
            end
        end
    end
    if(infoText) then
        button.info:SetText(infoText)
    end
end

local function Aby_Support()

    -- 将设置标签放在公会标签的右边。
    if "FriendsFrameTab_OpenGuild" and FriendsFrameTab_OpenGuild:IsShown() and "FriendsFrameTab5" then
        FriendsFrameTab5:SetPoint("LEFT" , FriendsFrameTab_OpenGuild , "RIGHT" , -15 , 0)
    end

    -- 使用后钩让右侧的好友滚动框体中好友信息内容与爱不易的插件保持一致。
    if Modules["ExtFriendsModule"] then
        local origfunc = AnotherFriendsFrame_UpdateFriendButton

        local function newfunc(arg1, ...)
            return arg1, color_button(...)
        end

        function AnotherFriendsFrame_UpdateFriendButton(...)
            return newfunc(origfunc(...), ...)
        end
    end
end


function AbySupport:event_Handler(event, ...)
    if event == "PLAYER_LOGIN" and IsAddOnLoaded("163UI_Plugins") then
        Aby_Support()
    end
end


AbySupport:RegisterEvent("PLAYER_LOGIN")
AbySupport:SetScript("OnEvent", AbySupport.event_Handler)