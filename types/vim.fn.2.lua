--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Deletes a match with ID {id} previously defined by |matchadd()|
-- 		or one of the |:match| commands.  Returns 0 if successful,
-- 		otherwise -1.  See example for |matchadd()|.  All matches can
-- 		be deleted in one operation by |clearmatches()|.
--- @return number
function vim.fn.matchdelete(id) end

-- Return the PID (process id) of |job-id| {job}.
--- @return number
function vim.fn.jobpid(id) end

-- Call function {func} with the items in |List| {arglist} as
-- 		arguments.
-- 		{func} can either be a |Funcref| or the name of a function.
-- 		a:firstline and a:lastline are set to the cursor line.
-- 		Returns the return value of the called function.
-- 		{dict} is for functions with the "dict" attribute.  It will be
-- 		used to set the local variable "self". |Dictionary-function|
--- @param dict dictionary
function vim.fn.call(func, arglist, dict) end

-- Defines a pattern to be highlighted in the current window (a
-- 		"match").  It will be highlighted with {group}.  Returns an
-- 		identification number (ID), which can be used to delete the
-- 		match using |matchdelete()|.
-- 		Matching is case sensitive and magic, unless case sensitivity
-- 		or magicness are explicitly overridden in {pattern}.  The
-- 		'magic', 'smartcase' and 'ignorecase' options are not used.
-- 		The "Conceal" value is special, it causes the match to be
-- 		concealed.
--
-- 		The optional {priority} argument assigns a priority to the
-- 		match.  A match with a high priority will have its
-- 		highlighting overrule that of a match with a lower priority.
-- 		A priority is specified as an integer (negative numbers are no
-- 		exception).  If the {priority} argument is not specified, the
-- 		default priority is 10.  The priority of 'hlsearch' is zero,
-- 		hence all matches with a priority greater than zero will
-- 		overrule it.  Syntax highlighting (see 'syntax') is a separate
-- 		mechanism, and regardless of the chosen priority a match will
-- 		always overrule syntax highlighting.
--
-- 		The optional {id} argument allows the request for a specific
-- 		match ID.  If a specified ID is already taken, an error
-- 		message will appear and the match will not be added.  An ID
-- 		is specified as a positive integer (zero excluded).  IDs 1, 2
-- 		and 3 are reserved for |:match|, |:2match| and |:3match|,
-- 		respectively.  If the {id} argument is not specified or -1,
-- 		|matchadd()| automatically chooses a free ID.
--
-- 		The optional {dict} argument allows for further custom
-- 		values. Currently this is used to specify a match specific
-- 		conceal character that will be shown for |hl-Conceal|
-- 		highlighted matches. The dict can have the following members:
--
-- 			conceal	    Special character to show instead of the
-- 				    match (only for |hl-Conceal| highlighed
-- 				    matches, see |:syn-cchar|)
-- 			window	    Instead of the current window use the
-- 				    window with this number or window ID.
--
-- 		The number of matches is not limited, as it is the case with
-- 		the |:match| commands.
--
-- 		Example: >
-- 			:highlight MyGroup ctermbg=green guibg=green
-- 			:let m = matchadd("MyGroup", "TODO")
-- <		Deletion of the pattern: >
-- 			:call matchdelete(m)
--
-- <		A list of matches defined by |matchadd()| and |:match| are
-- 		available from |getmatches()|.  All matches can be deleted in
-- 		one operation by |clearmatches()|.
--- @return number
function vim.fn.matchadd(group, pattern, priority, id) end

-- Sends {event} to {channel} via |RPC| and returns immediately.
-- 		If {channel} is 0, the event is broadcast to all channels.
-- 		Example: >
-- 			:au VimLeave call rpcnotify(0, "leaving")
--- @return sends
function vim.fn.rpcnotify(channel, event, ...) end

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

-- Return the lowest index in |List| {list} where the item has a
-- 		value equal to {expr}.  There is no automatic conversion, so
-- 		the String "4" is different from the Number 4.  And the number
-- 		4 is different from the Float 4.0.  The value of 'ignorecase'
-- 		is not used here, case always matters.
-- 		If {start} is given then start looking at the item with index
-- 		{start} (may be negative for an item relative to the end).
-- 		When {ic} is given and it is |TRUE|, ignore case.  Otherwise
-- 		case must match.
-- 		-1 is returned when {expr} is not found in {list}.
-- 		Example: >
-- 			:let idx = index(words, "the")
-- 			:if index(numbers, 123) >= 0
--- @param list any[]
--- @return number
function vim.fn.index(list, expr, start, ic) end

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

