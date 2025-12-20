-- Variables
local Modal = (script.Parent.Parent.Parent);

-- Modules
local Fusion = require(Modal.Packages.Fusion);
local Storage = require(Modal.Storage.Information);

-- Functions
local Scope = Storage.Scope
local Children = Fusion.Children

-- Types
type Configuration = {
	Title: string,
}

-- Init
local Holder = function(Settings: Configuration, Window)
	local Title = Scope:New "TextLabel" {
		Name = "Title",
		FontFace = Font.new(
			"rbxassetid://12187365364",
			Enum.FontWeight.Bold,
			Enum.FontStyle.Normal
		),
		TextColor3 = Window.Themes.Text.Title.Color,
		Text = Settings.Title,
		BackgroundTransparency = 1,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 14,
		Size = UDim2.new(1, -30, 0, 25),

		[Children] = {
			Scope:New "Frame" {
				Name = "Seperator",
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundColor3 = Window.Themes.Text.Title.Color,
				BackgroundTransparency = 0.9,
				Position = UDim2.new(0.5, 0, 1, 0),
				Size = UDim2.new(1, 10, 0.05, 0),
			},
		}
	}
	
	return {
		Object = Title,
	}
end

return Holder