# Neovim config

Minimalistic nvim config.
It uses Neovim's built-in `vim.pack` package manager, so there is no separate
plugin manager to bootstrap.

## Requirements

- Neovim 0.12 or newer
- Git
- [ripgrep](https://github.com/BurntSushi/ripgrep) for Telescope live grep
- A current Node.js release for Intelephense and Blade Formatter
- PHP and Composer when working on PHP projects

On macOS, the base tools can be installed with Homebrew:

```sh
brew install neovim git ripgrep lua-language-server stylua node php composer
```

Install the PHP language server and Blade formatter with npm:

```sh
npm install --global intelephense @shufo/blade-formatter
```

## Installation

Back up an existing configuration first, then clone this repository:

```sh
mv ~/.config/nvim ~/.config/nvim.backup
git clone https://github.com/sybsadev/.nvim.git ~/.config/nvim
nvim
```

Plugins are downloaded during the first startup. Restart Neovim after the
installation finishes, then run `:checkhealth` if something is missing.

Tree-sitter parsers can be installed from Neovim:

```vim
:TSInstall lua php blade html css javascript
```

To update the plugins later:

```vim
:lua vim.pack.update()
```

## PHP and Laravel projects

Intelephense is used as the general PHP language server. `laravel-ls` is
optional and is enabled automatically when its executable is available in
`PATH`.

It can be installed with Go:

```sh
go install github.com/laravel-ls/laravel-ls/cmd/laravel-ls@latest
```

The formatter and static analyser are expected to be installed in each
project:

```sh
composer require --dev laravel/pint larastan/larastan
```

Larastan also needs a `phpstan.neon` or `phpstan.neon.dist` file in the project
root. Open Neovim from that root so the language servers can index the whole
project:

```sh
cd path/to/project
nvim .
```

PHP and Blade files are formatted on save. PHPStan runs after saving a PHP
file when `vendor/bin/phpstan` exists.

## Key mappings

The leader key is `Space`. Pressing it and waiting briefly opens the which-key
menu.

| Mapping | Action |
| --- | --- |
| `-` | Open the parent directory in Oil |
| `<leader>ff` | Find files |
| `<leader>fg` | Search text with ripgrep |
| `<leader>fb` | List open buffers |
| `<leader>fs` | Find symbols in the current file |
| `<leader>ft` | Find TODO comments |
| `gd` | Go to definition |
| `grr` | Find references |
| `gri` | Go to implementation |
| `grt` | Go to type definition |
| `]d` / `[d` | Next / previous diagnostic |
| `<leader>e` | Show the diagnostic under the cursor |
| `<leader>xx` | Show project diagnostics |
| `<leader>xb` | Show diagnostics for the current buffer |
| `<leader>fo` | Format the current buffer |
| `<leader>ll` | Run PHPStan |
| `<leader>ss` / `<leader>sv` | Open a horizontal / vertical split |
| `<C-h/j/k/l>` | Move between windows |

### Multiple cursors ( below and above might not work as expected )

| Mapping | Action |
| --- | --- |
| `<leader>mj` / `<leader>mk` | Add a cursor below / above |
| `<leader>mn` | Add the next matching word or selection |
| `<leader>ms` | Skip the next match |
| `<leader>ma` | Add cursors to all matches |
| `<leader>m/` | Add the next result from `/` search |
| `<leader>m*` | Add all results from `/` search |
| `<Esc>` | Clear additional cursors |

Once the cursors are in place, normal Vim commands such as `ciw`, `I`, `A`,
and `d` work on all of them.