-- Return the byte count from the start of the buffer for line
-- 		{lnum}.  This includes the end-of-line character, depending on
-- 		the 'fileformat' option for the current buffer.  The first
-- 		line returns 1. UTF-8 encoding is used, 'fileencoding' is
-- 		ignored.  This can also be used to get the byte count for the
-- 		line just below the last line: >
-- 			line2byte(line("$") + 1)
-- <		This is the buffer size plus one.  If 'fileencoding' is empty
-- 		it is the file size plus one.
-- 		When {lnum} is invalid -1 is returned.
-- 		Also see |byte2line()|, |go| and |:goto|.
--- @return number
function vim.fn.line2byte(lnum) end

-- Convert each number in {list} to a character string can
-- 		concatenate them all.  Examples: >
-- 			list2str([32])		returns " "
-- 			list2str([65, 66, 67])	returns "ABC"
-- <		The same can be done (slowly) with: >
-- 			join(map(list, {nr, val -> nr2char(val)}), '')
-- <		|str2list()| does the opposite.
--
-- 		When {utf8} is omitted or zero, the current 'encoding' is used.
-- 		With {utf8} is 1, always return utf-8 characters.
-- 		With utf-8 composing characters work as expected: >
-- 			list2str([97, 769])	returns "á"
--- @param list any[]
--- @return string
function vim.fn.list2str(list, utf8) end

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

-- Evaluate Lua expression {expr} and return its result converted
-- 		to Vim data structures. See |lua-eval| for more details.
function vim.fn.luaeval(expr, expr) end

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

-- Same as |matchadd()|, but requires a list of positions {pos}
-- 		instead of a pattern. This command is faster than |matchadd()|
-- 		because it does not require to handle regular expressions and
-- 		sets buffer line boundaries to redraw screen. It is supposed
-- 		to be used when fast match additions and deletions are
-- 		required, for example to highlight matching parentheses.
-- 							*E5030* *E5031*
-- 		The list {pos} can contain one of these items:
-- 		- A number.  This whole line will be highlighted.  The first
-- 		  line has number 1.
-- 		- A list with one number, e.g., [23]. The whole line with this
-- 		  number will be highlighted.
-- 		- A list with two numbers, e.g., [23, 11]. The first number is
-- 		  the line number, the second one is the column number (first
-- 		  column is 1, the value must correspond to the byte index as
-- 		  |col()| would return).  The character at this position will
-- 		  be highlighted.
-- 		- A list with three numbers, e.g., [23, 11, 3]. As above, but
-- 		  the third number gives the length of the highlight in bytes.
--
-- 		Entries with zero and negative line numbers are silently
-- 		ignored, as well as entries with negative column numbers and
-- 		lengths.
--
-- 		The maximum number of positions is 8.
--
-- 		Example: >
-- 			:highlight MyGroup ctermbg=green guibg=green
-- 			:let m = matchaddpos("MyGroup", [[23, 24], 34])
-- <		Deletion of the pattern: >
-- 			:call matchdelete(m)
--
-- <		Matches added by |matchaddpos()| are returned by
-- 		|getmatches()| with an entry "pos1", "pos2", etc., with the
-- 		value a list like the {pos} item.
--- @param list any[]
--- @return number
function vim.fn.matchaddpos(group, list, priority, id) end

-- Selects the {nr} match item, as set with a |:match|,
-- 		|:2match| or |:3match| command.
-- 		Return a |List| with two elements:
-- 			The name of the highlight group used
-- 			The pattern used.
-- 		When {nr} is not 1, 2 or 3 returns an empty |List|.
-- 		When there is no match item set returns ['', ''].
-- 		This is useful to save and restore a |:match|.
-- 		Highlighting matches using the |:match| commands are limited
-- 		to three matches. |matchadd()| does not have this limitation.
--- @return list
function vim.fn.matcharg(nr) end

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

-- Stop a timer.  The timer callback will no longer be invoked.
-- 		{timer} is an ID returned by timer_start(), thus it must be a
-- 		Number.  If {timer} does not exist there is no error.
--- @return none
function vim.fn.timer_stop(timer) end

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

