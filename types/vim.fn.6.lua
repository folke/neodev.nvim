--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Round off {expr} to the nearest integral value and return it
-- 		as a |Float|.  If {expr} lies halfway between two integral
-- 		values, then use the larger one (away from zero).
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			echo round(0.456)
-- <			0.0  >
-- 			echo round(4.5)
-- <			5.0 >
-- 			echo round(-4.5)
-- <			-5.0
--- @return float
function vim.fn.round(expr) end

-- The result is a Number, which gives the byte index in
-- 		{haystack} of the first occurrence of the String {needle}.
-- 		If {start} is specified, the search starts at index {start}.
-- 		This can be used to find a second match: >
-- 			:let colon1 = stridx(line, ":")
-- 			:let colon2 = stridx(line, ":", colon1 + 1)
-- <		The search is done case-sensitive.
-- 		For pattern searches use |match()|.
-- 		-1 is returned if the {needle} does not occur in {haystack}.
-- 		See also |strridx()|.
-- 		Examples: >
-- 		  :echo stridx("An Example", "Example")	     3
-- 		  :echo stridx("Starting point", "Start")    0
-- 		  :echo stridx("Starting point", "start")   -1
-- <						*strstr()* *strchr()*
-- 		stridx() works similar to the C function strstr().  When used
-- 		with a single character it works similar to strchr().
--- @return number
function vim.fn.stridx(haystack, needle, start) end

-- the view of the current window.  Use |winrestview()| to
-- 		restore the view.
-- 		This is useful if you have a mapping that jumps around in the
-- 		buffer and you want to go back to the original view.
-- 		This does not save fold information.  Use the 'foldenable'
-- 		option to temporarily switch off folding, so that folds are
-- 		not opened when moving around. This may have side effects.
-- 		The return value includes:
-- 			lnum		cursor line number
-- 			col		cursor column (Note: the first column
-- 					zero, as opposed to what getpos()
-- 					returns)
-- 			coladd		cursor column offset for 'virtualedit'
-- 			curswant	column for vertical movement
-- 			topline		first line in the window
-- 			topfill		filler lines, only in diff mode
-- 			leftcol		first column displayed
-- 			skipcol		columns skipped
-- 		Note that no option values are saved.
--- @return dict
function vim.fn.winsaveview() end

-- Get a single character from the user or input stream.
-- 		If [expr] is omitted, wait until a character is available.
-- 		If [expr] is 0, only get a character when one is available.
-- 			Return zero otherwise.
-- 		If [expr] is 1, only check if a character is available, it is
-- 			not consumed.  Return zero if no character available.
--
-- 		Without [expr] and when [expr] is 0 a whole character or
-- 		special key is returned.  If it is a single character, the
-- 		result is a number.  Use nr2char() to convert it to a String.
-- 		Otherwise a String is returned with the encoded character.
-- 		For a special key it's a String with a sequence of bytes
-- 		starting with 0x80 (decimal: 128).  This is the same value as
-- 		the String "\<Key>", e.g., "\<Left>".  The returned value is
-- 		also a String when a modifier (shift, control, alt) was used
-- 		that is not included in the character.
--
-- 		When [expr] is 0 and Esc is typed, there will be a short delay
-- 		while Vim waits to see if this is the start of an escape
-- 		sequence.
--
-- 		When [expr] is 1 only the first byte is returned.  For a
-- 		one-byte character it is the character itself as a number.
-- 		Use nr2char() to convert it to a String.
--
-- 		Use getcharmod() to obtain any additional modifiers.
--
-- 		When the user clicks a mouse button, the mouse event will be
-- 		returned.  The position can then be found in |v:mouse_col|,
-- 		|v:mouse_lnum|, |v:mouse_winid| and |v:mouse_win|.  This
-- 		example positions the mouse as it would normally happen: >
-- 			let c = getchar()
-- 			if c == "\<LeftMouse>" && v:mouse_win > 0
-- 			  exe v:mouse_win . "wincmd w"
-- 			  exe v:mouse_lnum
-- 			  exe "normal " . v:mouse_col . "|"
-- 			endif
-- <
-- 		There is no prompt, you will somehow have to make clear to the
-- 		user that a character has to be typed.
-- 		There is no mapping for the character.
-- 		Key codes are replaced, thus when the user presses the <Del>
-- 		key you get the code for the <Del> key, not the raw character
-- 		sequence.  Examples: >
-- 			getchar() == "\<Del>"
-- 			getchar() == "\<S-Left>"
-- <		This example redefines "f" to ignore case: >
-- 			:nmap f :call FindChar()<CR>
-- 			:function FindChar()
-- 			:  let c = nr2char(getchar())
-- 			:  while col('.') < col('$') - 1
-- 			:    normal l
-- 			:    if getline('.')[col('.') - 1] ==? c
-- 			:      break
-- 			:    endif
-- 			:  endwhile
-- 			:endfunction
--- @return number
function vim.fn.getchar(expr) end

-- The result is a Number, which is |TRUE| when a directory
-- 		with the name {directory} exists.  If {directory} doesn't
-- 		exist, or isn't a directory, the result is |FALSE|.  {directory}
-- 		is any expression, which is used as a String.
--- @return number
function vim.fn.isdirectory(directory) end

-- The result is a dictionary of byte/chars/word statistics for
-- 		the current buffer.  This is the same info as provided by
-- 		|g_CTRL-G|
-- 		The return value includes:
-- 			bytes		Number of bytes in the buffer
-- 			chars		Number of chars in the buffer
-- 			words		Number of words in the buffer
-- 			cursor_bytes    Number of bytes before cursor position
-- 					(not in Visual mode)
-- 			cursor_chars    Number of chars before cursor position
-- 					(not in Visual mode)
-- 			cursor_words    Number of words before cursor position
-- 					(not in Visual mode)
-- 			visual_bytes    Number of bytes visually selected
-- 					(only in Visual mode)
-- 			visual_chars    Number of chars visually selected
-- 					(only in Visual mode)
-- 			visual_words    Number of chars visually selected
-- 					(only in Visual mode)
--- @return dict
function vim.fn.wordcount() end

-- with name {name}.  When the highlight group doesn't exist,
-- 		zero is returned.
-- 		This can be used to retrieve information about the highlight
-- 		group.  For example, to get the background color of the
-- 		"Comment" group: >
-- 	:echo synIDattr(synIDtrans(hlID("Comment")), "bg")
--- @return number
function vim.fn.hlID(name) end

