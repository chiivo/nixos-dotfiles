--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is lua file, vim will append your file to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

local lush = require('lush')
local hsl = lush.hsl

-- local darkblack = '#141515'
local darkblack = '#191a1a'
local black = '#262727'
local gray = '#555657'
local red = '#ff8278'
local green = '#bde077'
local yellow = '#eadc84'
local magenta = '#dd91f3'
local blue = '#77bee0'
local orange = '#ffc178'
local white = '#dddddd'
local pink = '#f5d1c8'

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function()
  return {
		-- The following are all the Neovim default highlight groups from the docs
		-- as of 0.5.0-nightly-446, to aid your theme creation. Your themes should
		-- probably style all of these at a bare minimum.
		--
		-- Referenced/linked groups must come before being referenced/lined,
		-- so the order shown ((mostly) alphabetical) is likely
		-- not the order you will end up with.
		--
		-- You can uncomment these and leave them empty to disable any
		-- styling for that group (meaning they mostly get styled as Normal)
		-- or leave them commented to apply vims default colouring or linking.
		
		Comment      {fg = gray, gui = 'italic'}, -- any comment
		-- ColorColumn  { }, -- used for the columns set with 'colorcolumn'
		Conceal      {fg = black}, -- placeholder characters substituted for concealed text (see 'conceallevel')
		-- Cursor       { }, -- character under the cursor
		-- lCursor      { }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
		-- CursorIM     { }, -- like Cursor, but used when in IME mode |CursorIM|
		-- CursorColumn { }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
		CursorLine   {}, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
		-- Directory    { }, -- directory names (and other special names in listings)
		-- DiffAdd      { }, -- diff mode: Added line |diff.txt|
		-- DiffChange   { }, -- diff mode: Changed line |diff.txt|
		-- DiffDelete   { }, -- diff mode: Deleted line |diff.txt|
		-- DiffText     { }, -- diff mode: Changed text within a changed line |diff.txt|
		EndOfBuffer  {fg = gray}, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
		-- TermCursor   { }, -- cursor in a focused terminal
		-- TermCursorNC { }, -- cursor in an unfocused terminal
		ErrorMsg     {bg = red, fg = white}, -- error messages on the command line
		VertSplit    {fg = gray}, -- the column separating vertically split windows
		Folded       {fg = gray}, -- line used for closed folds
		-- FoldColumn   { }, -- 'foldcolumn'
		-- SignColumn   { }, -- column where |signs| are displayed
		IncSearch    {fg = pink, bg = gray}, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
		Substitute   {fg = black, bg = yellow}, -- |:substitute| replacement text highlighting
		LineNr       {fg = gray}, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
		CursorLineNr {fg = pink, gui = 'bold'}, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
		MatchParen   {fg = black, bg = pink}, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
		ModeMsg      {fg = white}, -- 'showmode' message (e.g., "-- INSERT -- ")
		MsgArea      {fg = pink}, -- Area for messages and cmdline
		-- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
		-- MoreMsg      { }, -- |more-prompt|
		NonText      {fg = blue}, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
		-- Normal       { }, -- normal text
		-- NormalFloat  { }, -- Normal text in floating windows.
		-- NormalNC     { }, -- normal text in non-current windows
		Pmenu        {fg = pink}, -- Popup menu: normal item.
		PmenuSel     {fg = black, bg = pink}, -- Popup menu: selected item.
		PmenuSbar    {bg = gray}, -- Popup menu: scrollbar.
		PmenuThumb   {bg = white}, -- Popup menu: Thumb of the scrollbar.
		-- Question     { }, -- |hit-enter| prompt and yes/no questions
		QuickFixLine {bg = yellow}, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
		Search       {fg = black, bg = yellow, gui = 'bold'}, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
		SpecialKey   {fg = orange}, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
		-- SpellBad     { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise. 
		-- SpellCap     { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
		-- SpellLocal   { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
		-- SpellRare    { }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
		StatusLine   {bg = black}, -- status line of current window
		-- StatusLineNC { }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
		-- TabLine      { }, -- tab pages line, not active tab page label
		-- TabLineFill  { }, -- tab pages line, where there are no labels
		-- TabLineSel   { }, -- tab pages line, active tab page label
		Title        {fg = magenta}, -- titles for output from ":set all", ":autocmd" etc.
		Visual       {fg = white, bg = gray}, -- Visual mode selection
		-- VisualNOS    { }, -- Visual mode selection when vim is "Not Owning the Selection".
		WarningMsg   {fg = red}, -- warning messages
		-- Whitespace   { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
		-- WildMenu     { }, -- current match in 'wildmenu' completion
		
		-- These groups are not listed as default vim groups,
		-- but they are defacto standard group names for syntax highlighting.
		-- commented out groups should chain up to their "preferred" group by
		-- default,
		-- Uncomment and edit if you want more specific syntax highlighting.
		
		Constant       {fg = red}, -- (preferred) any constant
		-- String         {fg = red}, -- a string constant: "this is a string"
		-- Character      {fg = red}, -- a character constant: 'c', '\n'
		-- Number         {fg = red}, -- a number constant: 234, 0xff
		-- Boolean        {fg = red}, -- a boolean constant: TRUE, false
		-- Float          {fg = red}, -- a floating point constant: 2.3e10
		
		Identifier     {fg = blue}, -- (preferred) any variable name
		-- Function       {fg = blue}, -- function name (also: methods for classes)
		
		Statement      {fg = yellow}, -- (preferred) any statement
		-- Conditional    {fg = yellow}, -- if, then, else, endif, switch, etc.
		-- Repeat         {fg = yellow}, -- for, do, while, etc.
		-- Label          {fg = yellow}, -- case, default, etc.
		-- Operator       {fg = yellow}, -- "sizeof", "+", "*", etc.
		-- Keyword        {fg = yellow}, -- any other keyword
		-- Exception      {fg = yellow}, -- try, catch, throw
		
		PreProc        {fg = magenta}, -- (preferred) generic Preprocessor
		-- Include        {fg = magenta}, -- preprocessor #include
		-- Define         {fg = magenta}, -- preprocessor #define
		-- Macro          {fg = magenta}, -- same as Define
		-- PreCondit      {fg = magenta}, -- preprocessor #if, #else, #endif, etc.
		
		Type           {fg = green}, -- (preferred) int, long, char, etc.
		-- StorageClass   {fg = green}, -- static, register, volatile, etc.
		-- Structure      {fg = green}, -- struct, union, enum, etc.
		-- Typedef        {fg = green}, -- A typedef
		
		Special        {fg = orange}, -- (preferred) any special symbol
		-- SpecialChar    {fg = orange}, -- special character in a constant
		-- Tag            {fg = orange}, -- you can use CTRL-] on this
		-- Delimiter      {fg = orange}, -- character that needs attention
		-- SpecialComment {fg = orange}, -- special things inside a comment
		-- Debug          {fg = orange}, -- debugging statements
		
		Underlined  {fg = blue, gui = "underline"}, -- (preferred) text that stands out, HTML links
		Bold        {gui = "bold"},
		Italic      {gui = "italic"},
		
		-- ("Ignore", below, may be invisible...)
		-- Ignore         { }, -- (preferred) left blank, hidden  |hl-Ignore|
		
		Error       {fg = white, bg = red}, -- (preferred) any erroneous construct
		
		Todo        {fg = blue, bg = yellow}, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
		
		-- These groups are for the native LSP client. Some other LSP clients may
		-- use these groups, or use their own. Consult your LSP client's
		-- documentation.
		
		-- LspReferenceText                     { }, -- used for highlighting "text" references
		-- LspReferenceRead                     { }, -- used for highlighting "read" references
		-- LspReferenceWrite                    { }, -- used for highlighting "write" references
		
		-- LspDiagnosticsDefaultError           { }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
		-- LspDiagnosticsDefaultWarning         { }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
		-- LspDiagnosticsDefaultInformation     { }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
		-- LspDiagnosticsDefaultHint            { }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
		
		-- LspDiagnosticsVirtualTextError       { }, -- Used for "Error" diagnostic virtual text
		-- LspDiagnosticsVirtualTextWarning     { }, -- Used for "Warning" diagnostic virtual text
		-- LspDiagnosticsVirtualTextInformation { }, -- Used for "Information" diagnostic virtual text
		-- LspDiagnosticsVirtualTextHint        { }, -- Used for "Hint" diagnostic virtual text
		
		-- LspDiagnosticsUnderlineError         { }, -- Used to underline "Error" diagnostics
		-- LspDiagnosticsUnderlineWarning       { }, -- Used to underline "Warning" diagnostics
		-- LspDiagnosticsUnderlineInformation   { }, -- Used to underline "Information" diagnostics
		-- LspDiagnosticsUnderlineHint          { }, -- Used to underline "Hint" diagnostics
		
		-- LspDiagnosticsFloatingError          { }, -- Used to color "Error" diagnostic messages in diagnostics float
		-- LspDiagnosticsFloatingWarning        { }, -- Used to color "Warning" diagnostic messages in diagnostics float
		-- LspDiagnosticsFloatingInformation    { }, -- Used to color "Information" diagnostic messages in diagnostics float
		-- LspDiagnosticsFloatingHint           { }, -- Used to color "Hint" diagnostic messages in diagnostics float
		
		-- LspDiagnosticsSignError              { }, -- Used for "Error" signs in sign column
		-- LspDiagnosticsSignWarning            { }, -- Used for "Warning" signs in sign column
		-- LspDiagnosticsSignInformation        { }, -- Used for "Information" signs in sign column
		-- LspDiagnosticsSignHint               { }, -- Used for "Hint" signs in sign column
		
		-- LspCodeLens                          { }, -- Used to color the virtual text of the codelens
		
		-- These groups are for the neovim tree-sitter highlights.
		-- As of writing, tree-sitter support is a WIP, group names may change.
		-- By default, most of these groups link to an appropriate Vim group,
		-- TSError -> Error for example, so you do not have to define these unless
		-- you explicitly want to support Treesitter's improved syntax awareness.
		
		-- TSAnnotation         { };    -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
		-- TSAttribute          { };    -- (unstable) TODO: docs
		-- TSBoolean            { };    -- For booleans.
		-- TSCharacter          { };    -- For characters.
		-- TSComment            { };    -- For comment blocks.
		-- TSConstructor        { };    -- For constructor calls and definitions: ` { }` in Lua, and Java constructors.
		-- TSConditional        { };    -- For keywords related to conditionnals.
		-- TSConstant           { };    -- For constants
		-- TSConstBuiltin       { };    -- For constant that are built in the language: `nil` in Lua.
		-- TSConstMacro         { };    -- For constants that are defined by macros: `NULL` in C.
		-- TSError              { };    -- For syntax/parser errors.
		-- TSException          { };    -- For exception related keywords.
		-- TSField              { };    -- For fields.
		-- TSFloat              { };    -- For floats.
		-- TSFunction           { };    -- For function (calls and definitions).
		-- TSFuncBuiltin        { };    -- For builtin functions: `table.insert` in Lua.
		-- TSFuncMacro          { };    -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
		-- TSInclude            { };    -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
		-- TSKeyword            { };    -- For keywords that don't fall in previous categories.
		-- TSKeywordFunction    { };    -- For keywords used to define a fuction.
		-- TSLabel              { };    -- For labels: `label:` in C and `:label:` in Lua.
		-- TSMethod             { };    -- For method calls and definitions.
		-- TSNamespace          { };    -- For identifiers referring to modules and namespaces.
		-- TSNone               { };    -- TODO: docs
		-- TSNumber             { };    -- For all numbers
		-- TSOperator           { };    -- For any operator: `+`, but also `->` and `*` in C.
		-- TSParameter          { };    -- For parameters of a function.
		-- TSParameterReference { };    -- For references to parameters of a function.
		-- TSProperty           { };    -- Same as `TSField`.
		-- TSPunctDelimiter     { };    -- For delimiters ie: `.`
		-- TSPunctBracket       { };    -- For brackets and parens.
		-- TSPunctSpecial       { };    -- For special punctutation that does not fall in the catagories before.
		-- TSRepeat             { };    -- For keywords related to loops.
		-- TSString             { };    -- For strings.
		-- TSStringRegex        { };    -- For regexes.
		-- TSStringEscape       { };    -- For escape characters within a string.
		-- TSSymbol             { };    -- For identifiers referring to symbols or atoms.
		-- TSType               { };    -- For types.
		-- TSTypeBuiltin        { };    -- For builtin types.
		-- TSVariable           { };    -- Any variable name that does not have another highlight.
		-- TSVariableBuiltin    { };    -- Variable names that are defined by the languages, like `this` or `self`.
		
		-- TSTag                { };    -- Tags like html tag names.
		-- TSTagDelimiter       { };    -- Tag delimiter like `<` `>` `/`
		-- TSText               { };    -- For strings considered text in a markup language.
		-- TSEmphasis           { };    -- For text to be represented with emphasis.
		-- TSUnderline          { };    -- For text to be represented with an underline.
		-- TSStrike             { };    -- For strikethrough text.
		-- TSTitle              { };    -- Text that is part of a title.
		-- TSLiteral            { };    -- Literal text.
		-- TSURI                { };    -- Any URI like a link or email.

	}
end)

-- return our parsed theme for extension or use else where.
return theme

-- vi:nowrap
