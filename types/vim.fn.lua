--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Returns a list with all the current quickfix errors.  Each
-- 		list item is a dictionary with these entries:
-- 			bufnr	number of buffer that has the file name, use
-- 				bufname() to get the name
-- 			module	module name
-- 			lnum	line number in the buffer (first line is 1)
-- 			col	column number (first column is 1)
-- 			vcol	|TRUE|: "col" is visual column
-- 				|FALSE|: "col" is byte index
-- 			nr	error number
-- 			pattern	search pattern used to locate the error
-- 			text	description of the error
-- 			type	type of the error, 'E', '1', etc.
-- 			valid	|TRUE|: recognized error message
--
-- 		When there is no error list or it's empty, an empty list is
-- 		returned. Quickfix list entries with non-existing buffer
-- 		number are returned with "bufnr" set to zero.
--
-- 		Useful application: Find pattern matches in multiple files and
-- 		do something with them: >
-- 			:vimgrep /theword/jg *.c
-- 			:for d in getqflist()
-- 			:   echo bufname(d.bufnr) ':' d.lnum '=' d.text
-- 			:endfor
-- <
-- 		If the optional {what} dictionary argument is supplied, then
-- 		returns only the items listed in {what} as a dictionary. The
-- 		following string items are supported in {what}:
-- 			changedtick	get the total number of changes made
-- 					to the list |quickfix-changedtick|
-- 			context	get the |quickfix-context|
-- 			efm	errorformat to use when parsing "lines". If
-- 				not present, then the 'errorformat' option
-- 				value is used.
-- 			id	get information for the quickfix list with
-- 				|quickfix-ID|; zero means the id for the
-- 				current list or the list specified by "nr"
-- 			idx	index of the current entry in the list
-- 			items	quickfix list entries
-- 			lines	parse a list of lines using 'efm' and return
-- 				the resulting entries.  Only a |List| type is
-- 				accepted.  The current quickfix list is not
-- 				modified. See |quickfix-parse|.
-- 			nr	get information for this quickfix list; zero
-- 				means the current quickfix list and "$" means
-- 				the last quickfix list
-- 			size	number of entries in the quickfix list
-- 			title	get the list title |quickfix-title|
-- 			winid	get the quickfix |window-ID|
-- 			all	all of the above quickfix properties
-- 		Non-string items in {what} are ignored. To get the value of a
-- 		particular item, set it to zero.
-- 		If "nr" is not present then the current quickfix list is used.
-- 		If both "nr" and a non-zero "id" are specified, then the list
-- 		specified by "id" is used.
-- 		To get the number of lists in the quickfix stack, set "nr" to
-- 		"$" in {what}. The "nr" value in the returned dictionary
-- 		contains the quickfix stack size.
-- 		When "lines" is specified, all the other items except "efm"
-- 		are ignored.  The returned dictionary contains the entry
-- 		"items" with the list of entries.
--
-- 		The returned dictionary contains the following entries:
-- 			changedtick	total number of changes made to the
-- 					list |quickfix-changedtick|
-- 			context	quickfix list context. See |quickfix-context|
-- 				If not present, set to "".
-- 			id	quickfix list ID |quickfix-ID|. If not
-- 				present, set to 0.
-- 			idx	index of the current entry in the list. If not
-- 				present, set to 0.
-- 			items	quickfix list entries. If not present, set to
-- 				an empty list.
-- 			nr	quickfix list number. If not present, set to 0
-- 			size	number of entries in the quickfix list. If not
-- 				present, set to 0.
-- 			title	quickfix list title text. If not present, set
-- 				to "".
-- 			winid	quickfix |window-ID|. If not present, set to 0
--
-- 		Examples (See also |getqflist-examples|): >
-- 			:echo getqflist({'all': 1})
-- 			:echo getqflist({'nr': 2, 'title': 1})
-- 			:echo getqflist({'lines' : ["F1:10:L10"]})
--- @return list
function vim.fn.getqflist(what) end

-- Returns a list with all the entries in the location list for
-- 		window {nr}.  {nr} can be the window number or the |window-ID|.
-- 		When {nr} is zero the current window is used.
--
-- 		For a location list window, the displayed location list is
-- 		returned.  For an invalid window number {nr}, an empty list is
-- 		returned. Otherwise, same as |getqflist()|.
--
-- 		If the optional {what} dictionary argument is supplied, then
-- 		returns the items listed in {what} as a dictionary. Refer to
-- 		|getqflist()| for the supported items in {what}.
-- 		If {what} contains 'filewinid', then returns the id of the
-- 		window used to display files from the location list. This
-- 		field is applicable only when called from a location list
-- 		window.
--- @return list
function vim.fn.getloclist(nr, what) end

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

-- Preserve typeahead (also from mappings) and clear it, so that
-- 		a following prompt gets input from the user.  Should be
-- 		followed by a matching inputrestore() after the prompt.  Can
-- 		be used several times, in which case there must be just as
-- 		many inputrestore() calls.
-- 		Returns 1 when out of memory, 0 otherwise.
--- @return number
function vim.fn.inputsave() end

-- Restore typeahead that was saved with a previous |inputsave()|.
-- 		Should be called the same number of times inputsave() is
-- 		called.  Calling it more often is harmless though.
-- 		Returns 1 when there is nothing to restore, 0 otherwise.
--- @return number
function vim.fn.inputrestore() end