-- Show the {what} for 3 seconds at the top of the Vim window.
-- 		This works like: >
-- 			call popup_create({what}, #{
-- 				\ line: 1,
-- 				\ col: 10,
-- 				\ minwidth: 20,
-- 				\ time: 3000,
-- 				\ tabpage: -1,
-- 				\ zindex: 300,
-- 				\ drag: 1,
-- 				\ highlight: 'WarningMsg',
-- 				\ border: [],
-- 				\ close: 'click',
-- 				\ padding: [0,1,0,1],
-- 				\ })
-- <		The PopupNotification highlight group is used instead of
-- 		WarningMsg if it is defined.
--
-- 		Without the |+timers| feature the popup will not disappear
-- 		automatically, the user has to click in it.
--
-- 		The position will be adjusted to avoid overlap with other
-- 		notifications.
-- 		Use {options} to change the properties.
--
-- 		Can also be used as a |method|: >
-- 			GetText()->popup_notification({})
--- @return number
function vim.fn.popup_notification(what, options) end

-- Bitwise XOR on the two arguments.  The arguments are converted
-- 		to a number.  A List, Dict or Float argument causes an error.
-- 		Example: >
-- 			:let bits = xor(bits, 0x80)
-- <
--- @return number
function vim.fn.xor(expr, expr) end

-- Returns a |List| with all matches previously defined for the
-- 		current window by |matchadd()| and the |:match| commands.
-- 		|getmatches()| is useful in combination with |setmatches()|,
-- 		as |setmatches()| can restore a list of matches saved by
-- 		|getmatches()|.
-- 		Example: >
-- 			:echo getmatches()
-- <			[{'group': 'MyGroup1', 'pattern': 'TODO',
-- 			'priority': 10, 'id': 1}, {'group': 'MyGroup2',
-- 			'pattern': 'FIXME', 'priority': 10, 'id': 2}] >
-- 			:let m = getmatches()
-- 			:call clearmatches()
-- 			:echo getmatches()
-- <			[] >
-- 			:call setmatches(m)
-- 			:echo getmatches()
-- <			[{'group': 'MyGroup1', 'pattern': 'TODO',
-- 			'priority': 10, 'id': 1}, {'group': 'MyGroup2',
-- 			'pattern': 'FIXME', 'priority': 10, 'id': 2}] >
-- 			:unlet m
-- <
--- @return list
function vim.fn.getmatches() end

-- Like `execute()` but in the context of window {id}.
-- 		The window will temporarily be made the current window,
-- 		without triggering autocommands.  When executing {command}
-- 		autocommands will be triggered, this may have unexpected side
-- 		effects.  Use |:noautocmd| if needed.
-- 		Example: >
-- 			call win_execute(winid, 'set syntax=python')
-- <		Doing the same with `setwinvar()` would not trigger
-- 		autocommands and not actually show syntax highlighting.
-- 							*E994*
-- 		Not all commands are allowed in popup windows.
-- 		When window {id} does not exist then no error is given.
--
-- 		Can also be used as a |method|, the base is passed as the
-- 		second argument: >
-- 			GetCommand()->win_execute(winid)
--- @return string
function vim.fn.win_execute(id, command, silent) end

-- The result is a Number, which is 1 when the tabpage or window
-- 		has set a local path via |:tcd| or |:lcd|, otherwise 0.
--
-- 		Tabs and windows are identified by their respective numbers,
-- 		0 means current tab or window. Missing argument implies 0.
-- 		Thus the following are equivalent: >
-- 			haslocaldir()
-- 			haslocaldir(0)
-- 			haslocaldir(0, 0)
-- <		With {winnr} use that window in the current tabpage.
-- 		With {winnr} and {tabnr} use the window in that tabpage.
-- 		{winnr} can be the window number or the |window-ID|.
-- 		If {winnr} is -1 it is ignored, only the tab is resolved.
--- @return number
function vim.fn.haslocaldir(winnr, tabnr) end

-- Return the number of times an item with value {expr} appears
-- 		in |String|, |List| or |Dictionary| {comp}.
--
-- 		If {start} is given then start with the item with this index.
-- 		{start} can only be used with a |List|.
--
-- 		When {ic} is given and it's |TRUE| then case is ignored.
--
-- 		When {comp} is a string then the number of not overlapping
-- 		occurrences of {expr} is returned. Zero is returned when
-- 		{expr} is an empty string.
--- @param list any[]
--- @return number
function vim.fn.count(list, expr, ic, start) end

-- Like |gettabwinvar()| for the current tabpage.
-- 		Examples: >
-- 			:let list_is_on = getwinvar(2, '&list')
-- 			:echo "myvar = " . getwinvar(1, 'myvar')
function vim.fn.getwinvar(nr, varname, def) end

-- Like |strpart()| but using character index and length instead
-- 		of byte index and length.
-- 		When a character index is used where a character does not
-- 		exist it is assumed to be one character.  For example: >
-- 			strcharpart('abc', -1, 2)
-- <		results in 'a'.
--- @return string
function vim.fn.strcharpart(str, start, len) end

-- Set attrs in nvim__buf_set_lua_hl callbacks
--
--                 TODO(bfredl): This is rather pedestrian. The final interface
--                 should probably be derived from a reformed bufhl/virttext
--                 interface with full support for multi-line ranges etc
function vim.fn.nvim__put_attr(id, c0, c1) end

-- Calls many API methods atomically.
--
--                 This has two main usages:
--                 1. To perform several requests from an async context
--                    atomically, i.e. without interleaving redraws, RPC requests
--                    from other clients, or user interactions (however API
--                    methods may trigger autocommands or event processing which
--                    have such side-effects, e.g. |:sleep| may wake timers).
--                 2. To minimize RPC overhead (roundtrips) of a sequence of many
--                    requests.
--
--                 Parameters: ~
--                     {calls}  an array of calls, where each call is described
--                              by an array with two elements: the request name,
--                              and an array of arguments.
--
--                 Return: ~
--                     Array of two elements. The first is an array of return
--                     values. The second is NIL if all calls succeeded. If a
--                     call resulted in an error, it is a three-element array
--                     with the zero-based index of the call which resulted in an
--                     error, the error type and the error message. If an error
--                     occurred, the values from all preceding calls will still
--                     be returned.
function vim.fn.nvim_call_atomic(calls) end