-- Return the position of the cursor in the command line as a
-- 		byte count.  The first column is 1.
-- 		Only works when editing the command line, thus requires use of
-- 		|c_CTRL-\_e| or |c_CTRL-R_=| or an expression mapping.
-- 		Returns 0 otherwise.
-- 		Also see |getcmdtype()|, |setcmdpos()| and |getcmdline()|.
--- @return number
function vim.fn.getcmdpos() end

-- Return the line number of the first line at or below {lnum}
-- 		that is not blank.  Example: >
-- 			if getline(nextnonblank(1)) =~ "Java"
-- <		When {lnum} is invalid or there is no non-blank line at or
-- 		below it, zero is returned.
-- 		See also |prevnonblank()|.
--- @return number
function vim.fn.nextnonblank(lnum) end

-- Shorten directory names in the path {expr} and return the
-- 		result.  The tail, the file name, is kept as-is.  The other
-- 		components in the path are reduced to single letters.  Leading
-- 		'~' and '.' characters are kept.  Example: >
-- 			:echo pathshorten('~/.config/nvim/autoload/file1.vim')
-- <			~/.c/n/a/file1.vim ~
-- 		It doesn't matter if the path exists or not.
--- @return string
function vim.fn.pathshorten(expr) end

--- @return none
function vim.fn.prompt_addtext(buf, expr) end

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

-- The result is the {nr}th file in the argument list.  See
-- 		|arglist|.  "argv(0)" is the first one.  Example: >
-- 	:let i = 0
-- 	:while i < argc()
-- 	:  let f = escape(fnameescape(argv(i)), '.')
-- 	:  exe 'amenu Arg.' . f . ' :e ' . f . '<CR>'
-- 	:  let i = i + 1
-- 	:endwhile
-- <		Without the {nr} argument, or when {nr} is -1, a |List| with
-- 		the whole |arglist| is returned.
--
-- 		The {winid} argument specifies the window ID, see |argc()|.
--- @return list
function vim.fn.argv(_1, winid) end

-- The result is a Number, which is |TRUE| if a buffer called
-- 		{expr} exists.
-- 		If the {expr} argument is a number, buffer numbers are used.
-- 		Number zero is the alternate buffer for the current window.
--
-- 		If the {expr} argument is a string it must match a buffer name
-- 		exactly.  The name can be:
-- 		- Relative to the current directory.
-- 		- A full path.
-- 		- The name of a buffer with 'buftype' set to "nofile".
-- 		- A URL name.
-- 		Unlisted buffers will be found.
-- 		Note that help files are listed by their short name in the
-- 		output of |:buffers|, but bufexists() requires using their
-- 		long name to be able to find them.
-- 		bufexists() may report a buffer exists, but to use the name
-- 		with a |:buffer| command you may need to use |expand()|.  Esp
-- 		for MS-Windows 8.3 names in the form "c:\DOCUME~1"
-- 		Use "bufexists(0)" to test for the existence of an alternate
-- 		file name.
--- @return number
function vim.fn.bufexists(expr) end

-- The result is the number of files in the argument list.  See
-- 		|arglist|.
-- 		If {winid} is not supplied, the argument list of the current
-- 		window is used.
-- 		If {winid} is -1, the global argument list is used.
-- 		Otherwise {winid} specifies the window of which the argument
-- 		list is used: either the window number or the window ID.
-- 		Returns -1 if the {winid} argument is invalid.
--- @return number
function vim.fn.argc(winid) end

-- Return the Number 1 if {expr} is empty, zero otherwise.
-- 		A |List| or |Dictionary| is empty when it does not have any
-- 		items.  A Number is empty when its value is zero.  Special
-- 		variable is empty when it is |v:false| or |v:null|.
--- @return number
function vim.fn.empty(expr) end

-- Return a |List| with all the keys of {dict}.  The |List| is in
-- 		arbitrary order.
--- @param dict dictionary
--- @return list
function vim.fn.keys(dict) end

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

