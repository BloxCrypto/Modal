return {
	Mode = "Light",
	Accent = Color3.fromRGB(113, 182, 232),
	
	Background = {
		Rotation = 90,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(239, 237, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
		}),

		Line = {
			Color = Color3.fromRGB(0, 0, 0),
			Transparency = 0.9
		},

		OuterOutline = {
			Transparency = 0.6,
			Color = Color3.fromRGB(0, 0, 0),
			Rotation = 0,
		},

		InnerOutline = {
			Transparency = 0,
			Color = Color3.fromRGB(255, 255, 255),
			Rotation = 0,
		}
	},

	Text = {
		Title = {
			Color = Color3.fromRGB(0, 0, 0),
		},

		Description = {
			Color = Color3.fromRGB(110, 110, 110),
		}
	},

	Icons = {
		ActionButtons = {
			Color = Color3.fromRGB(0, 0, 0),
			Transparency = 0.7,
		}
	},

	Content = {
		Color = Color3.fromRGB(251, 248, 255),
		Rotation = 0,
		ScrollBarColor = Color3.fromRGB(200, 200, 200),

		InnerOutline = {
			Transparency = 0.9,
			Color = Color3.fromRGB(0, 0, 0),
		},

		OuterOutline = {
			Transparency = 1,
			Color = Color3.fromRGB(0, 0, 0),
			Rotation = 0,
		},
	},

	Component = {
		Color = Color3.fromRGB(245, 242, 249),
		Rotation = 0,
	},

	Controls = {
		Color = Color3.fromRGB(235, 232, 239),
		Outline = Color3.fromRGB(227, 225, 231)
	},
}
