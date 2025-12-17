-- Plugins Initialization
-- Lazy.nvim plugin manager setup

return {
  -- Import all plugin configurations
  { import = "plugins.ui" },
  { import = "plugins.editor" },
  { import = "plugins.lsp" },
  { import = "plugins.formatter" },
}