-- The result is a String, which is the {what} attribute of
-- 		syntax ID {synID}.  This can be used to obtain information
-- 		about a syntax item.
-- 		{mode} can be "gui", "cterm" or "term", to get the attributes
-- 		for that mode.  When {mode} is omitted, or an invalid value is
-- 		used, the attributes for the currently active highlighting are
-- 		used (GUI, cterm or term).
-- 		Use synIDtrans() to follow linked highlight groups.
-- 		{what}		result
-- 		"name"		the name of the syntax item
-- 		"fg"		foreground color (GUI: color name used to set
-- 				the color, cterm: color number as a string,
-- 				term: empty string)
-- 		"bg"		background color (as with "fg")
-- 		"font"		font name (only available in the GUI)
-- 				|highlight-font|
-- 		"sp"		special color (as with "fg") |highlight-guisp|
-- 		"fg#"		like "fg", but for the GUI and the GUI is
-- 				running the name in "#RRGGBB" form
-- 		"bg#"		like "fg#" for "bg"
-- 		"sp#"		like "fg#" for "sp"
-- 		"bold"		"1" if bold
-- 		"italic"	"1" if italic
-- 		"reverse"	"1" if reverse
-- 		"inverse"	"1" if inverse (= reverse)
-- 		"standout"	"1" if standout
-- 		"underline"	"1" if underlined
-- 		"undercurl"	"1" if undercurled
-- 		"strikethrough"	"1" if struckthrough
--
-- 		Example (echoes the color of the syntax item under the
-- 		cursor): >
-- 	:echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg")
--- @return string
function vim.fn.synIDattr(synID, what, mode) end

-- Add a buffer to the buffer list with {name}.
-- 		If a buffer for file {name} already exists, return that buffer
-- 		number.  Otherwise return the buffer number of the newly
-- 		created buffer.  When {name} is an empty string then a new
-- 		buffer is always created.
-- 		The buffer will not have' 'buflisted' set.
--- @return number
function vim.fn.bufadd(name) end

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

-- The result is a String, which is part of {src}, starting from
-- 		byte {start}, with the byte length {len}.
-- 		To count characters instead of bytes use |strcharpart()|.
--
-- 		When bytes are selected which do not exist, this doesn't
-- 		result in an error, the bytes are simply omitted.
-- 		If {len} is missing, the copy continues from {start} till the
-- 		end of the {src}. >
-- 			strpart("abcdefg", 3, 2)    == "de"
-- 			strpart("abcdefg", -2, 4)   == "ab"
-- 			strpart("abcdefg", 5, 4)    == "fg"
-- 			strpart("abcdefg", 3)	    == "defg"
--
-- <		Note: To get the first character, {start} must be 0.  For
-- 		example, to get three bytes under and after the cursor: >
-- 			strpart(getline("."), col(".") - 1, 3)
--- @return string
function vim.fn.strpart(str, start, len) end

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

-- The result is a Number, which is the width of window {nr}.
-- 		{nr} can be the window number or the |window-ID|.
-- 		When {nr} is zero, the width of the current window is
-- 		returned.  When window {nr} doesn't exist, -1 is returned.
-- 		An existing window always has a width of zero or more.
-- 		Examples: >
--   :echo "The current window has " . winwidth(0) . " columns."
--   :if winwidth(0) <= 50
--   :  50 wincmd |
--   :endif
-- <		For getting the terminal or screen size, see the 'columns'
-- 		option.
--- @return number
function vim.fn.winwidth(nr) end

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

-- Put up a file requester.  This only works when "has("browse")"
-- 		returns |TRUE| (only in some GUI versions).
-- 		The input fields are:
-- 		    {save}	when |TRUE|, select file to write
-- 		    {title}	title for the requester
-- 		    {initdir}	directory to start browsing in
-- 		    {default}	default file name
-- 		When the "Cancel" button is hit, something went wrong, or
-- 		browsing is not possible, an empty string is returned.
--- @return string
function vim.fn.browse(save, title, initdir, default) end

-- Dump the contents of the terminal screen of {buf} in the file
-- 		{filename}.  This uses a format that can be used with
-- 		|term_dumpload()| and |term_dumpdiff()|.
-- 		If the job in the terminal already finished an error is given:
-- 		*E958*
-- 		If {filename} already exists an error is given:	*E953*
-- 		Also see |terminal-diff|.
--
-- 		{options} is a dictionary with these optional entries:
-- 			"rows"		maximum number of rows to dump
-- 			"columns"	maximum number of columns to dump
--
-- 		Can also be used as a |method|, the base is used for the file
-- 		name: >
-- 			GetFilename()->term_dumpwrite(bufnr)
--- @return none
function vim.fn.term_dumpwrite(buf, filename, options) end

