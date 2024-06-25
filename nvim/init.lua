-- Vim options
vim.opt.backspace = '2'
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.relativenumber = true

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('t', '<ESC>', '<C-\\><C-n>', {noremap = true, desc = "Terminal escape"})

-- Bootstrap plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- Neovide settings
if vim.g.neovide then
    vim.g.neovide_cursor_animation_length = 0.02
end

-- Condition to add to plugins so they're not installed in vscode neovim
local no_vscode = function()
	return not vim.g.vscode
end


-- Configure plguins
require("lazy").setup({
    -- Basic Settings and themes
	{
		'nvim-treesitter/nvim-treesitter',
		build = ":TSUpdate",
		cond = no_vscode,
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "python" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		'RRethy/base16-nvim',
		cond = no_vscode,
		config = function()
			require('base16-colorscheme').with_config({
				telescope = true,
				indentblankline = true,
				notify = true,
				ts_rainbow = true,
				cmp = true,
				illuminate = true,
				dapui = true,
			})
			vim.cmd [[colorscheme base16-eighties]]
        end,
    },
    {
        'windwp/nvim-autopairs', -- Close pairs
        event = "InsertEnter",
        config = true
    },
    {
        'hrsh7th/nvim-cmp', -- Tab completion
        cond = no_vscode,
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'hrsh7th/nvim-cmp' }, },
        config = function()
            -- Set up nvim-cmp.
            local cmp = require 'cmp'
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
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'vsnip' }, -- For vsnip users.
                    -- { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                }, {
                    { name = 'buffer' },
                })
            })

            -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
            -- Set configuration for specific filetype.
            --[[ cmp.setup.filetype('gitcommit', {
                    sources = cmp.config.sources({
                    { name = 'git' },
                    }, {
                    { name = 'buffer' },
                    })
                })
                require("cmp_git").setup() ]] --

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })

            -- Set up lspconfig.
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
            require('lspconfig')['pyright'].setup {
                capabilities = capabilities
            }
            require('lspconfig')['lua_ls'].setup {
                capabilities = capabilities
            }
            require('lspconfig')['rust_analyzer'].setup {
                capabilities = capabilities
            }
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            require'lualine'.setup()
        end

    },
    {
        'nvim-telescope/telescope.nvim', -- Fuzy completion
        dependencies = { 'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make'
            } },
        config = function()
            -- You dont need to set any of these options. These are the default ones. Only
            -- the loading is important
            require('telescope').setup {
                extensions = {
                    fzf = {
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    }
                }
            }
            require("telescope").load_extension("fzf")
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Grep search" })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Search buffers" })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Search help" })
            vim.keymap.set('n', '<leader>hf', builtin.help_tags, { desc = "Search help" })
            vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = "Search registers" })
            vim.keymap.set('i', '<CTRL>', builtin.registers, { desc = "Search registers" })
        end

    },
    {
        'akinsho/toggleterm.nvim', -- Terminal toggling
        version = "*",
        cond = no_vscode,
        config = function()
            require "toggleterm".setup {}
            vim.keymap.set('n', '<leader>t', '<Cmd>ToggleTerm<CR>', { desc = "Togle term" })
        end
    },
    {
        "folke/which-key.nvim", -- Keybinding help
        cond = no_vscode,
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = function()
            local wk = require("which-key")
            wk.setup(
                vim.keymap.set('n', '<leader>hk', '<Cmd>WhichKey<CR>', { desc = "Key help" })
            )
            wk.register {
                ["<leader>f"] = {
                    name = "Find"
                }
            }
            wk.register {
                ["<leader>h"] = {
                    name = "Help"
                }
            }
            wk.register {
                ["<leader>v"] = { name = "Venv" }
            }
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    -- LSP Configuration
    { "neovim/nvim-lspconfig",      cond = no_vscode }, -- LSP configurations
    {
        "williamboman/mason-lspconfig.nvim",
        cond = no_vscode,
        config = function()
            require "mason-lspconfig".setup {
                ensure_installed = { "lua_ls", "rust_analyzer", "pyright" },
            }
            require "mason-lspconfig".setup_handlers {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {}
                end,
            }
        end
    },
    {
        "williamboman/mason.nvim", -- Install LSP servers easily
        cond = no_vscode,
        config = function()
            require "mason".setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end
    },
    { "mfussenegger/nvim-dap",      cond = no_vscode },              -- Dubug adapter
    { "rcarriga/nvim-dap-ui",       cond = no_vscode },              -- Debug adapter UI
    { "mfussenegger/nvim-lint",     cond = no_vscode },              -- Linting support LSP
    { "mhartington/formatter.nvim", cond = no_vscode },              -- Formatting support for LSP
})
