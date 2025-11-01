return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-tree/nvim-web-devicons"
		},
		opts = {
			extension = {
				['ui-select'] = {
					require('telescope.themes').get_dropdown(),
				},
			}
		},
	}
}

