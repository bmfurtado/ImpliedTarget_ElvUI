local addonName, addon = ...

if not ElvUI then
	error(addonName .. " could not load, missing dependency: ElvUI")
elseif not ImpliedTarget then
	error(addonName .. " could not load, missing dependency: ImpliedTarget")
end

local LAB = LibStub('LibActionButton-1.0-ElvUI', true)
if not LAB then
	error(addonName .. " could not load, missing dependency: LibActionButton-1.0-ElvUI")
end

local AddButton, RemoveButton = ImpliedTarget.AddButton, ImpliedTarget.RemoveButton

-- ElvUI handles paging for the primary action bar so remove it from ImpliedTarget
ImpliedTarget.DisablePaging()

-- ElvUI remaps key binds already so remove it from ImpliedTarget
ImpliedTarget.DisableKeyBinding()

-- ElvUI makes all new action buttons and hides the defaults so remove them from ImpliedTarget
for id = 1, NUM_ACTIONBAR_BUTTONS do
	RemoveButton('ActionButton' .. id)
	RemoveButton('ExtraActionButton' .. id)
	RemoveButton('MultiBarBottomLeftButton' .. id)
	RemoveButton('MultiBarBottomRightButton' .. id)
	RemoveButton('MultiBarLeftButton' .. id)
	RemoveButton('MultiBarRightButton' .. id)
end

for id = 1, NUM_OVERRIDE_BUTTONS or NUM_ACTIONBAR_BUTTONS do
	RemoveButton('OverrideActionBarButton' .. id)
end

-- Add ElvUI's action buttons
for button in pairs(LAB:GetAllButtons()) do
	local name = button:GetName()
	if name and name:match("^ElvUI_Bar%dButton%d+$") then
		AddButton(button)
	end
end

LAB.RegisterCallback(addon, 'OnButtonCreated', function(event, button)
	local name = button:GetName()
	if name and name:match("^ElvUI_Bar%dButton%d+$") then
		AddButton(button)
	end
end)
