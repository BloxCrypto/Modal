return {
	Mode = "Dark",
	Accent = Color3.fromRGB(80, 230, 160),

	Background = {
		Rotation = 135,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(14, 20, 16)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 14, 10))
		}),

		Line = {
			Color = Color3.fromRGB(160, 220, 190),
			Transparency = 0.87
		},

		OuterOutline = {
			Transparency = 0,
			Color = Color3.fromRGB(0, 0, 0),
			Rotation = 0,
		},

		InnerOutline = {
			Transparency = 0.7,
			Color = Color3.fromRGB(130, 180, 160),
			Rotation = 0,
		}
	},

	Text = {
		Title = {
			Color = Color3.fromRGB(255, 255, 255),
		},

		Description = {
			Color = Color3.fromRGB(185, 205, 195),
		}
	},

	Icons = {
		ActionButtons = {
			Color = Color3.fromRGB(255, 255, 255),
			Transparency = 0.1,
		}
	},

	Content = {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(16, 22, 18)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 20, 16))
		}),
		
		Rotation = 225,
		ScrollBarColor = Color3.fromRGB(130, 180, 160),

		InnerOutline = {
			Transparency = 0.9,
			Color = Color3.fromRGB(130, 180, 160),
			Rotation = 0,
		},

		OuterOutline = {
			Transparency = 0,
			Color = Color3.fromRGB(0, 0, 0),
			Rotation = 0,
		},
	},

	Component = {
		Color = Color3.fromRGB(22, 28, 24),
		Rotation = 0,
	},

	Controls = {
		Color = Color3.fromRGB(30, 37, 33),
		Outline = Color3.fromRGB(34, 42, 37)
	},
}