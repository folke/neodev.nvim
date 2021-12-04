--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Return the current text in the balloon.  Only for the string,
-- 		not used for the List.
--- @return string
function vim.fn.balloon_gettext() end

-- Returns the |jumplist| for the specified window.
--
-- 		Without arguments use the current window.
-- 		With {winnr} only use this window in the current tab page.
-- 		{winnr} can also be a |window-ID|.
-- 		With {winnr} and {tabnr} use the window in the specified tab
-- 		page.
--
-- 		The returned list contains two entries: a list with the jump
-- 		locations and the last used jump position number in the list.
-- 		Each entry in the jump location list is a dictionary with
-- 		the following entries:
-- 			bufnr		buffer number
-- 			col		column number
-- 			coladd		column offset for 'virtualedit'
-- 			filename	filename if available
-- 			lnum		line number
--- @return list
function vim.fn.getjumplist(winnr, tabnr) end

-- {not implemented yet}
-- 		Search for a text property as specified with {props}:
-- 		   id		property with this ID
-- 		   type		property with this type name
-- 		   bufnr	buffer to search in; when present a
-- 				start position with "lnum" and "col"
-- 				must be given; when omitted the
-- 				current buffer is used
-- 		   lnum		start in this line (when omitted start
-- 				at the cursor)
-- 		   col		start at this column (when omitted
-- 				and "lnum" is given: use column 1,
-- 				otherwise start at the cursor)
-- 		   skipstart	do not look for a match at the start
-- 				position
--
-- 		{direction} can be "f" for forward and "b" for backward.  When
-- 		omitted forward search is performed.
--
-- 		If a match is found then a Dict is returned with the entries
-- 		as with prop_list(), and additionally an "lnum" entry.
-- 		If no match is found then an empty Dict is returned.
--
-- 		See |text-properties| for information about text properties.
--- @return dict
function vim.fn.prop_find(props, direction) end

-- Checks for the existence of a |cscope| connection.  If no
-- 		parameters are specified, then the function returns:
-- 			0, if cscope was not available (not compiled in), or
-- 			   if there are no cscope connections;
-- 			1, if there is at least one cscope connection.
--
-- 		If parameters are specified, then the value of {num}
-- 		determines how existence of a cscope connection is checked:
--
-- 		{num}	Description of existence check
-- 		-----	------------------------------
-- 		0	Same as no parameters (e.g., "cscope_connection()").
-- 		1	Ignore {prepend}, and use partial string matches for
-- 			{dbpath}.
-- 		2	Ignore {prepend}, and use exact string matches for
-- 			{dbpath}.
-- 		3	Use {prepend}, use partial string matches for both
-- 			{dbpath} and {prepend}.
-- 		4	Use {prepend}, use exact string matches for both
-- 			{dbpath} and {prepend}.
--
-- 		Note: All string comparisons are case sensitive!
--
-- 		Examples.  Suppose we had the following (from ":cs show"): >
--
--   # pid    database name			prepend path
--   0 27664  cscope.out				/usr/local
-- <
-- 		Invocation					Return Val ~
-- 		----------					---------- >
-- 		cscope_connection()					1
-- 		cscope_connection(1, "out")				1
-- 		cscope_connection(2, "out")				0
-- 		cscope_connection(3, "out")				0
-- 		cscope_connection(3, "out", "local")			1
-- 		cscope_connection(4, "out")				0
-- 		cscope_connection(4, "out", "local")			0
-- 		cscope_connection(4, "cscope.out", "/usr/local")	1
-- <
--- @return number
function vim.fn.cscope_connection(num, dbpath, prepend) end

-- Get the channel handle that {job} is using.
-- 		To check if the job has no channel: >
-- 			if string(job_getchannel()) == 'channel fail'
-- <
-- 		Can also be used as a |method|: >
-- 			GetJob()->job_getchannel()
--- @return channel
function vim.fn.job_getchannel(job) end

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

-- Change the current working directory to {dir}.  The scope of
-- 		the directory change depends on the directory of the current
-- 		window:
-- 			- If the current window has a window-local directory
-- 			  (|:lcd|), then changes the window local directory.
-- 			- Otherwise, if the current tabpage has a local
-- 			  directory (|:tcd|) then changes the tabpage local
-- 			  directory.
-- 			- Otherwise, changes the global directory.
-- 		If successful, returns the previous working directory.  Pass
-- 		this to another chdir() to restore the directory.
-- 		On failure, returns an empty string.
--
-- 		Example: >
-- 			let save_dir = chdir(newdir)
-- 			if save_dir != ""
-- 			   " ... do some work
-- 			   call chdir(save_dir)
-- 			endif
--
-- <		Can also be used as a |method|: >
-- 			GetDir()->chdir()
--- @return string
function vim.fn.chdir(dir) end

-- Open the buffer {expr} or jump to the window that contains
-- 		{expr} and position the cursor at sign {id} in group {group}.
-- 		This is similar to the |:sign-jump| command.
--
-- 		For the use of {expr}, see |bufname()|.
--
-- 		Returns the line number of the sign. Returns -1 if the
-- 		arguments are invalid.
--
-- 		Example: >
-- 			" Jump to sign 10 in the current buffer
-- 			call sign_jump(10, '', '')
-- <
--- @return number
function vim.fn.sign_jump(id, group, expr) end

