local function Aby_Support()
    if "FriendsFrameTab_OpenGuild" and FriendsFrameTab_OpenGuild:IsShown() and "FriendsFrameTab5" then
        FriendsFrameTab5:SetPoint("LEFT" , FriendsFrameTab_OpenGuild , "RIGHT" , -15 , 0)
    end
end


local function event_Handler(self, event, ...)
    if event == "PLAYER_LOGIN" and IsAddOnLoaded("163UI_Plugins") then
        Aby_Support()
    end
end


local Listener = CreateFrame("Frame")
Listener:RegisterEvent("PLAYER_LOGIN")
Listener:SetScript("OnEvent", event_Handler)