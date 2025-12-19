-- Variables
local Modal = (script.Parent.Parent.Parent);
local Buttons = (Modal.Components.Buttons);

-- Modules
local Holder = require(Buttons.Holder);
local Fusion = require(Modal.Packages.Fusion);
local Storage = require(Modal.Storage.Information);
local Scoper = require(Modal.Utilities.Scoper);
local Animate = require(Modal.Utilities.Animate);

-- Functions
local Scope = Storage.Scope
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

-- Types
type Configuration = {
	Title: string,
	Description: string,
	DefaultText: string,
	Placeholder: string,
	Callback: (string) -> (),
}

-- Init
local Holder = function(Settings: Configuration, Window)
	local InputObject = Scope:Value();
	
	local Toggle = Holder({
		Title = Settings.Title,
		Description = Settings.Description,
		Interactable = true,
		Padding = 100,
		Callback = function()
			Scoper.Unwrap(InputObject):CaptureFocus();
		end,
		
		Children = {
			InputObject:set(Scope:New "TextBox" {
				Name = "Toggle",
				BackgroundColor3 = Window.Themes.Controls.Color,
				FontFace = Font.new(
					"rbxassetid://12187365364",
					Enum.FontWeight.Bold,
					Enum.FontStyle.Normal
				),
				Active = false,
				Text = (Settings.DefaultText or ""),
				AutomaticSize = Enum.AutomaticSize.X,
				Selectable = false,
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, 0, 0.5, 0),
				PlaceholderColor3 = Window.Themes.Text.Description.Color,
				TextColor3 = Window.Themes.Text.Title.Color,
				PlaceholderText = (Settings.Placeholder or ""),
				TextSize = 12,
				Size = UDim2.new(0, 22, 0, 22),
				
				[OnEvent "FocusLost"] = function()
					Settings.Callback(Scoper.Unwrap(InputObject).Text);
				end,

				[Children] = {
					Scope:New "UIPadding" {
						Name = "UIPadding",
						PaddingLeft = UDim.new(0, 5),
						PaddingRight = UDim.new(0, 5),
					},

					Scope:New "UICorner" {
						Name = "UICorner",
						CornerRadius = UDim.new(0, 6),
					},

					Scope:New "UIStroke" {
						Name = "UIStroke",
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Color = Window.Themes.Controls.Outline,
						Transparency = 0,
					},
				}
			})
		}
	}, Window);
	
	return Toggle
end

return Holder