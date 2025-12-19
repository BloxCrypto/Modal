-- Variables
local Modal = (script.Parent.Parent.Parent);
local Buttons = (Modal.Components.Buttons);

-- Modules
local Holder = require(Buttons.Holder);
local Fusion = require(Modal.Packages.Fusion);
local Storage = require(Modal.Storage.Information);
local Scoper = require(Modal.Utilities.Scoper);
local Animate = require(Modal.Utilities.Animate);
local ColorPicker = require(Modal.Components.Popups.ColorPicker);

-- Functions
local Scope = Storage.Scope
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

-- Types
type Configuration = {
	Title: string,
	Description: string,
	Default: Color3,
	Callback: (string) -> (),
}

-- Init
local Holder = function(Settings: Configuration, Window)
	local Option = Scope:Value(Settings.Default or Color3.fromRGB(255, 255, 255));
	local ColorPickerButton = Holder({
		Title = Settings.Title,
		Description = Settings.Description,
		Interactable = true,
		Padding = 35,

		Callback = function()
			ColorPicker.new({
				Title = Settings.Title,
				Options = Settings.Options,
				Callback = function(Value)
					Option:set(Value);
					Settings.Callback(Value);
				end,
			}, Window, Scoper.Unwrap(Option):ToHSV())
		end,
		
		Children = {
			Scope:New "Frame" {
				Name = "Info",
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, 0, 0.5, 0),
				Size = UDim2.fromOffset(25, 25),
				BackgroundTransparency = 0,
				BackgroundColor3 = Animate(function(Use)
					return Use(Option);
				end, 30, 1),
				
				[Children] = {
					Scope:New "UICorner" {
						CornerRadius = UDim.new(0, 8),
					},

					Scope:New "UIStroke" {
						BorderStrokePosition = Enum.BorderStrokePosition.Inner,
						Color = Color3.fromRGB(255, 255, 255),
						Transparency = 0.8,
						Thickness = 1.5,
					}
				},
			}
		}
	}, Window);
	
	return ColorPickerButton
end

return Holder