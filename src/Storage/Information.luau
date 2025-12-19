-- Services
local CoreGui = game:GetService("CoreGui");
local Players = game:GetService("Players");

-- Variables
local Modal = (script.Parent.Parent);

-- Modules
local Fusion = require(Modal.Packages.Fusion);

-- Functions
local Scope = Fusion:scoped();
local Children = (Fusion.Children);
local Create = function()
	return Scope:New("ScreenGui")({
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		
		Parent = (function()
			if (gethui and gethui()) then
				return gethui();
			elseif (CoreGui) then
				return CoreGui
			else
				return Players.LocalPlayer.PlayerGui
			end
		end)(),
	})
end

-- Init
local Storage = ({});
Storage.Scope = Scope
Storage.ScreenGuis = ({
	Window = Create();
	Notification = (function()
		local ScreenGui = Create();
		
		Scope:New "Frame" {
			Name = "Holder",
			AnchorPoint = Vector2.new(1, 0),
			BackgroundTransparency = 1,
			Position = UDim2.new(1, 0, 0, 0),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			Size = UDim2.new(0, 230, 1, 0),
			Parent = ScreenGui,
			
			[Children] = {
				Scope:New "UIListLayout" {
					Name = "UIListLayout",
					VerticalAlignment = Enum.VerticalAlignment.Bottom,
					SortOrder = Enum.SortOrder.LayoutOrder,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
				},

				Scope:New "UIPadding" {
					Name = "UIPadding",
					PaddingTop = UDim.new(0, 10),
					PaddingBottom = UDim.new(0, 10),
					PaddingRight = UDim.new(0, 10),
					PaddingLeft = UDim.new(0, 10),
				},
			}
		}
		
		return ScreenGui
	end)();
})

return Storage