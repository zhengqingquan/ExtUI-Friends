--========================================
-- 对ElvUI插件的兼容
--========================================
local addonName, nameSpace = ...
if not nameSpace.Modules then
    nameSpace.Modules = {}
end
local Modules = nameSpace.Modules
local ElvUISupport = CreateFrame("Frame")
Modules["ElvUISupportModule"] = ElvUISupport
tinsert(Modules, ElvUISupport)

local function ElvUI_Support()
    local E = ElvUI[1]

    -- 载入ElvUI的皮肤模块
    local S = E:GetModule("Skins")

    -- 勾选了暴雪原生外观设定，且勾选了好友选项
    if E.private.skins.blizzard.enable and E.private.skins.blizzard.friends then
        WhoFrameColumnHeader5:StripTextures()
        WhoFrameColumnHeader6:StripTextures()

        S:HandleTab(_G["FriendsFrameTab5"])

        if Modules["ExtFriendsModule"] then
            S:HandleScrollBar(_G.AnotherFriendsListFrameScrollFrame.scrollBar)
        end

        S:HandleDropDownBox(_G.SetFrameDropDownButton, 180)
        _G.SetFrameDropDownButton:SetPoint("TOPLEFT", _G.SetFrameDropDownButton:GetParent(), "BOTTOMLEFT", 30, 250)
        _G.SetFrameDropDownButton.set_DropDownButtonWidth = function () end

    end

    -- 勾选了勾选框皮肤外观设定
    if E.private.skins.checkBoxSkin then
        S:HandleCheckBox(_G.SetFrameCheckButton1)
    end
end

function ElvUISupport:event_Handler(event, ...)
    if event == "PLAYER_LOGIN" and IsAddOnLoaded("ElvUI") then
        ElvUI_Support()
    end
end

ElvUISupport:RegisterEvent("PLAYER_LOGIN")
ElvUISupport:SetScript("OnEvent", ElvUISupport.event_Handler)