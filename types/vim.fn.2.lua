--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

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

-- Get the |window-ID| for the popup preview window.
-- 		Return zero if there is none.
--- @return number
function vim.fn.popup_findpreview() end

-- Waits until {condition} evaluates to |TRUE|, where {condition}
-- 		is a |Funcref| or |string| containing an expression.
--
-- 		{timeout} is the maximum waiting time in milliseconds, -1
-- 		means forever.
--
-- 		Condition is evaluated on user events, internal events, and
-- 		every {interval} milliseconds (default: 200).
--
-- 		Returns a status integer:
-- 			0 if the condition was satisfied before timeout
-- 			-1 if the timeout was exceeded
-- 			-2 if the function was interrupted (by |CTRL-C|)
-- 			-3 if an error occurred
--- @return number
function vim.fn.wait(timeout, condition, interval) end

-- Set the size of terminal {buf}. The size of the window
-- 		containing the terminal will also be adjusted, if possible.
-- 		If {rows} or {cols} is zero or negative, that dimension is not
-- 		changed.
--
-- 		{buf} must be the buffer number of a terminal window.  Use an
-- 		empty string for the current buffer.  If the buffer does not
-- 		exist or is not a terminal window, an error is given.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_setsize(rows, cols)
--- @return none
function vim.fn.term_setsize(buf, rows, cols) end

-- When {actual} is not false an error message is added to
-- 		|v:errors|, like with |assert_equal()|.
-- 		Also see |assert-return|.
-- 		A value is false when it is zero or |v:false|. When "{actual}"
-- 		is not a number or |v:false| the assert fails.
-- 		When {msg} is omitted an error in the form
-- 		"Expected False but got {actual}" is produced.
--- @return number
function vim.fn.assert_false(actual, msg) end

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

-- Send the {string} to {server}.  The string is sent as input
-- 		keys and the function returns immediately.  At the Vim server
-- 		the keys are not mapped |:map|.
-- 		If {idvar} is present, it is taken as the name of a variable
-- 		and a {serverid} for later use with remote_read() is stored
-- 		there.
-- 		See also |clientserver| |RemoteReply|.
-- 		This function is not available in the |sandbox|.
--
-- 		Note: Any errors will be reported in the server and may mess
-- 		up the display.
-- 		Examples: >
-- 		:echo remote_send("gvim", ":DropAndReply ".file, "serverid").
-- 		 \ remote_read(serverid)
--
-- 		:autocmd NONE RemoteReply *
-- 		 \ echo remote_read(expand("<amatch>"))
-- 		:echo remote_send("gvim", ":sleep 10 | echo ".
-- 		 \ 'server2client(expand("<client>"), "HELLO")<CR>')
-- <
--- @return string
function vim.fn.remote_send(server, string, idvar) end

-- The result is a Number, which is non-zero if a highlight group
-- 		called {name} exists.  This is when the group has been
-- 		defined in some way.  Not necessarily when highlighting has
-- 		been defined for it, it may also have been used for a syntax
-- 		item.
--- @return number
function vim.fn.hlexists(name) end

-- Return a |Dict| that is null. Only useful for testing.
--- @return dict
function vim.fn.test_null_dict() end

-- The result is a copy of the String given, with all uppercase
-- 		characters turned into lowercase (just like applying |gu| to
-- 		the string).
--- @return string
function vim.fn.tolower(expr) end

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

-- With no arguments the result is a String, which is the name of
-- 		the current effective working directory. With {winnr} or
-- 		{tabnr} the working directory of that scope is returned.
-- 		Tabs and windows are identified by their respective numbers,
-- 		0 means current tab or window. Missing argument implies 0.
-- 		Thus the following are equivalent: >
-- 			getcwd()
-- 			getcwd(0)
-- 			getcwd(0, 0)
-- <		If {winnr} is -1 it is ignored, only the tab is resolved.
-- 		{winnr} can be the window number or the |window-ID|.
--- @return string
function vim.fn.getcwd(winnr, tabnr) end

-- Returns a list with all property type names.
--
-- 		{props} can contain a "bufnr" item.  When it is given, use
-- 		this buffer instead of the global property types.
--
-- 		See |text-properties| for information about text properties.
--- @return list
function vim.fn.prop_type_list(props) end

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