-- Set environment variable {name} to {val}.
-- 		When {val} is |v:null| the environment variable is deleted.
-- 		See also |expr-env|.
--- @return none
function vim.fn.setenv(name, val) end

-- Return non-zero when there is something to read from {handle}.
-- 		{handle} can be a Channel or a Job that has a Channel.
--
-- 		This is useful to read from a channel at a convenient time,
-- 		e.g. from a timer.
--
-- 		Note that messages are dropped when the channel does not have
-- 		a callback.  Add a close callback to avoid that.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_canread()
--- @return number
function vim.fn.ch_canread(handle) end

-- Add {expr} to the list of matches.  Only to be used by the
-- 		function specified with the 'completefunc' option.
-- 		Returns 0 for failure (empty string or out of memory),
-- 		1 when the match was added, 2 when the match was already in
-- 		the list.
-- 		See |complete-functions| for an explanation of {expr}.  It is
-- 		the same as one item in the list that 'omnifunc' would return.
--- @return number
function vim.fn.complete_add(expr) end

-- Clears all matches previously defined for the current window
-- 		by |matchadd()| and the |:match| commands.
--- @return none
function vim.fn.clearmatches() end

-- Return the position and size of popup {id}.  Returns a Dict
-- 		with these entries:
-- 		    col		screen column of the popup, one-based
-- 		    line	screen line of the popup, one-based
-- 		    width	width of the whole popup in screen cells
-- 		    height	height of the whole popup in screen cells
-- 		    core_col	screen column of the text box
-- 		    core_line	screen line of the text box
-- 		    core_width	width of the text box in screen cells
-- 		    core_height	height of the text box in screen cells
-- 		    firstline	line of the buffer at top (1 unless scrolled)
-- 				(not the value of the "firstline" property)
-- 		    lastline	line of the buffer at the bottom (updated when
-- 				the popup is redrawn)
-- 		    scrollbar	non-zero if a scrollbar is displayed
-- 		    visible	one if the popup is displayed, zero if hidden
-- 		Note that these are the actual screen positions.  They differ
-- 		from the values in `popup_getoptions()` for the sizing and
-- 		positioning mechanism applied.
--
-- 		The "core_" values exclude the padding and border.
--
-- 		If popup window {id} is not found an empty Dict is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetPopup()->popup_getpos()
--- @return dict
function vim.fn.popup_getpos(id) end

-- Call function {funcname} in the run-time library {libname}
-- 		with single argument {argument}.
-- 		This is useful to call functions in a library that you
-- 		especially made to be used with Vim.  Since only one argument
-- 		is possible, calling standard library functions is rather
-- 		limited.
-- 		The result is the String returned by the function.  If the
-- 		function returns NULL, this will appear as an empty string ""
-- 		to Vim.
-- 		If the function returns a number, use libcallnr()!
-- 		If {argument} is a number, it is passed to the function as an
-- 		int; if {argument} is a string, it is passed as a
-- 		null-terminated string.
-- 		This function will fail in |restricted-mode|.
--
-- 		libcall() allows you to write your own 'plug-in' extensions to
-- 		Vim without having to recompile the program.  It is NOT a
-- 		means to call system functions!  If you try to do so Vim will
-- 		very probably crash.
--
-- 		For Win32, the functions you write must be placed in a DLL
-- 		and use the normal C calling convention (NOT Pascal which is
-- 		used in Windows System DLLs).  The function must take exactly
-- 		one parameter, either a character pointer or a long integer,
-- 		and must return a character pointer or NULL.  The character
-- 		pointer returned must point to memory that will remain valid
-- 		after the function has returned (e.g. in static data in the
-- 		DLL).  If it points to allocated memory, that memory will
-- 		leak away.  Using a static buffer in the function should work,
-- 		it's then freed when the DLL is unloaded.
--
-- 		WARNING: If the function returns a non-valid pointer, Vim may
-- 		crash!	This also happens if the function returns a number,
-- 		because Vim thinks it's a pointer.
-- 		For Win32 systems, {libname} should be the filename of the DLL
-- 		without the ".DLL" suffix.  A full path is only required if
-- 		the DLL is not in the usual places.
-- 		For Unix: When compiling your own plugins, remember that the
-- 		object code must be compiled as position-independent ('PIC').
-- 		Examples: >
-- 			:echo libcall("libc.so", "getenv", "HOME")
-- <
--- @return string
function vim.fn.libcall(lib, func, arg) end

-- Returns |TRUE| when the wildmenu is active and |FALSE|
-- 		otherwise.  See 'wildmenu' and 'wildmode'.
-- 		This can be used in mappings to handle the 'wildcharm' option
-- 		gracefully. (Makes only sense with |mapmode-c| mappings).
--
-- 		For example to make <c-j> work like <down> in wildmode, use: >
--     :cnoremap <expr> <C-j> wildmenumode() ? "\<Down>\<Tab>" : "\<c-j>"
-- <
-- 		(Note, this needs the 'wildcharm' option set appropriately).
--- @return number
function vim.fn.wildmenumode() end

