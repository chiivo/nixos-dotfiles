--Vim-Plug
vim.cmd([[
call plug#begin()
Plug 'NvChad/nvim-colorizer.lua'
Plug 'feline-nvim/feline.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-treesitter/playground'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'glepnir/dashboard-nvim'
Plug 'Pocco81/TrueZen.nvim'
Plug 'elkowar/yuck.vim'
Plug 'rktjmp/lush.nvim'
Plug '~/.config/nvim/colors/bliss'
Plug 'Manas140/run.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'folke/twilight.nvim'
Plug 'nvim-orgmode/orgmode'
call plug#end()
]])

--Colors
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

--Startup
vim.cmd([[
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
set laststatus=3
nnoremap <silent> <Leader><Leader> :source $MYVIMRC<cr>
]])

--Colorizer
require'colorizer'.setup({
	'*',
})

--Dashboard
local home = os.getenv('HOME')
local db = require('dashboard')
db.custom_header = {
	'',
	'',
	'',
	'',
	' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
	' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
	' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
	' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
	' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
	' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
	'',
	'',
	'',
	'',
}
db.custom_center = {
	{
		icon = '  ',
		desc = 'New File					',
		action ='enew',
		shortcut = ':enew'
	},
	{
		icon = '  ',
		desc = 'Find  File					',
		action = 'Telescope find_files hidden=true no_ignore=true',
		shortcut = 'SPC f'
	},
	{
		icon = '  ',
		desc = 'Open Dotfiles					',
		action = 'Telescope find_files cwd=~/.config',
		shortcut = 'SPC f d'
	},
	{
		icon = '  ',
		desc = 'Update Plugins					',
		action = 'PlugUpdate',
		shortcut = ':PlugUpdate'
	}
}
vim.cmd([[
highlight DashboardHeader guifg = '#f5d1c8'
highlight DashboardCenter guifg = '#77bee0'
highlight DashboardShortcut guifg = '#ff8278'
highlight DashboardFooter guifg = '#dd91f3'
]])

