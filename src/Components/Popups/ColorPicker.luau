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
local Transparency = require(Modal.Utilities.Transparency);

-- Functions
local CurrentScope = Storage.Scope
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

-- Types
type Configuration = {
	Callback: (Color3) -> (),
}

-- Init
local ColorPicker = ({});

ColorPicker.new = function(Settings: Configuration, Window, H, S, V)
	local Scope = CurrentScope:innerScope({});
	local Opened = Scope:Value(false);

	local Colors = require(Modal.Utilities.Colors)(Scope);
	local Hue, Saturation, Brightness = (H or 1), (S or 1), (V or 1)
	local CurrentColor = nil

	local Component
	Component = Scope:New "Frame" {
		Name = "ColorPicker",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		ZIndex = 11,
		Parent = Window.Object,

		Size = Animate(function(Use)
			local WindowState = Use(Opened);
			local Scale = (WindowState and 0.75) or 0.7
			return UDim2.fromScale(Scale, Scale);
		end, 25, 0.7, Scope),

		[Children] = {
			Scope:New "UIPadding" {
				Name = "UIPadding",
				PaddingTop = UDim.new(0, 10),
				PaddingBottom = UDim.new(0, 10),
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10),
			},

			Scope:New "UIListLayout" {
				Name = "UIListLayout",
				SortOrder = Enum.SortOrder.LayoutOrder,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				Padding = UDim.new(0, 8),
			},

			Scope:New "UIAspectRatioConstraint" {
				Name = "UIAspectRatioConstraint",
				AspectRatio = 0.9,
			},

			Scope:New "ImageLabel" {
				Name = "HueSaturationFrame",
				LayoutOrder = 0,
				AnchorPoint = Vector2.new(0.5, 0),
				Image = "http://www.roblox.com/asset/?id=181615068",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Size = UDim2.new(1, 0, 0.43, -8),

				[Children] = {
					Scope:New "UICorner" {
						Name = "UICorner",
						CornerRadius = UDim.new(0, 14),
					},

					Scope:New "Frame" {
						Name = "Pointer",
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						Position = UDim2.new(1, 0, 0.5, 0),
						Size = UDim2.new(0, 10, 0, 10),

						[Children] = {
							Scope:New "UICorner" {
								Name = "UICorner",
								CornerRadius = UDim.new(1, 0),
							},

							Scope:New "UIStroke" {
								Name = "Ignore",
								Thickness = 3,
								Color = Color3.fromRGB(255, 255, 255),
							},
						}
					},
				}
			},

			Scope:New "ImageLabel" {
				Name = "ValueFrame",
				LayoutOrder = 1,
				AnchorPoint = Vector2.new(0.5, 0),
				Image = "http://www.roblox.com/asset/?id=181615071",
				BackgroundColor3 = Color3.fromRGB(255, 66, 66),
				Size = UDim2.new(1, 0, 0.1, -8),

				[Children] = {
					Scope:New "UICorner" {
						Name = "UICorner",
						CornerRadius = UDim.new(0.5, 0),
					},

					Scope:New "Frame" {
						Name = "Pointer",
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						Position = UDim2.new(0.8, 0, 0.5, 0),
						Size = UDim2.new(0, 10, 0, 10),

						[Children] = {
							Scope:New "UIStroke" {
								Name = "Ignore",
								Thickness = 3,
								Color = Color3.fromRGB(255, 255, 255),
							},

							Scope:New "UICorner" {
								Name = "UICorner",
								CornerRadius = UDim.new(1, 0),
							},
						}
					},
				}
			},

			Scope:New "Frame" {
				Name = "ColorPreviews",
				LayoutOrder = 2,
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Size = UDim2.new(1, 0, 0.3, -8),

				[Children] = {
					Scope:New "UIListLayout" {
						Name = "UIListLayout",
						FillDirection = Enum.FillDirection.Horizontal,
						SortOrder = Enum.SortOrder.LayoutOrder,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						Padding = UDim.new(0, 6),
					},

					Scope:New "Frame" {
						Name = "Hex",
						LayoutOrder = 0,
						BackgroundTransparency = 1,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Size = UDim2.new(0.45, 0, 1, 0),

						[Children] = {
							Scope:New "UIListLayout" {
								Name = "UIListLayout",
								SortOrder = Enum.SortOrder.LayoutOrder,
								Padding = UDim.new(0, 6),
							},

							Scope:New "Frame" {
								Name = "ColorDisplay",
								LayoutOrder = 0,
								BackgroundColor3 = Color3.fromRGB(255, 73, 73),
								Size = UDim2.new(1, 0, 0.5, -3),

								[Children] = {
									Scope:New "UICorner" {
										Name = "UICorner",
										CornerRadius = UDim.new(0, 14),
									},
									
									Scope:New "UIStroke" {
										BorderStrokePosition = Enum.BorderStrokePosition.Inner,
										Color = Color3.fromRGB(255, 255, 255),
										Transparency = 0.8,
										Thickness = 1.5,
									}
								}
							},

							Scope:New "Frame" {
								Name = "Hex",
								LayoutOrder = 1,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								Size = UDim2.new(1, 0, 0.5, -3),

								[Children] = {
									Scope:New "UICorner" {
										Name = "UICorner",
										CornerRadius = UDim.new(0, 14),
									},
									
									Scope:New "TextBox" {
										BackgroundTransparency = 1,
										Size = UDim2.new(1, 0, 1, 0),
										Text = "#ffffff",
										FontFace = Font.new(
											"rbxassetid://12187365364",
											Enum.FontWeight.Bold,
											Enum.FontStyle.Normal
										),
										TextWrapped = true,
										TextXAlignment = Enum.TextXAlignment.Left,
										TextColor3 = Scoper.Unwrap(Window.Themes.Text.Description.Color),
										TextScaled = true,
										
										[Children] = {
											Scope:New "UIPadding" {
												Name = "UIPadding",
												PaddingTop = UDim.new(0.25, 0),
												PaddingBottom = UDim.new(0.25, 0),
												PaddingLeft = UDim.new(0.1, 0),
												PaddingRight = UDim.new(0.1, 0),
											},
										}
									},

									Scope:New "UIGradient" {
										Name = "UIGradient",
										Rotation = Scoper.Unwrap(Window.Themes.Component.Rotation),
										Color = Colors.Get(Window.Themes.Component.Color),
									},
								}
							},
						}
					},

					Scope:New "Frame" {
						Name = "RGB",
						LayoutOrder = 1,
						AnchorPoint = Vector2.new(1, 0),
						BackgroundTransparency = 1,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Size = UDim2.new(0.525, 0, 1, 0),

						[Children] = {
							Scope:New "UIListLayout" {
								Name = "UIListLayout",
								FillDirection = Enum.FillDirection.Horizontal,
								SortOrder = Enum.SortOrder.LayoutOrder,
								HorizontalAlignment = Enum.HorizontalAlignment.Center,
								Padding = UDim.new(0, 6),
							},

							Scope:New "Frame" {
								Name = "R",
								LayoutOrder = 0,
								BackgroundTransparency = 1,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								Size = UDim2.new(0.33, -4, 1, 0),

								[Children] = {
									Scope:New "UIListLayout" {
										Name = "UIListLayout",
										SortOrder = Enum.SortOrder.LayoutOrder,
										HorizontalAlignment = Enum.HorizontalAlignment.Center,
									},

									Scope:New "TextLabel" {
										Name = "Title",
										LayoutOrder = 0,
										FontFace = Font.new(
											"rbxasset://fonts/families/SourceSansPro.json",
											Enum.FontWeight.Bold,
											Enum.FontStyle.Normal
										),
										BackgroundColor3 = Color3.fromRGB(255, 255, 255),
										TextColor3 = Scoper.Unwrap(Window.Themes.Text.Title.Color),
										Text = "R",
										TextScaled = false,
										TextSize = 16,
										AnchorPoint = Vector2.new(0.5, 0),
										TextWrapped = true,
										BackgroundTransparency = 1,
										TextTransparency = 0.2,
										Size = UDim2.new(1, 0, 0.5, 0),
									},

									Scope:New "TextBox" {
										Name = "Input",
										LayoutOrder = 1,
										BackgroundColor3 = Color3.fromRGB(255, 255, 255),
										FontFace = Font.new("rbxassetid://12187365364"),
										TextScaled = false,
										TextSize = 16,
										TextColor3 = Scoper.Unwrap(Window.Themes.Text.Description.Color),
										Text = "255",
										CursorPosition = -1,
										TextWrapped = true,
										AnchorPoint = Vector2.new(0, 1),
										BackgroundTransparency = 1,
										PlaceholderColor3 = Color3.fromRGB(178, 178, 178),
										Size = UDim2.new(1, 0, 0.55, 0),

										[Children] = {
											Scope:New "UIPadding" {
												Name = "UIPadding",
												PaddingTop = UDim.new(0.1, 0),
												PaddingBottom = UDim.new(0.1, 0),
											},
										}
									},
								}
							},

							Scope:New "Frame" {
								Name = "G",
								LayoutOrder = 1,
								BackgroundTransparency = 1,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								Size = UDim2.new(0.33, -4, 1, 0),

								[Children] = {
									Scope:New "UIListLayout" {
										Name = "UIListLayout",
										SortOrder = Enum.SortOrder.LayoutOrder,
										HorizontalAlignment = Enum.HorizontalAlignment.Center,
									},

									Scope:New "TextBox" {
										Name = "Input",
										LayoutOrder = 1,
										TextWrapped = true,
										BackgroundColor3 = Color3.fromRGB(255, 255, 255),
										TextColor3 = Scoper.Unwrap(Window.Themes.Text.Description.Color),
										Text = "255",
										TextScaled = false,
										TextSize = 16,
										AnchorPoint = Vector2.new(0, 1),
										FontFace = Font.new("rbxassetid://12187365364"),
										BackgroundTransparency = 1,
										PlaceholderColor3 = Color3.fromRGB(178, 178, 178),
										Size = UDim2.new(1, 0, 0.55, 0),

										[Children] = {
											Scope:New "UIPadding" {
												Name = "UIPadding",
												PaddingTop = UDim.new(0.1, 0),
												PaddingBottom = UDim.new(0.1, 0),
											},
										}
									},

									Scope:New "TextLabel" {
										Name = "Title",
										LayoutOrder = 0,
										FontFace = Font.new(
											"rbxasset://fonts/families/SourceSansPro.json",
											Enum.FontWeight.Bold,
											Enum.FontStyle.Normal
										),
										BackgroundColor3 = Color3.fromRGB(255, 255, 255),
										TextColor3 = Scoper.Unwrap(Window.Themes.Text.Title.Color),
										Text = "G",
										TextScaled = false,
										TextSize = 16,
										AnchorPoint = Vector2.new(0.5, 0),
										TextWrapped = true,
										BackgroundTransparency = 1,
										TextTransparency = 0.2,
										Size = UDim2.new(1, 0, 0.5, 0),
									},
								}
							},

							Scope:New "Frame" {
								Name = "B",
								LayoutOrder = 2,
								BackgroundTransparency = 1,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								Size = UDim2.new(0.33, -4, 1, 0),

								[Children] = {
									Scope:New "UIListLayout" {
										Name = "UIListLayout",
										SortOrder = Enum.SortOrder.LayoutOrder,
										HorizontalAlignment = Enum.HorizontalAlignment.Center,
									},

									Scope:New "TextLabel" {
										Name = "Title",
										LayoutOrder = 0,
										FontFace = Font.new(
											"rbxasset://fonts/families/SourceSansPro.json",
											Enum.FontWeight.Bold,
											Enum.FontStyle.Normal
										),
										BackgroundColor3 = Color3.fromRGB(255, 255, 255),
										TextColor3 = Scoper.Unwrap(Window.Themes.Text.Title.Color),
										Text = "B",
										TextScaled = false,
										TextSize = 16,
										AnchorPoint = Vector2.new(0.5, 0),
										TextWrapped = true,
										BackgroundTransparency = 1,
										TextTransparency = 0.2,
										Size = UDim2.new(1, 0, 0.5, 0),
									},

									Scope:New "TextBox" {
										Name = "Input",
										LayoutOrder = 1,
										BackgroundColor3 = Color3.fromRGB(255, 255, 255),
										FontFace = Font.new("rbxassetid://12187365364"),
										TextScaled = false,
										TextSize = 16,
										TextColor3 = Scoper.Unwrap(Window.Themes.Text.Description.Color),
										Text = "255",
										CursorPosition = -1,
										TextWrapped = true,
										AnchorPoint = Vector2.new(0, 1),
										BackgroundTransparency = 1,
										PlaceholderColor3 = Color3.fromRGB(178, 178, 178),
										Size = UDim2.new(1, 0, 0.55, 0),

										[Children] = {
											Scope:New "UIPadding" {
												Name = "UIPadding",
												PaddingTop = UDim.new(0.1, 0),
												PaddingBottom = UDim.new(0.1, 0),
											},
										}
									},
								}
							},
						}
					},
				}
			},

			Scope:New "Frame" {
				Name = "Padding",
				Size = UDim2.new(1, 0, 0.04, -8),
				LayoutOrder = 3,
				BackgroundTransparency = 1,
			},

			Scope:New "Frame" {
				Name = "Buttons",
				LayoutOrder = 4,
				AnchorPoint = Vector2.new(0, 1),
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Size = UDim2.new(1, 0, 0.15, -8),

				[Children] = {
					Scope:New "UIListLayout" {
						Name = "UIListLayout",
						SortOrder = Enum.SortOrder.LayoutOrder,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						Padding = UDim.new(0, 6),
						FillDirection = Enum.FillDirection.Horizontal,
					},

					Scope:New "TextButton" {
						Name = "Close",
						LayoutOrder = 0,
						TextTransparency = 1,
						AutoButtonColor = false,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Size = UDim2.new(0.5, -3, 1, 0),
						
						[OnEvent "MouseButton1Click"] = function()
							Window.PopupActive:set(false); 
							Opened:set(false);
							Transparency.ControlTransparency(Component, 0.3, 1);

							task.delay(0.3, function()
								Scope:doCleanup();
							end)
						end,

						[Children] = {
							Scope:New "UICorner" {
								Name = "UICorner",
								CornerRadius = UDim.new(0, 14),
							},

							Scope:New "UIGradient" {
								Name = "UIGradient",
								Rotation = Scoper.Unwrap(Window.Themes.Component.Rotation),
								Color = Colors.Get(Window.Themes.Component.Color),
							},
							
							Scope:New "TextLabel" {
								Size = UDim2.fromScale(1, 1),
								BackgroundTransparency = 1,
								TextSize = 14,
								Text = "Close",
								TextColor3 = Scoper.Unwrap(Window.Themes.Text.Description.Color),
								FontFace = Font.new(
									"rbxassetid://12187365364",
									Enum.FontWeight.Bold,
									Enum.FontStyle.Normal
								),
							}
						}
					},

					Scope:New "TextButton" {
						Name = "Done",
						LayoutOrder = 1,
						FontFace = Font.new(
							"rbxassetid://12187365364",
							Enum.FontWeight.Heavy,
							Enum.FontStyle.Normal
						),
						TextColor3 = Color3.fromRGB(255, 255, 255),
						Text = "Done",
						AutoButtonColor = false,
						BackgroundColor3 = Scoper.Unwrap(Window.Themes.Accent),
						TextSize = 14,
						Size = UDim2.new(0.5, -3, 1, 0),
						
						[OnEvent "MouseButton1Click"] = function()
							Settings.Callback(CurrentColor);
							Window.PopupActive:set(false); 
							Opened:set(false);
							Transparency.ControlTransparency(Component, 0.3, 1);

							task.delay(0.3, function()
								Scope:doCleanup();
							end)
						end,

						[Children] = {
							Scope:New "UICorner" {
								Name = "UICorner",
								CornerRadius = UDim.new(0, 14),
							},
						}
					},
				}
			},

			Scope:New "UIGradient" {
				Name = "UIGradient",
				Color = Colors.Get(Window.Themes.Background.Color),
				Rotation = Scoper.Unwrap(Window.Themes.Background.Rotation),
			},

			Scope:New "UIStroke" {
				Name = "UIStroke",
				Thickness = 2,
				Color = Color3.fromRGB(255, 255, 255),
				BorderStrokePosition = Enum.BorderStrokePosition.Inner,

				[Children] = {
					Scope:New "UIGradient" {
						Name = "UIGradient",
						Color = Colors.Get(Window.Themes.Background.InnerOutline.Color),
						Transparency = Colors.Get(Window.Themes.Background.InnerOutline.Transparency, true),
						Rotation = Scoper.Unwrap(Window.Themes.Background.InnerOutline.Rotation),
					},
				}
			},

			Scope:New "UIStroke" {
				Name = "UIStroke",
				Thickness = 0.5,
				Color = Color3.fromRGB(255, 255, 255),

				[Children] = {
					Scope:New "UIGradient" {
						Name = "UIGradient",
						Color = Colors.Get(Window.Themes.Background.OuterOutline.Color),
						Transparency = Colors.Get(Window.Themes.Background.OuterOutline.Transparency, true),
						Rotation = Scoper.Unwrap(Window.Themes.Background.OuterOutline.Rotation),
					},
				}
			},

			Scope:New "UICorner" {
				Name = "UICorner",
				CornerRadius = UDim.new(0, 20),
			},
		}
	}

	local HueSatFrame = Component.HueSaturationFrame
	local ValueSlider = Component.ValueFrame
	local ColorPreview = Component.ColorPreviews.Hex.ColorDisplay
	local HexInput = Component.ColorPreviews.Hex.Hex.TextBox
	local HueSatPointer = HueSatFrame.Pointer
	local ValuePointer = ValueSlider.Pointer
	
	local Inputs = {
		R = Component.ColorPreviews.RGB.R.Input,
		G = Component.ColorPreviews.RGB.G.Input,
		B = Component.ColorPreviews.RGB.B.Input
	}

	local UpdateColor = function()
		local FinalColor = Color3.fromHSV(Hue, Saturation, Brightness);
		local SliderColor = Color3.fromHSV(Hue, Saturation, 1);

		CurrentColor = FinalColor
		ColorPreview.BackgroundColor3 = FinalColor
		ValueSlider.BackgroundColor3 = SliderColor

		local R, G, B = FinalColor.R * 255, FinalColor.G * 255, FinalColor.B * 255
		HexInput.Text = string.format("#%02X%02X%02X", R, G, B);
		Inputs.R.Text = math.floor(R);
		Inputs.G.Text = math.floor(G);
		Inputs.B.Text = math.floor(B);

		HueSatPointer.Position = UDim2.new(Hue, 0, 1 - Saturation, 0) - UDim2.fromOffset(HueSatPointer.AbsoluteSize.X / 2, 0);
		ValuePointer.Position = UDim2.new(Brightness, 0, 0.5, 0) - UDim2.fromOffset(ValuePointer.AbsoluteSize.X / 2, 0);
	end

	local Handle = function(Element, InputCallback)
		Element.InputBegan:Connect(function(Input)
			if (Input.UserInputType == Enum.UserInputType.MouseButton1) then
				local Connection
				local EndConnection

				InputCallback(Input.Position);

				Connection = UserInputService.InputChanged:Connect(function(Change)
					if (Change.UserInputType == Enum.UserInputType.MouseMovement) then
						InputCallback(Change.Position);
					end
				end)

				EndConnection = UserInputService.InputEnded:Connect(function(End)
					if (End.UserInputType == Enum.UserInputType.MouseButton1) then
						Connection:Disconnect();
						EndConnection:Disconnect();
					end
				end)
			end
		end)
	end

	Handle(HueSatFrame, function(MousePosition)
		local RelX = math.clamp((MousePosition.X - HueSatFrame.AbsolutePosition.X) / HueSatFrame.AbsoluteSize.X, 0, 1);
		local RelY = math.clamp((MousePosition.Y - HueSatFrame.AbsolutePosition.Y) / HueSatFrame.AbsoluteSize.Y, 0, 1);

		Hue = RelX
		Saturation = 1 - RelY

		UpdateColor();
	end)

	Handle(ValueSlider, function(MousePosition)
		local RelX = math.clamp((MousePosition.X - ValueSlider.AbsolutePosition.X) / ValueSlider.AbsoluteSize.X, 0, 1);

		Brightness = RelX
		UpdateColor();
	end)

	HexInput.FocusLost:Connect(function()
		local Hex = HexInput.Text:gsub("#", "");
		
		if (#Hex == 6) then
			local R = tonumber(Hex:sub(1, 2), 16);
			local G = tonumber(Hex:sub(3, 4), 16);
			local B = tonumber(Hex:sub(5, 6), 16);

			if (R and G and B) then
				local H, S, V = Color3.fromRGB(R, G, B):ToHSV();
				Hue, Saturation, Brightness = H, S, V
				UpdateColor();
			end
		end
	end)

	for Key, Box in next, Inputs do
		Box.FocusLost:Connect(function()
			local R = tonumber(Inputs.R.Text) or 0
			local G = tonumber(Inputs.G.Text) or 0
			local B = tonumber(Inputs.B.Text) or 0

			R = math.clamp(R, 0, 255);
			G = math.clamp(G, 0, 255);
			B = math.clamp(B, 0, 255);

			local H, S, V = Color3.fromRGB(R, G, B):ToHSV();
			Hue, Saturation, Brightness = H, S, V
			UpdateColor();
		end)
	end
	
	Transparency.Add(Component);
	Transparency.ControlTransparency(Component, 0, 1);

	Window.PopupActive:set(true); 
	Opened:set(true);
	Transparency.ControlTransparency(Component, 0.3, 0);
	UpdateColor()
end

return ColorPicker