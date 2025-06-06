-- 提示：如果需要，可使用 `:h <选项>`了解其含义
vim.opt.clipboard = 'unnamedplus' -- use system clipboard
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.mouse = 'a' -- 允许在 Nvim 中使用鼠标

-- Tab
vim.opt.tabstop = 4 -- number of visual spaces per TAB
vim.opt.softtabstop = 4 -- number of spacesin tab when editing
vim.opt.shiftwidth = 4 -- insert 4 spaces on a tab
vim.opt.expandtab = true -- tabs are spaces, mainly because of python

-- UI config
vim.opt.number = true -- show absolute number
vim.opt.relativenumber = true -- add numbers to each line on the left side
vim.opt.cursorline = true -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true -- open new vertical split bottom
vim.opt.splitright = true -- open new horizontal splits right
-- vim.opt.termguicolors = true        -- enabl 24-bit RGB color in the TUI
vim.opt.showmode = false -- we are experienced, wo don't need the "-- INSERT --" mode hint

-- Searching
vim.opt.incsearch = true -- search as characters are entered
vim.opt.hlsearch = false -- do not highlight matches
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true -- but make it case sensitive if an uppercase is entered

-- 设置<leader>键为空格键
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Neovide 配置
if vim.g.neovide then
    -- 字体设置
    vim.o.guifont = "Fira Code:h14" -- 设置字体和大小，您可以根据喜好调整
    
    -- 缩放因子（初始值）
    vim.g.neovide_scale_factor = 1.0
    
    -- 不透明度设置
    vim.g.neovide_opacity = 1.0
    
    -- 滚动动画时间
    vim.g.neovide_scroll_animation_length = 0.3
    
    -- 光标动画设置
    vim.g.neovide_cursor_animation_length = 0.13
    vim.g.neovide_cursor_trail_size = 0.8
    vim.g.neovide_cursor_antialiasing = true
    
    -- 刷新率
    vim.g.neovide_refresh_rate = 60
    
    -- 空闲时刷新率
    vim.g.neovide_refresh_rate_idle = 5
    
    -- 记住窗口大小
    vim.g.neovide_remember_window_size = true
end
