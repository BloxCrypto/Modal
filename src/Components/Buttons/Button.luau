-- Variables
local Modal = (script.Parent.Parent.Parent);
local Buttons = (Modal.Components.Buttons);

-- Modules
local Holder = require(Buttons.Holder);
local Fusion = require(Modal.Packages.Fusion);
local Storage = require(Modal.Storage.Information);
local Scoper = require(Modal.Utilities.Scoper);
local Animate = require(Modal.Utilities.Animate);
local Colors = require(Modal.Utilities.Colors);

-- Functions
local Scope = Storage.Scope
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

-- Types
type Configuration = {
	Title: string,
	Description: string,
	Callback: () -> (),
}

-- Init
local Holder = function(Settings: Configuration, Window)
	local Button = Holder({
		Title = Settings.Title,
		Description = Settings.Description,
		Interactable = true,
		Callback = function()
			Settings.Callback();
		end,
	}, Window);
	
	return Button
end

return Holder