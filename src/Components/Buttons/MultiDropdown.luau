-- Variables
local Modal = (script.Parent.Parent.Parent);
local Buttons = (Modal.Components.Buttons);

-- Modules
local Holder = require(Buttons.Holder);
local Fusion = require(Modal.Packages.Fusion);
local Storage = require(Modal.Storage.Information);
local Scoper = require(Modal.Utilities.Scoper);
local Animate = require(Modal.Utilities.Animate);
local Dropdown = require(Modal.Components.Popups.Dropdown);

-- Functions
local Scope = Storage.Scope
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

-- Types
type Configuration = {
	Title: string,
	Description: string,
	Options: {string},
	Default: string,
	Callback: (string) -> (),
}

-- Init
local Holder = function(Settings: Configuration, Window)
	local Option = Scope:Value(Settings.Default or { "None" });
	local Toggle = Holder({
		Title = Settings.Title,
		Description = Settings.Description,
		Interactable = true,
		Padding = 80,

		Callback = function()
			Dropdown.new({
				Title = Settings.Title,
				Options = Settings.Options,
				MultiDropdown = true,
				CurrentOptions = Scoper.Unwrap(Option),
				Callback = function(Value)
					Option:set(Value);
					Settings.Callback(Value);
				end,
			}, Window)
		end,
		
		Children = {
			Scope:New "Frame" {
				Name = "Info",
				AnchorPoint = Vector2.new(1, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.new(1, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.X,
				Size = UDim2.new(0, 0, 1, 0),

				[Children] = {
					Scope:New "ImageLabel" {
						Name = "Icon",
						LayoutOrder = 1,
						ScaleType = Enum.ScaleType.Crop,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						ImageRectOffset = Vector2.new(0, 514),
						Image = "rbxassetid://16898617509",
						BackgroundTransparency = 1,
						ImageRectSize = Vector2.new(256, 256),
						ImageColor3 = Window.Themes.Text.Description.Color,
						Size = UDim2.new(0, 15, 0, 15),
					},

					Scope:New "UIListLayout" {
						Name = "UIListLayout",
						VerticalAlignment = Enum.VerticalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						Padding = UDim.new(0, 10),
						FillDirection = Enum.FillDirection.Horizontal,
					},

					Scope:New "TextLabel" {
						Name = "Selected",
						FontFace = Font.new(
							"rbxassetid://12187365364",
							Enum.FontWeight.SemiBold,
							Enum.FontStyle.Normal
						),
						TextColor3 = Window.Themes.Text.Description.Color,
						Text = Scope:Computed(function(Use)
							local Text = Use(Option) or ({ "None" });
							return table.concat(Text, ", ")
						end),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						TextTransparency = 0,
						BackgroundTransparency = 1,
						RichText = true,
						TextSize = 12,
						AutomaticSize = Enum.AutomaticSize.X,
						Size = UDim2.new(0, 0, 0, 20),

						[Children] = {
							Scope:New "UIPadding" {
								Name = "UIPadding",
								PaddingBottom = UDim.new(0, 1),
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