-- Modify file name {fname} according to {mods}.  {mods} is a
-- 		string of characters like it is used for file names on the
-- 		command line.  See |filename-modifiers|.
-- 		Example: >
-- 			:echo fnamemodify("main.c", ":p:h")
-- <		results in: >
-- 			/home/mool/vim/vim/src
-- <		Note: Environment variables don't work in {fname}, use
-- 		|expand()| first then.
--- @return string
function vim.fn.fnamemodify(fname, mods) end

-- Returns the size of the |context-stack|.
--- @return number
function vim.fn.ctxsize() end

-- Get the virtual text (annotation) for a buffer line.
--
--                 The virtual text is returned as list of lists, whereas the
--                 inner lists have either one or two elements. The first element
--                 is the actual text, the optional second element is the
--                 highlight group.
--
--                 The format is exactly the same as given to
--                 nvim_buf_set_virtual_text().
--
--                 If there is no virtual text associated with the given line, an
--                 empty list is returned.
--
--                 Parameters: ~
--                     {buffer}  Buffer handle, or 0 for current buffer
--                     {line}    Line to get the virtual text from (zero-indexed)
--
--                 Return: ~
--                     List of virtual text chunks
function vim.fn.nvim_buf_get_virtual_text(buffer, lnum) end

-- Play a sound identified by {name}.  Which event names are
-- 		supported depends on the system.  Often the XDG sound names
-- 		are used.  On Ubuntu they may be found in
-- 		/usr/share/sounds/freedesktop/stereo.  Example: >
-- 			call sound_playevent('bell')
-- <		On MS-Windows, {name} can be SystemAsterisk, SystemDefault,
-- 		SystemExclamation, SystemExit, SystemHand, SystemQuestion,
-- 		SystemStart, SystemWelcome, etc.
--
-- 		When {callback} is specified it is invoked when the sound is
-- 		finished.  The first argument is the sound ID, the second
-- 		argument is the status:
-- 			0	sound was played to the end
-- 			1	sound was interrupted
-- 			2	error occurred after sound started
-- 		Example: >
-- 		   func Callback(id, status)
-- 		     echomsg "sound " .. a:id .. " finished with " .. a:status
-- 		   endfunc
-- 		   call sound_playevent('bell', 'Callback')
--
-- <		MS-Windows: {callback} doesn't work for this function.
--
-- 		Returns the sound ID, which can be passed to `sound_stop()`.
-- 		Returns zero if the sound could not be played.
--
-- 		Can also be used as a |method|: >
-- 			GetSoundName()->sound_playevent()
--
-- <		{only available when compiled with the |+sound| feature}
--- @return number
function vim.fn.sound_playevent(name, callback) end

-- The result is a Number, which is the translated syntax ID of
-- 		{synID}.  This is the syntax group ID of what is being used to
-- 		highlight the character.  Highlight links given with
-- 		":highlight link" are followed.
--- @return number
function vim.fn.synIDtrans(synID) end

-- Specifically used to interrupt a program being debugged.  It
-- 		will cause process {pid} to get a SIGTRAP.  Behavior for other
-- 		processes is undefined. See |terminal-debugger|.
-- 		{Sends a SIGINT to a process {pid} other than MS-Windows}
--- @return number
function vim.fn.debugbreak(pid) end

-- Return all of environment variables as dictionary. You can
-- 		check if an environment variable exists like this: >
-- 			:echo has_key(environ(), 'HOME')
-- <		Note that the variable name may be CamelCase; to ignore case
-- 		use this: >
-- 			:echo index(keys(environ()), 'HOME', 0, 1) != -1
--- @return dict
function vim.fn.environ() end

-- Get the size of terminal {buf}. Returns a list with two
-- 		numbers: [rows, cols].  This is the size of the terminal, not
-- 		the window containing the terminal.
--
-- 		{buf} must be the buffer number of a terminal window.  Use an
-- 		empty string for the current buffer.  If the buffer does not
-- 		exist or is not a terminal window, an empty list is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getsize()
--- @return list
function vim.fn.term_getsize(buf) end

-- Delete lines {first} to {last} (inclusive) from buffer {expr}.
-- 		If {last} is omitted then delete line {first} only.
-- 		On success 0 is returned, on failure 1 is returned.
--
-- 		For the use of {expr}, see |bufname()| above.
--
-- 		{first} and {last} are used like with |setline()|. Note that
-- 		when using |line()| this refers to the current buffer. Use "$"
-- 		to refer to the last line in buffer {expr}.
--- @return number
function vim.fn.deletebufline(expr, first, last) end

-- The result is a |List|, where each item is the number of the
-- 		buffer associated with each window in the current tab page.
-- 		{arg} specifies the number of the tab page to be used. When
-- 		omitted the current tab page is used.
-- 		When {arg} is invalid the number zero is returned.
-- 		To get a list of all buffers in all tabs use this: >
-- 			let buflist = []
-- 			for i in range(tabpagenr('$'))
-- 			   call extend(buflist, tabpagebuflist(i + 1))
-- 			endfor
-- <		Note that a buffer may appear in more than one window.
--- @return list
function vim.fn.tabpagebuflist(arg) end

-- Adds a watcher to a dictionary. A dictionary watcher is
-- 		identified by three components:
--
-- 		- A dictionary({dict});
-- 		- A key pattern({pattern}).
-- 		- A function({callback}).
--
-- 		After this is called, every change on {dict} and on keys
-- 		matching {pattern} will result in {callback} being invoked.
--
-- 		For example, to watch all global variables: >
-- 			silent! call dictwatcherdel(g:, '*', 'OnDictChanged')
-- 			function! OnDictChanged(d,k,z)
-- 			  echomsg string(a:k) string(a:z)
-- 			endfunction
-- 			call dictwatcheradd(g:, '*', 'OnDictChanged')
-- <
-- 		For now {pattern} only accepts very simple patterns that can
-- 		contain a '*' at the end of the string, in which case it will
-- 		match every key that begins with the substring before the '*'.
-- 		That means if '*' is not the last character of {pattern}, only
-- 		keys that are exactly equal as {pattern} will be matched.
--
-- 		The {callback} receives three arguments:
--
-- 		- The dictionary being watched.
-- 		- The key which changed.
-- 		- A dictionary containing the new and old values for the key.
--
-- 		The type of change can be determined by examining the keys
-- 		present on the third argument:
--
-- 		- If contains both `old` and `new`, the key was updated.
-- 		- If it contains only `new`, the key was added.
-- 		- If it contains only `old`, the key was deleted.
--
-- 		This function can be used by plugins to implement options with
-- 		validation and parsing logic.
--- @param dict dictionary
--- @return start
function vim.fn.dictwatcheradd(dict, pattern, callback) end