-- Shorten directory names in the path {expr} and return the
-- 		result.  The tail, the file name, is kept as-is.  The other
-- 		components in the path are reduced to single letters.  Leading
-- 		'~' and '.' characters are kept.  Example: >
-- 			:echo pathshorten('~/.config/nvim/autoload/file1.vim')
-- <			~/.c/n/a/file1.vim ~
-- 		It doesn't matter if the path exists or not.
--- @return string
function vim.fn.pathshorten(expr) end

-- If [expr] is supplied and it evaluates to a non-zero Number or
-- 		a non-empty String (|non-zero-arg|), then the full mode is
-- 		returned, otherwise only the first letter is returned.
--
-- 		   n	    Normal
-- 		   no	    Operator-pending
-- 		   nov	    Operator-pending (forced charwise |o_v|)
-- 		   noV	    Operator-pending (forced linewise |o_V|)
-- 		   noCTRL-V Operator-pending (forced blockwise |o_CTRL-V|)
-- 		   niI	    Normal using |i_CTRL-O| in |Insert-mode|
-- 		   niR	    Normal using |i_CTRL-O| in |Replace-mode|
-- 		   niV	    Normal using |i_CTRL-O| in |Virtual-Replace-mode|
-- 		   v	    Visual by character
-- 		   V	    Visual by line
-- 		   CTRL-V   Visual blockwise
-- 		   s	    Select by character
-- 		   S	    Select by line
-- 		   CTRL-S   Select blockwise
-- 		   i	    Insert
-- 		   ic	    Insert mode completion |compl-generic|
-- 		   ix	    Insert mode |i_CTRL-X| completion
-- 		   R	    Replace |R|
-- 		   Rc	    Replace mode completion |compl-generic|
-- 		   Rv	    Virtual Replace |gR|
-- 		   Rx	    Replace mode |i_CTRL-X| completion
-- 		   c	    Command-line editing
-- 		   cv	    Vim Ex mode |gQ|
-- 		   ce	    Normal Ex mode |Q|
-- 		   r	    Hit-enter prompt
-- 		   rm	    The -- more -- prompt
-- 		   r?	    |:confirm| query of some sort
-- 		   !	    Shell or external command is executing
-- 		   t	    Terminal mode: keys go to the job
-- 		This is useful in the 'statusline' option or when used
-- 		with |remote_expr()| In most other places it always returns
-- 		"c" or "n".
-- 		Note that in the future more modes and more specific modes may
-- 		be added. It's better not to compare the whole string but only
-- 		the leading character(s).
-- 		Also see |visualmode()|.
--- @return string
function vim.fn.mode(expr) end

-- Create a timer and return the timer ID.
--
-- 		{time} is the waiting time in milliseconds. This is the
-- 		minimum time before invoking the callback.  When the system is
-- 		busy or Vim is not waiting for input the time will be longer.
--
-- 		{callback} is the function to call.  It can be the name of a
-- 		function or a |Funcref|.  It is called with one argument, which
-- 		is the timer ID.  The callback is only invoked when Vim is
-- 		waiting for input.
--
-- 		{options} is a dictionary.  Supported entries:
-- 		   "repeat"	Number of times to repeat the callback.
-- 				-1 means forever.  Default is 1.
-- 				If the timer causes an error three times in a
-- 				row the repeat is cancelled.
--
-- 		Example: >
-- 			func MyHandler(timer)
-- 			  echo 'Handler called'
-- 			endfunc
-- 			let timer = timer_start(500, 'MyHandler',
-- 				\ {'repeat': 3})
-- <		This invokes MyHandler() three times at 500 msec intervals.
--- @return number
function vim.fn.timer_start(time, callback, options) end

-- When {text} is a |List|: Append each item of the |List| as a
-- 		text line below line {lnum} in the current buffer.
-- 		Otherwise append {text} as one text line below line {lnum} in
-- 		the current buffer.
-- 		{lnum} can be zero to insert a line before the first one.
-- 		Returns 1 for failure ({lnum} out of range or out of memory),
-- 		0 for success.  Example: >
-- 			:let failed = append(line('$'), "# THE END")
-- 			:let failed = append(0, ["Chapter 1", "the beginning"])
--- @param list any[]
--- @return number
function vim.fn.append(lnum, list) end

-- Get a list of defined signs and their attributes.
-- 		This is similar to the |:sign-list| command.
--
-- 		If the {name} is not supplied, then a list of all the defined
-- 		signs is returned. Otherwise the attribute of the specified
-- 		sign is returned.
--
-- 		Each list item in the returned value is a dictionary with the
-- 		following entries:
-- 			icon	full path to the bitmap file of the sign
-- 			linehl	highlight group used for the whole line the
-- 				sign is placed in.
-- 			name	name of the sign
-- 			text	text that is displayed when there is no icon
-- 				or the GUI is not being used.
-- 			texthl	highlight group used for the text item
-- 			numhl	highlight group used for 'number' column at the
-- 				associated line. Overrides |hl-LineNr|,
-- 				|hl-CursorLineNr|.
--
-- 		Returns an empty List if there are no signs and when {name} is
-- 		not found.
--
-- 		Examples: >
-- 			" Get a list of all the defined signs
-- 			echo sign_getdefined()
--
-- 			" Get the attribute of the sign named mySign
-- 			echo sign_getdefined("mySign")
--- @return list
function vim.fn.sign_getdefined(name) end

