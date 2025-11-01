return {
	{
		'hrsh7th/nvim-cmp',
		dependencies= {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-nvim-lua',
			'L3MON4D3/LuaSnip',
			'rafamadriz/friendly-snippets',
		},
		config=function()
			local cmp = require('cmp')
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			require('luasnip.loaders.from_vscode').lazy_load()

			cmp.setup({
				sources = {
					{ name = 'path' },
					{ name = 'nvim_lsp'},
					{ name = 'nvim_lua'},
					{ name = 'luasnip', keyword_length = 2},
					{ name = 'buffer', keyword_length = 3},
				},
				mapping = cmp.mapping.preset.insert({
					['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
					['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
					['<C-y>'] = cmp.mapping.confirm({select = true}),
					['<C-space>'] = cmp.mapping.complete(),
				}),
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end
				},
			})
		end
	}

}