-- Search for regexp pattern {pattern}.  The search starts at the
-- 		cursor position (you can use |cursor()| to set it).
--
-- 		When a match has been found its line number is returned.
-- 		If there is no match a 0 is returned and the cursor doesn't
-- 		move.  No error message is given.
--
-- 		{flags} is a String, which can contain these character flags:
-- 		'b'	search Backward instead of forward
-- 		'c'	accept a match at the Cursor position
-- 		'e'	move to the End of the match
-- 		'n'	do Not move the cursor
-- 		'p'	return number of matching sub-Pattern (see below)
-- 		's'	Set the ' mark at the previous location of the cursor
-- 		'w'	Wrap around the end of the file
-- 		'W'	don't Wrap around the end of the file
-- 		'z'	start searching at the cursor column instead of Zero
-- 		If neither 'w' or 'W' is given, the 'wrapscan' option applies.
--
-- 		If the 's' flag is supplied, the ' mark is set, only if the
-- 		cursor is moved. The 's' flag cannot be combined with the 'n'
-- 		flag.
--
-- 		'ignorecase', 'smartcase' and 'magic' are used.
--
-- 		When the 'z' flag is not given, searching always starts in
-- 		column zero and then matches before the cursor are skipped.
-- 		When the 'c' flag is present in 'cpo' the next search starts
-- 		after the match.  Without the 'c' flag the next search starts
-- 		one column further.
--
-- 		When the {stopline} argument is given then the search stops
-- 		after searching this line.  This is useful to restrict the
-- 		search to a range of lines.  Examples: >
-- 			let match = search('(', 'b', line("w0"))
-- 			let end = search('END', '', line("w$"))
-- <		When {stopline} is used and it is not zero this also implies
-- 		that the search does not wrap around the end of the file.
-- 		A zero value is equal to not giving the argument.
--
-- 		When the {timeout} argument is given the search stops when
-- 		more than this many milliseconds have passed.  Thus when
-- 		{timeout} is 500 the search stops after half a second.
-- 		The value must not be negative.  A zero value is like not
-- 		giving the argument.
--
-- 							*search()-sub-match*
-- 		With the 'p' flag the returned value is one more than the
-- 		first sub-match in \(\).  One if none of them matched but the
-- 		whole pattern did match.
-- 		To get the column number too use |searchpos()|.
--
-- 		The cursor will be positioned at the match, unless the 'n'
-- 		flag is used.
--
-- 		Example (goes over all files in the argument list): >
-- 		    :let n = 1
-- 		    :while n <= argc()	    " loop over all files in arglist
-- 		    :  exe "argument " . n
-- 		    :  " start at the last char in the file and wrap for the
-- 		    :  " first search to find match at start of file
-- 		    :  normal G$
-- 		    :  let flags = "w"
-- 		    :  while search("foo", flags) > 0
-- 		    :	 s/foo/bar/g
-- 		    :	 let flags = "W"
-- 		    :  endwhile
-- 		    :  update		    " write the file if modified
-- 		    :  let n = n + 1
-- 		    :endwhile
-- <
-- 		Example for using some flags: >
-- 		    :echo search('\<if\|\(else\)\|\(endif\)', 'ncpe')
-- <		This will search for the keywords "if", "else", and "endif"
-- 		under or after the cursor.  Because of the 'p' flag, it
-- 		returns 1, 2, or 3 depending on which keyword is found, or 0
-- 		if the search fails.  With the cursor on the first word of the
-- 		line:
-- 		    if (foo == 0) | let foo = foo + 1 | endif ~
-- 		the function returns 1.  Without the 'c' flag, the function
-- 		finds the "endif" and returns 3.  The same thing happens
-- 		without the 'e' flag if the cursor is on the "f" of "if".
-- 		The 'n' flag tells the function not to move the cursor.
--- @return number
function vim.fn.search(pattern, flags, stopline, timeout) end

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