-- Send keystrokes {keys} to terminal {buf}.
-- 		{buf} is used as with |term_getsize()|.
--
-- 		{keys} are translated as key sequences. For example, "\<c-x>"
-- 		means the character CTRL-X.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_sendkeys(keys)
--- @return none
function vim.fn.term_sendkeys(buf, keys) end

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

-- Waits for jobs and their |on_exit| handlers to complete.
--
-- 		{jobs} is a List of |job-id|s to wait for.
-- 		{timeout} is the maximum waiting time in milliseconds, -1
-- 		means forever.
--
-- 		Timeout of 0 can be used to check the status of a job: >
-- 			let running = jobwait([{job-id}], 0)[0] == -1
-- <
-- 		During jobwait() callbacks for jobs not in the {jobs} list may
-- 		be invoked. The screen will not redraw unless |:redraw| is
-- 		invoked by a callback.
--
-- 		Returns a list of len({jobs}) integers, where each integer is
-- 		the status of the corresponding job:
-- 			Exit-code, if the job exited
-- 			-1 if the timeout was exceeded
-- 			-2 if the job was interrupted (by |CTRL-C|)
-- 			-3 if the job-id is invalid
--- @return number
function vim.fn.jobwait(ids, timeout) end

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

-- Returns 1 if the terminal of {buf} is using the alternate
-- 		screen.
-- 		{buf} is used as with |term_getsize()|.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getaltscreen()
--- @return number
function vim.fn.term_getaltscreen(buf) end

