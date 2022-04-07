" Vim-Plug
call plug#begin()
Plug 'NvChad/nvim-colorizer.lua'
Plug 'feline-nvim/feline.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'luochen1990/rainbow'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'junegunn/limelight.vim'
Plug 'windwp/nvim-autopairs'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'glepnir/dashboard-nvim'
Plug 'Pocco81/TrueZen.nvim'
Plug 'elkowar/yuck.vim'
Plug 'rktjmp/lush.nvim'
Plug '~/.config/nvim/colors/bliss'
Plug 'Manas140/run.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-orgmode/orgmode'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
call plug#end()

" Colors
let darkblack='#141515'
let black='#262727'
let red='#ff8278'
let green='#bde077'
let yellow='#eadc84'
let blue='#77bee0'
let magenta='#dd91f3'
let cyan='#ffc178'
let pink='#f5d1c8'
let gray='#555657'
let white='#dddddd'

" Startup
colorscheme bliss
let g:mapleader="\<Space>"
set clipboard=unnamedplus
set completeopt=menu,menuone,noselect
set autoindent
set smartindent
set cursorline
set tabstop=2
set shiftwidth=2
set guicursor=
set ignorecase
set mouse=a
set nocompatible
set nohlsearch
set number
set scrolloff=999
set smartcase
set termguicolors
syntax on
nnoremap <silent> <Leader><Leader> :source $MYVIMRC<cr>

" Colorizer
lua << EOF
require'colorizer'.setup({
	'*',
})
EOF

" Dashboard
let g:dashboard_default_executive ='telescope'
let g:dashboard_custom_shortcut={
\ 'last_session'       : 'SPC s l',
\ 'find_history'       : 'SPC f h',
\ 'find_file'          : 'SPC f f',
\ 'new_file'           : 'SPC c n',
\ 'change_colorscheme' : 'SPC t c',
\ 'find_word'          : 'SPC f a',
\ 'book_marks'         : 'SPC f b',
\ }
let g:dashboard_default_executive ='telescope'
nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
nnoremap <silent> <Leader>cn :DashboardNewFile<CR>
let g:dashboard_custom_header = [
\ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
\ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
\ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
\ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
\ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
\ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
\]