-- Return a |List| with spelling suggestions to replace {word}.
-- 		When {max} is given up to this number of suggestions are
-- 		returned.  Otherwise up to 25 suggestions are returned.
--
-- 		When the {capital} argument is given and it's non-zero only
-- 		suggestions with a leading capital will be given.  Use this
-- 		after a match with 'spellcapcheck'.
--
-- 		{word} can be a badly spelled word followed by other text.
-- 		This allows for joining two words that were split.  The
-- 		suggestions also include the following text, thus you can
-- 		replace a line.
--
-- 		{word} may also be a good word.  Similar words will then be
-- 		returned.  {word} itself is not included in the suggestions,
-- 		although it may appear capitalized.
--
-- 		The spelling information for the current window is used.  The
-- 		'spell' option must be set and the values of 'spelllang' and
-- 		'spellsuggest' are used.
--- @return list
function vim.fn.spellsuggest(word, max, capital) end

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

-- Send |String| or |Blob| {expr} over {handle}.
-- 		Works like |ch_sendexpr()|, but does not encode the request or
-- 		decode the response.  The caller is responsible for the
-- 		correct contents.  Also does not add a newline for a channel
-- 		in NL mode, the caller must do that.  The NL in the response
-- 		is removed.
-- 		See |channel-use|.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_sendraw(rawexpr)
function vim.fn.ch_sendraw(handle, expr, options) end

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

-- Close the "in" part of {handle}.  See |channel-close-in|.
-- 		{handle} can be a Channel or a Job that has a Channel.
-- 		A close callback is not invoked.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_close_in()
--- @return none
function vim.fn.ch_close_in(handle) end

-- Returns 1 when inside an event handler.  That is that Vim got
-- 		interrupted while waiting for the user to type a character,
-- 		e.g., when dropping a file on Vim.  This means interactive
-- 		commands cannot be used.  Otherwise zero is returned.
--- @return number
function vim.fn.eventhandler() end

-- This is similar to |json_encode()| with these differences:
-- 		- Object key names are not in quotes.
-- 		- v:none items in an array result in an empty item between
-- 		  commas.
-- 		For example, the Vim object:
-- 			[1,v:none,{"one":1},v:none] ~
-- 		Will be encoded as:
-- 			[1,,{one:1},,] ~
-- 		While json_encode() would produce:
-- 			[1,null,{"one":1},null] ~
-- 		This encoding is valid for JavaScript. It is more efficient
-- 		than JSON, especially when using an array with optional items.
--
-- 		Can also be used as a |method|: >
-- 			GetObject()->js_encode()
--- @return string
function vim.fn.js_encode(expr) end

-- Return the line number of the first line at or above {lnum}
-- 		that is not blank.  Example: >
-- 			let ind = indent(prevnonblank(v:lnum - 1))
-- <		When {lnum} is invalid or there is no non-blank line at or
-- 		above it, zero is returned.
-- 		Also see |nextnonblank()|.
--- @return number
function vim.fn.prevnonblank(lnum) end

-- This is for testing: If the memory allocation with {id} is
-- 		called, then decrement {countdown}, and when it reaches zero
-- 		let memory allocation fail {repeat} times.  When {repeat} is
-- 		smaller than one it fails one time.
--
-- 		Can also be used as a |method|: >
-- 			GetAllocId()->test_alloc_fail()
--- @return none
function vim.fn.test_alloc_fail(id, countdown, _repeat) end

-- The result is a String, which is the name of a file that
-- 		doesn't exist.  It can be used for a temporary file.  Example: >
-- 			:let tmpfile = tempname()
-- 			:exe "redir > " . tmpfile
-- <		For Unix, the file will be in a private directory |tempfile|.
-- 		For MS-Windows forward slashes are used when the 'shellslash'
-- 		option is set or when 'shellcmdflag' starts with '-'.
--- @return string
function vim.fn.tempname() end

-- Send data to channel {id}. For a job, it writes it to the
-- 		stdin of the process. For the stdio channel |channel-stdio|,
-- 		it writes to Nvim's stdout.  Returns the number of bytes
-- 		written if the write succeeded, 0 otherwise.
-- 		See |channel-bytes| for more information.
--
-- 		{data} may be a string, string convertible, or a list.  If
-- 		{data} is a list, the items will be joined by newlines; any
-- 		newlines in an item will be sent as NUL. To send a final
-- 		newline, include a final empty string. Example: >
-- 			:call chansend(id, ["abc", "123\n456", ""])
-- < 		will send "abc<NL>123<NUL>456<NL>".
--
-- 		chansend() writes raw data, not RPC messages.  If the channel
-- 		was created with `"rpc":v:true` then the channel expects RPC
-- 		messages, use |rpcnotify()| and |rpcrequest()| instead.
--- @return number
function vim.fn.chansend(id, data) end