-- Set the register {regname} to {value}.
-- 		{value} may be any value returned by |getreg()|, including
-- 		a |List|.
-- 		If {options} contains "a" or {regname} is upper case,
-- 		then the value is appended.
-- 		{options} can also contain a register type specification:
-- 		    "c" or "v"	      |charwise| mode
-- 		    "l" or "V"	      |linewise| mode
-- 		    "b" or "<CTRL-V>" |blockwise-visual| mode
-- 		If a number immediately follows "b" or "<CTRL-V>" then this is
-- 		used as the width of the selection - if it is not specified
-- 		then the width of the block is set to the number of characters
-- 		in the longest line (counting a <Tab> as 1 character).
-- 		If {options} contains "u" or '"', then the unnamed register is
-- 		set to point to register {regname}.
--
-- 		If {options} contains no register settings, then the default
-- 		is to use character mode unless {value} ends in a <NL> for
-- 		string {value} and linewise mode for list {value}. Blockwise
-- 		mode is never selected automatically.
-- 		Returns zero for success, non-zero for failure.
--
-- 							*E883*
-- 		Note: you may not use |List| containing more than one item to
-- 		      set search and expression registers. Lists containing no
-- 		      items act like empty strings.
--
-- 		Examples: >
-- 			:call setreg(v:register, @*)
-- 			:call setreg('*', @%, 'ac')
-- 			:call setreg('a', "1\n2\n3", 'b5')
--
-- <		This example shows using the functions to save and restore a
-- 		register: >
-- 			:let var_a = getreg('a', 1, 1)
-- 			:let var_amode = getregtype('a')
-- 			    ....
-- 			:call setreg('a', var_a, var_amode)
-- <		Note: you may not reliably restore register value
-- 		without using the third argument to |getreg()| as without it
-- 		newlines are represented as newlines AND Nul bytes are
-- 		represented as newlines as well, see |NL-used-for-Nul|.
--
-- 		You can also change the type of a register by appending
-- 		nothing: >
-- 			:call setreg('a', '', 'al')
--- @return number
function vim.fn.setreg(n, v, opt) end

-- The result is a String, which is type of register {regname}.
-- 		The value will be one of:
-- 		    "v"			for |charwise| text
-- 		    "V"			for |linewise| text
-- 		    "<CTRL-V>{width}"	for |blockwise-visual| text
-- 		    ""			for an empty or unknown register
-- 		<CTRL-V> is one character with value 0x16.
-- 		If {regname} is not specified, |v:register| is used.
--- @return string
function vim.fn.getregtype(regname) end

-- Perform glob() on all directories in {path} and concatenate
-- 		the results.  Example: >
-- 			:echo globpath(&rtp, "syntax/c.vim")
-- <
-- 		{path} is a comma-separated list of directory names.  Each
-- 		directory name is prepended to {expr} and expanded like with
-- 		|glob()|.  A path separator is inserted when needed.
-- 		To add a comma inside a directory name escape it with a
-- 		backslash.  Note that on MS-Windows a directory may have a
-- 		trailing backslash, remove it if you put a comma after it.
-- 		If the expansion fails for one of the directories, there is no
-- 		error message.
--
-- 		Unless the optional {nosuf} argument is given and is |TRUE|,
-- 		the 'suffixes' and 'wildignore' options apply: Names matching
-- 		one of the patterns in 'wildignore' will be skipped and
-- 		'suffixes' affect the ordering of matches.
--
-- 		When {list} is present and it is |TRUE| the result is a List
-- 		with all matching files. The advantage of using a List is, you
-- 		also get filenames containing newlines correctly. Otherwise
-- 		the result is a String and when there are several matches,
-- 		they are separated by <NL> characters.  Example: >
-- 			:echo globpath(&rtp, "syntax/c.vim", 0, 1)
-- <
-- 		{allinks} is used as with |glob()|.
--
-- 		The "**" item can be used to search in a directory tree.
-- 		For example, to find all "README.txt" files in the directories
-- 		in 'runtimepath' and below: >
-- 			:echo globpath(&rtp, "**/README.txt")
-- <		Upwards search and limiting the depth of "**" is not
-- 		supported, thus using 'path' will not always work properly.
--- @param list any[]
--- @return string
function vim.fn.globpath(path, expr, nosuf, list, alllinks) end

-- Put up a directory requester.  This only works when
-- 		"has("browse")" returns |TRUE| (only in some GUI versions).
-- 		On systems where a directory browser is not supported a file
-- 		browser is used.  In that case: select a file in the directory
-- 		to be used.
-- 		The input fields are:
-- 		    {title}	title for the requester
-- 		    {initdir}	directory to start browsing in
-- 		When the "Cancel" button is hit, something went wrong, or
-- 		browsing is not possible, an empty string is returned.
--- @return string
function vim.fn.browsedir(title, initdir) end

-- The result is the name of a buffer, as it is displayed by the
-- 		":ls" command.
-- +		If {expr} is omitted the current buffer is used.
-- 		If {expr} is a Number, that buffer number's name is given.
-- 		Number zero is the alternate buffer for the current window.
-- 		If {expr} is a String, it is used as a |file-pattern| to match
-- 		with the buffer names.  This is always done like 'magic' is
-- 		set and 'cpoptions' is empty.  When there is more than one
-- 		match an empty string is returned.
-- 		"" or "%" can be used for the current buffer, "#" for the
-- 		alternate buffer.
-- 		A full match is preferred, otherwise a match at the start, end
-- 		or middle of the buffer name is accepted.  If you only want a
-- 		full match then put "^" at the start and "$" at the end of the
-- 		pattern.
-- 		Listed buffers are found first.  If there is a single match
-- 		with a listed buffer, that one is returned.  Next unlisted
-- 		buffers are searched for.
-- 		If the {expr} is a String, but you want to use it as a buffer
-- 		number, force it to be a Number by adding zero to it: >
-- 			:echo bufname("3" + 0)
-- <		If the buffer doesn't exist, or doesn't have a name, an empty
-- 		string is returned. >
-- 	bufname("#")		alternate buffer name
-- 	bufname(3)		name of buffer 3
-- 	bufname("%")		name of current buffer
-- 	bufname("file2")	name of buffer where "file2" matches.
--- @return string
function vim.fn.bufname(expr) end

