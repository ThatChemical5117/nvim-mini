return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavor = "auto",
			background = {
				light = "macchiato",
				dark = "mocha"
			},
			term_color = false,
			transparent_background = true,
			integrations = {
				cmp = true,
				treesitter = true,
				harpoon = true,
				makrdown = true,
				mason = true,
				neogit = true,
				telescope = {
					enabled = true,
					transparent_background = true
				}
			}
		}
	}
}