-- Get the cursor position of terminal {buf}. Returns a list with
-- 		two numbers and a dictionary: [row, col, dict].
--
-- 		"row" and "col" are one based, the first screen cell is row
-- 		1, column 1.  This is the cursor position of the terminal
-- 		itself, not of the Vim window.
--
-- 		"dict" can have these members:
-- 		   "visible"	one when the cursor is visible, zero when it
-- 				is hidden.
-- 		   "blink"	one when the cursor is blinking, zero when it
-- 				is not blinking.
-- 		   "shape"	1 for a block cursor, 2 for underline and 3
-- 				for a vertical bar.
-- 		   "color"	color of the cursor, e.g. "green"
--
-- 		{buf} must be the buffer number of a terminal window. If the
-- 		buffer does not exist or is not a terminal window, an empty
-- 		list is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getcursor()
--- @return list
function vim.fn.term_getcursor(buf) end

-- cursor in the window.  This is counting screen cells from the
-- 		left side of the window.  The leftmost column is one.
--- @return number
function vim.fn.wincol() end

-- Evaluate Perl expression {expr} in scalar context and return
-- 		its result converted to Vim data structures. If value can't be
-- 		converted, it is returned as a string Perl representation.
-- 		Note: If you want an array or hash, {expr} must return a
-- 		reference to it.
-- 		Example: >
-- 			:echo perleval('[1 .. 4]')
-- <			[1, 2, 3, 4]
--
-- 		Can also be used as a |method|: >
-- 			GetExpr()->perleval()
--
-- <		{only available when compiled with the |+perl| feature}
--
--
-- popup_ functions are documented here: |popup-functions|.
function vim.fn.perleval(expr) end

-- Same as |match()|, but return the index of first character
-- 		after the match.  Example: >
-- 			:echo matchend("testing", "ing")
-- <		results in "7".
-- 							*strspn()* *strcspn()*
-- 		Vim doesn't have a strspn() or strcspn() function, but you can
-- 		do it with matchend(): >
-- 			:let span = matchend(line, '[a-zA-Z]')
-- 			:let span = matchend(line, '[^a-zA-Z]')
-- <		Except that -1 is returned when there are no matches.
--
-- 		The {start}, if given, has the same meaning as for |match()|. >
-- 			:echo matchend("testing", "ing", 2)
-- <		results in "7". >
-- 			:echo matchend("testing", "ing", 5)
-- <		result is "-1".
-- 		When {expr} is a |List| the result is equal to |match()|.
--- @return number
function vim.fn.matchend(expr, pat, start, count) end

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

-- The result is a Number, which is |TRUE| when a directory
-- 		with the name {directory} exists.  If {directory} doesn't
-- 		exist, or isn't a directory, the result is |FALSE|.  {directory}
-- 		is any expression, which is used as a String.
--- @return number
function vim.fn.isdirectory(directory) end

-- Set options on {handle}:
-- 			"callback"	the channel callback
-- 			"timeout"	default read timeout in msec
-- 			"mode"		mode for the whole channel
-- 		See |ch_open()| for more explanation.
-- 		{handle} can be a Channel or a Job that has a Channel.
--
-- 		Note that changing the mode may cause queued messages to be
-- 		lost.
--
-- 		These options cannot be changed:
-- 			"waittime"	only applies to |ch_open()|
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_setoptions(options)
--- @return none
function vim.fn.ch_setoptions(handle, options) end

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

-- Set attrs in nvim__buf_set_lua_hl callbacks
--
--                 TODO(bfredl): This is rather pedestrian. The final interface
--                 should probably be derived from a reformed bufhl/virttext
--                 interface with full support for multi-line ranges etc
function vim.fn.nvim__put_attr(id, c0, c1) end

-- Add a buffer to the buffer list with {name}.
-- 		If a buffer for file {name} already exists, return that buffer
-- 		number.  Otherwise return the buffer number of the newly
-- 		created buffer.  When {name} is an empty string then a new
-- 		buffer is always created.
-- 		The buffer will not have' 'buflisted' set.
--- @return number
function vim.fn.bufadd(name) end

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

