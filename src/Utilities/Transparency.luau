

-- Services
local TweenService = game:GetService("TweenService");

-- Init
local Transparency = ({ AddedObjects = ({}) });

Transparency.Add = function(Object: GuiObject)
	local Add = function(GuiObject)
		if (table.find(Transparency.AddedObjects, GuiObject)) then
			return
		end

		table.insert(Transparency.AddedObjects, GuiObject);

		if (GuiObject:IsA("UIStroke")) then
			if (GuiObject.Transparency < 1) then
				if (not GuiObject:FindFirstChild("Transparency")) then
					local TransparencyValue = Instance.new("NumberValue");
					TransparencyValue.Name = "Transparency"
					TransparencyValue.Parent = GuiObject
					TransparencyValue.Value = GuiObject.Transparency
				end
			end
		end

		if (GuiObject:IsA("GuiObject")) then
			if (GuiObject.BackgroundTransparency < 1) then
				if (not GuiObject:FindFirstChild("BackgroundTransparency")) then
					local BackgroundTransparency = Instance.new("NumberValue");
					BackgroundTransparency.Name = "BackgroundTransparency"
					BackgroundTransparency.Parent = GuiObject
					BackgroundTransparency.Value = GuiObject.BackgroundTransparency
				end
			end
			
			if (GuiObject:IsA("TextLabel") or GuiObject:IsA("TextButton") or GuiObject:IsA("TextBox")) then
				if (GuiObject.TextTransparency < 1) then
					if (not GuiObject:FindFirstChild("TextTransparency")) then
						local TextTransparency = Instance.new("NumberValue");
						TextTransparency.Name = "TextTransparency"
						TextTransparency.Parent = GuiObject
						TextTransparency.Value = GuiObject.TextTransparency
					end
				end
				
			elseif (GuiObject:IsA("ImageLabel") or GuiObject:IsA("ImageButton")) then
				if (GuiObject.ImageTransparency < 1) then
					if (not GuiObject:FindFirstChild("ImageTransparency")) then
						local ImageTransparency = Instance.new("NumberValue");
						ImageTransparency.Name = "ImageTransparency"
						ImageTransparency.Parent = GuiObject
						ImageTransparency.Value = GuiObject.ImageTransparency
					end
				end
				
			elseif (GuiObject:IsA("ScrollingFrame")) then
				if (GuiObject.ScrollBarImageTransparency < 1) then
					if (not GuiObject:FindFirstChild("ScrollBarImageTransparency")) then
						local ScrollBarImage = Instance.new("NumberValue");
						ScrollBarImage.Name = "ScrollBarImageTransparency"
						ScrollBarImage.Parent = GuiObject
						ScrollBarImage.Value = GuiObject.ScrollBarImageTransparency
					end
				end
			end
		end
	end

	Add(Object);
	Object.DescendantAdded:Connect(Add)

	for _, Object in next, Object:GetDescendants() do
		Add(Object);
	end
end

Transparency.Tween = function(Object, Duration, Properties)
	return TweenService:Create(Object, TweenInfo.new(Duration), Properties):Play()
end

Transparency.ControlTransparency = function(Object, Duration, TransparencyAmount)
	for _, ValueObject in next, Object:GetDescendants() do
		if (ValueObject:IsA("NumberValue") and string.find(ValueObject.Name, "Transparency")) then
			local Value = math.clamp(TransparencyAmount, ValueObject.Value, 1);
			
			if (ValueObject.Parent.Name == "_Window") then
				Value /= 3
			end
			
			Transparency.Tween(ValueObject.Parent, Duration, { [ValueObject.Name] = Value });
		end
	end
end

return Transparency