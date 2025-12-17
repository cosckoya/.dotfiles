-- Formatter Configuration: conform.nvim (replaces vim-prettier)
-- No Node/Yarn dependencies from user perspective

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>F",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    config = function()
      require("conform").setup({
        -- Map of filetype to formatters
        formatters_by_ft = {
          -- Bash/Shell formatters (no Node required)
          sh = { "shfmt" },
          bash = { "shfmt" },

          -- Lua formatter
          lua = { "stylua" },

          -- Markdown
          markdown = { "prettier" },

          -- JSON, YAML (optional)
          json = { "prettier" },
          yaml = { "prettier" },

          -- Use LSP fallback for other filetypes (includes Python and Go)
          ["*"] = { "lsp_format" },
        },

        -- Format on save configuration (disabled by default, enable per filetype if needed)
        format_on_save = nil,

        -- Format after save (for async)
        format_after_save = nil,

        -- Logging level
        log_level = vim.log.levels.ERROR,

        -- Notify on error
        notify_on_error = true,

        -- Custom formatters configuration
        formatters = {
          shfmt = {
            prepend_args = { "-i", "2" }, -- 2 space indent for shell scripts
          },
        },
      })

      -- Command to manually format
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_fallback = true, range = range })
      end, { range = true })
    end,
  },
}
