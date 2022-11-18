-- Minimal nvim config with packer
-- Assumes a directory in $NVIM_DATA_MINIMAL
-- Start with nvim -u <path-to-this-config>
-- Then exit out of neovim and start again.


-- Ignore default config
local fn = vim.fn
local config_path = fn.stdpath('config') 
vim.opt.runtimepath:remove(config_path)

-- Ignore default plugins
local data_path = fn.stdpath('data')
local pack_path = data_path .. '/site'
vim.opt.packpath:remove(pack_path)

-- append temporary config and pack dir
local test_dir = os.getenv('NVIM_DATA_MINIMAL')
if not data_path then
  error('$NVIM_DATA_MINIMAL environment variable not set!')
end
vim.opt.runtimepath:append(test_dir)
vim.opt.packpath:append(test_dir)

-- bootstrap packer
local packer_install_path = test_dir .. '/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
  vim.cmd('!git clone git@github.com:wbthomason/packer.nvim ' .. packer_install_path)
  vim.cmd('packadd packer.nvim')
  install_plugins = true
else
  vim.cmd('packadd packer.nvim')
end

local packer = require('packer') 

packer.init({
  package_root = test_dir .. '/pack',
  compile_path = test_dir .. '/plugin/packer_compiled.lua'
})

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'marko-cerovac/material.nvim',
    branch = 'main',
    setup = function()
      vim.g.material_style = 'darker'
      vim.g.material_terminal_italics = 1
    end,
    config = function()
      require('material').setup {}
    end,
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    requires = { 
      'nvim-treesitter/playground'
    },
    config = function()
      vim.schedule(function()
        local ts_configs = require'nvim-treesitter.configs'
        ts_configs.setup {
          playground = { -- Toggle with :TSPlaygroundToggle
            ensure_installed = {'haskell'},
            auto_install = true, -- Automatically install missing parsers when entering buffer
            highlight = {
              enable = true
            },
            enable = true,
            disable = {},
            updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = false, -- Whether the query persists across vim sessions
            keybindings = {
              toggle_query_editor = 'o',
              toggle_hl_groups = 'i',
              toggle_injected_languages = 't',
              toggle_anonymous_nodes = 'a',
              toggle_language_display = 'I',
              focus_language = 'f',
              unfocus_language = 'F',
              update = 'R',
              goto_node = '<cr>',
              show_help = '?',
            },
          },
          query_linter = {
            enable = true,
            use_virtual_text = true,
            lint_events = {'BufWrite', 'CursorHold'},
          },
        }
      end)
    end,
  }

  if install_plugins then
    packer.sync()
  end
end)