-- Send {string} over {handle}.
-- 		{handle} can be a Channel or a Job that has a Channel.
--
-- 		Works like |ch_evalexpr()|, but does not encode the request or
-- 		decode the response.  The caller is responsible for the
-- 		correct contents.  Also does not add a newline for a channel
-- 		in NL mode, the caller must do that.  The NL in the response
-- 		is removed.
-- 		Note that Vim does not know when the text received on a raw
-- 		channel is complete, it may only return the first part and you
-- 		need to use |ch_readraw()| to fetch the rest.
-- 		See |channel-use|.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_evalraw(rawstring)
function vim.fn.ch_evalraw(handle, string, options) end

-- current buffer.  The indent is counted in spaces, the value
-- 		of 'tabstop' is relevant.  {lnum} is used just like in
-- 		|getline()|.
-- 		When {lnum} is invalid -1 is returned.
--- @return number
function vim.fn.indent(lnum) end

-- Get the buffer number that {handle} is using for {what}.
-- 		{handle} can be a Channel or a Job that has a Channel.
-- 		{what} can be "err" for stderr, "out" for stdout or empty for
-- 		socket output.
-- 		Returns -1 when there is no buffer.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_getbufnr(what)
--- @return number
function vim.fn.ch_getbufnr(handle, what) end

-- Get the Job associated with {channel}.
-- 		If there is no job calling |job_status()| on the returned Job
-- 		will result in "fail".
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_getjob()
--- @return job
function vim.fn.ch_getjob(channel) end

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

-- Returns a Dictionary with information about {handle}.  The
-- 		items are:
-- 		   "id"		  number of the channel
-- 		   "status"	  "open", "buffered" or "closed", like
-- 				  ch_status()
-- 		When opened with ch_open():
-- 		   "hostname"	  the hostname of the address
-- 		   "port"	  the port of the address
-- 		   "sock_status"  "open" or "closed"
-- 		   "sock_mode"	  "NL", "RAW", "JSON" or "JS"
-- 		   "sock_io"	  "socket"
-- 		   "sock_timeout" timeout in msec
-- 		When opened with job_start():
-- 		   "out_status"	  "open", "buffered" or "closed"
-- 		   "out_mode"	  "NL", "RAW", "JSON" or "JS"
-- 		   "out_io"	  "null", "pipe", "file" or "buffer"
-- 		   "out_timeout"  timeout in msec
-- 		   "err_status"	  "open", "buffered" or "closed"
-- 		   "err_mode"	  "NL", "RAW", "JSON" or "JS"
-- 		   "err_io"	  "out", "null", "pipe", "file" or "buffer"
-- 		   "err_timeout"  timeout in msec
-- 		   "in_status"	  "open" or "closed"
-- 		   "in_mode"	  "NL", "RAW", "JSON" or "JS"
-- 		   "in_io"	  "null", "pipe", "file" or "buffer"
-- 		   "in_timeout"	  timeout in msec
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_info()
--- @return string
function vim.fn.ch_info(handle) end

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

-- Write {msg} in the channel log file, if it was opened with
-- 		|ch_logfile()|.
-- 		When {handle} is passed the channel number is used for the
-- 		message.
-- 		{handle} can be a Channel or a Job that has a Channel.  The
-- 		Channel must be open for the channel number to be used.
--
-- 		Can also be used as a |method|: >
-- 			'did something'->ch_log()
--- @return none
function vim.fn.ch_log(msg, handle) end

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

-- Start logging channel activity to {fname}.
-- 		When {fname} is an empty string: stop logging.
--
-- 		When {mode} is omitted or "a" append to the file.
-- 		When {mode} is "w" start with an empty file.
--
-- 		Use |ch_log()| to write log messages.  The file is flushed
-- 		after every message, on Unix you can use "tail -f" to see what
-- 		is going on in real time.
--
-- 		This function is not available in the |sandbox|.
-- 		NOTE: the channel communication is stored in the file, be
-- 		aware that this may contain confidential and privacy sensitive
-- 		information, e.g. a password you type in a terminal window.
--
-- 		Can also be used as a |method|: >
-- 			'logfile'->ch_logfile('w')
--- @return none
function vim.fn.ch_logfile(fname, mode) end

