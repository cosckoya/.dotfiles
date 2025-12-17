-- Editor Plugins: Simple and Functional Configuration
-- Only essential plugins for a pleasant editing experience

return {
  -- Which-Key: Display keybinding hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        preset = "modern",
        win = {
          border = "rounded",
        },
      })

      -- Register leader key groups
      wk.add({
        { "<leader>f", group = "Find" },
        { "<leader>c", group = "Code" },
        { "<leader>n", group = "Tree" },
      })
    end,
  },

  -- Autopairs: Auto close brackets, quotes, etc
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = false, -- No treesitter dependency
        fast_wrap = {},
      })

      -- Integration with nvim-cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- Comment: Smart commenting
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("Comment").setup()
    end,
  },

  -- Nvim-Tree File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Disable netrw at the very start
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
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

      -- Keybindings
      local keymap = vim.keymap.set
      local opts = { silent = true, noremap = true }

      keymap("n", "<leader>n", ":NvimTreeFocus<CR>", opts)
      keymap("n", "<C-n>", ":NvimTreeOpen<CR>", opts)
      keymap("n", "<C-t>", ":NvimTreeToggle<CR>", opts)
      keymap("n", "<C-f>", ":NvimTreeFindFile<CR>", opts)
    end,
  },

  -- Telescope Fuzzy Finder - Simple configuration
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
          },
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
              ["<Esc>"] = "close",
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            theme = "dropdown",
          },
        },
      })
    end,
  },
}
