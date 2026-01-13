-- UI Plugins: Theme and Statusline

return {
  -- Tokyonight Theme (customized for Drizzt Do'Urden palette)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",              -- night, storm, moon, or day
        transparent = false,           -- Enable transparent background
        terminal_colors = true,        -- Configure terminal colors
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = "dark",
          floats = "dark",
        },
        sidebars = { "qf", "help", "terminal" },
        day_brightness = 0.3,
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = true,
        -- Drizzt Do'Urden color overrides for coherence with terminal theme
        on_colors = function(colors)
          colors.bg = "#100814"        -- Deep drow cavern background
          colors.bg_dark = "#0f1119"   -- Guenhwyvar black
          colors.bg_highlight = "#2a2d45"
          colors.fg = "#e0dfe8"        -- Foreground text
          colors.fg_dark = "#8b8c99"
          colors.blue = "#7ec8e3"      -- Icy blue from Twinkle
          colors.cyan = "#7ec8e3"      -- Icy blue
          colors.magenta = "#b19cd9"   -- Lavender eyes
          colors.purple = "#b19cd9"    -- Lavender
          colors.green = "#5ab897"     -- Drow magic
          colors.yellow = "#f0c987"    -- Magical glow
          colors.red = "#d35d6e"       -- Battle red
          colors.orange = "#ffd89b"
        end,
        on_highlights = function(hl, c)
          -- StatusLine coherence with tmux
          hl.StatusLine = { bg = c.bg, fg = c.fg }
          hl.StatusLineNC = { bg = c.bg, fg = c.fg_dark }
        end,
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- Lualine Statusline (customized for Drizzt Do'Urden theme coherence)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Custom Drizzt Do'Urden theme for lualine (matches tmux powerline)
      local drizzt_theme = {
        normal = {
          a = { fg = "#100814", bg = "#b19cd9", gui = "bold" },  -- Lavender (like tmux session)
          b = { fg = "#e0dfe8", bg = "#2a2d45" },
          c = { fg = "#8b8c99", bg = "#100814" },
        },
        insert = {
          a = { fg = "#100814", bg = "#5ab897", gui = "bold" },  -- Drow green
          b = { fg = "#e0dfe8", bg = "#2a2d45" },
        },
        visual = {
          a = { fg = "#100814", bg = "#7ec8e3", gui = "bold" },  -- Icy blue
          b = { fg = "#e0dfe8", bg = "#2a2d45" },
        },
        replace = {
          a = { fg = "#100814", bg = "#d35d6e", gui = "bold" },  -- Battle red
          b = { fg = "#e0dfe8", bg = "#2a2d45" },
        },
        command = {
          a = { fg = "#100814", bg = "#f0c987", gui = "bold" },  -- Magical yellow
          b = { fg = "#e0dfe8", bg = "#2a2d45" },
        },
        inactive = {
          a = { fg = "#8b8c99", bg = "#100814" },
          b = { fg = "#8b8c99", bg = "#100814" },
          c = { fg = "#8b8c99", bg = "#100814" },
        },
      }

      require("lualine").setup({
        options = {
          theme = drizzt_theme,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },  -- Powerline style
          disabled_filetypes = {
            statusline = { "NvimTree" },
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = { "nvim-tree", "quickfix" },
      })
    end,
  },

  -- Web DevIcons (optional but recommended)
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        default = true,
      })
    end,
  },
}