-- Escape {string} for use as file name command argument.  All
-- 		characters that have a special meaning, such as '%' and '|'
-- 		are escaped with a backslash.
-- 		For most systems the characters escaped are
-- 		" \t\n*?[{`$\\%#'\"|!<".  For systems where a backslash
-- 		appears in a filename, it depends on the value of 'isfname'.
-- 		A leading '+' and '>' is also escaped (special after |:edit|
-- 		and |:write|).  And a "-" by itself (special after |:cd|).
-- 		Example: >
-- 			:let fname = '+some str%nge|name'
-- 			:exe "edit " . fnameescape(fname)
-- <		results in executing: >
-- 			edit \+some\ str\%nge\|name
--- @return string
function vim.fn.fnameescape(fname) end

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

-- Pushes the current editor state (|context|) on the
-- 		|context-stack|.
-- 		If {types} is given and is a |List| of |String|s, it specifies
-- 		which |context-types| to include in the pushed context.
-- 		Otherwise, all context types are included.
--- @return none
function vim.fn.ctxpush(types) end

-- The result is a Number, which is the current screen row of the
-- 		cursor.  The top line has number one.
-- 		This function is mainly used for testing.
-- 		Alternatively you can use |winline()|.
--
-- 		Note: Same restrictions as with |screencol()|.
--- @return number
function vim.fn.screenrow() end

-- Read from {handle} and return the received message.
-- 		{handle} can be a Channel or a Job that has a Channel.
-- 		For a NL channel this waits for a NL to arrive, except when
-- 		there is nothing more to read (channel was closed).
-- 		See |channel-more|.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_read()
--- @return string
function vim.fn.ch_read(handle, options) end

-- Returns non-zero when the popup menu is visible, zero
-- 		otherwise.  See |ins-completion-menu|.
-- 		This can be used to avoid some things that would remove the
-- 		popup menu.
--- @return number
function vim.fn.pumvisible() end

-- Like ch_read() but reads binary data and returns a |Blob|.
-- 		See |channel-more|.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_readblob()
--- @return blob
function vim.fn.ch_readblob(handle, options) end

-- Set the position for {expr}.  Possible values:
-- 			.	the cursor
-- 			'x	mark x
--
-- 		{list} must be a |List| with four or five numbers:
-- 		    [bufnum, lnum, col, off]
-- 		    [bufnum, lnum, col, off, curswant]
--
-- 		"bufnum" is the buffer number.	Zero can be used for the
-- 		current buffer.  When setting an uppercase mark "bufnum" is
-- 		used for the mark position.  For other marks it specifies the
-- 		buffer to set the mark in.  You can use the |bufnr()| function
-- 		to turn a file name into a buffer number.
-- 		For setting the cursor and the ' mark "bufnum" is ignored,
-- 		since these are associated with a window, not a buffer.
-- 		Does not change the jumplist.
--
-- 		"lnum" and "col" are the position in the buffer.  The first
-- 		column is 1.  Use a zero "lnum" to delete a mark.  If "col" is
-- 		smaller than 1 then 1 is used.
--
-- 		The "off" number is only used when 'virtualedit' is set. Then
-- 		it is the offset in screen columns from the start of the
-- 		character.  E.g., a position within a <Tab> or after the last
-- 		character.
--
-- 		The "curswant" number is only used when setting the cursor
-- 		position.  It sets the preferred column for when moving the
-- 		cursor vertically.  When the "curswant" number is missing the
-- 		preferred column is not set.  When it is present and setting a
-- 		mark position it is not used.
--
-- 		Note that for '< and '> changing the line number may result in
-- 		the marks to be effectively be swapped, so that '< is always
-- 		before '>.
--
-- 		Returns 0 when the position could be set, -1 otherwise.
-- 		An error message is given if {expr} is invalid.
--
-- 		Also see |getpos()| and |getcurpos()|.
--
-- 		This does not restore the preferred column for moving
-- 		vertically; if you set the cursor position with this, |j| and
-- 		|k| motions will jump to previous columns!  Use |cursor()| to
-- 		also set the preferred column.  Also see the "curswant" key in
-- 		|winrestview()|.
--- @param list any[]
--- @return number
function vim.fn.setpos(expr, list) end