" Bufferline
lua << EOF
require('bufferline').setup {
	highlights = {
		fill = {
			guibg = '#141515'
		},
		separator_selected = {
			guifg = '#141515',
			guibg = '#262727'
		},
		separator_visible = {
			guifg = '#141515',
			guibg = '#262727'
		},
		separator = {
			guifg = '#141515',
			guibg = '#262727'
		},
	},
	options = {
		mode = "buffers", -- "buffers" | "tabs" 
		numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
		--- @deprecated, please specify numbers as a function to customize the styling
		-- number_style = "superscript", -- "superscript" | "subscript" | "" | { "none", "subscript" }, -- buffer_id at index 1, ordinal at index 2
		close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
		middle_mouse_command = nil,	-- can be a string | function, see "Mouse actions"
		-- NOTE: this plugin is designed with this icon in mind,
		-- and so changing this is NOT recommended, this is intended
		-- as an escape hatch for people who cannot bear it for whatever reason
		indicator_icon = '▎',
		buffer_close_icon = '',
		modified_icon = '●',
		close_icon = '',
		left_trunc_marker = '',
		right_trunc_marker = '',
		--- name_formatter can be used to change the buffer's label in the bufferline.
		--- Please note some names can/will break the
		--- bufferline so use this at your discretion knowing that it has
		--- some limitations that will *NOT* be fixed.
		name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
			-- remove extension from markdown files for example
			if buf.name:match('%.md') then
				return vim.fn.fnamemodify(buf.name, ':t:r')
			end
		end,
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		tab_size = 18,
		diagnostics = false, -- false | "nvim_lsp" | "coc",
		diagnostics_update_in_insert = false,
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			return "("..count..")"
		end,
		-- NOTE: this will be called a lot so don't do any heavy processing here
		custom_filter = function(buf_number, buf_numbers)
			-- filter out filetypes you don't want to see
			if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
				return true
			end
			-- filter out by buffer name
			if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
				return true
			end
			-- filter out based on arbitrary rules
			-- e.g. filter out vim wiki buffer from tabline in your work repo
			if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
				return true
			end
			-- filter out by it's index number in list (don't show first buffer)
			if buf_numbers[1] ~= buf_number then
				return true
			end
		end,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer", -- text | function,
				text_align = "center" -- "left" | "center" | "right"
			}
		},
		show_buffer_icons = true, -- true | false, -- disable filetype icons for buffers
		show_buffer_close_icons = true, --true | false,
		show_close_icon = true, -- true | false,
		show_tab_indicators = true, -- true | false,
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		-- can also be a table containing 2 custom separators
		-- [focused and unfocused]. eg: { '|', '|' }
		separator_style = "padded_slant", -- "slant" | "padded_slant" | "thick" | "thin" | { 'any', 'any' },
		enforce_regular_tabs = false, -- false | true,
		always_show_bufferline = true, -- true | false,
		sort_by = 'id' -- 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
			-- add custom logic
			--return buffer_a.modified > buffer_b.modified
		--end
	}
}
EOF
" These commands will navigate through buffers in order regardless of which mode you are using
" e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
nnoremap <silent>b] :BufferLineCycleNext<CR>
nnoremap <silent>b[ :BufferLineCyclePrev<CR>
" These commands will move the current buffer backwards or forwards in the bufferline
nnoremap <silent>b> :BufferLineMoveNext<CR>
nnoremap <silent>b< :BufferLineMovePrev<CR>
" These commands will sort buffers by directory, language, or a custom criteria
nnoremap <silent>be :BufferLineSortByExtension<CR>
nnoremap <silent>bd :BufferLineSortByDirectory<CR>
nnoremap <silent><mymap> :lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>

" NvimTree
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
let g:nvim_tree_respect_buf_cwd = 1 "0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
let g:nvim_tree_create_in_closed_folder = 1 "0 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
	\ 'git': 1,
	\ 'folders': 1,
	\ 'files': 1,
	\ 'folder_arrows': 1,
	\ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set indent_markers (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
	\ 'default': '',
	\ 'symlink': '',
	\ 'git': {
	\   'unstaged': "✗",
	\   'staged': "✓",
	\   'unmerged': "",
	\   'renamed': "➜",
	\   'untracked': "★",
	\   'deleted': "",
	\   'ignored': "◌"
	\   },
	\ 'folder': {
	\   'arrow_open': "",
	\   'arrow_closed': "",
	\   'default': "",
	\   'open': "",
	\   'empty': "",
	\   'empty_open': "",
	\   'symlink': "",
	\   'symlink_open': "",
	\   }
	\ }

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" NvimTreeOpen, NvimTreeClose, NvimTreeFocus, NvimTreeFindFileToggle, and NvimTreeResize are also available if you need them

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeSymlink guifg='#eadc84'
highlight NvimTreeRootFolder guifg='#ff8278'
highlight NvimTreeFolderIcon guifg='#77bee0'
highlight NvimTreeFolderName guifg='#77bee0'
highlight NvimTreeEmptyFolderName guifg='#555657'
highlight NvimTreeOpenedFolderName guifg='#77bee0'
highlight NvimTreeExecFile guifg='#bde077'
highlight NvimTreeOpenedFile guifg='#dddddd'
highlight NvimTreeSpecialFile guifg='#ffc178'
highlight NvimTreeImageFile guifg='#dd91f3'
highlight NvimTreeIndentMarker guifg='#f5d1c8'

lua << EOF
require'nvim-tree'.setup {
	auto_reload_on_write = true,
	disable_netrw = false,
	hide_root_folder = false,
	hijack_cursor = false,
	hijack_netrw = true,
	hijack_unnamed_buffer_when_opening = false,
	ignore_buffer_on_setup = false,
	open_on_setup = false,
	open_on_tab = false,
	sort_by = "name",
	update_cwd = false,
	view = {
		width = 30,
		height = 30,
		side = 'left',
		preserve_window_proportions = false,
		number = false,
		relativenumber = false,
		signcolumn = "yes",
		mappings = {
			custom_only = false,
			list = {},
		},
	},
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
  update_focused_file = {
		enable = true,
		update_cwd  = false,
		ignore_list = {},
	},
	ignore_ft_on_setup = {},
	system_open = {
		cmd = nil,
		args = {},
	},
	diagnostics = {
		enable = false,
		show_on_dirs = false,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		}
	},
	filters = {
		dotfiles = false,
		custom = {},
		exclude = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 400,
	},
	actions = {
		change_dir = {
			enable = true,
			global = false,
		},
		open_file = {
			quit_on_open = true,
			resize_window = false,
			window_picker = {
				enable = true,
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", },
					buftype  = { "nofile", "terminal", "help", }
				}
			}
		}
	},
	trash = {
		cmd = "trash",
		require_confirm = true
	},
	log = {
		enable = false,
		truncate = false,
		types = {
			all = false,
			config = false,
			copy_paste = false,
			git = false,
			profile = false
		}
	}
}
EOF

" Nvim-AutoPairs
lua require('nvim-autopairs').setup{}

" IndentBlankLine
let g:indent_blankline_use_treesitter=v:true
let g:indent_blankline_space_char="."
let g:indent_blankline_space_char_blankline=" "
let g:indentLine_char="│"
let g:indent_blankline_char_highlight_list = ['Constant', 'Special', 'Statement', 'Type', 'Identifier', 'PreProc']
let g:indentLine_fileTypeExclude = ['dashboard']

" Rainbow
let g:rainbow_active=1
let g:rainbow_conf={
\	'guifgs': [red, cyan, yellow, green, blue, magenta],
\	'operators': '_,_',
\	'parentheses': ['start=/</ end=/>/ fold'],
\}

" Limelight
autocmd VimEnter * Limelight
let g:limelight_conceal_guifg=gray " Inactive Paragraph Limelight Color

