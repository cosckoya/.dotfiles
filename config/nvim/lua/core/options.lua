-- Neovim Core Options
-- Migrated from vimrc to Lua

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Display Settings
vim.opt.number = true                    -- Show line numbers
vim.opt.colorcolumn = "90"               -- Vertical line at column 90
vim.opt.signcolumn = "yes"               -- Always show sign column
vim.opt.laststatus = 2                   -- Always show status line
vim.opt.cursorline = true                -- Highlight current line

-- File Handling
vim.opt.fileencoding = "utf-8"           -- File encoding
vim.opt.fileformats = "unix"             -- Line ending format
vim.opt.backup = false                   -- No backup files
vim.opt.writebackup = false              -- No backup before overwriting
vim.opt.hidden = true                    -- Allow hidden buffers

-- Indentation
vim.opt.tabstop = 2                      -- Tab width
vim.opt.shiftwidth = 2                   -- Indent width
vim.opt.expandtab = true                 -- Use spaces instead of tabs
vim.opt.smartindent = true               -- Smart indentation
vim.opt.autoindent = true                -- Auto indentation
vim.opt.wrap = false                     -- No line wrapping

-- Search
vim.opt.hlsearch = true                  -- Highlight search results
vim.opt.incsearch = true                 -- Incremental search
vim.opt.ignorecase = true                -- Case insensitive search
vim.opt.smartcase = true                 -- Case sensitive if uppercase present

-- Performance
vim.opt.updatetime = 300                 -- Faster completion
vim.opt.history = 100                    -- Command history size
vim.opt.timeoutlen = 400                 -- Time to wait for mapped sequence
vim.opt.shortmess:append("c")            -- Don't show completion messages

-- Splits
vim.opt.splitright = true                -- Vertical split to the right
vim.opt.splitbelow = true                -- Horizontal split below

-- Mouse
vim.opt.mouse = "a"                      -- Enable mouse support

-- Clipboard
vim.opt.clipboard = "unnamedplus"        -- Use system clipboard

-- Completion
vim.opt.completeopt = "menu,menuone,noselect"  -- Completion options