-- Stop all timers.  The timer callbacks will no longer be
-- 		invoked.  Useful if some timers is misbehaving.  If there are
-- 		no timers there is no error.
--- @return none
function vim.fn.timer_stopall() end

-- Like ch_read() but for a JS and JSON channel does not decode
-- 		the message.  For a NL channel it does not block waiting for
-- 		the NL to arrive, but otherwise works like ch_read().
-- 		See |channel-more|.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_readraw()
--- @return string
function vim.fn.ch_readraw(handle, options) end

-- When {expected} and {actual} are not equal an error message is
-- 		added to |v:errors| and 1 is returned.  Otherwise zero is
-- 		returned |assert-return|.
-- 		There is no automatic conversion, the String "4" is different
-- 		from the Number 4.  And the number 4 is different from the
-- 		Float 4.0.  The value of 'ignorecase' is not used here, case
-- 		always matters.
-- 		When {msg} is omitted an error in the form "Expected
-- 		{expected} but got {actual}" is produced.
-- 		Example: >
-- 	assert_equal('foo', 'bar')
-- <		Will result in a string to be added to |v:errors|:
-- 	test.vim line 12: Expected 'foo' but got 'bar' ~
--- @return number
function vim.fn.assert_equal(exp, act, msg) end

-- Send {expr} over {handle}.  The {expr} is encoded
-- 		according to the type of channel.  The function cannot be used
-- 		with a raw channel.
-- 		See |channel-use|.				*E912*
-- 		{handle} can be a Channel or a Job that has a Channel.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_sendexpr(expr)
function vim.fn.ch_sendexpr(handle, expr, options) end

-- The result is a Dict with the screen position of the text
-- 		character in window {winid} at buffer line {lnum} and column
-- 		{col}.  {col} is a one-based byte index.
-- 		The Dict has these members:
-- 			row	screen row
-- 			col	first screen column
-- 			endcol	last screen column
-- 			curscol	cursor screen column
-- 		If the specified position is not visible, all values are zero.
-- 		The "endcol" value differs from "col" when the character
-- 		occupies more than one screen cell.  E.g. for a Tab "col" can
-- 		be 1 and "endcol" can be 8.
-- 		The "curscol" value is where the cursor would be placed.  For
-- 		a Tab it would be the same as "endcol", while for a double
-- 		width character it would be the same as "col".
--- @return dict
function vim.fn.screenpos(winid, lnum, col) end

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

-- the first file.  argc() - 1 is the last one.  See |arglist|.
--- @return number
function vim.fn.argidx() end

-- in the window.  This is counting screen lines from the top of
-- 		the window.  The first line is one.
-- 		If the cursor was moved the view on the file will be updated
-- 		first, this may cause a scroll.
--- @return number
function vim.fn.winline() end

-- Return the argument list ID.  This is a number which
-- 		identifies the argument list being used.  Zero is used for the
-- 		global argument list.  See |arglist|.
-- 		Returns -1 if the arguments are invalid.
--
-- 		Without arguments use the current window.
-- 		With {winnr} only use this window in the current tab page.
-- 		With {winnr} and {tabnr} use the window in the specified tab
-- 		page.
-- 		{winnr} can be the window number or the |window-ID|.
--- @return number
function vim.fn.arglistid(winnr, tabnr) end

-- cursor in the window.  This is counting screen cells from the
-- 		left side of the window.  The leftmost column is one.
--- @return number
function vim.fn.wincol() end

-- Escape the characters in {chars} that occur in {string} with a
-- 		backslash.  Example: >
-- 			:echo escape('c:\program files\vim', ' \')
-- <		results in: >
-- 			c:\\program\ files\\vim
-- <		Also see |shellescape()| and |fnameescape()|.
--- @return string
function vim.fn.escape(string, chars) end

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

-- Run {cmd} and add an error message to |v:errors| if it does
-- 		NOT produce a beep or visual bell.
-- 		Also see |assert_fails()| and |assert-return|.
--- @return number
function vim.fn.assert_beeps(cmd) end

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

-- Get the |window-ID| for the specified window.
-- 		When {win} is missing use the current window.
-- 		With {win} this is the window number.  The top window has
-- 		number 1.
-- 		Without {tab} use the current tab, otherwise the tab with
-- 		number {tab}.  The first tab has number one.
-- 		Return zero if the window cannot be found.
--- @return number
function vim.fn.win_getid(win, tab) end

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