" TrueZen
lua << EOF
local true_zen = require("true-zen")
true_zen.setup({
	integrations = {
		feline = true,
	},
})
EOF

" Orgmode
lua << EOF
-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()
-- Tree-sitter configuration
require'nvim-treesitter.configs'.setup {
	-- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
	highlight = {
		enable = true,
		disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
		additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
	},
	ensure_installed = {'org'}, -- Or run :TSUpdate org
}
require('orgmode').setup({
	org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
	org_default_notes_file = '~/Dropbox/org/refile.org',
})
require'cmp'.setup({
  sources = {
    { name = 'orgmode' }
  }
})
EOF

" Nvim Cmp
lua << EOF
	-- Setup nvim-cmp.
	local cmp = require'cmp'

	cmp.setup({
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
				-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
				-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			end,
		},
		mapping = {
			['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
			['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
			['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
			['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
			['<C-e>'] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		},
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

	-- Set configuration for specific filetype.
	cmp.setup.filetype('gitcommit', {
		sources = cmp.config.sources({
			{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
		}, {
			{ name = 'buffer' },
		})
	})

	-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline('/', {
		sources = {
			{ name = 'buffer' }
		}
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
		sources = cmp.config.sources({
			{ name = 'path' }
		}, {
			{ name = 'cmdline' }
		})
	})

--  -- Setup lspconfig.
--  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--  require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--    capabilities = capabilities
--  }
EOF

"Source
lua << EOF
local colors = {
	darkblack = '#141515',
	black = '#262727',
	red = '#ff8278',
	green = '#bde077',
	yellow = '#eadc84',
	blue = '#77bee0',
	magenta = '#dd91f3',
	orange = '#ffc178',
	pink = '#f5d1c8',
	gray = '#555657',
	white = '#dddddd'
}

local vi_mode_colors = {
	NORMAL = colors.pink,
	INSERT = colors.green,
	VISUAL = colors.magenta,
	OP = colors.green,
	BLOCK = colors.magenta,
	REPLACE = colors.magenta,
	['V-REPLACE'] = colors.magenta,
	ENTER = colors.orange,
	MORE = colors.orange,
	SELECT = colors.orange,
	COMMAND = colors.green,
	SHELL = colors.green,
	TERM = colors.green,
	NONE = colors.yellow
}

local function file_osinfo()
	local os = vim.bo.fileformat:upper()
	local icon
	if os == 'UNIX' then
		icon = ' '
	elseif os == 'MAC' then
		icon = ' '
	else
		icon = ' '
	end
	return icon .. os
end

local vi_mode_utils = require 'feline.providers.vi_mode'

local comps = {
	cap = {
		left = {
			provider = "",
			right_sep = {
				str = " ",
				hl = {bg = colors.black}
			},
			hl = {
				fg = colors.blue,
				bg = colors.black
			}
		},
		right = {
			provider = "",
			left_sep = {
				str = " ",
				hl = {bg = colors.black}
			},
			hl = {
				fg = colors.blue,
				bg = colors.black
			}
		}
	},
	vi_mode = {
		left = {
			provider = function()
				return ''-- .. vi_mode_utils.get_vim_mode()
			end,
			hl = function()
				local val = {
					name = vi_mode_utils.get_mode_highlight_name(),
					fg = vi_mode_utils.get_mode_color(),
					bg = colors.black
				}
				return val
			end,
			right_sep = {
				str = " ",
				hl = {bg = colors.black}
			}
		}
	},
	file = {
		info = {
			provider = {
				name = 'file_info',
				opts = {
					type = 'relative',
					file_readonly_icon = '  ',
					file_modified_icon = ''
				}
			},
			hl = {
				fg = colors.magenta,
				bg = colors.black,
				style = 'bold'
			}
		},
		os = {
			provider = file_osinfo,
			left_sep = {
				str = " ",
				hl = {bg = colors.black}
			},
			hl = {
				fg = colors.magenta,
				bg = colors.black,
				style = 'bold'
			}
		},
		position = {
			provider = 'position',
			left_sep = {
				str = " ",
				hl = {bg = colors.black}
			},
			hl = {
				fg = colors.orange,
				bg = colors.black
				-- style = 'bold'
			}
		}
	},
	inactive = {
		hl = {
			bg = colors.black
		}
	}
}

local components = {
	active = {},
	inactive = {}
}

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

table.insert(components.active[1], comps.cap.left)
table.insert(components.active[1], comps.vi_mode.left)
table.insert(components.active[2], comps.file.info)
table.insert(components.active[3], comps.file.os)
table.insert(components.active[3], comps.file.position)
table.insert(components.active[3], comps.cap.right)

table.insert(components.inactive[1], comps.inactive)

require('feline').setup(
{
	colors = colors,
	force_inactive = {
		filetypes = {
			'dashboard',
			'packer',
			'NvimTree',
			'fugitive',
			'fugitiveblame'
		},
		buftypes = {'terminal'},
		bufnames = {}
	},
	components = components,
	vi_mode_colors = vi_mode_colors
})
EOF
