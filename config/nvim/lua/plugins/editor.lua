-- Editor Plugins: File Explorer, Fuzzy Finder, Syntax Highlighting

return {
  -- Nvim-Tree File Explorer (replaces NERDTree)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Disable netrw at the very start
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        filters = {
          dotfiles = false,
          custom = { ".git" },
        },
        git = {
          enable = true,
          ignore = false,
        },
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
      })

      -- Keybindings (replicate NERDTree keybindings)
      local keymap = vim.keymap.set
      local opts = { silent = true, noremap = true }

      keymap("n", "<leader>n", ":NvimTreeFocus<CR>", opts)
      keymap("n", "<C-n>", ":NvimTreeOpen<CR>", opts)
      keymap("n", "<C-t>", ":NvimTreeToggle<CR>", opts)
      keymap("n", "<C-f>", ":NvimTreeFindFile<CR>", opts)
    end,
  },

  -- Telescope Fuzzy Finder (replaces FZF)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          prompt_prefix = "🔍 ",
          selection_caret = "➤ ",
          path_display = { "truncate" },
          file_ignore_patterns = {
            "node_modules",
            ".git/",
            "*.pyc",
            "__pycache__",
            "*.o",
            "*.a",
          },
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
              ["<C-q>"] = "close",
              ["<Esc>"] = "close",
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            theme = "dropdown",
          },
          live_grep = {
            theme = "dropdown",
          },
          buffers = {
            theme = "dropdown",
          },
        },
        extensions = {},
      })
    end,
  },

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        -- Install parsers for these languages
        ensure_installed = {
          "python",
          "go",
          "bash",
          "lua",
          "vim",
          "vimdoc",
          "markdown",
          "markdown_inline",
          "json",
          "yaml",
          "toml",
        },
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        -- Automatically install missing parsers when entering buffer
        auto_install = true,
        -- List of parsers to ignore installing
        ignore_install = {},
        highlight = {
          enable = true,
          -- Disable slow treesitter highlight for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<S-CR>",
            node_decremental = "<BS>",
          },
        },
      })
    end,
  },
}
