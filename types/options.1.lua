---@meta

--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- boolean	(default off)
-- 			global
-- 	When on, ":autocmd", shell and write commands are not allowed in
-- 	".nvimrc" and ".exrc" in the current directory and map commands are
-- 	displayed.  Switch it off only if you know that you will not run into
-- 	problems, or when the 'exrc' option is off.  On Unix this option is
-- 	only used if the ".nvimrc" or ".exrc" is not owned by you.  This can be
-- 	dangerous if the systems allows users to do a "chown".  You better set
-- 	'secure' at the end of your |init.vim| then.
-- 	This option cannot be set from a |modeline| or in the |sandbox|, for
-- 	security reasons.
vim.o.secure = "false"
-- number	(default 1000)
-- 			global
-- 	Maximum number of times a mapping is done without resulting in a
-- 	character to be used.  This normally catches endless mappings, like
-- 	":map x y" with ":map y x".  It still does not catch ":map g wg",
-- 	because the 'w' is used before the next mapping is done.  See also
-- 	|key-mapping|.
vim.o.maxmapdepth = "1000"
-- boolean	(Vim default: on, Vi default: off)
-- 			global
-- 	When on, listings pause when the whole screen is filled.  You will get
-- 	the |more-prompt|.  When this option is off there are no pauses, the
-- 	listing continues until finished.
vim.o.more = "true"
-- number	(default 1000)
-- 			global
-- 	Maximum amount of memory (in Kbyte) to use for pattern matching.
-- 	The maximum value is about 2000000.  Use this to work without a limit.
-- 							*E363*
-- 	When Vim runs into the limit it gives an error message and mostly
-- 	behaves like CTRL-C was typed.
-- 	Running into the limit often means that the pattern is very
-- 	inefficient or too complex.  This may already happen with the pattern
-- 	"\(.\)*" on a very long line.  ".*" works much better.
-- 	Might also happen on redraw, when syntax rules try to match a complex
-- 	text structure.
-- 	Vim may run out of memory before hitting the 'maxmempattern' limit, in
-- 	which case you get an "Out of memory" error instead.
vim.o.maxmempattern = "1000"
-- string	(default empty)
-- 			global
-- 	When not empty all messages are written in a file with this name.
-- 	When the file exists messages are appended.
-- 	Writing to the file ends when Vim exits or when 'verbosefile' is made
-- 	empty.  Writes are buffered, thus may not show up for some time.
-- 	Setting 'verbosefile' to a new value is like making it empty first.
-- 	The difference with |:redir| is that verbose messages are not
-- 	displayed when 'verbosefile' is set.
vim.o.verbosefile = ""
-- number	(default 25)
-- 			global
-- 	Maximum number of items to use in a menu.  Used for menus that are
-- 	generated from a list of items, e.g., the Buffers menu.  Changing this
-- 	option has no direct effect, the menu must be refreshed first.
vim.o.menuitems = "25"
-- number	(default 4000)
-- 			global
-- 	If this many milliseconds nothing is typed the swap file will be
-- 	written to disk (see |crash-recovery|).  Also used for the
-- 	|CursorHold| autocommand event.
vim.o.updatetime = "4000"
-- string	(default "460000,2000,500")
-- 			global
-- 	Parameters for |:mkspell|.  This tunes when to start compressing the
-- 	word tree.  Compression can be slow when there are many words, but
-- 	it's needed to avoid running out of memory.  The amount of memory used
-- 	per word depends very much on how similar the words are, that's why
-- 	this tuning is complicated.
vim.o.mkspellmem = "460000,2000,500"
-- Removed. |vim-differences|
vim.o.ttyfast = "true"
-- boolean	(default off)
-- 			global
-- 	When on, the OS function fsync() will be called after saving a file
-- 	(|:write|, |writefile()|, …), |swap-file| and |shada-file|. This
-- 	flushes the file to disk, ensuring that it is safely written.
-- 	Slow on some systems: writing buffers, quitting Nvim, and other
-- 	operations may sometimes take a few seconds.
vim.o.fsync = "false"
-- boolean	(default off)
-- 			global
-- 	When on, the ":substitute" flag 'g' is default on.  This means that
-- 	all matches in a line are substituted instead of one.  When a 'g' flag
-- 	is given to a ":substitute" command, this will toggle the substitution
-- 	of all or one match.  See |complex-change|.
vim.o.gdefault = "false"
vim.o.thesaurusfunc = ""
-- boolean (default off)
-- 			local to window
-- 	Every wrapped line will continue visually indented (same amount of
-- 	space as the beginning of that line), thus preserving horizontal blocks
-- 	of text.
vim.wo.breakindent = "false"
-- string (default empty)
-- 			local to window
-- 	Settings for 'breakindent'. It can consist of the following optional
-- 	items and must be separated by a comma:
-- 		min:{n}	    Minimum text width that will be kept after
-- 			    applying 'breakindent', even if the resulting
-- 			    text should normally be narrower. This prevents
-- 			    text indented almost to the right window border
-- 			    occupying lot of vertical space when broken.
-- 		shift:{n}   After applying 'breakindent', the wrapped line's
-- 			    beginning will be shifted by the given number of
-- 			    characters.  It permits dynamic French paragraph
-- 			    indentation (negative) or emphasizing the line
-- 			    continuation (positive).
-- 		sbr	    Display the 'showbreak' value before applying the
-- 			    additional indent.
-- 	The default value for min is 20 and shift is 0.
vim.wo.breakindentopt = ""
-- boolean	(default off)
-- 			local to window
-- 	List mode: Show tabs as CTRL-I is displayed, display $ after end of
-- 	line.  Useful to see the difference between tabs and spaces and for
-- 	trailing blanks.  Further changed by the 'listchars' option.
vim.wo.list = "false"
-- boolean	(default off)
-- 			local to window
-- 	Show the line number relative to the line with the cursor in front of
-- 	each line. Relative line numbers help you use the |count| you can
-- 	precede some vertical motion commands (e.g. j k + -) with, without
-- 	having to calculate it yourself. Especially useful in combination with
-- 	other commands (e.g. y d c < > gq gw =).
-- 	When the 'n' option is excluded from 'cpoptions' a wrapped
-- 	line will not use the column of line numbers.
-- 	The 'numberwidth' option can be used to set the room used for the line
-- 	number.
-- 	When a long, wrapped line doesn't start with the first character, '-'
-- 	characters are put before the number.
-- 	See |hl-LineNr|  and |hl-CursorLineNr| for the highlighting used for
-- 	the number.
vim.wo.relativenumber = "false"
-- number	(default 0)
-- 			global or local to window |global-local|
-- 	Minimal number of screen lines to keep above and below the cursor.
-- 	This will make some context visible around where you are working.  If
-- 	you set it to a very large value (999) the cursor line will always be
-- 	in the middle of the window (except at the start or end of the file or
-- 	when long lines wrap).
-- 	After using the local value, go back the global value with one of
-- 	these two: >
-- 		setlocal scrolloff<
-- 		setlocal scrolloff=-1
-- <	For scrolling horizontally see 'sidescrolloff'.
vim.wo.scrolloff = "0"
-- boolean	(default on)
-- 			local to window
-- 	This option changes how text is displayed.  It doesn't change the text
-- 	in the buffer, see 'textwidth' for that.
-- 	When on, lines longer than the width of the window will wrap and
-- 	displaying continues on the next line.  When off lines will not wrap
-- 	and only part of long lines will be displayed.  When the cursor is
-- 	moved to a part that is not shown, the screen will scroll
-- 	horizontally.
-- 	The line will be broken in the middle of a word if necessary.  See
-- 	'linebreak' to get the break at a word boundary.
-- 	To make scrolling horizontally a bit more useful, try this: >
-- 		:set sidescroll=5
-- 		:set listchars+=precedes:<,extends:>
-- <	See 'sidescroll', 'listchars' and |wrap-off|.
-- 	This option can't be set from a |modeline| when the 'diff' option is
-- 	on.
vim.wo.wrap = "true"
-- string (default "0")
-- 			local to window
-- 	When and how to draw the foldcolumn. Valid values are:
-- 	    "auto":       resize to the maximum amount of folds to display.
-- 	    "auto:[1-9]": resize to accommodate multiple folds up to the
-- 			  selected level
--             0:            to disable foldcolumn
-- 	    "[1-9]":      to display a fixed number of columns
-- 	See |folding|.
vim.wo.foldcolumn = "0"
-- number (default 0)
-- 			global or local to window |global-local|
-- 	The minimal number of screen columns to keep to the left and to the
-- 	right of the cursor if 'nowrap' is set.  Setting this option to a
-- 	value greater than 0 while having |'sidescroll'| also at a non-zero
-- 	value makes some context visible in the line you are scrolling in
-- 	horizontally (except at beginning of the line).  Setting this option
-- 	to a large value (like 999) has the effect of keeping the cursor
-- 	horizontally centered in the window, as long as one does not come too
-- 	close to the beginning of the line.
-- 	After using the local value, go back the global value with one of
-- 	these two: >
-- 		setlocal sidescrolloff<
-- 		setlocal sidescrolloff=-1
-- <
-- 	Example: Try this together with 'sidescroll' and 'listchars' as
-- 		 in the following example to never allow the cursor to move
-- 		 onto the "extends" character: >
vim.wo.sidescrolloff = "0"
-- string	(default "auto")
-- 			local to window
-- 	When and how to draw the signcolumn. Valid values are:
-- 	   "auto"   	only when there is a sign to display
-- 	   "auto:[1-9]" resize to accommodate multiple signs up to the
-- 	                given number (maximum 9), e.g. "auto:4"
-- 	   "no"	    	never
-- 	   "yes"    	always
-- 	   "yes:[1-9]"  always, with fixed space for signs up to the given
-- 	                number (maximum 9), e.g. "yes:3"
vim.wo.signcolumn = "auto"
-- boolean (default on)
-- 			local to window
-- 	When off, all folds are open.  This option can be used to quickly
-- 	switch between showing all text unfolded and viewing the text with
-- 	folds (including manually opened or closed folds).  It can be toggled
-- 	with the |zi| command.  The 'foldcolumn' will remain blank when
-- 	'foldenable' is off.
-- 	This option is set by commands that create a new fold or close a fold.
-- 	See |folding|.
vim.wo.foldenable = "true"
-- boolean	(default off)
-- 			local to window
-- 	When on spell checking will be done.  See |spell|.
-- 	The languages are specified with 'spelllang'.
vim.wo.spell = "false"
-- string (default: "0")
-- 			local to window
-- 	The expression used for when 'foldmethod' is "expr".  It is evaluated
-- 	for each line to obtain its fold level.  See |fold-expr|.
vim.wo.foldexpr = "0"
-- boolean	(default off)
-- 			local to window
-- 	Keep the window width when windows are opened or closed and
-- 	'equalalways' is set.  Also for |CTRL-W_=|.
-- 	The width may be changed anyway when running out of room.
vim.wo.winfixwidth = "false"
-- string (default: "#")
-- 			local to window
-- 	Used only when 'foldmethod' is "indent".  Lines starting with
-- 	characters in 'foldignore' will get their fold level from surrounding
-- 	lines.  White space is skipped before checking for this character.
-- 	The default "#" works well for C programs.  See |fold-indent|.
vim.wo.foldignore = "#"
-- boolean  (default off)
-- 			local to window
-- 	When this option is set, as the cursor in the current
-- 	window moves other cursorbound windows (windows that also have
-- 	this option set) move their cursors to the corresponding line and
-- 	column.  This option is useful for viewing the
-- 	differences between two versions of a file (see 'diff'); in diff mode,
-- 	inserted and deleted lines (though not characters within a line) are
-- 	taken into account.
vim.wo.cursorbind = "false"
-- number (default 0)
-- 			local to window
-- 	Determine how text with the "conceal" syntax attribute |:syn-conceal|
-- 	is shown:
vim.wo.conceallevel = "0"
-- boolean	(default off)
-- 			local to window
-- 	Highlight the screen column of the cursor with CursorColumn
-- 	|hl-CursorColumn|.  Useful to align text.  Will make screen redrawing
-- 	slower.
-- 	If you only want the highlighting in the current window you can use
-- 	these autocommands: >
-- 		au WinLeave * set nocursorline nocursorcolumn
-- 		au WinEnter * set cursorline cursorcolumn
-- <
vim.wo.cursorcolumn = "false"
-- boolean	(default off)
-- 			local to window
-- 	When on, display orientation becomes right-to-left, i.e., characters
-- 	that are stored in the file appear from the right to the left.
-- 	Using this option, it is possible to edit files for languages that
-- 	are written from the right to the left such as Hebrew and Arabic.
-- 	This option is per window, so it is possible to edit mixed files
-- 	simultaneously, or to view the same file in both ways (this is
-- 	useful whenever you have a mixed text file with both right-to-left
-- 	and left-to-right strings so that both sets are displayed properly
-- 	in different windows).  Also see |rileft.txt|.
vim.wo.rightleft = "false"
-- string	(default "")
-- 			global
-- 	String to put at the start of lines that have been wrapped.  Useful
-- 	values are "> " or "+++ ": >
-- 		:set showbreak=>\
-- <	Note the backslash to escape the trailing space.  It's easier like
-- 	this: >
-- 		:let &showbreak = '+++ '
-- <	Only printable single-cell characters are allowed, excluding <Tab> and
-- 	comma (in a future version the comma might be used to separate the
-- 	part that is shown at the end and at the start of a line).
-- 	The |hl-NonText| highlight group determines the highlighting.
-- 	Note that tabs after the showbreak will be displayed differently.
-- 	If you want the 'showbreak' to appear in between line numbers, add the
-- 	"n" flag to 'cpoptions'.
vim.wo.showbreak = ""
-- string	(default "search")
-- 			local to window
-- 	Each word in this option enables the command line editing to work in
-- 	right-to-left mode for a group of commands:
vim.wo.rightleftcmd = "search"
-- number (default: 0)
-- 			local to window
-- 	Sets the fold level: Folds with a higher level will be closed.
-- 	Setting this option to zero will close all folds.  Higher numbers will
-- 	close fewer folds.
-- 	This option is set by commands like |zm|, |zM| and |zR|.
-- 	See |fold-foldlevel|.
vim.wo.foldlevel = "0"
-- string	(default empty)
-- 			global or local to window |global-local|
-- 	When nonempty, this option determines the content of the status line.
-- 	Also see |status-line|.
vim.wo.statusline = ""
-- boolean	(default off)
-- 			local to window
-- 	If on, Vim will wrap long lines at a character in 'breakat' rather
-- 	than at the last character that fits on the screen.  Unlike
-- 	'wrapmargin' and 'textwidth', this does not insert <EOL>s in the file,
-- 	it only affects the way the file is displayed, not its contents.
-- 	If 'breakindent' is set, line is visually indented. Then, the value
-- 	of 'showbreak' is used to put in front of wrapped lines. This option
-- 	is not used when the 'wrap' option is off.
-- 	Note that <Tab> characters after an <EOL> are mostly not displayed
-- 	with the right amount of white space.
vim.wo.linebreak = "false"
-- number (default: 20)
-- 			local to window
-- 	Sets the maximum nesting of folds for the "indent" and "syntax"
-- 	methods.  This avoids that too many folds will be created.  Using more
-- 	than 20 doesn't work, because the internal limit is 20.
vim.wo.foldnestmax = "20"
-- boolean	(default off)
-- 			local to window
-- 	Join the current window in the group of windows that shows differences
-- 	between files.  See |diff-mode|.
vim.wo.diff = "false"
-- number (default: 1)
-- 			local to window
-- 	Sets the number of screen lines above which a fold can be displayed
-- 	closed.  Also for manually closed folds.  With the default value of
-- 	one a fold can only be closed if it takes up two or more screen lines.
-- 	Set to zero to be able to close folds of just one screen line.
-- 	Note that this only has an effect on what is displayed.  After using
-- 	"zc" to close a fold, which is displayed open because it's smaller
-- 	than 'foldminlines', a following "zc" may close a containing fold.
vim.wo.foldminlines = "1"
-- boolean (default off)
-- 			local to window
-- 	This option can be set to start editing Arabic text.
-- 	Setting this option will:
-- 	- Set the 'rightleft' option, unless 'termbidi' is set.
-- 	- Set the 'arabicshape' option, unless 'termbidi' is set.
-- 	- Set the 'keymap' option to "arabic"; in Insert mode CTRL-^ toggles
-- 	  between typing English and Arabic key mapping.
-- 	- Set the 'delcombine' option
vim.wo.arabic = "false"
-- string (default: "manual")
-- 			local to window
-- 	The kind of folding used for the current window.  Possible values:
-- 	|fold-manual|	manual	    Folds are created manually.
-- 	|fold-indent|	indent	    Lines with equal indent form a fold.
-- 	|fold-expr|	expr	    'foldexpr' gives the fold level of a line.
-- 	|fold-marker|	marker	    Markers are used to specify folds.
-- 	|fold-syntax|	syntax	    Syntax highlighting items specify folds.
-- 	|fold-diff|	diff	    Fold text that is not changed.
vim.wo.foldmethod = "manual"
-- number	(default: half the window height)
-- 			local to window
-- 	Number of lines to scroll with CTRL-U and CTRL-D commands.  Will be
-- 	set to half the number of lines in the window when the window size
-- 	changes.  If you give a count to the CTRL-U or CTRL-D command it will
-- 	be used as the new value for 'scroll'.  Reset to half the window
-- 	height with ":set scroll=0".
vim.wo.scroll = "0"
-- string (default: "{{{,}}}")
-- 			local to window
-- 	The start and end marker used when 'foldmethod' is "marker".  There
-- 	must be one comma, which separates the start and end marker.  The
-- 	marker is a literal string (a regular expression would be too slow).
-- 	See |fold-marker|.
vim.wo.foldmarker = "{{{,}}}"
-- string (default: "foldtext()")
-- 			local to window
-- 	An expression which is used to specify the text displayed for a closed
-- 	fold.  See |fold-foldtext|.
vim.wo.foldtext = "foldtext()"
-- boolean	(default off)
-- 			local to window
-- 	Highlight the screen line of the cursor with CursorLine
-- 	|hl-CursorLine|.  Useful to easily spot the cursor.  Will make screen
-- 	redrawing slower.
-- 	When Visual mode is active the highlighting isn't used to make it
-- 	easier to see the selected text.
vim.wo.cursorline = "false"
-- boolean	(default off)
-- 			local to window
-- 	Print the line number in front of each line.  When the 'n' option is
-- 	excluded from 'cpoptions' a wrapped line will not use the column of
-- 	line numbers.
-- 	Use the 'numberwidth' option to adjust the room for the line number.
-- 	When a long, wrapped line doesn't start with the first character, '-'
-- 	characters are put before the number.
-- 	For highlighting see |hl-LineNr|, |hl-CursorLineNr|, and the
-- 	|:sign-define| "numhl" argument.
-- 						*number_relativenumber*
-- 	The 'relativenumber' option changes the displayed number to be
-- 	relative to the cursor.  Together with 'number' there are these
-- 	four combinations (cursor in line 3):
vim.wo.number = "false"
-- string (default: "number,line")
-- 			local to window
-- 			{not available when compiled without the |+syntax|
-- 			feature}
-- 	Comma separated list of settings for how 'cursorline' is displayed.
-- 	Valid values:
-- 	"line"		Highlight the text line of the cursor with
-- 			CursorLine |hl-CursorLine|.
-- 	"screenline"	Highlight only the screen line of the cursor with
-- 			CursorLine |hl-CursorLine|.
-- 	"number"	Highlight the line number of the cursor with
-- 			CursorLineNr |hl-CursorLineNr|.
vim.wo.cursorlineopt = "both"
-- string	(default "")
-- 			local to window
-- 	'colorcolumn' is a comma separated list of screen columns that are
-- 	highlighted with ColorColumn |hl-ColorColumn|.  Useful to align
-- 	text.  Will make screen redrawing slower.
-- 	The screen column can be an absolute number, or a number preceded with
-- 	'+' or '-', which is added to or subtracted from 'textwidth'. >
vim.wo.colorcolumn = ""
-- boolean	(default off)
-- 			local to window
-- 	Keep the window height when windows are opened or closed and
-- 	'equalalways' is set.  Also for |CTRL-W_=|.  Set by default for the
-- 	|preview-window| and |quickfix-window|.
-- 	The height may be changed anyway when running out of room.
vim.wo.winfixheight = "false"
-- boolean (default off)
-- 			local to window
-- 	Identifies the preview window.  Only one window can have this option
-- 	set.  It's normally not set directly, but by using one of the commands
-- 	|:ptag|, |:pedit|, etc.
vim.wo.previewwindow = "false"
-- number	(Vim default: 4  Vi default: 8)
-- 			local to window
-- 	Minimal number of columns to use for the line number.  Only relevant
-- 	when the 'number' or 'relativenumber' option is set or printing lines
-- 	with a line number. Since one space is always between the number and
-- 	the text, there is one less character for the number itself.
-- 	The value is the minimum width.  A bigger width is used when needed to
-- 	fit the highest line number in the buffer respectively the number of
-- 	rows in the window, depending on whether 'number' or 'relativenumber'
-- 	is set. Thus with the Vim default of 4 there is room for a line number
-- 	up to 999. When the buffer has 1000 lines five columns will be used.
-- 	The minimum value is 1, the maximum value is 20.
vim.wo.numberwidth = "4"
-- string	(default: "tab:> ,trail:-,nbsp:+"
-- 				 Vi default: "eol:$")
-- 			global or local to window |global-local|
-- 	Strings to use in 'list' mode and for the |:list| command.  It is a
-- 	comma separated list of string settings.
vim.wo.listchars = "tab:> ,trail:-,nbsp:+"
-- number	(default 0)
-- 			local to window
-- 	Enables pseudo-transparency for a floating window. Valid values are in
-- 	the range of 0 for fully opaque window (disabled) to 100 for fully
-- 	transparent background. Values between 0-30 are typically most useful.
vim.wo.winblend = "0"
-- string	(default "")
-- 			global
-- 	A comma separated list of these words:
-- 	    block	Allow virtual editing in Visual block mode.
-- 	    insert	Allow virtual editing in Insert mode.
-- 	    all		Allow virtual editing in all modes.
-- 	    onemore	Allow the cursor to move just past the end of the line
vim.wo.virtualedit = ""
-- string (default: "")
-- 			local to window
-- 	Sets the modes in which text in the cursor line can also be concealed.
-- 	When the current mode is listed then concealing happens just like in
-- 	other lines.
-- 	  n		Normal mode
-- 	  v		Visual mode
-- 	  i		Insert mode
-- 	  c		Command line editing, for 'incsearch'
vim.wo.concealcursor = ""
vim.wo.winbar = ""
-- string	(default "")
-- 			global or local to window |global-local|
-- 	Characters to fill the statuslines and vertical separators.
-- 	It is a comma separated list of items:
vim.wo.fillchars = ""
-- boolean  (default off)
-- 			local to window
-- 	See also |scroll-binding|.  When this option is set, the current
-- 	window scrolls as other scrollbind windows (windows that also have
-- 	this option set) scroll.  This option is useful for viewing the
-- 	differences between two versions of a file, see 'diff'.
-- 	See |'scrollopt'| for options that determine how this option should be
-- 	interpreted.
-- 	This option is mostly reset when splitting a window to edit another
-- 	file.  This means that ":split | edit file" results in two windows
-- 	with scroll-binding, but ":split file" does not.
vim.wo.scrollbind = "false"
-- string (default empty)
-- 			local to window
-- 	Window-local highlights.  Comma-delimited list of highlight
-- 	|group-name| pairs "{hl-builtin}:{hl},..." where each {hl-builtin} is
-- 	a built-in |highlight-groups| item to be overridden by {hl} group in
-- 	the window.  Only built-in |highlight-groups| are supported, not
-- 	syntax highlighting (use |:ownsyntax| for that).
vim.wo.winhighlight = ""
