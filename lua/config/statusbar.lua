--- Line
---@diagnostic disable: need-check-nil

-- Highlights for LSP signs in status bar
vim.api.nvim_set_hl(0, "LspDiagnosticsSignError", {fg = "#f38ba8", bg = "#181825"})
vim.api.nvim_set_hl(0, "LspDiagnosticsSignWarning", {fg = "#f9e2af", bg = "#181825"})
vim.api.nvim_set_hl(0, "LspDiagnosticsSignInformation", {fg ="#89dceb", bg = "#181825"})
vim.api.nvim_set_hl(0, "LspDiagnosticsSignHint", {fg = "#94e2d5", bg="#181825"})

-- Highlights for the Status line modes
vim.api.nvim_set_hl(0, "StatuslineAccent", {fg ="#0f1633", bg = "#36a3d9"})
vim.api.nvim_set_hl(0, "StatuslineInsertAccent", {fg = "#0f1633", bg = "#b8cc52"})
vim.api.nvim_set_hl(0, "StatuslineVisualAccent", {fg= "#0f1633", bg= "#ffee99"})
vim.api.nvim_set_hl(0, "StatuslineReplaceAccent", {fg= "#0f1633", bg= "#f07178"})
vim.api.nvim_set_hl(0, "StatuslineCmdLineAccent", {fg= "#0f1633", bg= "#ae81ff"})
vim.api.nvim_set_hl(0, "StatuslineTerminalAccent", {fg= "#0f1633", bg= "#ffffff"})

-- mode table to display
local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

-- gets current mode
local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(" %s ", modes[current_mode]):upper()
end

-- changed mode color based on current mode
local function update_mode_colors()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#StatusLineAccent#"
  if current_mode == "n" then
      mode_color = "%#StatuslineAccent#"
  elseif current_mode == "i" or current_mode == "ic" then
      mode_color = "%#StatuslineInsertAccent#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
      mode_color = "%#StatuslineVisualAccent#"
  elseif current_mode == "R" then
      mode_color = "%#StatuslineReplaceAccent#"
  elseif current_mode == "c" then
      mode_color = "%#StatuslineCmdLineAccent#"
  elseif current_mode == "t" then
      mode_color = "%#StatuslineTerminalAccent#"
  end
  return mode_color
end


-- returns the name of the branch in git
local function GitBranch()
	local command = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
	local commandResault = command:read("*a")

	command:close()

	return commandResault
end

-- Takes output of GitBranch and decides what to render in statusline
local function StatuslineGit()

	local branchName = GitBranch()
	local noBranchName = ''
	local statuslineoutput

	if branchName:len() > 0 then
		statuslineoutput = string.format("%s ", branchName)
	else
		statuslineoutput = noBranchName
	end

	return statuslineoutput
end

-- returns the file path of the current buffer 
local function filepath()
  local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
  if fpath == "" or fpath == "." then
      return " "
  end

  return string.format(" %%<%s/", fpath)
end

-- returns the file name of the current buffer
local function filename()
  local fname = vim.fn.expand "%:t"
  if fname == "" then
      return ""
  end
  return fname .. " "
end

-- gets the line info for the current buffer
local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " %p%% %l:%c "
end

-- uses the lsp to get diagnostic signs
-- and display them in the status line
local function lsp()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = " %#LspDiagnosticsSignError#󰅚 " .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = " %#LspDiagnosticsSignWarning#󰀪 " .. count["warnings"]
  end
  if count["hints"] ~= 0 then
    hints = " %#LspDiagnosticsSignHint#󰌶 " .. count["hints"]
  end
  if count["info"] ~= 0 then
    info = " %#LspDiagnosticsSignInformation# " .. count["info"]
  end

  return errors .. warnings .. hints .. info .. "%#LineNr#%#CursorColumn#"
end

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- status line
Statusline = {}

-- Active status line
---@diagnostic disable-next-line: duplicate-set-field
Statusline.active = function()
  return table.concat {
	"%#LineNr#",
	update_mode_colors(),
	mode(),
	"%#LineNr#",
	"%#CursorColumn#",
	filepath(),
	filename(),
	"%m",
    lsp(),
	"%=",
	StatuslineGit(),
	"%#LineNr#",
	"%#CursorColumn#",
	" %y",
	" %{&fileencoding?&fileencoding:&encoding}",
	"[%{&fileformat}]",
	lineinfo(),
}
end

-- status line for out of focus buffer
---@diagnostic disable-next-line: duplicate-set-field
function Statusline.inactive()
	return table.concat{
		"%#LineNr#",
		filepath(),
		filename(),
		"%m",
		"%=",
		StatuslineGit(),
		" %y",
		" %{&fileencoding?&fileencoding:&encoding}",
		"[%{&fileformat}]",
	}
end

---@diagnostic disable-next-line: duplicate-set-field
function Statusline.short()
  return "%f"
end

-- creates the auto command for creatig the status bar
vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)



