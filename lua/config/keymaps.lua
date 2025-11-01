vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear highlight search" })

-- Center screen when jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz", {desc = "Jump down"})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {desc = "Jump up"})
vim.keymap.set("n", "n", "nzzzv", { desc = "Center when finding next"} )
vim.keymap.set("n", "N", "Nzzzv", { desc = "Center when finding previous" })

-- copy + paste
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Copy to clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Copy to clipboard from Visual" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Copy to clipboard special" })

vim.keymap.set("n", "<leader>p", "\"+p", { desc = "Paste from clipboard" })

vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set("n", '<leader>bn', ':bnext<CR>', { desc = "Next Buffer" })
vim.keymap.set("n", '<leader>bp', ':bprevious<CR>', { desc = "Previous Buffer" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Splitting & Resizing
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Quick file navigation
vim.keymap.set("n", "<leader>e", ":Explore<CR>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>ff", ":find ", { desc = "Find file" })

-- Copy file path
vim.keymap.set('n', '<leader>pa', function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end)