-- The result is a Number, which is |TRUE| if a buffer called
-- 		{expr} exists and is listed (has the 'buflisted' option set).
-- 		The {expr} argument is used like with |bufexists()|.
--- @return number
function vim.fn.buflisted(expr) end

-- Like |strpart()| but using character index and length instead
-- 		of byte index and length.
-- 		When a character index is used where a character does not
-- 		exist it is assumed to be one character.  For example: >
-- 			strcharpart('abc', -1, 2)
-- <		results in 'a'.
--- @return string
function vim.fn.strcharpart(str, start, len) end

-- Set the matches for Insert mode completion.
-- 		Can only be used in Insert mode.  You need to use a mapping
-- 		with CTRL-R = (see |i_CTRL-R|).  It does not work after CTRL-O
-- 		or with an expression mapping.
-- 		{startcol} is the byte offset in the line where the completed
-- 		text start.  The text up to the cursor is the original text
-- 		that will be replaced by the matches.  Use col('.') for an
-- 		empty string.  "col('.') - 1" will replace one character by a
-- 		match.
-- 		{matches} must be a |List|.  Each |List| item is one match.
-- 		See |complete-items| for the kind of items that are possible.
-- 		Note that the after calling this function you need to avoid
-- 		inserting anything that would cause completion to stop.
-- 		The match can be selected with CTRL-N and CTRL-P as usual with
-- 		Insert mode completion.  The popup menu will appear if
-- 		specified, see |ins-completion-menu|.
-- 		Example: >
-- 	inoremap <F5> <C-R>=ListMonths()<CR>
--
-- 	func! ListMonths()
-- 	  call complete(col('.'), ['January', 'February', 'March',
-- 		\ 'April', 'May', 'June', 'July', 'August', 'September',
-- 		\ 'October', 'November', 'December'])
-- 	  return ''
-- 	endfunc
-- <		This isn't very useful, but it shows how it works.  Note that
-- 		an empty string is returned to avoid a zero being inserted.
--- @return none
function vim.fn.complete(startcol, matches) end

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

-- Set the function name prefix to be used for the |terminal-api|
-- 		function in terminal {buf}.  For example: >
-- 		    :call term_setapi(buf, "Myapi_")
-- 		    :call term_setapi(buf, "")
-- <
-- 		The default is "Tapi_".  When {expr} is an empty string then
-- 		no |terminal-api| function can be used for {buf}.
--- @return none
function vim.fn.term_setapi(buf, expr) end

-- Set the ANSI color palette used by terminal {buf}.
-- 		{colors} must be a List of 16 valid color names or hexadecimal
-- 		color codes, like those accepted by |highlight-guifg|.
-- 		Also see |term_getansicolors()| and |g:terminal_ansi_colors|.
--
-- 		The colors normally are:
-- 			0    black
-- 			1    dark red
-- 			2    dark green
-- 			3    brown
-- 			4    dark blue
-- 			5    dark magenta
-- 			6    dark cyan
-- 			7    light grey
-- 			8    dark grey
-- 			9    red
-- 			10   green
-- 			11   yellow
-- 			12   blue
-- 			13   magenta
-- 			14   cyan
-- 			15   white
--
-- 		These colors are used in the GUI and in the terminal when
-- 		'termguicolors' is set.  When not using GUI colors (GUI mode
-- 		or 'termguicolors'), the terminal window always uses the 16
-- 		ANSI colors of the underlying terminal.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_setansicolors(colors)
--
-- <		{only available with GUI enabled and/or the |+termguicolors|
-- 		feature}
--- @return none
function vim.fn.term_setansicolors(buf, colors) end

-- When exiting Vim or trying to close the terminal window in
-- 		another way, {how} defines whether the job in the terminal can
-- 		be stopped.
-- 		When {how} is empty (the default), the job will not be
-- 		stopped, trying to exit will result in |E947|.
-- 		Otherwise, {how} specifies what signal to send to the job.
-- 		See |job_stop()| for the values.
--
-- 		After sending the signal Vim will wait for up to a second to
-- 		check that the job actually stopped.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_setkill(how)
--- @return none
function vim.fn.term_setkill(buf, how) end

-- Same as |matchstr()|, but return the matched string, the start
-- 		position and the end position of the match.  Example: >
-- 			:echo matchstrpos("testing", "ing")
-- <		results in ["ing", 4, 7].
-- 		When there is no match ["", -1, -1] is returned.
-- 		The {start}, if given, has the same meaning as for |match()|. >
-- 			:echo matchstrpos("testing", "ing", 2)
-- <		results in ["ing", 4, 7]. >
-- 			:echo matchstrpos("testing", "ing", 5)
-- <		result is ["", -1, -1].
-- 		When {expr} is a |List| then the matching item, the index
-- 		of first item where {pat} matches, the start position and the
-- 		end position of the match are returned. >
-- 			:echo matchstrpos([1, '__x'], '\a')
-- <		result is ["x", 1, 2, 3].
-- 		The type isn't changed, it's not necessarily a String.
--- @return list
function vim.fn.matchstrpos(expr, pat, start, count) end

-- Set the command to write in a session file to restore the job
-- 		in this terminal.  The line written in the session file is: >
-- 			terminal ++curwin ++cols=%d ++rows=%d {command}
-- <		Make sure to escape the command properly.
--
-- 		Use an empty {command} to run 'shell'.
-- 		Use "NONE" to not restore this window.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_setrestore(command)
--- @return none
function vim.fn.term_setrestore(buf, command) end

