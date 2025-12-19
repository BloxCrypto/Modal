-- Variables
local Modal = (script.Parent.Parent);

-- Modules
local Fusion = require(Modal.Packages.Fusion);
local Storage = require(Modal.Storage.Information);

-- Functions
local StorageScope = (Storage.Scope);
local Setup = function(InnerScope)
	local Scope = InnerScope or StorageScope
	local Colors = ({});

	Colors.Darken = function(Color, Factor)
		if (typeof(Color) == "Color3") then
			return Color3.fromRGB(
				math.clamp(Color.R * 255 - Factor, 0, 255),
				math.clamp(Color.G * 255 - Factor, 0, 255),
				math.clamp(Color.B * 255 - Factor, 0, 255)
			)
		elseif (typeof(Color) == "ColorSequence") then
			local Keypoints = ({});

			for Index, Key in next, (Color.Keypoints) do
				Keypoints[Index] = ColorSequenceKeypoint.new(Key.Time,
					Color3.fromRGB(
						math.clamp(Key.Value.R * 255 - Factor, 0, 255),
						math.clamp(Key.Value.G * 255 - Factor, 0, 255),
						math.clamp(Key.Value.B * 255 - Factor, 0, 255)
					)
				)
			end

			return ColorSequence.new(Keypoints);
		end
	end

	Colors.Lighten = function(Color, Factor)
		if (typeof(Color) == "Color3") then
			return Color3.fromRGB(
				math.clamp(Color.R * 255 + Factor, 0, 255),
				math.clamp(Color.G * 255 + Factor, 0, 255),
				math.clamp(Color.B * 255 + Factor, 0, 255)
			)
		elseif (typeof(Color) == "ColorSequence") then
			local Keypoints = ({});

			for Index, Key in next, (Color.Keypoints) do
				Keypoints[Index] = ColorSequenceKeypoint.new(Key.Time,
					Color3.fromRGB(
						math.clamp(Key.Value.R * 255 + Factor, 0, 255),
						math.clamp(Key.Value.G * 255 + Factor, 0, 255),
						math.clamp(Key.Value.B * 255 + Factor, 0, 255)
					)
				)
			end

			return ColorSequence.new(Keypoints);
		end
	end

	Colors.Set = function(Color: Color3, Factor: number, Mode: string)
		local Method = (Mode == "Light" and Colors.Darken) or Colors.Lighten
		return Method(Color, Factor)
	end
	
	Colors.Get = function(Theme: Fusion.Value, Transparency: boolean, SetupTheme: boolean)
		local NewValue = (SetupTheme and Theme) or Fusion.peek(Theme);
		if (Transparency) then
			if (typeof(NewValue) == "number") then
				return NumberSequence.new({
					NumberSequenceKeypoint.new(0, NewValue),
					NumberSequenceKeypoint.new(1, NewValue)
				})
			elseif (typeof(NewValue) == "NumberSequence") then
				return (NewValue);
			else
				return (1);
			end
		else
			if (typeof(NewValue) == "Color3") then
				return ColorSequence.new({
					ColorSequenceKeypoint.new(0, NewValue),
					ColorSequenceKeypoint.new(1, NewValue),
				})
			elseif (typeof(NewValue) == "ColorSequence") then
				return (NewValue);
			else
				return Color3.fromRGB(255, 0, 0);
			end
		end
	end 
	
	Colors.SetupTheme = function(Theme: Fusion.Value, Transparency: boolean)
		return Scope:Computed(function(Use)
			local ThemeValue = (Use(Theme))
			return Colors.Get(ThemeValue, Transparency, true);
		end)
	end
	
	return Colors
end

-- ⚙️ Init
return setmetatable(Setup(), {
	__call = function(self, InnerScope)
		return Setup(InnerScope);
	end,
})