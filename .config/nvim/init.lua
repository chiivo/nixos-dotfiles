--Packer
require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'NvChad/nvim-colorizer.lua'
	use 'feline-nvim/feline.nvim'
	use 'nvim-tree/nvim-web-devicons'
	use 'lukas-reineke/indent-blankline.nvim'
	use 'windwp/nvim-autopairs'
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-tree/nvim-tree.lua'
	use 'nvim-treesitter/playground'
	use 'akinsho/nvim-bufferline.lua'
	use 'nvimdev/dashboard-nvim'
	use 'Pocco81/true-zen.nvim'
	use 'elkowar/yuck.vim'
	use 'rktjmp/lush.nvim'
	use '~/.config/nvim/colors/bliss'
	use 'Manas140/run.nvim'
	use 'nvim-treesitter/nvim-treesitter'
	use 'folke/twilight.nvim'
	use 'folke/which-key.nvim'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	use 'rafamadriz/friendly-snippets'
	use 'nvim-neorg/neorg'
	use 'nvim-orgmode/orgmode'
	use 'jbyuki/nabla.nvim'
	use 'dhruvasagar/vim-table-mode'
	use 'numToStr/Comment.nvim'
	use 'rcarriga/nvim-notify'
end)

-- Colors
local colors = {
	-- darkblack = '#141515',
	darkblack = '#191a1a',
	black = '#262727',
	red = '#ff8278',
	orange = '#ffc178',
	yellow = '#eadc84',
	green = '#bde077',
	blue = '#77bee0',
	magenta = '#dd91f3',
	pink = '#f5d1c8',
	gray = '#555657',
	white = '#dddddd'
}

-- Startup
vim.cmd([[
colorscheme bliss
let g:mapleader="\<Space>"
set clipboard=unnamedplus
set completeopt=menu,menuone,noselect
set cursorline
set tabstop=2
set shiftwidth=2
set guicursor=
set ignorecase
set mouse=a
set mousemodel=extend
set nocompatible
set nohlsearch
set number
set scrolloff=999
set smartcase
set termguicolors
syntax on
set laststatus=3
set linebreak
]])

-- Run
require('run').setup()

-- Colorizer
require 'colorizer'.setup {
	filetypes = {
		'*',
	}
}

-- Dashboard
local db = require('dashboard')
db.setup {
	theme = 'hyper',
	config = {
		week_header = { enable = true },
		project = { enable = false },
		shortcut = {
			{
				desc = ' Update',
				group = '@property',
				action = 'execute "PackerUpdate" | TSUpdate all',
				key = 'u'
			},
      {
				desc = ' Files',
        group = 'Label',
        action = 'Telescope find_files',
        key = 'f',
      },
      {
				desc = ' Apps',
        group = 'DiagnosticHint',
        action = 'Telescope app',
        key = 'a',
      },
      {
        desc = ' Dotfiles',
        group = 'Number',
        action = 'Telescope dotfiles',
        key = 'd',
      },
      {
        desc = ' Quit',
        group = '@property',
        action = 'q',
        key = 'q',
      }
    }
  }
}
vim.cmd([[
highlight DashboardHeader guifg = '#f5d1c8'
highlight DashboardFooter guifg = '#dd91f3'
highlight DashboardProjectTitle guifg = '#77bee0'
highlight DashboardProjectTitleIcon guifg = '#77bee0'
highlight DashboardProjectIcon guifg = '#77bee0'
highlight DashboardMruTitle guifg = '#bde077'
highlight DashboardMruIcon guifg = '#bde077'
highlight DashboardFiles guifg = '#555657'
]])

