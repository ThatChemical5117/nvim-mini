return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {"c", "lua", "vim", "vimdoc", "cpp", "diff", "bash", "java" },
			sync_install = true,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		}
	}
}