-- Override options in popup {id} with entries in {options}.
-- 		These options can be set:
-- 			border
-- 			borderchars
-- 			borderhighlight
-- 			callback
-- 			close
-- 			cursorline
-- 			drag
-- 			filter
-- 			firstline
-- 			flip
-- 			highlight
-- 			mapping
-- 			mask
-- 			moved
-- 			padding
-- 			resize
-- 			scrollbar
-- 			scrollbarhighlight
-- 			thumbhighlight
-- 			time
-- 			title
-- 			wrap
-- 			zindex
-- 		The options from |popup_move()| can also be used.
-- 		For "hidden" use |popup_hide()| and |popup_show()|.
-- 		"tabpage" cannot be changed.
--
-- 		Can also be used as a |method|: >
-- 			GetPopup()->popup_setoptions(options)
--- @return none
function vim.fn.popup_setoptions(id, options) end

-- Execute Lua code. Parameters (if any) are available as `...`
--                 inside the chunk. The chunk can return a value.
--
--                 Only statements are executed. To evaluate an expression,
--                 prefix it with `return` : return my_function(...)
--
--                 Parameters: ~
--                     {code}  Lua code to execute
--                     {args}  Arguments to the code
--
--                 Return: ~
--                     Return value of Lua code if present or NIL.
--- @param args any[]
function vim.fn.nvim_exec_lua(code, args) end

-- Removes a watcher added  with |dictwatcheradd()|. All three
-- 		arguments must match the ones passed to |dictwatcheradd()| in
-- 		order for the watcher to be successfully deleted.
--- @param dict dictionary
--- @return stop
function vim.fn.dictwatcherdel(dict, pattern, callback) end

-- Returns a Dictionary with the last known position of the
-- 		mouse.  This can be used in a mapping for a mouse click or in
-- 		a filter of a popup window.  The items are:
-- 			screenrow	screen row
-- 			screencol	screen column
-- 			winid		Window ID of the click
-- 			winrow		row inside "winid"
-- 			wincol		column inside "winid"
-- 			line		text line inside "winid"
-- 			column		text column inside "winid"
-- 		All numbers are 1-based.
--
-- 		If not over a window, e.g. when in the command line, then only
-- 		"screenrow" and "screencol" are valid, the others are zero.
--
-- 		When on the status line below a window or the vertical
-- 		separater right of a window, the "line" and "column" values
-- 		are zero.
--
-- 		When the position is after the text then "column" is the
-- 		length of the text in bytes.
--
-- 		If the mouse is over a popup window then that window is used.
--
--
-- 		When using |getchar()| the Vim variables |v:mouse_lnum|,
-- 		|v:mouse_col| and |v:mouse_winid| also provide these values.
--- @return dict
function vim.fn.getmousepos() end

-- Returns a 2-tuple (Array), where item 0 is the current channel
--                 id and item 1 is the |api-metadata| map (Dictionary).
--
--                 Return: ~
--                     2-tuple [{channel-id}, {api-metadata}]
--
--                 Attributes: ~
--                     {fast}
function vim.fn.nvim_get_api_info() end

-- FileType event has been triggered at least once.  Can be used
-- 		to avoid triggering the FileType event again in the scripts
-- 		that detect the file type. |FileType|
-- 		Returns |FALSE| when `:setf FALLBACK` was used.
-- 		When editing another file, the counter is reset, thus this
-- 		really checks if the FileType event has been triggered for the
-- 		current buffer.  This allows an autocommand that starts
-- 		editing another buffer to set 'filetype' and load a syntax
-- 		file.
--- @return number
function vim.fn.did_filetype() end

-- Like |input()|, but when the GUI is running and text dialogs
-- 		are supported, a dialog window pops up to input the text.
-- 		Example: >
-- 		   :let n = inputdialog("value for shiftwidth", shiftwidth())
-- 		   :if n != ""
-- 		   :  let &sw = n
-- 		   :endif
-- <		When the dialog is cancelled {cancelreturn} is returned.  When
-- 		omitted an empty string is returned.
-- 		Hitting <Enter> works like pressing the OK button.  Hitting
-- 		<Esc> works like pressing the Cancel button.
-- 		NOTE: Command-line completion is not supported.
--
-- 		Can also be used as a |method|: >
-- 			GetPrompt()->inputdialog()
--- @return string
function vim.fn.inputdialog(prompt, text, completion) end

-- Returns the number of filler lines above line {lnum}.
-- 		These are the lines that were inserted at this point in
-- 		another diff'ed window.  These filler lines are shown in the
-- 		display but don't exist in the buffer.
-- 		{lnum} is used like with |getline()|.  Thus "." is the current
-- 		line, "'m" mark m, etc.
-- 		Returns 0 if the current window is not in diff mode.
--- @return number
function vim.fn.diff_filler(lnum) end

-- Return a list of command-line completion matches. {type}
-- 		specifies what for.  The following completion types are
-- 		supported:
--
-- 		arglist		file names in argument list
-- 		augroup		autocmd groups
-- 		buffer		buffer names
-- 		behave		:behave suboptions
-- 		cmdline		|cmdline-completion|
-- 		color		color schemes
-- 		command		Ex command (and arguments)
-- 		compiler	compilers
-- 		cscope		|:cscope| suboptions
-- 		dir		directory names
-- 		environment	environment variable names
-- 		event		autocommand events
-- 		expression	Vim expression
-- 		file		file and directory names
-- 		file_in_path	file and directory names in |'path'|
-- 		filetype	filetype names |'filetype'|
-- 		function	function name
-- 		help		help subjects
-- 		highlight	highlight groups
-- 		history		:history suboptions
-- 		locale		locale names (as output of locale -a)
-- 		mapclear        buffer argument
-- 		mapping		mapping name
-- 		menu		menus
-- 		messages	|:messages| suboptions
-- 		option		options
-- 		packadd		optional package |pack-add| names
-- 		shellcmd	Shell command
-- 		sign		|:sign| suboptions
-- 		syntax		syntax file names |'syntax'|
-- 		syntime		|:syntime| suboptions
-- 		tag		tags
-- 		tag_listfiles	tags, file names
-- 		user		user names
-- 		var		user variables
--
-- 		If {pat} is an empty string then all matches are returned.
-- 		Otherwise only items matching {pat} are returned. See
-- 		|wildcards| for the use of special characters in {pat}.
--
-- 		If the optional {filtered} flag is set to 1, then 'wildignore'
-- 		is applied to filter the results.  Otherwise all the matches
-- 		are returned. The 'wildignorecase' option always applies.
--
-- 		If there are no matches, an empty list is returned.  An
-- 		invalid value for {type} produces an error.
--- @return list
function vim.fn.getcompletion(pat, type, filtered) end

