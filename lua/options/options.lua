           
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.number = true
vim.opt.signcolumn = "yes"		
vim.diagnostic.config { update_in_insert = true }  

vim.opt.splitbelow = true
vim.opt.splitright = true
					
vim.g.editorconfig = false
vim.expandtab =true 
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4


vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 999
--mein comment

vim.opt.virtualedit = "insert,block"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true

-- setup lazy.nvim

vim.opt.termguicolors = true
vim.o.timeoutlen = 1000

--clear space and set leader
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "


-- remaps
--vim.keymap.set("n", "<leader>q", "<CMD>Oil --float<CR>", {desc = "Open parent directory"})
vim.keymap.set("n", "<leader>q", "<Esc>", {remap = false})
vim.keymap.set("n", "<leader><Left>", "<C-o>", {remap = true})
vim.keymap.set("n", "<leader><Right>", "<C-i>", {remap = true})
vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action, { noremap = true, silent = true, buffer = bufnr })

local cmp = require'cmp'

cmp.setup({
snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space-z>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
})

--local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  --require('lspconfig')['tslsp'].setup {
    --capabilities = capabilities
  --}

-- disable netrw at the very start of your init.lua



-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})


local api = require "nvim-tree.api"
vim.keymap.set('n', '<leader>t', api.tree.toggle)