--Bufferline
require('bufferline').setup {
	highlights = {
		fill = {
			guibg = colors.darkblack
		},
		separator_selected = {
			guifg = colors.darkblack,
			guibg = colors.black
		},
		separator_visible = {
			guifg = colors.darkblack,
			guibg = colors.black
		},
		separator = {
			guifg = colors.darkblack,
			guibg = colors.black
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
		buffer_close_icon = '',
		modified_icon = '',
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
		separator_style = "thin", -- "slant" | "padded_slant" | "thick" | "thin" | { 'any', 'any' },
		enforce_regular_tabs = false, -- false | true,
		always_show_bufferline = true, -- true | false,
		sort_by = 'id' -- 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
			-- add custom logic
			--return buffer_a.modified > buffer_b.modified
		--end
	}
}

vim.cmd([[
"These commands will navigate through buffers in order regardless of which mode you are using
"e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
nnoremap <silent>b] :BufferLineCycleNext<CR>
nnoremap <silent>b[ :BufferLineCyclePrev<CR>
" These commands will move the current buffer backwards or forwards in the bufferline
nnoremap <silent>b> :BufferLineMoveNext<CR>
nnoremap <silent>b< :BufferLineMovePrev<CR>
" These commands will sort buffers by directory, language, or a custom criteria
nnoremap <silent>be :BufferLineSortByExtension<CR>
nnoremap <silent>bd :BufferLineSortByDirectory<CR>
nnoremap <silent><mymap> :lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>
]])

--NvimTree
vim.cmd([[
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
"NvimTreeOpen, NvimTreeClose, NvimTreeFocus, NvimTreeFindFileToggle, and NvimTreeResize are also available if you need them

"a list of groups can be found at `:help nvim_tree_highlight`
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
]])

require'nvim-tree'.setup {
	auto_reload_on_write = true,
	create_in_closed_folder = true;
	disable_netrw = false,
	hijack_cursor = true,
	hijack_netrw = true,
	hijack_unnamed_buffer_when_opening = false,
	ignore_buffer_on_setup = false,
	open_on_setup = false,
	open_on_setup_file = false,
	open_on_tab = false,
	sort_by = "name",
	update_cwd = false,
	reload_on_bufenter = false,
	respect_buf_cwd = true,
	view = {
		width = 30,
		height = 30,
		hide_root_folder = false,
		side = 'left',
		preserve_window_proportions = true,
		number = false,
		relativenumber = false,
		signcolumn = "yes",
		mappings = {
			custom_only = false,
			list = {},
		},
	},
  renderer = {
		add_trailing = false,
		group_empty = false,
		highlight_git = false,
		highlight_opened_files = "none",
		root_folder_modifier = ":~",
		indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
		icons = {
			webdev_colors = true,
			git_placement = "before",
			padding = " ",
			symlink_arrow = " >> ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				default = '',
				symlink = '',
				folder = {
					arrow_open = "",
					arrow_closed = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
			  },
				git = {
					unstaged = "",
					staged = "",
					unmerged = "",
					renamed = "",
					untracked = "",
					deleted = "",
					ignored = ""
				},
  		},
		},
		special_files = { 'README.md', 'Makefile', 'MAKEFILE' },
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

--Nvim-AutoPairs
require('nvim-autopairs').setup{
	enable_check_bracket_line = false,
	fast_wrap = {
		map = '<A-e>',
		chars = { '{', '[', '(', '"', "'" },
		pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
		end_key = '$',
		keys = 'qwertyuiopasdfghjklzxcvbnm',
		check_comma = true,
		highlight = 'Search',
		highlight_grey='Comment'
	}
}

--Indent-BlankLine
vim.cmd ([[
highlight IndentBlanklineIndent1 guifg='#ff8278' gui=nocombine
highlight IndentBlanklineIndent2 guifg='#ffc178' gui=nocombine
highlight IndentBlanklineIndent3 guifg='#eadc84' gui=nocombine
highlight IndentBlanklineIndent4 guifg='#bde077' gui=nocombine
highlight IndentBlanklineIndent5 guifg='#77bee0' gui=nocombine
highlight IndentBlanklineIndent6 guifg='#dd91f3' gui=nocombine
]])
require("indent_blankline").setup {
	space_char_blankline = " ",
	char_highlight_list = {
		"IndentBlanklineIndent1",
		"IndentBlanklineIndent2",
		"IndentBlanklineIndent3",
		"IndentBlanklineIndent4",
		"IndentBlanklineIndent5",
		"IndentBlanklineIndent6",
	},
	filetype_exclude = {'dashboard'}
}

--Twilight
require("twilight").setup {
	dimming = {
		alpha = 1,
		color = { "Comment" },
		inactive = false
	},
	context = 0,
	treesitter = false,
	expand = {
		"function",
		"method",
		"method_definition",
		"table",
		"if_statement",
		"let_statement",
		"lua_statement",
		"call_statement",
	},
	exclude = { "dashboard" },
}
vim.cmd([[autocmd VimEnter * Twilight]])

--TrueZen
require("true-zen").setup({
	ui = {
		bottom = {
			laststatus = 0,
			ruler = false,
			showmode = false,
			showcmd = false,
			cmdheight = 1,
		},
		top = {
			showtabline = 0,
		},
		left = {
			number = false,
			relativenumber = false,
			signcolumn = "no",
		},
	},
	modes = {
		ataraxis = {
			left_padding = 0,
			right_padding = 0,
			top_padding = 0,
			bottom_padding = 0,
			ideal_writing_area_width = {0},
			auto_padding = true,
			keep_default_fold_fillchars = true,
			custom_bg = {"none", ""},
			bg_configuration = true,
			quit = "untoggle",
			ignore_floating_windows = true,
			affected_higroups = {
				NonText = true,
				FoldColumn = true,
				ColorColumn = true,
				VertSplit = true,
				StatusLine = true,
				StatusLineNC = true,
				SignColumn = true,
			},
		},
		focus = {
			margin_of_error = 5,
			focus_method = "experimental"
		},
	},
	integrations = {
		vim_gitgutter = false,
		galaxyline = false,
		tmux = false,
		gitsigns = false,
		nvim_bufferline = false,
		limelight = false,
		twilight = false,
		vim_airline = false,
		vim_powerline = false,
		vim_signify = false,
		express_line = false,
		lualine = false,
		lightline = false,
		feline = false
	},
	misc = {
		on_off_commands = false,
		ui_elements_commands = false,
		cursor_by_mode = false,
	}
})

--Feline
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
				return ''-- .. vi_mode_utils.get_vim_mode()
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
					file_readonly_icon = '  ',
					file_modified_icon = ''
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
table.insert(components.active[3], comps.file.position)
table.insert(components.active[3], comps.file.os)
table.insert(components.active[3], comps.cap.right)

table.insert(components.inactive[1], comps.inactive)

require('feline').setup({
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

--Treesitter
require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all"
	ensure_installed = {},
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,
	-- List of parsers to ignore installing (for "all")
	ignore_install = {},
	highlight = {
	  -- `false` will disable the whole extension
	  enable = true,
	  -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
	  -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
	  -- the name of the parser)
	  -- list of language that will be disabled
	  disable = {},
	  -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
	  -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
	  -- Using this option may slow down your editor, and you may see some duplicate highlights.
	  -- Instead of true it can also be a list of languages
	  additional_vim_regex_highlighting = false,
	},
}

--Treesitter Playground
require "nvim-treesitter.configs".setup {
	playground = {
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
	}
}

--OrgMode
-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()
-- Tree-sitter configuration
require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = {'org'}, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
	},
	ensure_installed = {'org'}, -- Or run :TSUpdate org
}
require('orgmode').setup({
	org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
	org_default_notes_file = '~/Dropbox/org/refile.org',
})