-- defined, zero otherwise.
--
-- 		For checking for a supported feature use |has()|.
-- 		For checking if a file exists use |filereadable()|.
--
-- 		The {expr} argument is a string, which contains one of these:
-- 			&option-name	Vim option (only checks if it exists,
-- 					not if it really works)
-- 			+option-name	Vim option that works.
-- 			$ENVNAME	environment variable (could also be
-- 					done by comparing with an empty
-- 					string)
-- 			*funcname	built-in function (see |functions|)
-- 					or user defined function (see
-- 					|user-function|). Also works for a
-- 					variable that is a Funcref.
-- 			varname		internal variable (see
-- 					|internal-variables|).  Also works
-- 					for |curly-braces-names|, |Dictionary|
-- 					entries, |List| items, etc.  Beware
-- 					that evaluating an index may cause an
-- 					error message for an invalid
-- 					expression.  E.g.: >
-- 					   :let l = [1, 2, 3]
-- 					   :echo exists("l[5]")
-- <					   0 >
-- 					   :echo exists("l[xx]")
-- <					   E121: Undefined variable: xx
-- 					   0
-- 			:cmdname	Ex command: built-in command, user
-- 					command or command modifier |:command|.
-- 					Returns:
-- 					1  for match with start of a command
-- 					2  full match with a command
-- 					3  matches several user commands
-- 					To check for a supported command
-- 					always check the return value to be 2.
-- 			:2match		The |:2match| command.
-- 			:3match		The |:3match| command.
-- 			#event		autocommand defined for this event
-- 			#event#pattern	autocommand defined for this event and
-- 					pattern (the pattern is taken
-- 					literally and compared to the
-- 					autocommand patterns character by
-- 					character)
-- 			#group		autocommand group exists
-- 			#group#event	autocommand defined for this group and
-- 					event.
-- 			#group#event#pattern
-- 					autocommand defined for this group,
-- 					event and pattern.
-- 			##event		autocommand for this event is
-- 					supported.
--
-- 		Examples: >
-- 			exists("&mouse")
-- 			exists("$HOSTNAME")
-- 			exists("*strftime")
-- 			exists("*s:MyFunc")
-- 			exists("bufcount")
-- 			exists(":Make")
-- 			exists("#CursorHold")
-- 			exists("#BufReadPre#*.gz")
-- 			exists("#filetypeindent")
-- 			exists("#filetypeindent#FileType")
-- 			exists("#filetypeindent#FileType#*")
-- 			exists("##ColorScheme")
-- <		There must be no space between the symbol (&/$/*/#) and the
-- 		name.
-- 		There must be no extra characters after the name, although in
-- 		a few cases this is ignored.  That may become more strict in
-- 		the future, thus don't count on it!
-- 		Working example: >
-- 			exists(":make")
-- <		NOT working example: >
-- 			exists(":make install")
--
-- <		Note that the argument must be a string, not the name of the
-- 		variable itself.  For example: >
-- 			exists(bufcount)
-- <		This doesn't check for existence of the "bufcount" variable,
-- 		but gets the value of "bufcount", and checks if that exists.
--- @return number
function vim.fn.exists(expr) end

-- Return the hyperbolic sine of {expr} as a |Float| in the range
-- 		[-inf, inf].
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo sinh(0.5)
-- <			0.521095 >
-- 			:echo sinh(-0.9)
-- <			-1.026517
--- @return float
function vim.fn.sinh(expr) end

-- Open a new window displaying the contents of {filename}
-- 		The file must have been created with |term_dumpwrite()|.
-- 		Returns the buffer number or zero when it fails.
-- 		Also see |terminal-diff|.
--
-- 		For {options} see |term_dumpdiff()|.
--
-- 		Can also be used as a |method|: >
-- 			GetFilename()->term_dumpload()
-- <
--- @return number
function vim.fn.term_dumpload(filename, options) end

-- Send {expr} over {handle}.  The {expr} is encoded
-- 		according to the type of channel.  The function cannot be used
-- 		with a raw channel.
-- 		See |channel-use|.				*E912*
-- 		{handle} can be a Channel or a Job that has a Channel.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_sendexpr(expr)
function vim.fn.ch_sendexpr(handle, expr, options) end

-- Returns non-zero when the popup menu is visible, zero
-- 		otherwise.  See |ins-completion-menu|.
-- 		This can be used to avoid some things that would remove the
-- 		popup menu.
--- @return number
function vim.fn.pumvisible() end

-- Stop playing all sounds.
-- 		{only available when compiled with the |+sound| feature}
--- @return none
function vim.fn.sound_clear() end

-- Deactivates UI events on the channel.
--
--                 Removes the client from the list of UIs. |nvim_list_uis()|
function vim.fn.nvim_ui_detach() end

-- Stop |job-id| {id} by sending SIGTERM to the job process. If
-- 		the process does not terminate after a timeout then SIGKILL
-- 		will be sent. When the job terminates its |on_exit| handler
-- 		(if any) will be invoked.
-- 		See |job-control|.
--
-- 		Returns 1 for valid job id, 0 for invalid id, including jobs have
-- 		exited or stopped.
--- @return number
function vim.fn.jobstop(id) end

-- Return the current |command-line-window| type. Possible return
-- 		values are the same as |getcmdtype()|. Returns an empty string
-- 		when not in the command-line window.
--- @return string
function vim.fn.getcmdwintype() end

-- window.  The top window has number 1.
--
-- 		The optional argument {arg} supports the following values:
-- 			$	the number of the last window (the window
-- 				count).
-- 			#	the number of the last accessed window (where
-- 				|CTRL-W_p| goes to).  If there is no previous
-- 				window or it is in another tab page 0 is
-- 				returned.
-- 			{N}j	the number of the Nth window below the
-- 				current window (where |CTRL-W_j| goes to).
-- 			{N}k	the number of the Nth window above the current
-- 				window (where |CTRL-W_k| goes to).
-- 			{N}h	the number of the Nth window left of the
-- 				current window (where |CTRL-W_h| goes to).
-- 			{N}l	the number of the Nth window right of the
-- 				current window (where |CTRL-W_l| goes to).
-- 		The number can be used with |CTRL-W_w| and ":wincmd w"
-- 		|:wincmd|.
-- 		Also see |tabpagewinnr()| and |win_getid()|.
-- 		Examples: >
-- 			let window_count = winnr('$')
-- 			let prev_window = winnr('#')
-- 			let wnum = winnr('3k')
-- <
--- @return number
function vim.fn.winnr(expr) end

-- Expand special items in {expr} like what is done for an Ex
-- 		command such as `:edit`.  This expands special keywords, like
-- 		with |expand()|, and environment variables, anywhere in
-- 		{expr}.  Returns the expanded string.
-- 		Example: >
-- 			:echo expandcmd('make %<.o')
--- @return string
function vim.fn.expandcmd(expr) end

-- the current window sizes.  Only works properly when no windows
-- 		are opened or closed and the current window and tab page is
-- 		unchanged.
-- 		Example: >
-- 			:let cmd = winrestcmd()
-- 			:call MessWithWindowSizes()
-- 			:exe cmd
-- <
--- @return string
function vim.fn.winrestcmd() end

-- the first file.  argc() - 1 is the last one.  See |arglist|.
--- @return number
function vim.fn.argidx() end

-- Just like |libcall()|, but used for a function that returns an
-- 		int instead of a string.
-- 		Examples: >
-- 			:echo libcallnr("/usr/lib/libc.so", "getpid", "")
-- 			:call libcallnr("libc.so", "printf", "Hello World!\n")
-- 			:call libcallnr("libc.so", "sleep", 10)
-- <
--- @return number
function vim.fn.libcallnr(lib, func, arg) end

-- Return the number of the most recent change.  This is the same
-- 		number as what is displayed with |:undolist| and can be used
-- 		with the |:undo| command.
-- 		When a change was made it is the number of that change.  After
-- 		redo it is the number of the redone change.  After undo it is
-- 		one less than the number of the undone change.
--- @return number
function vim.fn.changenr() end

-- Escape the characters in {chars} that occur in {string} with a
-- 		backslash.  Example: >
-- 			:echo escape('c:\program files\vim', ' \')
-- <		results in: >
-- 			c:\\program\ files\\vim
-- <		Also see |shellescape()| and |fnameescape()|.
--- @return string
function vim.fn.escape(string, chars) end

-- position given with {expr}.  The accepted positions are:
-- 		    .	    the cursor position
-- 		    $	    the last line in the current buffer
-- 		    'x	    position of mark x (if the mark is not set, 0 is
-- 			    returned)
-- 		    w0	    first line visible in current window (one if the
-- 			    display isn't updated, e.g. in silent Ex mode)
-- 		    w$	    last line visible in current window (this is one
-- 			    less than "w0" if no lines are visible)
-- 		    v	    In Visual mode: the start of the Visual area (the
-- 			    cursor is the end).  When not in Visual mode
-- 			    returns the cursor position.  Differs from |'<| in
-- 			    that it's updated right away.
-- 		Note that a mark in another file can be used.  The line number
-- 		then applies to another buffer.
-- 		To get the column number use |col()|.  To get both use
-- 		|getpos()|.
-- 		Examples: >
-- 			line(".")		line number of the cursor
-- 			line("'t")		line number of mark t
-- 			line("'" . marker)	line number of mark marker
--- @return number
function vim.fn.line(expr) end

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

-- Bitwise XOR on the two arguments.  The arguments are converted
-- 		to a number.  A List, Dict or Float argument causes an error.
-- 		Example: >
-- 			:let bits = xor(bits, 0x80)
-- <
--- @return number
function vim.fn.xor(expr, expr) end

-- The result is a nested List containing the layout of windows
-- 		in a tabpage.
--
-- 		Without {tabnr} use the current tabpage, otherwise the tabpage
-- 		with number {tabnr}. If the tabpage {tabnr} is not found,
-- 		returns an empty list.
--
-- 		For a leaf window, it returns:
-- 			['leaf', {winid}]
-- 		For horizontally split windows, which form a column, it
-- 		returns:
-- 			['col', [{nested list of windows}]]
-- 		For vertically split windows, which form a row, it returns:
-- 			['row', [{nested list of windows}]]
--
-- 		Example: >
-- 			" Only one window in the tab page
-- 			:echo winlayout()
-- 			['leaf', 1000]
-- 			" Two horizontally split windows
-- 			:echo winlayout()
-- 			['col', [['leaf', 1000], ['leaf', 1001]]]
-- 			" Three horizontally split windows, with two
-- 			" vertically split windows in the middle window
-- 			:echo winlayout(2)
-- 			['col', [['leaf', 1002], ['row', ['leaf', 1003],
-- 					     ['leaf', 1001]]], ['leaf', 1000]]
-- <
--- @return list
function vim.fn.winlayout(tabnr) end

-- Like |winnr()| but for tab page {tabarg}.
-- 		{tabarg} specifies the number of tab page to be used.
-- 		{arg} is used like with |winnr()|:
-- 		- When omitted the current window number is returned.  This is
-- 		  the window which will be used when going to this tab page.
-- 		- When "$" the number of windows is returned.
-- 		- When "#" the previous window nr is returned.
-- 		Useful examples: >
-- 		    tabpagewinnr(1)	    " current window of tab page 1
-- 		    tabpagewinnr(4, '$')    " number of windows in tab page 4
-- <		When {tabarg} is invalid zero is returned.
--- @return number
function vim.fn.tabpagewinnr(tabarg, arg) end

-- Run {cmd} and add an error message to |v:errors| if it does
-- 		NOT produce an error.  Also see |assert-return|.
-- 		When {error} is given it must match in |v:errmsg|.
-- 		Note that beeping is not considered an error, and some failing
-- 		commands only beep.  Use |assert_beeps()| for those.
--- @return number
function vim.fn.assert_fails(cmd, error) end

-- Return the value of environment variable {name}.
-- 		When the variable does not exist |v:null| is returned.  That
-- 		is different from a variable set to an empty string.
-- 		See also |expr-env|.
--- @return string
function vim.fn.getenv(name) end

-- Show the {what} above the cursor, and close it when the cursor
-- 		moves.  This works like: >
-- 			call popup_create({what}, #{
-- 				\ pos: 'botleft',
-- 				\ line: 'cursor-1',
-- 				\ col: 'cursor',
-- 				\ moved: 'WORD',
-- 				\ })
-- <		Use {options} to change the properties.
-- 		If "pos" is passed as "topleft" then the default for "line"
-- 		becomes "cursor+1".
--
-- 		Can also be used as a |method|: >
-- 			GetText()->popup_atcursor({})
--- @return number
function vim.fn.popup_atcursor(what, options) end

-- Without {end}: Remove the item at {idx} from |List| {list} and
-- 		return the item.
-- 		With {end}: Remove items from {idx} to {end} (inclusive) and
-- 		return a List with these items.  When {idx} points to the same
-- 		item as {end} a list with one item is returned.  When {end}
-- 		points to an item before {idx} this is an error.
-- 		See |list-index| for possible values of {idx} and {end}.
-- 		Example: >
-- 			:echo "last item: " . remove(mylist, -1)
-- 		Remove the entry from {dict} with key {key} and return it.
-- 		Example: >
-- 			:echo "removed " . remove(dict, "one")
-- <		If there is no {key} in {dict} this is an error.
--
-- 		Use |delete()| to remove a file.
--- @param dict dictionary
function vim.fn.remove(dict, key) end

-- Get the value of an internal variable.  These values for
-- 		{name} are supported:
-- 			need_fileinfo
--
-- 		Can also be used as a |method|: >
-- 			GetName()->test_getvalue()
function vim.fn.test_getvalue(string) end

-- Get the |window-ID| for the popup preview window.
-- 		Return zero if there is none.
--- @return number
function vim.fn.popup_findpreview() end

-- Convert {expr} into a JSON string.  Accepts
-- 		|msgpack-special-dict| as the input.  Will not convert
-- 		|Funcref|s, mappings with non-string keys (can be created as
-- 		|msgpack-special-dict|), values with self-referencing
-- 		containers, strings which contain non-UTF-8 characters,
-- 		pseudo-UTF-8 strings which contain codepoints reserved for
-- 		surrogate pairs (such strings are not valid UTF-8 strings).
-- 		Non-printable characters are converted into "\u1234" escapes
-- 		or special escapes like "\t", other are dumped as-is.
--- @return string
function vim.fn.json_encode(expr) end

-- The result is a Number, which is the number of the current
-- 		tab page.  The first tab page has number 1.
-- 		The optional argument {arg} supports the following values:
-- 			$	the number of the last tab page (the tab page
-- 				count).
-- 			#	the number of the last accessed tab page (where
-- 				|g<Tab>| goes to).  If there is no previous
-- 				tab page, 0 is returned.
-- 		The number can be used with the |:tab| command.
--- @return number
function vim.fn.tabpagenr(arg) end

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

-- Read file {fname} and return a |List|, each line of the file
-- 		as an item.  Lines are broken at NL characters.  Macintosh
-- 		files separated with CR will result in a single long line
-- 		(unless a NL appears somewhere).
-- 		All NUL characters are replaced with a NL character.
-- 		When {binary} contains "b" binary mode is used:
-- 		- When the last line ends in a NL an extra empty list item is
-- 		  added.
-- 		- No CR characters are removed.
-- 		Otherwise:
-- 		- CR characters that appear before a NL are removed.
-- 		- Whether the last line ends in a NL or not does not matter.
-- 		- Any UTF-8 byte order mark is removed from the text.
-- 		When {max} is given this specifies the maximum number of lines
-- 		to be read.  Useful if you only want to check the first ten
-- 		lines of a file: >
-- 			:for line in readfile(fname, '', 10)
-- 			:  if line =~ 'Date' | echo line | endif
-- 			:endfor
-- <		When {max} is negative -{max} lines from the end of the file
-- 		are returned, or as many as there are.
-- 		When {max} is zero the result is an empty list.
-- 		Note that without {max} the whole file is read into memory.
-- 		Also note that there is no recognition of encoding.  Read a
-- 		file into a buffer if you need to.
-- 		When the file can't be opened an error message is given and
-- 		the result is an empty list.
-- 		Also see |writefile()|.
--- @return list
function vim.fn.readfile(fname, binary, max) end

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

-- The result is a String, which is the name of the machine on
-- 		which Vim is currently running.  Machine names greater than
-- 		256 characters long are truncated.
--- @return string
function vim.fn.hostname() end

-- Simplify the file name as much as possible without changing
-- 		the meaning.  Shortcuts (on MS-Windows) or symbolic links (on
-- 		Unix) are not resolved.  If the first path component in
-- 		{filename} designates the current directory, this will be
-- 		valid for the result as well.  A trailing path separator is
-- 		not removed either.
-- 		Example: >
-- 			simplify("./dir/.././/file/") == "./file/"
-- <		Note: The combination "dir/.." is only removed if "dir" is
-- 		a searchable directory or does not exist.  On Unix, it is also
-- 		removed when "dir" is a symbolic link within the same
-- 		directory.  In order to resolve all the involved symbolic
-- 		links before simplifying the path name, use |resolve()|.
--- @return string
function vim.fn.simplify(filename) end

-- Return the logarithm of Float {expr} to base 10 as a |Float|.
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo log10(1000)
-- <			3.0 >
-- 			:echo log10(0.01)
-- <			-2.0
--- @return float
function vim.fn.log10(expr) end

-- Return a list containing the number values which represent
-- 		each character in String {expr}.  Examples: >
-- 			str2list(" ")		returns [32]
-- 			str2list("ABC")		returns [65, 66, 67]
-- <		|list2str()| does the opposite.
--
-- 		When {utf8} is omitted or zero, the current 'encoding' is used.
-- 		With {utf8} set to 1, always treat the String as utf-8
-- 		characters.  With utf-8 composing characters are handled
-- 		properly: >
-- 			str2list("á")		returns [97, 769]
--- @return list
function vim.fn.str2list(expr, utf8) end

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

-- {expr1} and {expr2} must be both |Lists| or both
-- 		|Dictionaries|.
--
-- 		If they are |Lists|: Append {expr2} to {expr1}.
-- 		If {expr3} is given insert the items of {expr2} before item
-- 		{expr3} in {expr1}.  When {expr3} is zero insert before the
-- 		first item.  When {expr3} is equal to len({expr1}) then
-- 		{expr2} is appended.
-- 		Examples: >
-- 			:echo sort(extend(mylist, [7, 5]))
-- 			:call extend(mylist, [2, 3], 1)
-- <		When {expr1} is the same List as {expr2} then the number of
-- 		items copied is equal to the original length of the List.
-- 		E.g., when {expr3} is 1 you get N new copies of the first item
-- 		(where N is the original length of the List).
-- 		Use |add()| to concatenate one item to a list.  To concatenate
-- 		two lists into a new list use the + operator: >
-- 			:let newlist = [1, 2, 3] + [4, 5]
-- <
-- 		If they are |Dictionaries|:
-- 		Add all entries from {expr2} to {expr1}.
-- 		If a key exists in both {expr1} and {expr2} then {expr3} is
-- 		used to decide what to do:
-- 		{expr3} = "keep": keep the value of {expr1}
-- 		{expr3} = "force": use the value of {expr2}
-- 		{expr3} = "error": give an error message		*E737*
-- 		When {expr3} is omitted then "force" is assumed.
--
-- 		{expr1} is changed when {expr2} is not empty.  If necessary
-- 		make a copy of {expr1} first.
-- 		{expr2} remains unchanged.
-- 		When {expr1} is locked and {expr2} is not empty the operation
-- 		fails.
-- 		Returns {expr1}.
--- @return list/dict
function vim.fn.extend(expr1, expr2, expr3) end

-- Set option or local variable {varname} in window {winnr} to
-- 		{val}.
-- 		Tabs are numbered starting with one.  For the current tabpage
-- 		use |setwinvar()|.
-- 		{winnr} can be the window number or the |window-ID|.
-- 		When {winnr} is zero the current window is used.
-- 		This also works for a global or local buffer option, but it
-- 		doesn't work for a global or local buffer variable.
-- 		For a local buffer option the global value is unchanged.
-- 		Note that the variable name without "w:" must be used.
-- 		Examples: >
-- 			:call settabwinvar(1, 1, "&list", 0)
-- 			:call settabwinvar(3, 2, "myvar", "foobar")
-- <		This function is not available in the |sandbox|.
--- @return set
function vim.fn.settabwinvar(tabnr, winnr, varname, val) end

-- Evaluate Python expression {expr} and return its result
-- 		converted to Vim data structures.
-- 		Uses Python 2 or 3, see |python_x| and 'pyxversion'.
-- 		See also: |pyeval()|, |py3eval()|
function vim.fn.pyxeval(expr) end

-- Returns a |String| which is a unique identifier of the
-- 		container type (|List|, |Dict| and |Partial|). It is
-- 		guaranteed that for the mentioned types `id(v1) ==# id(v2)`
-- 		returns true iff `type(v1) == type(v2) && v1 is v2` (note:
-- 		|v:_null_list| and |v:_null_dict| have the same `id()` with
-- 		different types because they are internally represented as
-- 		a NULL pointers). Currently `id()` returns a hexadecimal
-- 		representanion of the pointers to the containers (i.e. like
-- 		`0x994a40`), same as `printf("%p", {expr})`, but it is advised
-- 		against counting on exact format of return value.
--
-- 		It is not guaranteed that `id(no_longer_existing_container)`
-- 		will not be equal to some other `id()`: new containers may
-- 		reuse identifiers of the garbage-collected ones.
--- @return string
function vim.fn.id(expr) end

-- The result is a copy of the String given, with all lowercase
-- 		characters turned into uppercase (just like applying |gU| to
-- 		the string).
--- @return string
function vim.fn.toupper(expr) end

-- Open a channel to {address}.  See |channel|.
-- 		Returns a Channel.  Use |ch_status()| to check for failure.
--
-- 		{address} has the form "hostname:port", e.g.,
-- 		"localhost:8765".
--
-- 		If {options} is given it must be a |Dictionary|.
-- 		See |channel-open-options|.
--
-- 		Can also be used as a |method|: >
-- 			GetAddress()->ch_open()
--- @return channel
function vim.fn.ch_open(address, options) end

-- This function acts much like the |input()| function with but
-- 		two exceptions:
-- 		a) the user's response will be displayed as a sequence of
-- 		asterisks ("*") thereby keeping the entry secret, and
-- 		b) the user's response will not be recorded on the input
-- 		|history| stack.
-- 		The result is a String, which is whatever the user actually
-- 		typed on the command-line in response to the issued prompt.
-- 		NOTE: Command-line completion is not supported.
--- @return string
function vim.fn.inputsecret(prompt, text) end

-- Return the name of the undo file that would be used for a file
-- 		with name {name} when writing.  This uses the 'undodir'
-- 		option, finding directories that exist.  It does not check if
-- 		the undo file exists.
-- 		{name} is always expanded to the full path, since that is what
-- 		is used internally.
-- 		If {name} is empty undofile() returns an empty string, since a
-- 		buffer without a file name will not write an undo file.
-- 		Useful in combination with |:wundo| and |:rundo|.
-- 		When compiled without the |+persistent_undo| option this always
-- 		returns an empty string.
--- @return string
function vim.fn.undofile(name) end

-- Get character {index} from {str}.  This uses a character
-- 		index, not a byte index.  Composing characters are considered
-- 		separate characters here.
-- 		Also see |strcharpart()| and |strchars()|.
--- @return number
function vim.fn.strgetchar(str, index) end

-- Get the Job associated with {channel}.
-- 		If there is no job calling |job_status()| on the returned Job
-- 		will result in "fail".
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_getjob()
--- @return job
function vim.fn.ch_getjob(channel) end

-- The result is the Number of the current entry in {history}.
-- 		See |hist-names| for the possible values of {history}.
-- 		If an error occurred, -1 is returned.
--
-- 		Example: >
-- 			:let inp_index = histnr("expr")
--- @return number
function vim.fn.histnr(history) end

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

-- The result is a Number, which is the number of display cells
-- 		String {expr} occupies.  A Tab character is counted as one
-- 		cell, alternatively use |strdisplaywidth()|.
-- 		When {expr} contains characters with East Asian Width Class
-- 		Ambiguous, this function's return value depends on 'ambiwidth'.
-- 		Also see |strlen()|, |strdisplaywidth()| and |strchars()|.
--- @return number
function vim.fn.strwidth(expr) end

