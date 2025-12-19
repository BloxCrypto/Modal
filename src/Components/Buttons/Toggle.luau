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
	DefaultValue: boolean,
	Callback: (boolean) -> (),
}

-- Init
local Holder = function(Settings: Configuration, Window)
	local Toggled = Scope:Value(Settings.DefaultValue);	
	local Toggle = Holder({
		Title = Settings.Title,
		Description = Settings.Description,
		Interactable = true,
		Padding = 45,
		Callback = function()
			local New = (not Scoper.Unwrap(Toggled))
			Toggled:set(New);
			Settings.Callback(New);
		end,
		
		Children = {
			Scope:New "Frame" {
				Name = "Toggle",
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, 0, 0.5, 0),
				Size = UDim2.new(0, 42, 0, 22),
				BackgroundColor3 = Animate(function(Use)
					local IsToggled = Use(Toggled);
					local Accent = Use(Window.Themes.Accent);			
					local Off = Use(Window.Themes.Controls.Color);
					return (IsToggled and Accent) or Off
				end, 30, 1),

				[Children] = {
					Scope:New "UIStroke" {
						Name = "UIStroke",
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Color = Color3.fromRGB(255, 255, 255),
						BorderStrokePosition = Enum.BorderStrokePosition.Inner,
						Transparency = Animate(function(Use)
							local On = Use(Toggled);
							return (On and 0.8) or 1
						end, 30, 1),
					},

					Scope:New "UIStroke" {
						Name = "UIStroke",
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Color = Window.Themes.Controls.Outline,
						Transparency = 0,
					},
					
					Scope:New "UICorner" {
						Name = "UICorner",
						CornerRadius = UDim.new(1, 0),
					},

					Scope:New "Frame" {
						Name = "Circle",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Size = UDim2.new(0.5, 0, 1, -6),
						BackgroundTransparency = 0.15,
						
						Position = Animate(function(Use)
							local IsToggled = Use(Toggled);
							return (IsToggled and UDim2.new(1, -3, 0.5, 0)) or UDim2.new(0, 3, 0.5, 0)
						end, 30, 0.95),
						
						AnchorPoint = Animate(function(Use)
							local IsToggled = Use(Toggled);
							return (IsToggled and Vector2.new(1, 0.5)) or Vector2.new(0, 0.5)
						end, 30, 1),

						[Children] = {
							Scope:New "UICorner" {
								Name = "UICorner",
								CornerRadius = UDim.new(1, 0),
							},
						}
					},
				}
			}
		}
	}, Window);
	
	return Toggle
end

return Holder