-- Returns the highlight ID for diff mode at line {lnum} column
-- 		{col} (byte index).  When the current line does not have a
-- 		diff change zero is returned.
-- 		{lnum} is used like with |getline()|.  Thus "." is the current
-- 		line, "'m" mark m, etc.
-- 		{col} is 1 for the leftmost column, {lnum} is 1 for the first
-- 		line.
-- 		The highlight ID can be used with |synIDattr()| to obtain
-- 		syntax information about the highlighting.
--- @return number
function vim.fn.diff_hlID(lnum, col) end

-- Returns a Dictionary with information about Insert mode
-- 		completion.  See |ins-completion|.
-- 		The items are:
-- 		   mode		Current completion mode name string.
-- 				See |complete_info_mode| for the values.
-- 		   pum_visible	|TRUE| if popup menu is visible.
-- 				See |pumvisible()|.
-- 		   items	List of completion matches.  Each item is a
-- 				dictionary containing the entries "word",
-- 				"abbr", "menu", "kind", "info" and "user_data".
-- 				See |complete-items|.
-- 		   selected	Selected item index.  First index is zero.
-- 				Index is -1 if no item is selected (showing
-- 				typed text only)
-- 		   inserted	Inserted string. [NOT IMPLEMENT YET]
--
-- 							*complete_info_mode*
-- 		mode values are:
-- 		   ""		     Not in completion mode
-- 		   "keyword"	     Keyword completion |i_CTRL-X_CTRL-N|
-- 		   "ctrl_x"	     Just pressed CTRL-X |i_CTRL-X|
-- 		   "whole_line"	     Whole lines |i_CTRL-X_CTRL-L|
-- 		   "files"	     File names |i_CTRL-X_CTRL-F|
-- 		   "tags"	     Tags |i_CTRL-X_CTRL-]|
-- 		   "path_defines"    Definition completion |i_CTRL-X_CTRL-D|
-- 		   "path_patterns"   Include completion |i_CTRL-X_CTRL-I|
-- 		   "dictionary"	     Dictionary |i_CTRL-X_CTRL-K|
-- 		   "thesaurus"	     Thesaurus |i_CTRL-X_CTRL-T|
-- 		   "cmdline"	     Vim Command line |i_CTRL-X_CTRL-V|
-- 		   "function"	     User defined completion |i_CTRL-X_CTRL-U|
-- 		   "omni"	     Omni completion |i_CTRL-X_CTRL-O|
-- 		   "spell"	     Spelling suggestions |i_CTRL-X_s|
-- 		   "eval"            |complete()| completion
-- 		   "unknown"	     Other internal modes
--
-- 		If the optional {what} list argument is supplied, then only
-- 		the items listed in {what} are returned.  Unsupported items in
-- 		{what} are silently ignored.
--
-- 		To get the position and size of the popup menu, see
-- 		|pum_getpos()|. It's also available in |v:event| during the
-- 		|CompleteChanged| event.
--
-- 		Examples: >
-- 			" Get all items
-- 			call complete_info()
-- 			" Get only 'mode'
-- 			call complete_info(['mode'])
-- 			" Get only 'mode' and 'pum_visible'
-- 			call complete_info(['mode', 'pum_visible'])
-- <
--- @return dict
function vim.fn.complete_info(what) end

-- Expand wildcards and the following special keywords in {expr}.
-- 		'wildignorecase' applies.
--
-- 		If {list} is given and it is |TRUE|, a List will be returned.
-- 		Otherwise the result is a String and when there are several
-- 		matches, they are separated by <NL> characters.
--
-- 		If the expansion fails, the result is an empty string.  A name
-- 		for a non-existing file is not included, unless {expr} does
-- 		not start with '%', '#' or '<', see below.
--
-- 		When {expr} starts with '%', '#' or '<', the expansion is done
-- 		like for the |cmdline-special| variables with their associated
-- 		modifiers.  Here is a short overview:
--
-- 			%		current file name
-- 			#		alternate file name
-- 			#n		alternate file name n
-- 			<cfile>		file name under the cursor
-- 			<afile>		autocmd file name
-- 			<abuf>		autocmd buffer number (as a String!)
-- 			<amatch>	autocmd matched name
-- 			<sfile>		sourced script file or function name
-- 			<slnum>		sourced script line number or function
-- 					line number
-- 			<sflnum>	script file line number, also when in
-- 					a function
-- 			<cword>		word under the cursor
-- 			<cWORD>		WORD under the cursor
-- 			<client>	the {clientid} of the last received
-- 					message |server2client()|
-- 		Modifiers:
-- 			:p		expand to full path
-- 			:h		head (last path component removed)
-- 			:t		tail (last path component only)
-- 			:r		root (one extension removed)
-- 			:e		extension only
--
-- 		Example: >
-- 			:let &tags = expand("%:p:h") . "/tags"
-- <		Note that when expanding a string that starts with '%', '#' or
-- 		'<', any following text is ignored.  This does NOT work: >
-- 			:let doesntwork = expand("%:h.bak")
-- <		Use this: >
-- 			:let doeswork = expand("%:h") . ".bak"
-- <		Also note that expanding "<cfile>" and others only returns the
-- 		referenced file name without further expansion.  If "<cfile>"
-- 		is "~/.cshrc", you need to do another expand() to have the
-- 		"~/" expanded into the path of the home directory: >
-- 			:echo expand(expand("<cfile>"))
-- <
-- 		There cannot be white space between the variables and the
-- 		following modifier.  The |fnamemodify()| function can be used
-- 		to modify normal file names.
--
-- 		When using '%' or '#', and the current or alternate file name
-- 		is not defined, an empty string is used.  Using "%:p" in a
-- 		buffer with no name, results in the current directory, with a
-- 		'/' added.
--
-- 		When {expr} does not start with '%', '#' or '<', it is
-- 		expanded like a file name is expanded on the command line.
-- 		'suffixes' and 'wildignore' are used, unless the optional
-- 		{nosuf} argument is given and it is |TRUE|.
-- 		Names for non-existing files are included.  The "**" item can
-- 		be used to search in a directory tree.  For example, to find
-- 		all "README" files in the current directory and below: >
-- 			:echo expand("**/README")
-- <
-- 		expand() can also be used to expand variables and environment
-- 		variables that are only known in a shell.  But this can be
-- 		slow, because a shell may be used to do the expansion.  See
-- 		|expr-env-expand|.
-- 		The expanded variable is still handled like a list of file
-- 		names.  When an environment variable cannot be expanded, it is
-- 		left unchanged.  Thus ":echo expand('$FOOBAR')" results in
-- 		"$FOOBAR".
--
-- 		See |glob()| for finding existing files.  See |system()| for
-- 		getting the raw output of an external command.
--- @param list any[]
function vim.fn.expand(expr, nosuf, list) end

