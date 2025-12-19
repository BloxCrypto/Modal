-- Variables
local Modal = (script.Parent.Parent.Parent);

-- Modules
local Fusion = require(Modal.Packages.Fusion);
local Storage = require(Modal.Storage.Information);
local Scoper = require(Modal.Utilities.Scoper);
local Colors = require(Modal.Utilities.Colors);
local Animate = require(Modal.Utilities.Animate);

-- Functions
local Scope = Storage.Scope
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

-- Types
type Configuration = {
	Title: string,
	Description: string,
	Interactable: boolean,
	Padding: number?,
	Children: { GuiObject },
	Callback: () -> (),
}

-- Init
local Holder = function(Settings: Configuration, Window)
	local Focused, Held = Scope:Value(false), Scope:Value(false);
	local ComponentPalette = (Window.Themes.Component);
	local Title, Description = Scope:Value(Settings.Title), Scope:Value(Settings.Description);

	local Component = Scope:New "TextButton" {
		Name = "Holder",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		Size = UDim2.new(1, -15, 0, 45),
		AutomaticSize = Enum.AutomaticSize.Y,

		[OnEvent "MouseEnter"] = function()
			Focused:set(true);
		end,
		
		[OnEvent "MouseLeave"] = function()
			Focused:set(false);
			Held:set(false);
		end,
		
		[OnEvent "MouseButton1Down"] = function()
			if (Scoper.Unwrap(Focused)) then
				Held:set(true);
			end
		end,
		
		[OnEvent "MouseButton1Up"] = function()
			Held:set(false);
		end,
		
		[OnEvent "MouseButton1Click"] = function()
			if (Settings.Interactable and Settings.Callback) then
				Settings.Callback();
			end
		end,

		[Children] = {			
			Scope:New "UIGradient" {
				Name = "UIGradient",
				Rotation = ComponentPalette.Rotation,
				Color = Colors.SetupTheme(ComponentPalette.Color),
			},
			
			Scope:New "UICorner" {
				Name = "UICorner",
				CornerRadius = UDim.new(0, 10),
			},
			
			Scope:New "Frame" {
				Name = "Highlight",
				Size = UDim2.fromScale(1, 1) + UDim2.fromOffset(20, 0),
				Position = UDim2.fromOffset(-10, 0),
				
				BackgroundColor3 = Animate(function(Use)
					local Mode = Use(Window.Themes.Mode);
					return (Mode == "Light" and Color3.fromRGB(100, 100, 100)) or Color3.fromRGB(255, 255, 255)
				end, 30, 1),
				
				BackgroundTransparency = Animate(function(Use)
					if (Settings.Interactable) then
						local IsHeld, IsFocused = Use(Held), Use(Focused);						
						return (IsHeld and 0.95) or (IsFocused and 0.975) or 1
					else
						return 1
					end
				end, 30, 1), 
				
				[Children] = {
					Scope:New "UICorner" {
						Name = "UICorner",
						CornerRadius = UDim.new(0, 10),
					},
				}
			},

			Scope:New "UIStroke" {
				Name = "UIStroke",
				Thickness = 0.7,
				Transparency = 0.95,
			},

			Scope:New "Frame" {
				Name = "Text",
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.Y,

				[Children] = {
					Scope:New "UIListLayout" {
						Name = "UIListLayout",
						VerticalAlignment = Enum.VerticalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder,
					},
					
					Scope:New "UIPadding" {
						PaddingTop = UDim.new(0, 10),
						PaddingBottom = UDim.new(0, 10),
					},

					Scope:New "TextLabel" {
						Name = "Title",
						FontFace = Font.new(
							"rbxassetid://12187365364",
							Enum.FontWeight.Bold,
							Enum.FontStyle.Normal
						),
						TextColor3 = Window.Themes.Text.Title.Color,
						BackgroundTransparency = 1,
						Size = UDim2.new(1, -(Settings.Padding or 0), 0, 0),
						TextSize = 13,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Left,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),

						Text = Scope:Computed(function(Use)
							return (Use(Title) or "");
						end),

						Visible = Scope:Computed(function(Use)
							local TitleExists = Use(Title);
							return (TitleExists and true) or false
						end)
					},

					Scope:New "TextLabel" {
						Name = "Description",
						LayoutOrder = 1,
						FontFace = Font.new(
							"rbxassetid://12187365364",
							Enum.FontWeight.Medium,
							Enum.FontStyle.Normal
						),
						TextColor3 = Window.Themes.Text.Description.Color,
						BackgroundTransparency = 1,
						Size = UDim2.new(1, -(Settings.Padding or 0), 0, 0),
						TextSize = 12,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Left,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),

						Text = Scope:Computed(function(Use)
							return (Use(Description) or "");
						end),

						Visible = Scope:Computed(function(Use)
							local DescriptionExists = Use(Description);
							return (DescriptionExists and true) or false
						end)
					},
				}
			},

			Scope:New "UIStroke" {
				Name = "UIStroke",
				Thickness = 2,
				Transparency = 0.7,
				Color = Color3.fromRGB(255, 255, 255),
				BorderStrokePosition = Enum.BorderStrokePosition.Inner,
			},

			Scope:New "UIPadding" {
				Name = "UIPadding",
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10),
			},
			
			Settings.Children
		}
	}

	local Configuration = ({ Object = Component });

	Configuration.SetTitle = function(self, NewTitle: string)
		Title:set(NewTitle);
	end

	Configuration.SetDescription = function(self, NewDescription: string)
		Description:set(NewDescription);
	end
	
	return Configuration
end

return Holder