-- Specifically used to interrupt a program being debugged.  It
-- 		will cause process {pid} to get a SIGTRAP.  Behavior for other
-- 		processes is undefined. See |terminal-debugger|.
-- 		{Sends a SIGINT to a process {pid} other than MS-Windows}
--- @return number
function vim.fn.debugbreak(pid) end

-- Like ch_read() but for a JS and JSON channel does not decode
-- 		the message.  For a NL channel it does not block waiting for
-- 		the NL to arrive, but otherwise works like ch_read().
-- 		See |channel-more|.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_readraw()
--- @return string
function vim.fn.ch_readraw(handle, options) end

-- Evaluate Lua expression {expr} and return its result converted
-- 		to Vim data structures. See |lua-eval| for more details.
function vim.fn.luaeval(expr, expr) end

-- the first file.  argc() - 1 is the last one.  See |arglist|.
--- @return number
function vim.fn.argidx() end

-- Append the item {expr} to |List| {list}.  Returns the
-- 		resulting |List|.  Examples: >
-- 			:let alist = add([1, 2, 3], item)
-- 			:call add(mylist, "woodstock")
-- <		Note that when {expr} is a |List| it is appended as a single
-- 		item.  Use |extend()| to concatenate |Lists|.
-- 		Use |insert()| to add an item at another position.
--- @param list any[]
--- @return list
function vim.fn.add(list, item) end

-- {expr} can be a list or a dictionary.  For a dictionary,
-- 		it returns the maximum of all values in the dictionary.
-- 		If {expr} is neither a list nor a dictionary, or one of the
-- 		items in {expr} cannot be used as a Number this results in
--                 an error.  An empty |List| or |Dictionary| results in zero.
--- @return number
function vim.fn.max(expr) end

-- Get the contents of {row} of terminal screen of {buf}.
-- 		For {buf} see |term_getsize()|.
--
-- 		The first line has {row} one.  When {row} is "." the cursor
-- 		line is used.  When {row} is invalid an empty string is
-- 		returned.
--
-- 		Return a List containing a Dict for each screen cell:
-- 		    "chars"	character(s) at the cell
-- 		    "fg"	foreground color as #rrggbb
-- 		    "bg"	background color as #rrggbb
-- 		    "attr"	attributes of the cell, use |term_getattr()|
-- 				to get the individual flags
-- 		    "width"	cell width: 1 or 2
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_scrape(row)
--- @return list
function vim.fn.term_scrape(buf, row) end

-- Same as |system()|, but returns a |List| with lines (parts of
-- 		output separated by NL) with NULs transformed into NLs. Output
-- 		is the same as |readfile()| will output with {binary} argument
-- 		set to "b", except that a final newline is not preserved,
-- 		unless {keepempty} is non-zero.
-- 		Note that on MS-Windows you may get trailing CR characters.
--
-- 		Returns an empty string on error.
--- @return list
function vim.fn.systemlist(cmd, input) end

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

-- Subscribes to event broadcasts.
--
--                 Parameters: ~
--                     {event}  Event type string
function vim.fn.nvim_subscribe(event) end

-- The result is a String, which is a formatted date and time, as
-- 		specified by the {format} string.  The given {time} is used,
-- 		or the current time if no time is given.  The accepted
-- 		{format} depends on your system, thus this is not portable!
-- 		See the manual page of the C function strftime() for the
-- 		format.  The maximum length of the result is 80 characters.
-- 		See also |localtime()| and |getftime()|.
-- 		The language can be changed with the |:language| command.
-- 		Examples: >
-- 		  :echo strftime("%c")		   Sun Apr 27 11:49:23 1997
-- 		  :echo strftime("%Y %b %d %X")	   1997 Apr 27 11:53:25
-- 		  :echo strftime("%y%m%d %T")	   970427 11:53:55
-- 		  :echo strftime("%H:%M")	   11:55
-- 		  :echo strftime("%c", getftime("file.c"))
-- 						   Show mod time of file.c.
-- <		Not available on all systems.  To check use: >
-- 			:if exists("*strftime")
--- @return string
function vim.fn.strftime(format, time) end

