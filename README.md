# nvim-minimal-packer
Minimal Neovim config with packer (for reproducing plugin behaviour)

* Add plugin and configs to the config.
* Start with:
```bash
# bash or zsh
NVIM_DATA_MINIMAL=$(mktemp -d) nvim -u <path-to-imit-lua>
```
```fish
# fish
NVIM_DATA_MINIMAL=(mktemp -d) nvim -u <path-to-imit-lua>
```
This will bootstrap a packer installation into the temp directory.

* Then exit out of Neovim and start again with `nvim -u <path-to-init-lua>`
