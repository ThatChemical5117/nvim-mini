
-- Add keybindings to on LSP attach
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Set options
		local keymap = vim.keymap
		local opts = {buffer = ev.buf, silent = true, remap = false}

		opts.desc = "Show LSP references"
		keymap.set("n", "<leader>vrr", "<cmd>Telescope lso_references<CR>", opts)

		opts.desc = "Go to declaration"
		keymap.set("n", "<leader>vgd", vim.lsp.buf.declaration, opts)

		-- Definition
		opts.desc = "Show LSP definition"
		keymap.set("n", "<leader>vgd", function() vim.lsp.buf.definition() end, opts)

		opts.desc = "Show LSP implemntations"
		keymap.set("n", "<leader>vgi", "<cmd>Telescope lsp_implementations<CR>", opts)

		opts.desc = "Show LSP type definitions"
		keymap.set("n", "<leader>vgt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

		-- Quick fix
		opts.desc = "open code actions"
		vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)

		-- rename
		opts.desc = "rename function"
		vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts )

		opts.desc = "Show buffer diagnostics"
		keymap.set("n", "<leader>vbd", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

		-- open diagnostic 
		opts.desc = "Open Diagnostic"
		keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)


		-- Hover
		opts.desc = "Hover"
		keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)

		-- go to workspace symbol
		opts.desc = "Workspace symbol"
		keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)

			-- move to diagnostic next
		opts.desc = "goto next diagnostic"
		keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)

		-- move to previous
		opts.desc = "goto previous diagnostic"
		keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end,opts )

		-- signature help
		opts.desc = "signature help"
		vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	end
})

-- get diagnostic severity
local severity = vim.diagnostic.severity

-- set signs 
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }

-- set signs
vim.diagnostic.config({
	signs = {
		text = {
			[severity.ERROR] = signs.Error,
			[severity.WARN] = signs.Warn,
			[severity.HINT] = signs.Hint,
			[severity.INFO] = signs.Info
		}
	}
})