-- Return the current text in the balloon.  Only for the string,
-- 		not used for the List.
--- @return string
function vim.fn.balloon_gettext() end

-- Interrupt script execution.  It works more or less like the
-- 		user typing CTRL-C, most commands won't execute and control
-- 		returns to the user.  This is useful to abort execution
-- 		from lower down, e.g. in an autocommand.  Example: >
-- 		:function s:check_typoname(file)
-- 		:   if fnamemodify(a:file, ':t') == '['
-- 		:       echomsg 'Maybe typo'
-- 		:       call interrupt()
-- 		:   endif
-- 		:endfunction
-- 		:au BufWritePre * call s:check_typoname(expand('<amatch>'))
--- @return none
function vim.fn.interrupt() end

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

-- Like ch_read() but reads binary data and returns a |Blob|.
-- 		See |channel-more|.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_readblob()
--- @return blob
function vim.fn.ch_readblob(handle, options) end

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

-- {expr1} must be a |List| or a |Dictionary|.
-- 		Replace each item in {expr1} with the result of evaluating
-- 		{expr2}. {expr2} must be a |string| or |Funcref|.
--
-- 		If {expr2} is a |string|, inside {expr2} |v:val| has the value
-- 		of the current item. For a |Dictionary| |v:key| has the key
-- 		of the current item and for a |List| |v:key| has the index of
-- 		the current item.
-- 		Example: >
-- 			:call map(mylist, '"> " . v:val . " <"')
-- <		This puts "> " before and " <" after each item in "mylist".
--
-- 		Note that {expr2} is the result of an expression and is then
-- 		used as an expression again.  Often it is good to use a
-- 		|literal-string| to avoid having to double backslashes.  You
-- 		still have to double ' quotes
--
-- 		If {expr2} is a |Funcref| it is called with two arguments:
-- 			1. The key or the index of the current item.
-- 			2. the value of the current item.
-- 		The function must return the new value of the item. Example
-- 		that changes each value by "key-value": >
-- 			func KeyValue(key, val)
-- 			  return a:key . '-' . a:val
-- 			endfunc
-- 			call map(myDict, function('KeyValue'))
-- <		It is shorter when using a |lambda|: >
-- 			call map(myDict, {key, val -> key . '-' . val})
-- <		If you do not use "val" you can leave it out: >
-- 			call map(myDict, {key -> 'item: ' . key})
-- <		If you do not use "key" you can use a short name: >
-- 			call map(myDict, {_, val -> 'item: ' . val})
-- <
-- 		The operation is done in-place.  If you want a |List| or
-- 		|Dictionary| to remain unmodified make a copy first: >
-- 			:let tlist = map(copy(mylist), ' v:val . "\t"')
--
-- <		Returns {expr1}, the |List| or |Dictionary| that was filtered.
-- 		When an error is encountered while evaluating {expr2} no
-- 		further items in {expr1} are processed. When {expr2} is a
-- 		Funcref errors inside a function are ignored, unless it was
-- 		defined with the "abort" flag.
--- @return list/dict
function vim.fn.map(expr1, expr2) end

-- Like |garbagecollect()|, but executed right away.  This must
-- 		only be called directly to avoid any structure to exist
-- 		internally, and |v:testing| must have been set before calling
-- 		any function.
--- @return none
function vim.fn.test_garbagecollect_now() end

-- {textlist} must be a |List| of strings.  This |List| is
-- 		displayed, one string per line.  The user will be prompted to
-- 		enter a number, which is returned.
-- 		The user can also select an item by clicking on it with the
-- 		mouse.  For the first string 0 is returned.  When clicking
-- 		above the first item a negative number is returned.  When
-- 		clicking on the prompt one more than the length of {textlist}
-- 		is returned.
-- 		Make sure {textlist} has less than 'lines' entries, otherwise
-- 		it won't work.  It's a good idea to put the entry number at
-- 		the start of the string.  And put a prompt in the first item.
-- 		Example: >
-- 			let color = inputlist(['Select color:', '1. red',
-- 				\ '2. green', '3. blue'])
--- @return number
function vim.fn.inputlist(textlist) end

