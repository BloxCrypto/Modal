return {
	Mode = "Dark",
	Accent = Color3.fromRGB(125, 73, 255),

	Background = {
		Rotation = 75,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(23, 23, 34)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 15))
		}),

		Line = {
			Color = Color3.fromRGB(180, 180, 220),
			Transparency = 0.87
		},

		OuterOutline = {
			Transparency = 0,
			Color = Color3.fromRGB(0, 0, 0),
			Rotation = 0,
		},

		InnerOutline = {
			Transparency = 0.7,
			Color = Color3.fromRGB(160, 160, 200),
			Rotation = 0,
		}
	},
	
	Text = {
		Title = {
			Color = Color3.fromRGB(255, 255, 255),
		},

		Description = {
			Color = Color3.fromRGB(190, 190, 210),
		}
	},
	
	Icons = {
		ActionButtons = {
			Color = Color3.fromRGB(235, 235, 255),
			Transparency = 0.2,
		}
	},
	
	Content = {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(17, 17, 24)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 16, 22))
		}),
		
		Rotation = 225,
		ScrollBarColor = Color3.fromRGB(160, 160, 190),
		
		InnerOutline = {
			Transparency = 0.9,
			Color = Color3.fromRGB(150, 150, 190),
			Rotation = 0,
		},
		
		OuterOutline = {
			Transparency = 0,
			Color = Color3.fromRGB(0, 0, 0),
			Rotation = 0,
		},
	},
	
	Component = {
		Color = Color3.fromRGB(23, 23, 33),
		Rotation = 0,
	},
	
	Controls = {
		Color = Color3.fromRGB(30, 30, 43),
		Outline = Color3.fromRGB(33, 33, 46)
	},
}