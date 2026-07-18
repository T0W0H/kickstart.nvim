-- -- Linting
--
-- vim.pack.add { 'https://github.com/mfussenegger/nvim-lint' }
--
-- local lint = require 'lint'
-- lint.linters_by_ft = {
--   markdown = { 'markdownlint' }, -- Make sure to install `markdownlint` via mason / npm
-- }
--
-- -- To allow other plugins to add linters to require('lint').linters_by_ft,
-- -- instead set linters_by_ft like this:
-- -- lint.linters_by_ft = lint.linters_by_ft or {}
-- -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
-- --
-- -- However, note that this will enable a set of default linters,
-- -- which will cause errors unless these tools are available:
-- -- {
-- --   clojure = { "clj-kondo" },
-- --   dockerfile = { "hadolint" },
-- --   inko = { "inko" },
-- --   janet = { "janet" },
-- --   json = { "jsonlint" },
-- --   markdown = { "vale" },
-- --   rst = { "vale" },
-- --   ruby = { "ruby" },
-- --   terraform = { "tflint" },
-- --   text = { "vale" }
-- -- }
-- --
-- -- You can disable the default linters by setting their filetypes to nil:
-- -- lint.linters_by_ft['clojure'] = nil
-- -- lint.linters_by_ft['dockerfile'] = nil
-- -- lint.linters_by_ft['inko'] = nil
-- -- lint.linters_by_ft['janet'] = nil
-- -- lint.linters_by_ft['json'] = nil
-- -- lint.linters_by_ft['markdown'] = nil
-- -- lint.linters_by_ft['rst'] = nil
-- -- lint.linters_by_ft['ruby'] = nil
-- -- lint.linters_by_ft['terraform'] = nil
-- -- lint.linters_by_ft['text'] = nil
--
-- -- Create autocommand which carries out the actual linting
-- -- on the specified events.
-- local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
-- vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
--   group = lint_augroup,
--   callback = function()
--     -- Only run the linter in buffers that you can modify in order to
--     -- avoid superfluous noise, notably within the handy LSP pop-ups that
--     -- describe the hovered symbol using Markdown.
--     if vim.bo.modifiable then lint.try_lint() end
--   end,
-- })
--

-- Linting
vim.pack.add { 'https://github.com/mfussenegger/nvim-lint' }

local lint = require 'lint'

-- 覆盖默认 linter 映射
lint.linters_by_ft = {
  cpp = { 'cpplint' },
  python = { 'flake8' },
  json = { 'jsonlint' },
  markdown = { 'markdownlint' },
}

-- 降低各 linter 严格度
lint.linters.cpplint = {
  args = { '--filter=-build/header_guard,-whitespace/line_length,-whitespace/braces', '--quiet' },
}
lint.linters.flake8 = {
  args = { '--ignore=E501,W503,E302', '--max-line-length=120' },
}
lint.linters.markdownlint = {
  args = { '--disable', 'MD013', 'MD033', 'MD024' },
}

-- 自动触发 lint
local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    if vim.bo.modifiable then lint.try_lint() end
  end,
})
