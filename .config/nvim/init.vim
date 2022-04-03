" Vim-Plug
call plug#begin()
Plug 'norcalli/nvim-colorizer.lua'
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'kyazdani42/nvim-web-devicons'
Plug 'luochen1990/rainbow'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'junegunn/limelight.vim'
Plug 'jiangmiao/auto-pairs'
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
lua require'colorizer'.setup()

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
    },
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
          buftype  = { "nofile", "terminal", "help", },
        },
      },
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      git = false,
      profile = false,
    },
  },
}
EOF

" Auto-Pairs
let g:AutoPairs={'(':')', '[':']', '{':'}', "'":"'", '"':'"', '`':'`', '/*':'*/', '<':'>'}

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
		galaxyline = true,
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
EOF

"Source
source ~/.local/share/nvim/plugged/galaxyline.nvim/example/blissline.lua
