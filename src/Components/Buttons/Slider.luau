-- Services
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");

-- Variables
local Modal = (script.Parent.Parent.Parent);
local Buttons = (Modal.Components.Buttons);
local Mouse = (Players.LocalPlayer:GetMouse());

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
	Default: string,
	Maximum: number,
	Minimum: number,
	DecimalCount: number?,
	Callback: (number) -> (),
}

-- Init
local Holder = function(Settings: Configuration, Window)
	local Hitbox = Scope:Value();
	local ValueObject = Scope:Value();

	local ChangeSliderValue = Scope:Value(false);
	local Fill = Scope:Value(0);
	local Value = Scope:Value(0);

	local Set
	local DecimalCount = (Settings.DecimalCount or 0);

	local Slider = Holder({
		Title = Settings.Title,
		Description = Settings.Description,
		Padding = 150,
		Children = {
			Scope:New "Frame" {
				Name = "Slider",
				AnchorPoint = Vector2.new(1, 0),
				BackgroundTransparency = 1,
				Position = UDim2.new(1, 0, 0, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Size = UDim2.new(0.5, 0, 1, 0),

				[Children] = {
					ValueObject:set(Scope:New "TextBox" {
						Name = "Selected",
						FontFace = Font.new(
							"rbxassetid://12187365364",
							Enum.FontWeight.Heavy,
							Enum.FontStyle.Normal
						),
						TextColor3 = Window.Themes.Text.Title.Color,
						TextSize = 12,
						BackgroundTransparency = 1,
						RichText = true,
						TextTransparency = 0.25,
						Size = UDim2.new(0, 0, 0, 20),
						AutomaticSize = Enum.AutomaticSize.X,
						
						Text = Scope:Computed(function(Use)
							return tostring(Use(Value))
						end),
						
						[OnEvent "FocusLost"] = function()
							local Amount = tonumber(Scoper.Unwrap(ValueObject).Text);
							Set(Amount);
							Settings.Callback(Amount);
						end,
						
						[Children] = {
							Scope:New "UIPadding" {
								Name = "UIPadding",
								PaddingBottom = UDim.new(0, 1),
							},
						}
					}),

					Scope:New "Frame" {
						Name = "Slide",
						AnchorPoint = Vector2.new(1, 0.5),
						BackgroundColor3 = Window.Themes.Controls.Color,
						Position = UDim2.new(1, 0, 0.5, 0),
						LayoutOrder = 1,
						Size = UDim2.new(0, 100, 0, 7),

						[Children] = {
							Hitbox:set(Scope:New "TextButton" {
								Size = UDim2.new(1, 0, 0, 25),
								Position = UDim2.fromScale(0.5, 0.5),
								AnchorPoint = Vector2.new(0.5, 0.5),
								ZIndex = 5,
								BackgroundTransparency = 1,
								
								[OnEvent "MouseButton1Down"] = function()
									ChangeSliderValue:set(true)
								end,

								[OnEvent "MouseButton1Up"] = function()
									ChangeSliderValue:set(false)
									Settings.Callback(Scoper.Unwrap(Value));
								end,

								[OnEvent "MouseLeave"] = function()
									ChangeSliderValue:set(false)
									Settings.Callback(Scoper.Unwrap(Value));
								end,
							}),
							
							Scope:New "UIStroke" {
								Name = "UIStroke",
								Thickness = 0.5,
								Color = Window.Themes.Controls.Outline,
								Transparency = 0,
							},

							Scope:New "UICorner" {
								Name = "UICorner",
								CornerRadius = UDim.new(1, 0),
							},

							Scope:New "Frame" {
								Name = "Highlight",
								BackgroundColor3 = Window.Themes.Accent,
								Size = Animate(function(Use)
									return UDim2.fromScale(Use(Fill) or 0, 1)
								end, 100, 1),

								[Children] = {
									Scope:New "UICorner" {
										Name = "UICorner",
										CornerRadius = UDim.new(1, 0),
									},

									Scope:New "UIStroke" {
										Name = "UIStroke",
										ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
										Transparency = 0.8,
										Color = Color3.fromRGB(255, 255, 255),
										BorderStrokePosition = Enum.BorderStrokePosition.Inner,
									},

									Scope:New "Frame" {
										Name = "Circle",
										AnchorPoint = Vector2.new(0.5, 0.5),
										BackgroundColor3 = Color3.fromRGB(245, 245, 245),
										Position = UDim2.new(1, 0, 0.5, 0),
										Size = UDim2.new(0, 20, 0, 15),
										BackgroundTransparency = 0.1,
										
										[Children] = {
											Scope:New "UIStroke" {
												Name = "UIStroke",
												ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
												Transparency = 0.8,
												Color = Color3.fromRGB(255, 255, 255),
												BorderStrokePosition = Enum.BorderStrokePosition.Inner,
											},

											Scope:New "UIStroke" {
												Name = "UIStroke",
												ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
												Transparency = 0.95,
											},

											Scope:New "UICorner" {
												Name = "UICorner",
												CornerRadius = UDim.new(1, 0),
											},
										}
									},
								}
							},
						}
					},

					Scope:New "UIListLayout" {
						Name = "UIListLayout",
						VerticalAlignment = Enum.VerticalAlignment.Center,
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						Padding = UDim.new(0, 15),
						SortOrder = Enum.SortOrder.LayoutOrder,
					},
				}
			}
		}
	}, Window);
	
	table.insert(Scope, task.spawn(function()
		local Connection
		Set = function(Number)
			local Object = Scoper.Unwrap(Hitbox);
			
			if (Object) then
				local Scale = math.clamp((Mouse.X - Object.AbsolutePosition.X) / Object.AbsoluteSize.X, 0, 1);
				local ValueAmount = tostring(math.clamp(Number or (Scale * Settings.Maximum), Settings.Minimum, Settings.Maximum))

				Value:set(tonumber(string.format(`%.{ DecimalCount }f`, ValueAmount)));
				Fill:set(math.clamp((Number and Number / Settings.Maximum) or Scale, 0, 1));
			end
		end

		if Settings.Default then
			Set(Settings.Default);
		end

		Scope:Observer(ChangeSliderValue):onChange(function()
			local CurrentValue = Scoper.Unwrap(ChangeSliderValue);

			if (CurrentValue) then
				Connection = RunService.RenderStepped:Connect(function()
					Set();
				end)
			elseif (Connection) then
				Connection:Disconnect();
			end
		end)
	end))
	
	return Slider
end

return Holder