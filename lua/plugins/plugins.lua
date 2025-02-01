
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Sevim.cmd.colorscheme("deepwhite")
--tup lazy.nvim
require("lazy").setup({
  {
      "Verf/deepwhite.nvim",
      config = function()
	vim.cmd.colorscheme("deepwhite")
 
      end,
      --opts = {
      --	vim.cmd.colorscheme("deepwhite")
      --}
      -- add your plugins here
  },
  {
      "hrsh7th/nvim-cmp",
	dependencies = {
        {'L3MON4D3/LuaSnip'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'saadparwaiz1/cmp_luasnip'},
	},
opts = {
    sources = {
  { name = "nvim_lsp" },
  { name = "path" },
  { name = "luasnip" },
  {
      name = 'buffer',
      option = {
          get_bufnrs = function()
              return vim.api.nvim_list_bufs()
          end
      }
  }    
  }
  }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
	require("nvim-treesitter.configs").setup({
	    ensure_installed = { "c", "lua", "c_sharp", "vim", "vimdoc", "query", "javascript", "typescript"},
	    auto_install = true,                                                           
	    highlight = {
		enable = true
	    },
	    incremental_selection = {
	           enable = true,
	           keymaps = {
	           init_selection = "<Leader>ss", -- set to `false` to disable one of the mappings
	           node_incremental = "<Leader>si",
	           scope_incremental = "<Leader>sc",
	           node_decremental = "<Leader>sd",
		},                               
	    },
	    textobjects = {
		select = {
                    enable = true,
                    
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    
                    keymaps = {
                      -- You can use the capture groups defined in textobjects.scm
                      ["af"] = "@function.outer",
                      ["if"] = "@function.inner",
                      ["ac"] = "@class.outer",
                      -- You can optionally set descriptions to the mappings (used in the desc parameter of
                      -- nvim_buf_set_keymap) which plugins like which-key display
                      ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                      -- You can also use captures from other query groups like `locals.scm`
                      ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                    },
                    -- You can choose the select mode (default is charwise 'v')
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * method: eg 'v' or 'o'
                    -- and should return the mode ('v', 'V', or '<c-v>') or a table
                    -- mapping query_strings to modes.
                    selection_modes = {
                      ['@parameter.outer'] = 'v', -- charwise
                      ['@function.outer'] = 'V', -- linewise
                      ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    -- If you set this to `true` (default is `false`) then any textobject is
                    -- extended to include preceding or succeeding whitespace. Succeeding
                    -- whitespace has priority in order to act similarly to eg the built-in
                    -- `ap`.
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * selection_mode: eg 'v'
                    -- and should return true or false
                    include_surrounding_whitespace = true,
		},
	    },
	})
    end,
  },
  {
      "nvim-treesitter/nvim-treesitter-textobjects",
  },
  {
      "nvim-tree/nvim-tree.lua",
  },
  {
	"nvim-tree/nvim-web-devicons"
  },
{
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
}
})
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.lsp.start({
	    name = 'tslsp',
	    cmd = {'typescript-language-server', '--stdio'},
	    root_dir = vim.fs.dirname(vim.fs.find({'tsconfig.json', 'package.json'}, { upward = true })[1]),
	})
	vim.keymap.set("n", "<leader>r", function ()
	    vim.lsp.buf.rename()
	end)
	vim.keymap.set("n", "<leader>f", function ()
            vim.lsp.buf.definition()
	end)

	vim.keymap.set("n", "<leader>g", function ()
            vim.lsp.buf.definition()
	end)
end,})
require("oil").setup()