-- Join the items in {list} together into one String.
-- 		When {sep} is specified it is put in between the items.  If
-- 		{sep} is omitted a single space is used.
-- 		Note that {sep} is not added at the end.  You might want to
-- 		add it there too: >
-- 			let lines = join(mylist, "\n") . "\n"
-- <		String items are used as-is.  |Lists| and |Dictionaries| are
-- 		converted into a string like with |string()|.
-- 		The opposite function is |split()|.
--- @param list any[]
--- @return string
function vim.fn.join(list, sep) end

-- Restores a list of matches saved by |getmatches() for the
-- 		current window|.  Returns 0 if successful, otherwise -1.  All
-- 		current matches are cleared before the list is restored.  See
-- 		example for |getmatches()|.
--- @param list any[]
--- @return number
function vim.fn.setmatches(list) end

-- Returns 1 when inside an event handler.  That is that Vim got
-- 		interrupted while waiting for the user to type a character,
-- 		e.g., when dropping a file on Vim.  This means interactive
-- 		commands cannot be used.  Otherwise zero is returned.
--- @return number
function vim.fn.eventhandler() end

-- Returns the text that is displayed for the closed fold at line
-- 		{lnum}.  Evaluates 'foldtext' in the appropriate context.
-- 		When there is no closed fold at {lnum} an empty string is
-- 		returned.
-- 		{lnum} is used like with |getline()|.  Thus "." is the current
-- 		line, "'m" mark m, etc.
-- 		Useful when exporting folded text, e.g., to HTML.
--- @return string
function vim.fn.foldtextresult(lnum) end

-- The result is a Number, which is non-zero if a highlight group
-- 		called {name} exists.  This is when the group has been
-- 		defined in some way.  Not necessarily when highlighting has
-- 		been defined for it, it may also have been used for a syntax
-- 		item.
--- @return number
function vim.fn.hlexists(name) end

-- Returns information about windows as a List with Dictionaries.
--
-- 		If {winid} is given Information about the window with that ID
-- 		is returned.  If the window does not exist the result is an
-- 		empty list.
--
-- 		Without {winid} information about all the windows in all the
-- 		tab pages is returned.
--
-- 		Each List item is a Dictionary with the following entries:
-- 			botline		last displayed buffer line
-- 			bufnr		number of buffer in the window
-- 			height		window height (excluding winbar)
-- 			loclist		1 if showing a location list
-- 			quickfix	1 if quickfix or location list window
-- 			terminal	1 if a terminal window
-- 			tabnr		tab page number
-- 			topline		first displayed buffer line
-- 			variables	a reference to the dictionary with
-- 					window-local variables
-- 			width		window width
-- 			winbar		1 if the window has a toolbar, 0
-- 					otherwise
-- 			wincol		leftmost screen column of the window
-- 			winid		|window-ID|
-- 			winnr		window number
-- 			winrow		topmost screen column of the window
--- @return list
function vim.fn.getwininfo(winid) end

-- Add the String {item} to the history {history} which can be
-- 		one of:					*hist-names*
-- 			"cmd"	 or ":"	  command line history
-- 			"search" or "/"   search pattern history
-- 			"expr"	 or "="   typed expression history
-- 			"input"  or "@"	  input line history
-- 			"debug"  or ">"   debug command history
-- 			empty		  the current or last used history
-- 		The {history} string does not need to be the whole name, one
-- 		character is sufficient.
-- 		If {item} does already exist in the history, it will be
-- 		shifted to become the newest entry.
-- 		The result is a Number: 1 if the operation was successful,
-- 		otherwise 0 is returned.
--
-- 		Example: >
-- 			:call histadd("input", strftime("%Y %b %d"))
-- 			:let date=input("Enter date: ")
-- <		This function is not available in the |sandbox|.
--- @return string
function vim.fn.histadd(history, item) end

-- Clear {history}, i.e. delete all its entries.  See |hist-names|
-- 		for the possible values of {history}.
--
-- 		If the parameter {item} evaluates to a String, it is used as a
-- 		regular expression.  All entries matching that expression will
-- 		be removed from the history (if there are any).
-- 		Upper/lowercase must match, unless "\c" is used |/\c|.
-- 		If {item} evaluates to a Number, it will be interpreted as
-- 		an index, see |:history-indexing|.  The respective entry will
-- 		be removed if it exists.
--
-- 		The result is a Number: 1 for a successful operation,
-- 		otherwise 0 is returned.
--
-- 		Examples:
-- 		Clear expression register history: >
-- 			:call histdel("expr")
-- <
-- 		Remove all entries starting with "*" from the search history: >
-- 			:call histdel("/", '^\*')
-- <
-- 		The following three are equivalent: >
-- 			:call histdel("search", histnr("search"))
-- 			:call histdel("search", -1)
-- 			:call histdel("search", '^'.histget("search", -1).'$')
-- <
-- 		To delete the last search pattern and use the last-but-one for
-- 		the "n" command and 'hlsearch': >
-- 			:call histdel("search", -1)
-- 			:let @/ = histget("search", -1)
--- @return string
function vim.fn.histdel(history, item) end