-- Get the amount of indent for line {lnum} according the C
-- 		indenting rules, as with 'cindent'.
-- 		The indent is counted in spaces, the value of 'tabstop' is
-- 		relevant.  {lnum} is used just like in |getline()|.
-- 		When {lnum} is invalid -1 is returned.
-- 		See |C-indenting|.
--- @return number
function vim.fn.cindent(lnum) end

-- Open a terminal window and run {cmd} in it.
--
-- 		{cmd} can be a string or a List, like with |job_start()|. The
-- 		string "NONE" can be used to open a terminal window without
-- 		starting a job, the pty of the terminal can be used by a
-- 		command like gdb.
--
-- 		Returns the buffer number of the terminal window.  If {cmd}
-- 		cannot be executed the window does open and shows an error
-- 		message.
-- 		If opening the window fails zero is returned.
--
-- 		{options} are similar to what is used for |job_start()|, see
-- 		|job-options|.  However, not all options can be used.  These
-- 		are supported:
-- 		   all timeout options
-- 		   "stoponexit", "cwd", "env"
-- 		   "callback", "out_cb", "err_cb", "exit_cb", "close_cb"
-- 		   "in_io", "in_top", "in_bot", "in_name", "in_buf"
-- 		   "out_io", "out_name", "out_buf", "out_modifiable", "out_msg"
-- 		   "err_io", "err_name", "err_buf", "err_modifiable", "err_msg"
-- 		However, at least one of stdin, stdout or stderr must be
-- 		connected to the terminal.  When I/O is connected to the
-- 		terminal then the callback function for that part is not used.
--
-- 		There are extra options:
-- 		   "term_name"	     name to use for the buffer name, instead
-- 				     of the command name.
-- 		   "term_rows"	     vertical size to use for the terminal,
-- 				     instead of using 'termwinsize'
-- 		   "term_cols"	     horizontal size to use for the terminal,
-- 				     instead of using 'termwinsize'
-- 		   "vertical"	     split the window vertically; note that
-- 				     other window position can be defined with
-- 				     command modifiers, such as |:belowright|.
-- 		   "curwin"	     use the current window, do not split the
-- 				     window; fails if the current buffer
-- 				     cannot be |abandon|ed
-- 		   "hidden"	     do not open a window
-- 		   "norestore"	     do not add the terminal window to a
-- 				     session file
-- 		   "term_kill"	     what to do when trying to close the
-- 				     terminal window, see |term_setkill()|
-- 		   "term_finish"     What to do when the job is finished:
-- 					"close": close any windows
-- 					"open": open window if needed
-- 				     Note that "open" can be interruptive.
-- 				     See |term++close| and |term++open|.
-- 		   "term_opencmd"    command to use for opening the window when
-- 				     "open" is used for "term_finish"; must
-- 				     have "%d" where the buffer number goes,
-- 				     e.g. "10split|buffer %d"; when not
-- 				     specified "botright sbuf %d" is used
-- 		   "eof_chars"	     Text to send after all buffer lines were
-- 				     written to the terminal.  When not set
-- 				     CTRL-D is used on MS-Windows. For Python
-- 				     use CTRL-Z or "exit()". For a shell use
-- 				     "exit".  A CR is always added.
-- 		   "ansi_colors"     A list of 16 color names or hex codes
-- 				     defining the ANSI palette used in GUI
-- 				     color modes.  See |g:terminal_ansi_colors|.
-- 		   "tty_type"	     (MS-Windows only): Specify which pty to
-- 				     use.  See 'termwintype' for the values.
-- 		   "term_api"	     function name prefix for the
-- 				     |terminal-api| function.  See
-- 				     |term_setapi()|.
--
-- 		Can also be used as a |method|: >
-- 			GetCommand()->term_start()
--- @return number
function vim.fn.term_start(cmd, options) end

-- Wait for pending updates of {buf} to be handled.
-- 		{buf} is used as with |term_getsize()|.
-- 		{time} is how long to wait for updates to arrive in msec.  If
-- 		not set then 10 msec will be used.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_wait()
--- @return number
function vim.fn.term_wait(buf, time) end

-- This is for testing: If the memory allocation with {id} is
-- 		called, then decrement {countdown}, and when it reaches zero
-- 		let memory allocation fail {repeat} times.  When {repeat} is
-- 		smaller than one it fails one time.
--
-- 		Can also be used as a |method|: >
-- 			GetAllocId()->test_alloc_fail()
--- @return none
function vim.fn.test_alloc_fail(id, countdown, _repeat) end

-- Set a flag to enable the effect of 'autochdir' before Vim
-- 		startup has finished.
--- @return none
function vim.fn.test_autochdir() end

-- Characters in {string} are queued for processing as if they
-- 		were typed by the user. This uses a low level input buffer.
-- 		This function works only when with |+unix| or GUI is running.
--
-- 		Can also be used as a |method|: >
-- 			GetText()->test_feedinput()
--- @return none
function vim.fn.test_feedinput(string) end

-- The result is a String, which describes the last Visual mode
-- 		used in the current buffer.  Initially it returns an empty
-- 		string, but once Visual mode has been used, it returns "v",
-- 		"V", or "<CTRL-V>" (a single CTRL-V character) for
-- 		character-wise, line-wise, or block-wise Visual mode
-- 		respectively.
-- 		Example: >
-- 			:exe "normal " . visualmode()
-- <		This enters the same Visual mode as before.  It is also useful
-- 		in scripts if you wish to act differently depending on the
-- 		Visual mode that was used.
-- 		If Visual mode is active, use |mode()| to get the Visual mode
-- 		(e.g., in a |:vmap|).
-- 		If [expr] is supplied and it evaluates to a non-zero Number or
-- 		a non-empty String, then the Visual mode will be cleared and
-- 		the old value is returned.  See |non-zero-arg|.
--- @return string
function vim.fn.visualmode(expr) end

