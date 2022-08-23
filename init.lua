-- Minimal nvim config with packer
-- Assumes an empty directory '/tmp/nvim-minimal'
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
local test_dir = '/tmp/nvim-minimal'
vim.opt.runtimepath:append(test_dir)
vim.opt.packpath:append(test_dir)

-- bootstrap packer
local install_path = test_dir .. '/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd('packadd packer.nvim')
  install_plugins = true
end

local packer = require('packer') 

packer.init({
  package_root = test_dir .. '/pack',
  compile_path = test_dir .. '/plugin/packer_compiled.lua'
})

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  if install_plugins then
    packer.sync()
  end
end)

