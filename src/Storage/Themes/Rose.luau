return {
	Mode = "Dark",
	Accent = Color3.fromRGB(255, 85, 140),

	Background = {
		Rotation = 135,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 14, 16)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 8, 10))
		}),

		Line = {
			Color = Color3.fromRGB(220, 160, 180),
			Transparency = 0.87
		},

		OuterOutline = {
			Transparency = 0,
			Color = Color3.fromRGB(0, 0, 0),
			Rotation = 0,
		},

		InnerOutline = {
			Transparency = 0.8,
			Color = Color3.fromRGB(180, 130, 150),
			Rotation = 0,
		}
	},

	Text = {
		Title = {
			Color = Color3.fromRGB(255, 255, 255),
		},

		Description = {
			Color = Color3.fromRGB(205, 185, 195),
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
			ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 16, 18)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 14, 16))
		}),

		Rotation = 225,
		ScrollBarColor = Color3.fromRGB(180, 130, 150),
		InnerOutline = {
			Transparency = 0.9,
			Color = Color3.fromRGB(180, 130, 150),
			Rotation = 0,
		},

		OuterOutline = {
			Transparency = 0,
			Color = Color3.fromRGB(0, 0, 0),
			Rotation = 0,
		},
	},

	Component = {
		Color = Color3.fromRGB(28, 22, 24),
		Rotation = 0,
	},
	
	Controls = {
		Color = Color3.fromRGB(37, 30, 33),
		Outline = Color3.fromRGB(42, 34, 37)
	},
}