-- Set the flag to call the garbagecollector as if in the main
-- 		loop.  Only to be used in tests.
--- @return none
function vim.fn.test_garbagecollect_soon() end

-- Get the value of an internal variable.  These values for
-- 		{name} are supported:
-- 			need_fileinfo
--
-- 		Can also be used as a |method|: >
-- 			GetName()->test_getvalue()
function vim.fn.test_getvalue(string) end

-- Ignore any error containing {expr}.  A normal message is given
-- 		instead.
-- 		This is only meant to be used in tests, where catching the
-- 		error with try/catch cannot be used (because it skips over
-- 		following code).
-- 		{expr} is used literally, not as a pattern.
-- 		When the {expr} is the string "RESET" then the list of ignored
-- 		errors is made empty.
--
-- 		Can also be used as a |method|: >
-- 			GetErrorText()->test_ignore_error()
--- @return none
function vim.fn.test_ignore_error(expr) end

-- Return a |Blob| that is null. Only useful for testing.
--- @return blob
function vim.fn.test_null_blob() end

-- Return a |Channel| that is null. Only useful for testing.
-- 		{only available when compiled with the +channel feature}
--- @return channel
function vim.fn.test_null_channel() end

-- Return a |Dict| that is null. Only useful for testing.
--- @return dict
function vim.fn.test_null_dict() end

-- Return a |Job| that is null. Only useful for testing.
-- 		{only available when compiled with the +job feature}
--- @return job
function vim.fn.test_null_job() end

-- Return a |List| that is null. Only useful for testing.
--- @return list
function vim.fn.test_null_list() end

-- Return a |Partial| that is null. Only useful for testing.
--- @return funcref
function vim.fn.test_null_partial() end

-- Return a |String| that is null. Only useful for testing.
--- @return string
function vim.fn.test_null_string() end

-- Reset the flag that indicates option {name} was set.  Thus it
-- 		looks like it still has the default value. Use like this: >
-- 			set ambiwidth=double
-- 			call test_option_not_set('ambiwidth')
-- <		Now the 'ambiwidth' option behaves like it was never changed,
-- 		even though the value is "double".
-- 		Only to be used for testing!
--
-- 		Can also be used as a |method|: >
-- 			GetOptionName()->test_option_not_set()
--- @return none
function vim.fn.test_option_not_set(name) end

-- Overrides certain parts of Vim's internal processing to be able
-- 		to run tests. Only to be used for testing Vim!
-- 		The override is enabled when {val} is non-zero and removed
-- 		when {val} is zero.
-- 		Current supported values for name are:
--
-- 		name	     effect when {val} is non-zero ~
-- 		redraw       disable the redrawing() function
-- 		redraw_flag  ignore the RedrawingDisabled flag
-- 		char_avail   disable the char_avail() function
-- 		starting     reset the "starting" variable, see below
-- 		nfa_fail     makes the NFA regexp engine fail to force a
-- 			     fallback to the old engine
-- 		no_query_mouse  do not query the mouse position for "dec"
-- 				terminals
-- 		no_wait_return	set the "no_wait_return" flag.  Not restored
-- 				with "ALL".
-- 		ALL	     clear all overrides ({val} is not used)
--
-- 		"starting" is to be used when a test should behave like
-- 		startup was done.  Since the tests are run by sourcing a
-- 		script the "starting" variable is non-zero. This is usually a
-- 		good thing (tests run faster), but sometimes changes behavior
-- 		in a way that the test doesn't work properly.
-- 		When using: >
-- 			call test_override('starting', 1)
-- <		The value of "starting" is saved.  It is restored by: >
-- 			call test_override('starting', 0)
--
-- <		Can also be used as a |method|: >
-- 			GetOverrideVal()-> test_override('starting')
--- @return none
function vim.fn.test_override(expr, val) end

-- Return the reference count of {expr}.  When {expr} is of a
-- 		type that does not have a reference count, returns -1.  Only
-- 		to be used for testing.
--
-- 		Can also be used as a |method|: >
-- 			GetVarname()->test_refcount()
--- @return number
function vim.fn.test_refcount(expr) end

-- Pretend using scrollbar {which} to move it to position
-- 		{value}.  {which} can be:
-- 			left	Left scrollbar of the current window
-- 			right	Right scrollbar of the current window
-- 			hor	Horizontal scrollbar
--
-- 		For the vertical scrollbars {value} can be 1 to the
-- 		line-count of the buffer.  For the horizontal scrollbar the
-- 		{value} can be between 1 and the maximum line length, assuming
-- 		'wrap' is not set.
--
-- 		When {dragging} is non-zero it's like dragging the scrollbar,
-- 		otherwise it's like clicking in the scrollbar.
-- 		Only works when the {which} scrollbar actually exists,
-- 		obviously only when using the GUI.
--
-- 		Can also be used as a |method|: >
-- 			GetValue()->test_scrollbar('right', 0)
--- @return none
function vim.fn.test_scrollbar(which, value, dragging) end

-- Set the mouse position to be used for the next mouse action.
-- 		{row} and {col} are one based.
-- 		For example: >
-- 			call test_setmouse(4, 20)
-- 			call feedkeys("\<LeftMouse>", "xt")
--- @return none
function vim.fn.test_setmouse(row, col) end

-- Set the time Vim uses internally.  Currently only used for
-- 		timestamps in the history, as they are used in viminfo, and
-- 		for undo.
-- 		Using a value of 1 makes Vim not sleep after a warning or
-- 		error message.
-- 		{expr} must evaluate to a number.  When the value is zero the
-- 		normal behavior is restored.
--
-- 		Can also be used as a |method|: >
-- 			GetTime()->test_settime()
--- @return none
function vim.fn.test_settime(expr) end

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

