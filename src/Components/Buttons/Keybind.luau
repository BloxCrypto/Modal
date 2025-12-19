-- Services
local UserInputService = game:GetService("UserInputService");

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
	DefaultKeybind: string,
	Callback: (Enum.KeyCode | Enum.UserInputType) -> (),
}

-- Init
local Holder = function(Settings: Configuration, Window)
	local Key = (Settings.DefaultKeybind or "None");
	local Text = Scope:Value(Key);
	
	local Keybind = Holder({
		Title = Settings.Title,
		Description = Settings.Description,
		Interactable = true,
		Padding = 90,
		Callback = function()
			Text:set("press a key");
			UserInputService.InputBegan:Once(function(Input, Processed)
				if (not Processed) then
					local InputType = Input.UserInputType
					local KeyCode = Input.KeyCode

					if (InputType == Enum.UserInputType.Keyboard) then
						Text:set(KeyCode.Name);
						Settings.Callback(KeyCode);
					else
						Text:set(InputType.Name);
						Settings.Callback(InputType);
					end
				end
			end)
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
						ImageRectOffset = Vector2.new(257, 0),
						Image = "rbxassetid://16898673794",
						BackgroundTransparency = 1,
						ImageRectSize = Vector2.new(256, 256),
						ImageColor3 = Window.Themes.Text.Description.Color,
						Size = UDim2.new(0, 15, 0, 15),
					},

					Scope:New "TextLabel" {
						Name = "Selected",
						FontFace = Font.new(
							"rbxassetid://12187365364",
							Enum.FontWeight.ExtraBold,
							Enum.FontStyle.Normal
						),
						TextColor3 = Window.Themes.Text.Description.Color,
						Text = Text,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						TextSize = 12,
						RichText = true,
						AutomaticSize = Enum.AutomaticSize.X,
						Size = UDim2.new(0, 0, 0, 20),

						[Children] = {
							Scope:New "UIPadding" {
								Name = "UIPadding",
								PaddingBottom = UDim.new(0, 1),
							},
						}
					},

					Scope:New "UIListLayout" {
						Name = "UIListLayout",
						VerticalAlignment = Enum.VerticalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						Padding = UDim.new(0, 10),
						FillDirection = Enum.FillDirection.Horizontal,
					},
				}
			}
		}
	}, Window);
	
	return Keybind
end

return Holder