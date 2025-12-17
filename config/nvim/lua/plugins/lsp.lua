-- LSP Configuration: Neovim 0.11+ Native API
-- Simplified - only Mason for installation

return {
  -- Mason: LSP installer
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      -- Install LSP servers automatically
      local mason_registry = require("mason-registry")
      local servers = { "lua-language-server", "pyright", "bash-language-server" }

      for _, server in ipairs(servers) do
        if not mason_registry.is_installed(server) then
          vim.cmd("MasonInstall " .. server)
        end
      end

      -- Configure LSP after Mason is ready
      vim.defer_fn(function()
        -- Diagnostic configuration
        vim.diagnostic.config({
          virtual_text = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = "✘",
              [vim.diagnostic.severity.WARN] = "▲",
              [vim.diagnostic.severity.HINT] = "⚑",
              [vim.diagnostic.severity.INFO] = "»",
            },
          },
          update_in_insert = false,
          underline = true,
          severity_sort = true,
          float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = true,
          },
        })

        -- LSP handlers
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
          border = "rounded",
        })

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
          vim.lsp.handlers.signature_help,
          { border = "rounded" }
        )

        -- Capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if has_cmp then
          capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
        end

        -- on_attach function
        local on_attach = function(client, bufnr)
          local opts = { buffer = bufnr, noremap = true, silent = true }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        end

        local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

        -- Configure LSP servers using native API
        vim.lsp.config("lua_ls", {
          cmd = { mason_bin .. "/lua-language-server" },
          root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", ".git" },
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        })

        vim.lsp.config("pyright", {
          cmd = { mason_bin .. "/pyright-langserver", "--stdio" },
          root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
          capabilities = capabilities,
          on_attach = on_attach,
        })

        vim.lsp.config("bashls", {
          cmd = { mason_bin .. "/bash-language-server", "start" },
          root_markers = { ".git" },
          capabilities = capabilities,
          on_attach = on_attach,
          filetypes = { "sh", "bash" },
        })

        -- Auto-enable LSP servers by filetype
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "lua",
          callback = function() vim.lsp.enable("lua_ls") end,
        })

        vim.api.nvim_create_autocmd("FileType", {
          pattern = "python",
          callback = function() vim.lsp.enable("pyright") end,
        })

        vim.api.nvim_create_autocmd("FileType", {
          pattern = { "sh", "bash" },
          callback = function() vim.lsp.enable("bashls") end,
        })
      end, 100)
    end,
  },
}