-- Get information about buffers as a List of Dictionaries.
--
-- 		Without an argument information about all the buffers is
-- 		returned.
--
-- 		When the argument is a Dictionary only the buffers matching
-- 		the specified criteria are returned.  The following keys can
-- 		be specified in {dict}:
-- 			buflisted	include only listed buffers.
-- 			bufloaded	include only loaded buffers.
-- 			bufmodified	include only modified buffers.
--
-- 		Otherwise, {expr} specifies a particular buffer to return
-- 		information for.  For the use of {expr}, see |bufname()|
-- 		above.  If the buffer is found the returned List has one item.
-- 		Otherwise the result is an empty list.
--
-- 		Each returned List item is a dictionary with the following
-- 		entries:
-- 			bufnr		buffer number.
-- 			changed		TRUE if the buffer is modified.
-- 			changedtick	number of changes made to the buffer.
-- 			hidden		TRUE if the buffer is hidden.
-- 			listed		TRUE if the buffer is listed.
-- 			lnum		current line number in buffer.
-- 			linecount	number of lines in the buffer (only
-- 					valid when loaded)
-- 			loaded		TRUE if the buffer is loaded.
-- 			name		full path to the file in the buffer.
-- 			signs		list of signs placed in the buffer.
-- 					Each list item is a dictionary with
-- 					the following fields:
-- 					    id	  sign identifier
-- 					    lnum  line number
-- 					    name  sign name
-- 			variables	a reference to the dictionary with
-- 					buffer-local variables.
-- 			windows		list of |window-ID|s that display this
-- 					buffer
--
-- 		Examples: >
-- 			for buf in getbufinfo()
-- 			    echo buf.name
-- 			endfor
-- 			for buf in getbufinfo({'buflisted':1})
-- 			    if buf.changed
-- 				....
-- 			    endif
-- 			endfor
-- <
-- 		To get buffer-local options use: >
-- 			getbufvar({bufnr}, '&option_name')
--
-- <
--- @return list
function vim.fn.getbufinfo(expr) end

-- Move the window {nr} to a new split of the window {target}.
-- 		This is similar to moving to {target}, creating a new window
-- 		using |:split| but having the same contents as window {nr}, and
-- 		then closing {nr}.
--
-- 		Both {nr} and {target} can be window numbers or |window-ID|s.
--
-- 		Returns zero for success, non-zero for failure.
--
-- 		{options} is a Dictionary with the following optional entries:
-- 		  "vertical"	When TRUE, the split is created vertically,
-- 				like with |:vsplit|.
-- 		  "rightbelow"	When TRUE, the split is made below or to the
-- 				right (if vertical).  When FALSE, it is done
-- 				above or to the left (if vertical).  When not
-- 				present, the values of 'splitbelow' and
-- 				'splitright' are used.
--
-- 		Can also be used as a |method|: >
-- 			GetWinid()->win_splitmove(target)
-- <
--- @return number
function vim.fn.win_splitmove(nr, target, options) end

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

-- The result is a String, which is {expr} with all unprintable
-- 		characters translated into printable characters |'isprint'|.
-- 		Like they are shown in a window.  Example: >
-- 			echo strtrans(@a)
-- <		This displays a newline in register a as "^@" instead of
-- 		starting a new line.
--- @return string
function vim.fn.strtrans(expr) end

-- The result is a Dict, which is the tag stack of window {nr}.
-- 		{nr} can be the window number or the |window-ID|.
-- 		When {nr} is not specified, the current window is used.
-- 		When window {nr} doesn't exist, an empty Dict is returned.
--
-- 		The returned dictionary contains the following entries:
-- 			curidx		Current index in the stack. When at
-- 					top of the stack, set to (length + 1).
-- 					Index of bottom of the stack is 1.
-- 			items		List of items in the stack. Each item
-- 					is a dictionary containing the
-- 					entries described below.
-- 			length		Number of entries in the stack.
--
-- 		Each item in the stack is a dictionary with the following
-- 		entries:
-- 			bufnr		buffer number of the current jump
-- 			from		cursor position before the tag jump.
-- 					See |getpos()| for the format of the
-- 					returned list.
-- 			matchnr		current matching tag number. Used when
-- 					multiple matching tags are found for a
-- 					name.
-- 			tagname		name of the tag
--
-- 		See |tagstack| for more information about the tag stack.
--- @return dict
function vim.fn.gettagstack(nr) end

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

-- The result is the number of a buffer, as it is displayed by
-- 		the ":ls" command.  For the use of {expr}, see |bufname()|
-- 		above.
-- 		If the buffer doesn't exist, -1 is returned.  Or, if the
-- 		{create} argument is present and not zero, a new, unlisted,
-- 		buffer is created and its number is returned.
-- 		bufnr("$") is the last buffer: >
-- 			:let last_buffer = bufnr("$")
-- <		The result is a Number, which is the highest buffer number
-- 		of existing buffers.  Note that not all buffers with a smaller
-- 		number necessarily exist, because ":bwipeout" may have removed
-- 		them.  Use bufexists() to test for the existence of a buffer.
--- @return number
function vim.fn.bufnr(expr, create) end