-- Split {msg} into lines to be displayed in a balloon.  The
-- 		splits are made for the current window size and optimize to
-- 		show debugger output.
-- 		Returns a |List| with the split lines.
-- 		Can also be used as a |method|: >
-- 			GetText()->balloon_split()->balloon_show()
--
-- <		{only available when compiled with the |+balloon_eval_term|
-- 		feature}
--- @return list
function vim.fn.balloon_split(msg) end

-- Unsubscribes to event broadcasts.
--
--                 Parameters: ~
--                     {event}  Event type string
function vim.fn.nvim_unsubscribe(event) end

-- Get the Job associated with {channel}.
-- 		If there is no job calling |job_status()| on the returned Job
-- 		will result in "fail".
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_getjob()
--- @return job
function vim.fn.ch_getjob(channel) end

-- Return the current command-line.  Only works when the command
-- 		line is being edited, thus requires use of |c_CTRL-\_e| or
-- 		|c_CTRL-R_=|.
-- 		Example: >
-- 			:cmap <F7> <C-\>eescape(getcmdline(), ' \')<CR>
-- <		Also see |getcmdtype()|, |getcmdpos()| and |setcmdpos()|.
-- 		Returns an empty string when entering a password or using
-- 		|inputsecret()|.
--- @return string
function vim.fn.getcmdline() end

-- Expand special items in {expr} like what is done for an Ex
-- 		command such as `:edit`.  This expands special keywords, like
-- 		with |expand()|, and environment variables, anywhere in
-- 		{expr}.  Returns the expanded string.
-- 		Example: >
-- 			:echo expandcmd('make %<.o')
--- @return string
function vim.fn.expandcmd(expr) end

-- Escape {string} for use as a shell command argument.
-- 		On Windows when 'shellslash' is not set, it
-- 		will enclose {string} in double quotes and double all double
-- 		quotes within {string}.
-- 		Otherwise, it will enclose {string} in single quotes and
-- 		replace all "'" with "'\''".
--
-- 		When the {special} argument is present and it's a non-zero
-- 		Number or a non-empty String (|non-zero-arg|), then special
-- 		items such as "!", "%", "#" and "<cword>" will be preceded by
-- 		a backslash.  This backslash will be removed again by the |:!|
-- 		command.
--
-- 		The "!" character will be escaped (again with a |non-zero-arg|
-- 		{special}) when 'shell' contains "csh" in the tail.  That is
-- 		because for csh and tcsh "!" is used for history replacement
-- 		even when inside single quotes.
--
-- 		With a |non-zero-arg| {special} the <NL> character is also
-- 		escaped.  When 'shell' containing "csh" in the tail it's
-- 		escaped a second time.
--
-- 		Example of use with a |:!| command: >
-- 		    :exe '!dir ' . shellescape(expand('<cfile>'), 1)
-- <		This results in a directory listing for the file under the
-- 		cursor.  Example of use with |system()|: >
-- 		    :call system("chmod +w -- " . shellescape(expand("%")))
-- <		See also |::S|.
--- @return string
function vim.fn.shellescape(string, special) end

-- Return the PID (process id) of |job-id| {job}.
--- @return number
function vim.fn.jobpid(id) end

-- If {arg} is not specified, then information about all the tab
-- 		pages is returned as a List. Each List item is a Dictionary.
-- 		Otherwise, {arg} specifies the tab page number and information
-- 		about that one is returned.  If the tab page does not exist an
-- 		empty List is returned.
--
-- 		Each List item is a Dictionary with the following entries:
-- 			tabnr		tab page number.
-- 			variables	a reference to the dictionary with
-- 					tabpage-local variables
-- 			windows		List of |window-ID|s in the tab page.
--- @return list
function vim.fn.gettabinfo(expr) end

-- The result is a Number, which is 1 when a file with the
-- 		name {file} exists, and can be written.  If {file} doesn't
-- 		exist, or is not writable, the result is 0.  If {file} is a
-- 		directory, and we can write to it, the result is 2.
--- @return number
function vim.fn.filewritable(file) end

-- The result is a Number, which is the number of display cells
-- 		String {expr} occupies on the screen when it starts at {col}
-- 		(first column is zero).  When {col} is omitted zero is used.
-- 		Otherwise it is the screen column where to start.  This
-- 		matters for Tab characters.
-- 		The option settings of the current window are used.  This
-- 		matters for anything that's displayed differently, such as
-- 		'tabstop' and 'display'.
-- 		When {expr} contains characters with East Asian Width Class
-- 		Ambiguous, this function's return value depends on 'ambiwidth'.
-- 		Also see |strlen()|, |strwidth()| and |strchars()|.
--- @return number
function vim.fn.strdisplaywidth(expr, col) end

-- Convert {expr} to a Number by omitting the part after the
-- 		decimal point.
-- 		{expr} must evaluate to a |Float| or a Number.
-- 		When the value of {expr} is out of range for a |Number| the
-- 		result is truncated to 0x7fffffff or -0x7fffffff (or when
-- 		64-bit Number support is enabled, 0x7fffffffffffffff or
-- 		-0x7fffffffffffffff).  NaN results in -0x80000000 (or when
-- 		64-bit Number support is enabled, -0x8000000000000000).
-- 		Examples: >
-- 			echo float2nr(3.95)
-- <			3  >
-- 			echo float2nr(-23.45)
-- <			-23  >
-- 			echo float2nr(1.0e100)
-- <			2147483647  (or 9223372036854775807) >
-- 			echo float2nr(-1.0e150)
-- <			-2147483647 (or -9223372036854775807) >
-- 			echo float2nr(1.0e-100)
-- <			0
--- @return number
function vim.fn.float2nr(expr) end

-- Return a string with a single character, which has the number
-- 		value {expr}.  Examples: >
-- 			nr2char(64)		returns "@"
-- 			nr2char(32)		returns " "
-- <		Example for "utf-8": >
-- 			nr2char(300)		returns I with bow character
-- <		UTF-8 encoding is always used, {utf8} option has no effect,
-- 		and exists only for backwards-compatibility.
-- 		Note that a NUL character in the file is specified with
-- 		nr2char(10), because NULs are represented with newline
-- 		characters.  nr2char(0) is a real NUL and terminates the
-- 		string, thus results in an empty string.
--
-- nvim_...({...})					*E5555* *nvim_...()* *eval-api*
-- 		Call nvim |api| functions. The type checking of arguments will
-- 		be stricter than for most other builtins. For instance,
-- 		if Integer is expected, a |Number| must be passed in, a
-- 		|String| will not be autoconverted.
-- 		Buffer numbers, as returned by |bufnr()| could be used as
-- 		first argument to nvim_buf_... functions.  All functions
-- 		expecting an object (buffer, window or tabpage) can
-- 		also take the numerical value 0 to indicate the current
-- 		(focused) object.
--- @return string
function vim.fn.nr2char(expr, utf8) end

-- The result is a Number, which is the last modification time of
-- 		the given file {fname}.  The value is measured as seconds
-- 		since 1st Jan 1970, and may be passed to strftime().  See also
-- 		|localtime()| and |strftime()|.
-- 		If the file {fname} can't be found -1 is returned.
--- @return number
function vim.fn.getftime(fname) end

-- Self-identifies the client.
--
--                 The client/plugin/application should call this after
--                 connecting, to provide hints about its identity and purpose,
--                 for debugging and orchestration.
--
--                 Can be called more than once; the caller should merge old info
--                 if appropriate. Example: library first identifies the channel,
--                 then a plugin using that library later identifies itself.
--
--                 Note:
--                     "Something is better than nothing". You don't need to
--                     include all the fields.
--
--                 Parameters: ~
--                     {name}        Short name for the connected client
--                     {version}     Dictionary describing the version, with
--                                   these (optional) keys:
--                                   • "major" major version (defaults to 0 if
--                                     not set, for no release yet)
--                                   • "minor" minor version
--                                   • "patch" patch number
--                                   • "prerelease" string describing a
--                                     prerelease, like "dev" or "beta1"
--                                   • "commit" hash or similar identifier of
--                                     commit
--                     {type}        Must be one of the following values. Client
--                                   libraries should default to "remote" unless
--                                   overridden by the user.
--                                   • "remote" remote client connected to Nvim.
--                                   • "ui" gui frontend
--                                   • "embedder" application using Nvim as a
--                                     component (for example, IDE/editor
--                                     implementing a vim mode).
--                                   • "host" plugin host, typically started by
--                                     nvim
--                                   • "plugin" single plugin, started by nvim
--                     {methods}     Builtin methods in the client. For a host,
--                                   this does not include plugin methods which
--                                   will be discovered later. The key should be
--                                   the method name, the values are dicts with
--                                   these (optional) keys (more keys may be
--                                   added in future versions of Nvim, thus
--                                   unknown keys are ignored. Clients must only
--                                   use keys defined in this or later versions
--                                   of Nvim):
--                                   • "async" if true, send as a notification.
--                                     If false or unspecified, use a blocking
--                                     request
--                                   • "nargs" Number of arguments. Could be a
--                                     single integer or an array of two
--                                     integers, minimum and maximum inclusive.
--                     {attributes}  Arbitrary string:string map of informal
--                                   client properties. Suggested keys:
--                                   • "website": Client homepage URL (e.g.
--                                     GitHub repository)
--                                   • "license": License description ("Apache
--                                     2", "GPLv3", "MIT", …)
--                                   • "logo": URI or path to image, preferably
--                                     small logo or icon. .png or .svg format is
--                                     preferred.
function vim.fn.nvim_set_client_info(name, version, type, methods, attributes) end

-- Move popup {id} to the position specified with {options}.
-- 		{options} may contain the items from |popup_create()| that
-- 		specify the popup position:
-- 			line
-- 			col
-- 			pos
-- 			maxheight
-- 			minheight
-- 			maxwidth
-- 			minwidth
-- 			fixed
-- 		For {id} see `popup_hide()`.
-- 		For other options see |popup_setoptions()|.
--
-- 		Can also be used as a |method|: >
-- 			GetPopup()->popup_move(options)
--- @return none
function vim.fn.popup_move(id, options) end

-- Return an item that represents a time value.  The format of
-- 		the item depends on the system.  It can be passed to
-- 		|reltimestr()| to convert it to a string or |reltimefloat()|
-- 		to convert to a float.
--
-- 		Without an argument it returns the current "relative time", an
-- 		implementation-defined value meaningful only when used as an
-- 		argument to |reltime()|, |reltimestr()| and |reltimefloat()|.
--
-- 		With one argument it returns the time passed since the time
-- 		specified in the argument.
-- 		With two arguments it returns the time passed between {start}
-- 		and {end}.
-- 		The {start} and {end} arguments must be values returned by
-- 		reltime().
--
-- 		Note: |localtime()| returns the current (non-relative) time.
--- @return list
function vim.fn.reltime(start, _end) end

-- Subscribes to event broadcasts.
--
--                 Parameters: ~
--                     {event}  Event type string
function vim.fn.nvim_subscribe(event) end

-- Get the channel handle that {job} is using.
-- 		To check if the job has no channel: >
-- 			if string(job_getchannel()) == 'channel fail'
-- <
-- 		Can also be used as a |method|: >
-- 			GetJob()->job_getchannel()
--- @return channel
function vim.fn.job_getchannel(job) end

-- Returns a Dictionary with information about {job}:
-- 		   "status"	what |job_status()| returns
-- 		   "channel"	what |job_getchannel()| returns
-- 		   "cmd"	List of command arguments used to start the job
-- 		   "process"	process ID
-- 		   "tty_in"	terminal input name, empty when none
-- 		   "tty_out"	terminal output name, empty when none
-- 		   "exitval"	only valid when "status" is "dead"
-- 		   "exit_cb"	function to be called on exit
-- 		   "stoponexit"	|job-stoponexit|
--
-- 		   Only in Unix:
-- 		   "termsig"	the signal which terminated the process
-- 				(See |job_stop()| for the values)
-- 				only valid when "status" is "dead"
--
-- 		   Only in MS-Windows:
-- 		   "tty_type"	Type of virtual console in use.
-- 				Values are "winpty" or "conpty".
-- 				See 'termwintype'.
--
-- 		Without any arguments, returns a List with all Job objects.
--
-- 		Can also be used as a |method|: >
-- 			GetJob()->job_info()
--- @return dict
function vim.fn.job_info(job) end

-- Change options for {job}.  Supported are:
-- 		   "stoponexit"	|job-stoponexit|
-- 		   "exit_cb"	|job-exit_cb|
--
-- 		Can also be used as a |method|: >
-- 			GetJob()->job_setoptions(options)
--- @return none
function vim.fn.job_setoptions(job, options) end