-- The result is a Number, which is 1 if |Dictionary| {dict} has
-- 		an entry with key {key}.  Zero otherwise.
--- @param dict dictionary
--- @return number
function vim.fn.has_key(dict, key) end

-- Define a new sign named {name} or modify the attributes of an
-- 		existing sign.  This is similar to the |:sign-define| command.
--
-- 		Prefix {name} with a unique text to avoid name collisions.
-- 		There is no {group} like with placing signs.
--
-- 		The {name} can be a String or a Number.  The optional {dict}
-- 		argument specifies the sign attributes.  The following values
-- 		are supported:
-- 		    icon	full path to the bitmap file for the sign.
-- 		    linehl	highlight group used for the whole line the
-- 				sign is placed in.
-- 		    text	text that is displayed when there is no icon
-- 				or the GUI is not being used.
-- 		    texthl	highlight group used for the text item
-- 		    numhl	highlight group used for 'number' column at the
-- 				associated line. Overrides |hl-LineNr|,
-- 				|hl-CursorLineNr|.
--
-- 		If the sign named {name} already exists, then the attributes
-- 		of the sign are updated.
--
-- 		Returns 0 on success and -1 on failure.
--
-- 		Examples: >
-- 			call sign_define("mySign", {"text" : "=>", "texthl" :
-- 					\ "Error", "linehl" : "Search"})
--- @param dict dictionary
--- @return number
function vim.fn.sign_define(name, dict) end

-- Characters in {string} are queued for processing as if they
-- 		were typed by the user. This uses a low level input buffer.
-- 		This function works only when with |+unix| or GUI is running.
--
-- 		Can also be used as a |method|: >
-- 			GetText()->test_feedinput()
--- @return none
function vim.fn.test_feedinput(string) end

-- Set option or local variable {varname} in buffer {expr} to
-- 		{val}.
-- 		This also works for a global or local window option, but it
-- 		doesn't work for a global or local window variable.
-- 		For a local window option the global value is unchanged.
-- 		For the use of {expr}, see |bufname()| above.
-- 		Note that the variable name without "b:" must be used.
-- 		Examples: >
-- 			:call setbufvar(1, "&mod", 1)
-- 			:call setbufvar("todo", "myvar", "foobar")
-- <		This function is not available in the |sandbox|.
--- @return set
function vim.fn.setbufvar(expr, varname, val) end

-- The result is a dictionary, which holds information about the
-- 		swapfile {fname}. The available fields are:
-- 			version VIM version
-- 			user	user name
-- 			host	host name
-- 			fname	original file name
-- 			pid	PID of the VIM process that created the swap
-- 				file
-- 			mtime	last modification time in seconds
-- 			inode	Optional: INODE number of the file
-- 			dirty	1 if file was modified, 0 if not
-- 		In case of failure an "error" item is added with the reason:
-- 			Cannot open file: file not found or in accessible
-- 			Cannot read file: cannot read first block
-- 			Not a swap file: does not contain correct block ID
-- 			Magic number mismatch: Info in first block is invalid
--- @return dict
function vim.fn.swapinfo(fname) end

-- Get a line of text from the terminal window of {buf}.
-- 		{buf} is used as with |term_getsize()|.
--
-- 		The first line has {row} one.  When {row} is "." the cursor
-- 		line is used.  When {row} is invalid an empty string is
-- 		returned.
--
-- 		To get attributes of each character use |term_scrape()|.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getline(row)
--- @return string
function vim.fn.term_getline(buf, row) end

-- Return the arc cosine of {expr} measured in radians, as a
-- 		|Float| in the range of [0, pi].
-- 		{expr} must evaluate to a |Float| or a |Number| in the range
-- 		[-1, 1].
-- 		Examples: >
-- 			:echo acos(0)
-- <			1.570796 >
-- 			:echo acos(-0.5)
-- <			2.094395
--- @return float
function vim.fn.acos(expr) end

-- Get the value of a tab-local variable {varname} in tab page
-- 		{tabnr}. |t:var|
-- 		Tabs are numbered starting with one.
-- 		When {varname} is empty a dictionary with all tab-local
-- 		variables is returned.
-- 		Note that the name without "t:" must be used.
-- 		When the tab or variable doesn't exist {def} or an empty
-- 		string is returned, there is no error message.
function vim.fn.gettabvar(nr, varname, def) end