-- When {dict} is omitted or zero: Return the rhs of mapping
-- 		{name} in mode {mode}.  The returned String has special
-- 		characters translated like in the output of the ":map" command
-- 		listing.
--
-- 		When there is no mapping for {name}, an empty String is
-- 		returned.  When the mapping for {name} is empty, then "<Nop>"
-- 		is returned.
--
-- 		The {name} can have special key names, like in the ":map"
-- 		command.
--
-- 		{mode} can be one of these strings:
-- 			"n"	Normal
-- 			"v"	Visual (including Select)
-- 			"o"	Operator-pending
-- 			"i"	Insert
-- 			"c"	Cmd-line
-- 			"s"	Select
-- 			"x"	Visual
-- 			"l"	langmap |language-mapping|
-- 			"t"	Terminal
-- 			""	Normal, Visual and Operator-pending
-- 		When {mode} is omitted, the modes for "" are used.
--
-- 		When {abbr} is there and it is |TRUE| use abbreviations
-- 		instead of mappings.
--
-- 		When {dict} is there and it is |TRUE| return a dictionary
-- 		containing all the information of the mapping with the
-- 		following items:
-- 		  "lhs"	     The {lhs} of the mapping.
-- 		  "rhs"	     The {rhs} of the mapping as typed.
-- 		  "silent"   1 for a |:map-silent| mapping, else 0.
-- 		  "noremap"  1 if the {rhs} of the mapping is not remappable.
-- 		  "expr"     1 for an expression mapping (|:map-<expr>|).
-- 		  "buffer"   1 for a buffer local mapping (|:map-local|).
-- 		  "mode"     Modes for which the mapping is defined. In
-- 			     addition to the modes mentioned above, these
-- 			     characters will be used:
-- 			     " "     Normal, Visual and Operator-pending
-- 			     "!"     Insert and Commandline mode
-- 				     (|mapmode-ic|)
-- 		  "sid"	     The script local ID, used for <sid> mappings
-- 			     (|<SID>|).
-- 		  "lnum"     The line number in "sid", zero if unknown.
-- 		  "nowait"   Do not wait for other, longer mappings.
-- 			     (|:map-<nowait>|).
--
-- 		The mappings local to the current buffer are checked first,
-- 		then the global mappings.
-- 		This function can be used to map a key even when it's already
-- 		mapped, and have it do the original mapping too.  Sketch: >
-- 			exe 'nnoremap <Tab> ==' . maparg('<Tab>', 'n')
--- @param dict dictionary
--- @return string
function vim.fn.maparg(name, mode, abbr, dict) end

-- Return a |List| with all the values of {dict}.  The |List| is
-- 		in arbitrary order.
--- @param dict dictionary
--- @return list
function vim.fn.values(dict) end

-- Return a list with information about timers.
-- 		When {id} is given only information about this timer is
-- 		returned.  When timer {id} does not exist an empty list is
-- 		returned.
-- 		When {id} is omitted information about all timers is returned.
--
-- 		For each timer the information is stored in a Dictionary with
-- 		these items:
-- 		    "id"	    the timer ID
-- 		    "time"	    time the timer was started with
-- 		    "repeat"	    number of times the timer will still fire;
-- 				    -1 means forever
-- 		    "callback"	    the callback
--- @return list
function vim.fn.timer_info(id) end

-- Pause or unpause a timer.  A paused timer does not invoke its
-- 		callback when its time expires.  Unpausing a timer may cause
-- 		the callback to be invoked almost immediately if enough time
-- 		has passed.
--
-- 		Pausing a timer is useful to avoid the callback to be called
-- 		for a short time.
--
-- 		If {paused} evaluates to a non-zero Number or a non-empty
-- 		String, then the timer is paused, otherwise it is unpaused.
-- 		See |non-zero-arg|.
--- @return none
function vim.fn.timer_pause(id, pause) end

-- Stop all timers.  The timer callbacks will no longer be
-- 		invoked.  Useful if some timers is misbehaving.  If there are
-- 		no timers there is no error.
--- @return none
function vim.fn.timer_stopall() end

-- The result is a copy of the String given, with all uppercase
-- 		characters turned into lowercase (just like applying |gu| to
-- 		the string).
--- @return string
function vim.fn.tolower(expr) end

-- The result is a copy of the String given, with all lowercase
-- 		characters turned into uppercase (just like applying |gU| to
-- 		the string).
--- @return string
function vim.fn.toupper(expr) end

-- Return the largest integral value with magnitude less than or
-- 		equal to {expr} as a |Float| (truncate towards zero).
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			echo trunc(1.456)
-- <			1.0  >
-- 			echo trunc(-5.456)
-- <			-5.0  >
-- 			echo trunc(4.0)
-- <			4.0
--- @return float
function vim.fn.trunc(expr) end

-- a client to a Vim server. |remote_send()|
-- 		On Win32 systems this might not work, the OS does not always
-- 		allow a window to bring itself to the foreground.  Use
-- 		|remote_foreground()| instead.
-- 		{only in the Win32 GUI and console version}
--- @return number
function vim.fn.foreground() end

-- Remove second and succeeding copies of repeated adjacent
-- 		{list} items in-place.  Returns {list}.  If you want a list
-- 		to remain unmodified make a copy first: >
-- 			:let newlist = uniq(copy(mylist))
-- <		The default compare function uses the string representation of
-- 		each item.  For the use of {func} and {dict} see |sort()|.
--- @param list any[]
--- @param dict dictionary
--- @return list
function vim.fn.uniq(list, func, dict) end

