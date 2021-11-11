--========================================
-- 整个FriendsFrame框体的扩展。
-- 这里做一些简单且不依附于滚动框体的部分组件调整。
-- 还会做一些插件的自身的事件脚本。
--========================================
--========================================
-- 后续会添加对插件的配置。
--========================================
local addonName, nameSpace = ...
if not nameSpace.Modules then
    nameSpace.Modules = {}
end
local Modules = nameSpace.Modules
local ExtMain = CreateFrame("Frame")
Modules["ExtMainModule"] = ExtMain
tinsert(Modules, ExtMain)

ExtMain.OVERALL_WIDTH = 690 -- 整体框体的宽度，例如FriendsFrame
ExtMain.INSIDE_WIDTH = 655 -- 内嵌框体的宽度，例如FrameScrollFrame
ExtMain.BATTL_NET_ID_WIDTH = 540 -- 战网ID框体的宽度
local initial_Width_FriendsFrame = FriendsFrame:GetWidth() -- FriendsFrame的初始宽度
local initial_Width_FriendsFrameBattlenetFrame = FriendsFrameBattlenetFrame:GetWidth() -- FriendsFrameBattlenetFrame的初始宽度

function ExtMain:iniMainFrame()

	-- 整个好友框体扩展
    FriendsFrame:SetWidth(self.OVERALL_WIDTH)

	-- 战网实名好友请求的警告框体
	FriendsListFrame.RIDWarning:SetWidth(self.INSIDE_WIDTH)

	-- 战网ID框体扩展
	FriendsFrameBattlenetFrame:SetWidth(self.BATTL_NET_ID_WIDTH)

	-- 战网通告框体的位置
	FriendsFrameBattlenetFrame.BroadcastFrame:ClearAllPoints()
	FriendsFrameBattlenetFrame.BroadcastFrame:SetPoint("CENTER", FriendsFrame,"CENTER", 0,95)

end

ExtMain:iniMainFrame()




-- 斜杠处理命令，大多数时候只是用来测试。
-- local function slash_function()
-- end
-- SLASH_EXTF1, SLASH_EXTF2 = "/EXTF", "/extf"
-- SlashCmdList["EXTF"] = slash_function



-- 暂时不扩展战友招募框体
hooksecurefunc("FriendsFrame_Update", function ()
	local selectedTab = PanelTemplates_GetSelectedTab(FriendsFrame) or FRIEND_TAB_FRIENDS; -- 选择的为标签1
	if selectedTab == FRIEND_TAB_FRIENDS then
		local selectedHeaderTab = PanelTemplates_GetSelectedTab(FriendsTabHeader) or FRIEND_HEADER_TAB_FRIENDS;
		if selectedHeaderTab == FRIEND_HEADER_TAB_RAF then
			FriendsFrame:SetWidth(initial_Width_FriendsFrame)
			FriendsFrameBattlenetFrame:SetWidth(initial_Width_FriendsFrameBattlenetFrame)
		else
			FriendsFrame:SetWidth(690)
			FriendsFrameBattlenetFrame:SetWidth(ExtMain.BATTL_NET_ID_WIDTH)
		end
	else
		FriendsFrame:SetWidth(690)
		FriendsFrameBattlenetFrame:SetWidth(ExtMain.BATTL_NET_ID_WIDTH)
	end
end)


-- 修正当团队成员改变时，边框下方会改变的情况。
-- 依赖于GROUP_ROSTER_UPDATE事件
hooksecurefunc("FrameTemplate_SetButtonBarHeight", function(self, buttonBarHeight)
	self.Inset:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -6, 26);
end)