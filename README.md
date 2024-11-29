# config.nvim

A repo for my neovim configuration.

## Installation:

```bash
mv ~/.config/nvim/ ~/.config/nvim.bak
git clone https://github.com/lcroberts/config.nvim ~/.config/nvim

# Windows

Move-Item $HOME\AppData\Local\nvim $HOME\AppData\Local\nvim.bak
git clone https://github.com/lcroberts/config.nvim $HOME\AppData\Local\nvim
```

## Removal

```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim

# Windows

rd -Recurse -Force ~\AppData\Local\nvim
rd -Recurse -Force ~\AppData\Local\nvim-data
```