-- The result is a Number, which is the screen column of the file
-- 		position given with {expr}.  That is, the last screen position
-- 		occupied by the character at that position, when the screen
-- 		would be of unlimited width.  When there is a <Tab> at the
-- 		position, the returned Number will be the column at the end of
-- 		the <Tab>.  For example, for a <Tab> in column 1, with 'ts'
-- 		set to 8, it returns 8. |conceal| is ignored.
-- 		For the byte position use |col()|.
-- 		For the use of {expr} see |col()|.
-- 		When 'virtualedit' is used {expr} can be [lnum, col, off], where
-- 		"off" is the offset in screen columns from the start of the
-- 		character.  E.g., a position within a <Tab> or after the last
-- 		character.  When "off" is omitted zero is used.
-- 		When Virtual editing is active in the current mode, a position
-- 		beyond the end of the line can be returned. |'virtualedit'|
-- 		The accepted positions are:
-- 		    .	    the cursor position
-- 		    $	    the end of the cursor line (the result is the
-- 			    number of displayed characters in the cursor line
-- 			    plus one)
-- 		    'x	    position of mark x (if the mark is not set, 0 is
-- 			    returned)
-- 		    v       In Visual mode: the start of the Visual area (the
-- 			    cursor is the end).  When not in Visual mode
-- 			    returns the cursor position.  Differs from |'<| in
-- 			    that it's updated right away.
-- 		Note that only marks in the current file can be used.
-- 		Examples: >
--   virtcol(".")	   with text "foo^Lbar", with cursor on the "^L", returns 5
--   virtcol("$")	   with text "foo^Lbar", returns 9
--   virtcol("'t")    with text "	  there", with 't at 'h', returns 6
-- <		The first column is 1.  0 is returned for an error.
-- 		A more advanced example that echoes the maximum length of
-- 		all lines: >
-- 		    echo max(map(range(1, line('$')), "virtcol([v:val, '$'])"))
--- @return number
function vim.fn.virtcol(expr) end

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

-- Return a list with the tab number and window number of window
-- 		with ID {expr}: [tabnr, winnr].
-- 		Return [0, 0] if the window cannot be found.
--- @return list
function vim.fn.win_id2tabwin(expr) end

-- Return the value of environment variable {name}.
-- 		When the variable does not exist |v:null| is returned.  That
-- 		is different from a variable set to an empty string.
-- 		See also |expr-env|.
--- @return string
function vim.fn.getenv(name) end

-- Return the window number of window with ID {expr}.
-- 		Return 0 if the window cannot be found in the current tabpage.
--- @return number
function vim.fn.win_id2win(expr) end

-- Return the screen position of window {nr} as a list with two
-- 		numbers: [row, col].  The first window always has position
-- 		[1, 1], unless there is a tabline, then it is [2, 1].
-- 		{nr} can be the window number or the |window-ID|.
-- 		Return [0, 0] if the window cannot be found in the current
-- 		tabpage.
--- @return list
function vim.fn.win_screenpos(nr) end

-- When {expr} is a String or a Number the length in bytes is
-- 		used, as with |strlen()|.
-- 		When {expr} is a |List| the number of items in the |List| is
-- 		returned.
-- 		When {expr} is a |Blob| the number of bytes is returned.
-- 		When {expr} is a |Dictionary| the number of entries in the
-- 		|Dictionary| is returned.
-- 		Otherwise an error is given.
--- @return number
function vim.fn.len(expr) end

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

-- Check if there is a mapping that matches with {name} in mode
-- 		{mode}.  See |maparg()| for {mode} and special names in
-- 		{name}.
-- 		When {abbr} is there and it is non-zero use abbreviations
-- 		instead of mappings.
-- 		A match happens with a mapping that starts with {name} and
-- 		with a mapping which is equal to the start of {name}.
--
-- 			matches mapping "a"	"ab"	"abc" ~
-- 		   mapcheck("a")	yes	yes	 yes
-- 		   mapcheck("abc")	yes	yes	 yes
-- 		   mapcheck("ax")	yes	no	 no
-- 		   mapcheck("b")	no	no	 no
--
-- 		The difference with maparg() is that mapcheck() finds a
-- 		mapping that matches with {name}, while maparg() only finds a
-- 		mapping for {name} exactly.
-- 		When there is no mapping that starts with {name}, an empty
-- 		String is returned.  If there is one, the RHS of that mapping
-- 		is returned.  If there are several mappings that start with
-- 		{name}, the RHS of one of them is returned.  This will be
-- 		"<Nop>" if the RHS is empty.
-- 		The mappings local to the current buffer are checked first,
-- 		then the global mappings.
-- 		This function can be used to check if a mapping can be added
-- 		without being ambiguous.  Example: >
-- 	:if mapcheck("_vv") == ""
-- 	:   map _vv :set guifont=7x13<CR>
-- 	:endif
-- <		This avoids adding the "_vv" mapping when there already is a
-- 		mapping for "_v" or for "_vvv".
--- @return string
function vim.fn.mapcheck(name, mode, abbr) end

-- The result is a Number, which is 1 if there is a mapping that
-- 		contains {what} in somewhere in the rhs (what it is mapped to)
-- 		and this mapping exists in one of the modes indicated by
-- 		{mode}.
-- 		When {abbr} is there and it is |TRUE| use abbreviations
-- 		instead of mappings.  Don't forget to specify Insert and/or
-- 		Command-line mode.
-- 		Both the global mappings and the mappings local to the current
-- 		buffer are checked for a match.
-- 		If no matching mapping is found 0 is returned.
-- 		The following characters are recognized in {mode}:
-- 			n	Normal mode
-- 			v	Visual mode
-- 			o	Operator-pending mode
-- 			i	Insert mode
-- 			l	Language-Argument ("r", "f", "t", etc.)
-- 			c	Command-line mode
-- 		When {mode} is omitted, "nvo" is used.
--
-- 		This function is useful to check if a mapping already exists
-- 		to a function in a Vim script.  Example: >
-- 			:if !hasmapto('\ABCdoit')
-- 			:   map <Leader>d \ABCdoit
-- 			:endif
-- <		This installs the mapping to "\ABCdoit" only if there isn't
-- 		already a mapping to "\ABCdoit".
--- @return number
function vim.fn.hasmapto(what, mode, abbr) end

-- Subscribes to event broadcasts.
--
--                 Parameters: ~
--                     {event}  Event type string
function vim.fn.nvim_subscribe(event) end

-- Unsubscribes to event broadcasts.
--
--                 Parameters: ~
--                     {event}  Event type string
function vim.fn.nvim_unsubscribe(event) end

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

