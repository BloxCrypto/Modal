return {
	Mode = "Dark",
	Accent = Color3.fromRGB(120, 160, 255),

	Background = {
		Rotation = 180,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 8, 15)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 5))
		}),

		Line = {
			Color = Color3.fromRGB(100, 140, 255),
			Transparency = 0.88
		},

		OuterOutline = {
			Transparency = 0,
			Color = Color3.fromRGB(0, 0, 0),
			Rotation = 0,
		},

		InnerOutline = {
			Transparency = 0.7,
			Color = Color3.fromRGB(80, 120, 200),
			Rotation = 0,
		}
	},
	
	Text = {
		Title = {
			Color = Color3.fromRGB(240, 245, 255),
		},

		Description = {
			Color = Color3.fromRGB(160, 180, 220),
		}
	},
	
	Icons = {
		ActionButtons = {
			Color = Color3.fromRGB(240, 245, 255),
			Transparency = 0.15,
		}
	},
	
	Content = {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 12, 20)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 8, 15))
		}),

		Rotation = 270,
		ScrollBarColor = Color3.fromRGB(100, 140, 200),

		InnerOutline = {
			Transparency = 0.85,
			Color = Color3.fromRGB(80, 120, 200),
			Rotation = 0,
		},

		OuterOutline = {
			Transparency = 0,
			Color = Color3.fromRGB(0, 0, 0),
			Rotation = 0,
		},
	},
	
	Component = {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(13, 18, 31)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 20, 35))
		}),
		
		Rotation = 45,
	},
	
	Controls = {
		Color = Color3.fromRGB(18, 24, 40),
		Outline = Color3.fromRGB(25, 35, 60)
	},
}