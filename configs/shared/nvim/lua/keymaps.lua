-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}

vim.g.maplocalleader = " "
vim.g.mapleader = " "

-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Neovide 特定的快捷键
if vim.g.neovide then
    -- 字体放大缩小
    vim.keymap.set('n', '<D-=>', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>', opts)
    vim.keymap.set('n', '<D-->', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>', opts)
    vim.keymap.set('n', '<D-0>', ':lua vim.g.neovide_scale_factor = 1<CR>', opts)
    
    -- 可选：添加更多Neovide相关的快捷键
    vim.keymap.set('n', '<D-v>', '"+p', opts) -- 粘贴
    vim.keymap.set('v', '<D-c>', '"+y', opts) -- 复制
    vim.keymap.set('n', '<D-a>', 'ggVG', opts) -- 全选
end

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

