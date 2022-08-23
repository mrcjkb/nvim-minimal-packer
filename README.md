# nvim-minimal-packer
Minimal NeoVim config with packer (for reproducing plugin behaviour)

* Assumes an empty temp directory `/tmp/nvim-minimal`
* Add plugin and configs to the config.
* Start with `nvim -u <path-to-imit-lua>`. This will bootstrap a packer installation into the temp directory.
* Then exit out of neovim and start again with `nvim -u <path-to-init-lua>`