-- Bufferline
require('bufferline').setup {
	highlights = {
		fill = {
			bg = colors.darkblack
		},
		separator_selected = {
			fg = colors.darkblack,
			bg = colors.black
		},
		separator_visible = {
			fg = colors.darkblack,
			bg = colors.black
		},
		separator = {
			fg = colors.darkblack,
			bg = colors.black
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

-- NvimTree
vim.cmd([[
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
	disable_netrw = false,
	hijack_cursor = true,
	hijack_netrw = true,
	hijack_unnamed_buffer_when_opening = false,
	open_on_tab = false,
	sort_by = "name",
	update_cwd = false,
	reload_on_bufenter = false,
	respect_buf_cwd = true,
	view = {
		width = 30,
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
	system_open = {
		cmd = nil,
		args = {},
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

-- Nvim-AutoPairs
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

-- Indent-BlankLine
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

-- Twilight
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
	exclude = { "dashboard", "norg", "org" },
}
vim.cmd([[autocmd VimEnter * Twilight]])

-- True-Zen
require("true-zen").setup({
	modes = {
		ataraxis = {
			shade = "dark", -- if `dark` then dim the padding windows, otherwise if it's `light` it'll brighten said windows
			backdrop = 0, -- percentage by which padding windows should be dimmed/brightened. Must be a number between 0 and 1. Set to 0 to keep the same background color
			minimum_writing_area = { -- minimum size of main window
				width = 70,
				height = 44,
			},
			quit_untoggles = true, -- type :q or :qa to quit Ataraxis mode
			padding = { -- padding windows
				left = 52,
				right = 52,
				top = 0,
				bottom = 0,
			},
			open_callback = nil, -- run a function when opening Ataraxis mode
			close_callback = nil, -- run a function when closing Ataraxis mode
		},
		minimalist = {
			ignored_buf_types = { "nofile" }, -- save current options from any window except ones displaying these kinds of buffers
			options = { -- options to be disabled when entering Minimalist mode
				number = false,
				relativenumber = false,
				showtabline = 0,
				signcolumn = "no",
				statusline = "",
				cmdheight = 1,
				laststatus = 0,
				showcmd = false,
				showmode = false,
				ruler = false,
				numberwidth = 1
			},
			open_callback = nil, -- run a function when opening Minimalist mode
			close_callback = nil, -- run a function when closing Minimalist mode
		},
		narrow = {
			--- change the style of the fold lines. Set it to:
			--- `informative`: to get nice pre-baked folds
			--- `invisible`: hide them
			--- function() end: pass a custom func with your fold lines. See :h foldtext
			folds_style = "informative",
			run_ataraxis = true, -- display narrowed text in a Ataraxis session
			open_callback = nil, -- run a function when opening Narrow mode
			close_callback = nil, -- run a function when closing Narrow mode
		},
		focus = {
			open_callback = nil, -- run a function when opening Focus mode
			close_callback = nil, -- run a function when closing Focus mode
		}
	},
	focus = {
		open_callback = nil, -- run a function when opening Focus mode
		close_callback = nil, -- run a function when closing Focus mode
	},
	integrations = {
		tmux = false, -- hide tmux status bar in (minimalist, ataraxis)
		kitty = { -- increment font size in Kitty. Note: you must set `allow_remote_control socket-only` and `listen_on unix:/tmp/kitty` in your personal config (ataraxis)
			enabled = false,
			font = "+3"
		},
		twilight = false -- enable twilight (ataraxis)
	}
})

-- Feline
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

-- Treesitter
require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all"
	ensure_installed = {'bash', 'c', 'css', 'latex', 'lua', 'nix', 'norg', 'org', 'rust', 'scss', 'toml', 'vim'},
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,
	-- List of parsers to ignore installing (for "all")
	ignore_install = {},
	indent = {
		enable = true
	},
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
		additional_vim_regex_highlighting = {'norg'}, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
	},
	--Treesitter Playground
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
		}
	}
}

-- Neorg
require('neorg').setup {
	load = {
		["core.defaults"] = {},
		["core.concealer"] = {
			config = {
				icon_preset = 'varied'
			}
		},
		["core.export.markdown"] = {},
		["core.qol.toc"] = {},
		["core.journal"] = {},
		["core.manoeuvre"] = {},
		["core.presenter"] = {
			config = {
				zen_mode = 'truezen'
			}
		},
		["core.completion"] = {
			config = {
				engine = 'nvim-cmp'
			}
		},
		["core.export"] = {},
		["core.integrations.nvim-cmp"] = {},
	}
}

-- Orgmode
-- Load custom treesitter grammar for org filetype
require('orgmode').setup_ts_grammar()
-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop,
  -- highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    -- Required for spellcheck, some LaTex highlights and
    -- code block highlights that do not have ts grammar
    additional_vim_regex_highlighting = {'org'},
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}
require('orgmode').setup({
  org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
  org_default_notes_file = '~/Dropbox/org/refile.org',
})
-- Which-Key
local wk = require("which-key")
wk.setup{
	key_labels = {
		["<space>"] = "SPC",
		["<leader>"] = "LDR"
	},
  popup_mappings = {
    scroll_down = 'j', -- binding to scroll down inside the popup
    scroll_up = 'k', -- binding to scroll up inside the popup
  },
	window = {
		border = "single", -- none, single, double, shadow
		margin = { 0, 0, 0, 0 }
	},
	layout = {
		align = "center"
	}
}
wk.register({
	["<leader>"] = {"<cmd>source $MYVIMRC<cr>", "Source Nvim Config"},
	t = {
		name = "NvimTree",
		n = {"<cmd>NvimTreeToggle<cr>", "Toggle NvimTree"},
		r = {"<cmd>NvimTreeRefresh<cr>", "Refresh NvimTree"}
	},
	b = {
		name = "Bufferline",
		-- These commands will navigate through buffers in order regardless of which mode you are using
		["]"] = {"<cmd>BufferLineCycleNext<cr>", "Next Buffer"},
		["["] = {"<cmd>BufferLineCyclePrev<cr>", "Previous Buffer"},
		-- These commands will move the current buffer backwards or forwards in the bufferline
		[">"] = {"<cmd>BufferLineMoveNext<cr>", "Move Buffer Up"},
		["<"] = {"<cmd>BufferLineMovePrev<cr>", "Mover Buffer Down"},
		-- These commands will sort buffers by directory, language, or a custom criteria
		e = {"<cmd>BufferLineSortByExtension<cr>", "Sort Buffers By Extension"},
		d = {"<cmd>BufferLineSortByDirectory<cr>", "Sort Buffers By Directory"},
		a = {"<cmd>lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<cr>", "Sort Buffer By Alphabet"}
	},
	p = {"<cmd>lua require('nabla').popup({border = 'rounded'})<cr>", "Nabla Popup"},
	e = {"<cmd>Run<cr>", "Run Script"}
}, {prefix = "<leader>"})

-- LuaSnip
require("luasnip.loaders.from_vscode").lazy_load()

-- Nvim-Cmp
local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "*",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}
local cmp = require'cmp'
cmp.setup{
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		['<C-k>'] = cmp.mapping.select_prev_item(),
		['<C-j>'] = cmp.mapping.select_next_item(),
		['<C-b>'] = cmp.mapping.scroll_docs(-1),
		['<C-f>'] = cmp.mapping.scroll_docs(1),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	},
	formatting = {
		fields = { "kind", "abbr" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			vim_item.menu = ({
				luasnip = "(Snippet)",
				buffer = "(Buffer)",
				path = "(Path)",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = 'luasnip' }, -- For luasnip users.
		{ name = 'buffer' },
		{ name = 'path' },
		{ name = 'norg' },
		{ name = 'org' },
	},
	window = {
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
		},
		completion = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
		}
	}
}
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'cmdline' }
  })
})
vim.cmd ([[
highlight! CmpItemKindSnippet guifg=#bde077
highlight! CmpItemKindText guifg=#77bee0
highlight! CmpItemKindFolder guifg=#77bee0
highlight! CmpItemKindFile guifg=#dd91f3
]])

-- Comment
require('Comment').setup()

-- Nvim-Notify
require("notify").setup({
	background_colour = '#262727',
	fps = 144,
	render = "simple",
	stages = "fade"
})
