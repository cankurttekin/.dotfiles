function ColorMyWorld(color, mode)
	color = color or "catppuccin-macchiato"
    mode = mode or "dark"
	vim.cmd.colorscheme(color)
    vim.o.background = mode

	--vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyWorld()