-- Return a list with the buffer numbers of all buffers for
-- 		terminal windows.
--- @return list
function vim.fn.term_list() end

-- When {pattern} does not match {actual} an error message is
-- 		added to |v:errors|.  Also see |assert-return|.
--
-- 		{pattern} is used as with |=~|: The matching is always done
-- 		like 'magic' was set and 'cpoptions' is empty, no matter what
-- 		the actual value of 'magic' or 'cpoptions' is.
--
-- 		{actual} is used as a string, automatic conversion applies.
-- 		Use "^" and "$" to match with the start and end of the text.
-- 		Use both to match the whole text.
--
-- 		When {msg} is omitted an error in the form
-- 		"Pattern {pattern} does not match {actual}" is produced.
-- 		Example: >
-- 	assert_match('^f.*o$', 'foobar')
-- <		Will result in a string to be added to |v:errors|:
-- 	test.vim line 12: Pattern '^f.*o$' does not match 'foobar' ~
--- @return number
function vim.fn.assert_match(pat, text, msg) end

-- Get the title of terminal {buf}. This is the title that the
-- 		job in the terminal has set.
--
-- 		{buf} must be the buffer number of a terminal window. If the
-- 		buffer does not exist or is not a terminal window, an empty
-- 		string is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_gettitle()
--- @return string
function vim.fn.term_gettitle(buf) end

-- Send a reply string to {clientid}.  The most recent {clientid}
-- 		that sent a string can be retrieved with expand("<client>").
-- 		Note:
-- 		This id has to be stored before the next command can be
-- 		received.  I.e. before returning from the received command and
-- 		before calling any commands that waits for input.
-- 		See also |clientserver|.
-- 		Example: >
-- 			:echo server2client(expand("<client>"), "HELLO")
--- @return number
function vim.fn.server2client(clientid, string) end

-- Set line {lnum} of the current buffer to {text}.  To insert
-- 		lines use |append()|. To set lines in another buffer use
-- 		|setbufline()|.
--
-- 		{lnum} is used like with |getline()|.
-- 		When {lnum} is just below the last line the {text} will be
-- 		added as a new line.
--
-- 		If this succeeds, 0 is returned.  If this fails (most likely
-- 		because {lnum} is invalid) 1 is returned.
--
-- 		Example: >
-- 			:call setline(5, strftime("%c"))
--
-- <		When {text} is a |List| then line {lnum} and following lines
-- 		will be set to the items in the list.  Example: >
-- 			:call setline(5, ['aaa', 'bbb', 'ccc'])
-- <		This is equivalent to: >
-- 			:for [n, l] in [[5, 'aaa'], [6, 'bbb'], [7, 'ccc']]
-- 			:  call setline(n, l)
-- 			:endfor
--
-- <		Note: The '[ and '] marks are not set.
--- @return number
function vim.fn.setline(lnum, line) end

-- If the popup menu (see |ins-completion-menu|) is not visible,
--  		returns an empty |Dictionary|, otherwise, returns a
--  		|Dictionary| with the following keys:
--  			height		nr of items visible
--  			width		screen cells
--  			row		top screen row (0 first row)
--  			col		leftmost screen column (0 first col)
--  			size		total nr of items
--  			scrollbar	|TRUE| if visible
--
--   		The values are the same as in |v:event| during |CompleteChanged|.
--- @return dict
function vim.fn.pum_getpos() end

-- Without {flags} or with {flags} empty: Deletes the file by the
-- 		name {fname}.  This also works when {fname} is a symbolic link.
-- 		A symbolic link itself is deleted, not what it points to.
--
-- 		When {flags} is "d": Deletes the directory by the name
-- 		{fname}.  This fails when directory {fname} is not empty.
--
-- 		When {flags} is "rf": Deletes the directory by the name
-- 		{fname} and everything in it, recursively.  BE CAREFUL!
-- 		Note: on MS-Windows it is not possible to delete a directory
-- 		that is being used.
--
-- 		The result is a Number, which is 0 if the delete operation was
-- 		successful and -1 when the deletion failed or partly failed.
--- @return number
function vim.fn.delete(fname, flags) end

