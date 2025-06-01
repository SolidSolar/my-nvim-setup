
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


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

-- Sevim.cmd.cclorscheme("deepwhite")
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
	"neovim/nvim-lspconfig"
  },
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
	config = 
	{
		capabilities = capabilities,
	},
        -- your configuration comes here; leave empty for default settings
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "apyra/nvim-unity-sync",
    config = function()
      require("unity.plugin").setup({
        -- Configs here (Optional) 
        })
    end,
    ft = "cs",
  }
})
require("mason").setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
})

vim.lsp.config("roslyn", {
    on_attach = function()
        print("This will run when the server attaches!")
    end,
    settings = {
        ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
        },
        ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
        },
		["background_analysis"] ={
			dotnet_analyzer_diagnostics_scope = "fullSolution",
			dotnet_compiler_diagnostics_scope = "fullSolution",
		}
    },
	opts={
		filewatching = "roslyn"
	}
})

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        --vim.lsp.start({
        --    name = 'tslsp',
        --    cmd = {'typescript-language-server', '--stdio'},
        --    root_dir = vim.fs.dirname(vim.fs.find({'tsconfig.json', 'package.json'}, { upward = true })[1]),
        --})
	vim.keymap.set("n", "<leader>r", function ()
	    vim.lsp.buf.rename()
	end)
	vim.keymap.set("n", "<leader>d", function ()
            vim.lsp.buf.definition()
	end)

end,})
