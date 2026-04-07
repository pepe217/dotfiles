--@brief
---
--- https://github.com/elixir-lang/expert
---
--- Expert is the official language server implementation for the Elixir programming language.
---
--- 'root_dir' is chosen like this: if two or more directories containing `mix.exs` were found when
--- searching directories upward, the second one (higher up) is chosen, with the assumption that it
--- is the root of an umbrella app. Otherwise the directory containing the single mix.exs that was
--- found is chosen.

---@type vim.lsp.Config
return {
  filetypes = { 'elixir', 'eelixir', 'heex', 'surface' },
  cmd = { 'expert', '--stdio' },
  root_markers = { 'mix.exs', '.git' },
}
