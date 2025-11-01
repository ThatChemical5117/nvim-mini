return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {"lua", "vim", "vimdoc"},
			sync_install = true,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		}
	}
}
