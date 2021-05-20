--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- The result is a Number, which is the current screen column of
-- 		the cursor. The leftmost column has number 1.
-- 		This function is mainly used for testing.
--
-- 		Note: Always returns the current screen column, thus if used
-- 		in a command (e.g. ":echo screencol()") it will return the
-- 		column inside the command line, which is 1 when the command is
-- 		executed. To get the cursor position in the file use one of
-- 		the following mappings: >
-- 			nnoremap <expr> GG ":echom ".screencol()."\n"
-- 			nnoremap <silent> GG :echom screencol()<CR>
-- 			noremap GG <Cmd>echom screencol()<Cr>
--- @return number
function vim.fn.screencol() end

-- Convert {expr} from JSON object.  Accepts |readfile()|-style
-- 		list as the input, as well as regular string.  May output any
-- 		Vim value. In the following cases it will output
-- 		|msgpack-special-dict|:
-- 		1. Dictionary contains duplicate key.
-- 		2. Dictionary contains empty key.
-- 		3. String contains NUL byte.  Two special dictionaries: for
-- 		   dictionary and for string will be emitted in case string
-- 		   with NUL byte was a dictionary key.
--
-- 		Note: function treats its input as UTF-8 always.  The JSON
-- 		standard allows only a few encodings, of which UTF-8 is
-- 		recommended and the only one required to be supported.
-- 		Non-UTF-8 characters are an error.
function vim.fn.json_decode(expr) end

-- Sends a request to {channel} to invoke {method} via
-- 		|RPC| and blocks until a response is received.
-- 		Example: >
-- 			:let result = rpcrequest(rpc_chan, "func", 1, 2, 3)
--- @return sends
function vim.fn.rpcrequest(channel, method, ...) end

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

-- Returns a String with the status of {job}:
-- 			"run"	job is running
-- 			"fail"	job failed to start
-- 			"dead"	job died or was stopped after running
--
-- 		On Unix a non-existing command results in "dead" instead of
-- 		"fail", because a fork happens before the failure can be
-- 		detected.
--
-- 		If an exit callback was set with the "exit_cb" option and the
-- 		job is now detected to be "dead" the callback will be invoked.
--
-- 		For more information see |job_info()|.
--
-- 		Can also be used as a |method|: >
-- 			GetJob()->job_status()
--- @return string
function vim.fn.job_status(job) end

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

-- Search for the declaration of {name}.
--
-- 		With a non-zero {global} argument it works like |gD|, find
-- 		first match in the file.  Otherwise it works like |gd|, find
-- 		first match in the function.
--
-- 		With a non-zero {thisblock} argument matches in a {} block
-- 		that ends before the cursor position are ignored.  Avoids
-- 		finding variable declarations only valid in another scope.
--
-- 		Moves the cursor to the found match.
-- 		Returns zero for success, non-zero for failure.
-- 		Example: >
-- 			if searchdecl('myvar') == 0
-- 			   echo getline('.')
-- 			endif
-- <
-- 							*searchpair()*
-- searchpair({start}, {middle}, {end} [, {flags} [, {skip}
-- 				[, {stopline} [, {timeout}]]]])
-- 		Search for the match of a nested start-end pair.  This can be
-- 		used to find the "endif" that matches an "if", while other
-- 		if/endif pairs in between are ignored.
-- 		The search starts at the cursor.  The default is to search
-- 		forward, include 'b' in {flags} to search backward.
-- 		If a match is found, the cursor is positioned at it and the
-- 		line number is returned.  If no match is found 0 or -1 is
-- 		returned and the cursor doesn't move.  No error message is
-- 		given.
--
-- 		{start}, {middle} and {end} are patterns, see |pattern|.  They
-- 		must not contain \( \) pairs.  Use of \%( \) is allowed.  When
-- 		{middle} is not empty, it is found when searching from either
-- 		direction, but only when not in a nested start-end pair.  A
-- 		typical use is: >
-- 			searchpair('\<if\>', '\<else\>', '\<endif\>')
-- <		By leaving {middle} empty the "else" is skipped.
--
-- 		{flags} 'b', 'c', 'n', 's', 'w' and 'W' are used like with
-- 		|search()|.  Additionally:
-- 		'r'	Repeat until no more matches found; will find the
-- 			outer pair.  Implies the 'W' flag.
-- 		'm'	Return number of matches instead of line number with
-- 			the match; will be > 1 when 'r' is used.
-- 		Note: it's nearly always a good idea to use the 'W' flag, to
-- 		avoid wrapping around the end of the file.
--
-- 		When a match for {start}, {middle} or {end} is found, the
-- 		{skip} expression is evaluated with the cursor positioned on
-- 		the start of the match.  It should return non-zero if this
-- 		match is to be skipped.  E.g., because it is inside a comment
-- 		or a string.
-- 		When {skip} is omitted or empty, every match is accepted.
-- 		When evaluating {skip} causes an error the search is aborted
-- 		and -1 returned.
--  		{skip} can be a string, a lambda, a funcref or a partial.
-- 		Anything else makes the function fail.
--
-- 		For {stopline} and {timeout} see |search()|.
--
-- 		The value of 'ignorecase' is used.  'magic' is ignored, the
-- 		patterns are used like it's on.
--
-- 		The search starts exactly at the cursor.  A match with
-- 		{start}, {middle} or {end} at the next character, in the
-- 		direction of searching, is the first one found.  Example: >
-- 			if 1
-- 			  if 2
-- 			  endif 2
-- 			endif 1
-- <		When starting at the "if 2", with the cursor on the "i", and
-- 		searching forwards, the "endif 2" is found.  When starting on
-- 		the character just before the "if 2", the "endif 1" will be
-- 		found.  That's because the "if 2" will be found first, and
-- 		then this is considered to be a nested if/endif from "if 2" to
-- 		"endif 2".
-- 		When searching backwards and {end} is more than one character,
-- 		it may be useful to put "\zs" at the end of the pattern, so
-- 		that when the cursor is inside a match with the end it finds
-- 		the matching start.
--
-- 		Example, to find the "endif" command in a Vim script: >
--
-- 	:echo searchpair('\<if\>', '\<el\%[seif]\>', '\<en\%[dif]\>', 'W',
-- 			\ 'getline(".") =~ "^\\s*\""')
--
-- <		The cursor must be at or after the "if" for which a match is
-- 		to be found.  Note that single-quote strings are used to avoid
-- 		having to double the backslashes.  The skip expression only
-- 		catches comments at the start of a line, not after a command.
-- 		Also, a word "en" or "if" halfway through a line is considered
-- 		a match.
-- 		Another example, to search for the matching "{" of a "}": >
--
-- 	:echo searchpair('{', '', '}', 'bW')
--
-- <		This works when the cursor is at or before the "}" for which a
-- 		match is to be found.  To reject matches that syntax
-- 		highlighting recognized as strings: >
--
-- 	:echo searchpair('{', '', '}', 'bW',
-- 	     \ 'synIDattr(synID(line("."), col("."), 0), "name") =~? "string"')
-- <
-- 							*searchpairpos()*
-- searchpairpos({start}, {middle}, {end} [, {flags} [, {skip}
-- 				[, {stopline} [, {timeout}]]]])
-- 		Same as |searchpair()|, but returns a |List| with the line and
-- 		column position of the match. The first element of the |List|
-- 		is the line number and the second element is the byte index of
-- 		the column position of the match.  If no match is found,
-- 		returns [0, 0]. >
--
-- 			:let [lnum,col] = searchpairpos('{', '', '}', 'n')
-- <
-- 		See |match-parens| for a bigger and more useful example.
--- @return number
function vim.fn.searchdecl(name, global, thisblock) end

-- Return the natural logarithm (base e) of {expr} as a |Float|.
-- 		{expr} must evaluate to a |Float| or a |Number| in the range
-- 		(0, inf].
-- 		Examples: >
-- 			:echo log(10)
-- <			2.302585 >
-- 			:echo log(exp(5))
-- <			5.0
--- @return float
function vim.fn.log(expr) end

--- @return number
function vim.fn.searchpair(start, middle, _end, flags, ...) end

-- Like |settabwinvar()| for the current tab page.
-- 		Examples: >
-- 			:call setwinvar(1, "&list", 0)
-- 			:call setwinvar(2, "myvar", "foobar")
--- @return set
function vim.fn.setwinvar(nr, varname, val) end

--- @return list
function vim.fn.searchpairpos(start, middle, _end, flags, ...) end

-- Returns a String with 64 hex characters, which is the SHA256
-- 		checksum of {string}.
--- @return string
function vim.fn.sha256(string) end

-- Same as |search()|, but returns a |List| with the line and
-- 		column position of the match. The first element of the |List|
-- 		is the line number and the second element is the byte index of
-- 		the column position of the match. If no match is found,
-- 		returns [0, 0].
-- 		Example: >
-- 	:let [lnum, col] = searchpos('mypattern', 'n')
--
-- <		When the 'p' flag is given then there is an extra item with
-- 		the sub-pattern match number |search()-sub-match|.  Example: >
-- 	:let [lnum, col, submatch] = searchpos('\(\l\)\|\(\u\)', 'np')
-- <		In this example "submatch" is 2 when a lowercase letter is
-- 		found |/\l|, 3 when an uppercase letter is found |/\u|.
--- @return list
function vim.fn.searchpos(pattern, flags, stopline, timeout) end

-- Return the line number of the first line at or below {lnum}
-- 		that is not blank.  Example: >
-- 			if getline(nextnonblank(1)) =~ "Java"
-- <		When {lnum} is invalid or there is no non-blank line at or
-- 		below it, zero is returned.
-- 		See also |prevnonblank()|.
--- @return number
function vim.fn.nextnonblank(lnum) end

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

-- Show the {what} near the cursor, handle selecting one of the
-- 		items with cursorkeys, and close it an item is selected with
-- 		Space or Enter. {what} should have multiple lines to make this
-- 		useful.  This works like: >
-- 			call popup_create({what}, #{
-- 				\ pos: 'center',
-- 				\ zindex: 200,
-- 				\ drag: 1,
-- 				\ wrap: 0,
-- 				\ border: [],
-- 				\ cursorline: 1,
-- 				\ padding: [0,1,0,1],
-- 				\ filter: 'popup_filter_menu',
-- 				\ mapping: 0,
-- 				\ })
-- <		The current line is highlighted with a match using
-- 		"PopupSelected", or "PmenuSel" if that is not defined.
--
-- 		Use {options} to change the properties.  Should at least set
-- 		"callback" to a function that handles the selected item.
-- 		Example: >
-- 			func ColorSelected(id, result)
-- 			   " use a:result
-- 			endfunc
-- 			call popup_menu(['red', 'green', 'blue'], #{
-- 				\ callback: 'ColorSelected',
-- 				\ })
--
-- <		Can also be used as a |method|: >
-- 			GetChoices()->popup_menu({})
--- @return number
function vim.fn.popup_menu(what, options) end

-- Returns a list of server addresses, or empty if all servers
-- 		were stopped. |serverstart()| |serverstop()|
-- 		Example: >
-- 			:echo serverlist()
--- @return string
function vim.fn.serverlist() end

-- Set line {lnum} to {text} in buffer {expr}.  To insert
-- 		lines use |append()|.
--
-- 		For the use of {expr}, see |bufname()| above.
--
-- 		{lnum} is used like with |setline()|.
-- 		This works like |setline()| for the specified buffer.
-- 		On success 0 is returned, on failure 1 is returned.
--
-- 		If {expr} is not a valid buffer or {lnum} is not valid, an
-- 		error message is given.
--- @return number
function vim.fn.setbufline(expr, lnum, line) end

-- Uses the |Dictionary| returned by |winsaveview()| to restore
-- 		the view of the current window.
-- 		Note: The {dict} does not have to contain all values, that are
-- 		returned by |winsaveview()|. If values are missing, those
-- 		settings won't be restored. So you can use: >
-- 		    :call winrestview({'curswant': 4})
-- <
-- 		This will only set the curswant value (the column the cursor
-- 		wants to move on vertical movements) of the cursor to column 5
-- 		(yes, that is 5), while all other settings will remain the
-- 		same. This is useful, if you set the cursor position manually.
--
-- 		If you have changed the values the result is unpredictable.
-- 		If the window size changed the result won't be the same.
--- @param dict dictionary
--- @return none
function vim.fn.winrestview(dict) end

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

-- Set the current character search information to {dict},
-- 		which contains one or more of the following entries:
--
-- 		    char	character which will be used for a subsequent
-- 				|,| or |;| command; an empty string clears the
-- 				character search
-- 		    forward	direction of character search; 1 for forward,
-- 				0 for backward
-- 		    until	type of character search; 1 for a |t| or |T|
-- 				character search, 0 for an |f| or |F|
-- 				character search
--
-- 		This can be useful to save/restore a user's character search
-- 		from a script: >
-- 			:let prevsearch = getcharsearch()
-- 			:" Perform a command which clobbers user's search
-- 			:call setcharsearch(prevsearch)
-- <		Also see |getcharsearch()|.
--- @param dict dictionary
--- @return dict
function vim.fn.setcharsearch(dict) end

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

-- Set the cursor position in the command line to byte position
-- 		{pos}.  The first position is 1.
-- 		Use |getcmdpos()| to obtain the current position.
-- 		Only works while editing the command line, thus you must use
-- 		|c_CTRL-\_e|, |c_CTRL-R_=| or |c_CTRL-R_CTRL-R| with '='.  For
-- 		|c_CTRL-\_e| and |c_CTRL-R_CTRL-R| with '=' the position is
-- 		set after the command line is set to the expression.  For
-- 		|c_CTRL-R_=| it is set after evaluating the expression but
-- 		before inserting the resulting text.
-- 		When the number is too big the cursor is put at the end of the
-- 		line.  A number smaller than one has undefined results.
-- 		Returns 0 when successful, 1 when not editing the command
-- 		line.
--- @return number
function vim.fn.setcmdpos(pos) end

-- Stop a timer.  The timer callback will no longer be invoked.
-- 		{timer} is an ID returned by timer_start(), thus it must be a
-- 		Number.  If {timer} does not exist there is no error.
--- @return none
function vim.fn.timer_stop(timer) end

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

-- Remove the text property type {name}.  When text properties
-- 		using the type {name} are still in place, they will not have
-- 		an effect and can no longer be removed by name.
--
-- 		{props} can contain a "bufnr" item.  When it is given, delete
-- 		a property type from this buffer instead of from the global
-- 		property types.
--
-- 		When text property type {name} is not found there is no error.
--
-- 		See |text-properties| for information about text properties.
--
-- 		Can also be used as a |method|: >
-- 			GetPropName()->prop_type_delete()
--- @return none
function vim.fn.prop_type_delete(name, props) end

-- Return the sound-folded equivalent of {word}.  Uses the first
-- 		language in 'spelllang' for the current window that supports
-- 		soundfolding.  'spell' must be set.  When no sound folding is
-- 		possible the {word} is returned unmodified.
-- 		This can be used for making spelling suggestions.  Note that
-- 		the method can be quite slow.
--- @return string
function vim.fn.soundfold(word) end

-- The result is a Number.  If the line {lnum} is in a closed
-- 		fold, the result is the number of the first line in that fold.
-- 		If the line {lnum} is not in a closed fold, -1 is returned.
--- @return number
function vim.fn.foldclosed(lnum) end

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

-- Same as |match()|, but return a |List|.  The first item in the
-- 		list is the matched string, same as what matchstr() would
-- 		return.  Following items are submatches, like "\1", "\2", etc.
-- 		in |:substitute|.  When an optional submatch didn't match an
-- 		empty string is used.  Example: >
-- 			echo matchlist('acd', '\(a\)\?\(b\)\?\(c\)\?\(.*\)')
-- <		Results in: ['acd', 'a', '', 'c', 'd', '', '', '', '', '']
-- 		When there is no match an empty list is returned.
--- @return list
function vim.fn.matchlist(expr, pat, start, count) end

-- Set tab-local variable {varname} to {val} in tab page {tabnr}.
-- 		|t:var|
-- 		Note that the variable name without "t:" must be used.
-- 		Tabs are numbered starting with one.
-- 		This function is not available in the |sandbox|.
--- @return set
function vim.fn.settabvar(nr, varname, val) end

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

-- Return the largest integral value less than or equal to
-- 		{expr} as a |Float| (round down).
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			echo floor(1.856)
-- <			1.0  >
-- 			echo floor(-5.456)
-- <			-6.0  >
-- 			echo floor(4.0)
-- <			4.0
--- @return float
function vim.fn.floor(expr) end

-- The result is a Number, which is the current screen row of the
-- 		cursor.  The top line has number one.
-- 		This function is mainly used for testing.
-- 		Alternatively you can use |winline()|.
--
-- 		Note: Same restrictions as with |screencol()|.
--- @return number
function vim.fn.screenrow() end

-- Evaluate Python expression {expr} and return its result
-- 		converted to Vim data structures.
-- 		Numbers and strings are returned as they are (strings are
-- 		copied though, Unicode strings are additionally converted to
-- 		UTF-8).
-- 		Lists are represented as Vim |List| type.
-- 		Dictionaries are represented as Vim |Dictionary| type with
-- 		keys converted to strings.
function vim.fn.py3eval(expr) end

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

-- The result is a String, which is the text {expr} converted
-- 		from encoding {from} to encoding {to}.
-- 		When the conversion completely fails an empty string is
-- 		returned.  When some characters could not be converted they
-- 		are replaced with "?".
-- 		The encoding names are whatever the iconv() library function
-- 		can accept, see ":!man 3 iconv".
-- 		Most conversions require Vim to be compiled with the |+iconv|
-- 		feature.  Otherwise only UTF-8 to latin1 conversion and back
-- 		can be done.
-- 		Note that Vim uses UTF-8 for all Unicode encodings, conversion
-- 		from/to UCS-2 is automatically changed to use UTF-8.  You
-- 		cannot use UCS-2 in a string anyway, because of the NUL bytes.
--- @return string
function vim.fn.iconv(expr, from, to) end

-- The result is a Number, which is the |window-ID| of the first
-- 		window associated with buffer {expr}.  For the use of {expr},
-- 		see |bufname()| above.  If buffer {expr} doesn't exist or
-- 		there is no such window, -1 is returned.  Example: >
--
-- 	echo "A window containing buffer 1 is " . (bufwinid(1))
-- <
-- 		Only deals with the current tab page.
--- @return number
function vim.fn.bufwinid(expr) end

-- Go to window with ID {expr}.  This may also change the current
-- 		tabpage.
-- 		Return 1 if successful, 0 if the window cannot be found.
--- @return number
function vim.fn.win_gotoid(expr) end

-- Activates UI events on the channel.
--
--                 Entry point of all UI clients. Allows |--embed| to continue
--                 startup. Implies that the client is ready to show the UI. Adds
--                 the client to the list of UIs. |nvim_list_uis()|
--
--                 Note:
--                     If multiple UI clients are attached, the global screen
--                     dimensions degrade to the smallest client. E.g. if client
--                     A requests 80x40 but client B requests 200x100, the global
--                     screen has size 80x40.
--
--                 Parameters: ~
--                     {width}    Requested screen columns
--                     {height}   Requested screen rows
--                     {options}  |ui-option| map
function vim.fn.nvim_ui_attach(width, height, options) end

-- The result is the swap file path of the buffer {expr}.
-- 		For the use of {expr}, see |bufname()| above.
-- 		If buffer {expr} is the current buffer, the result is equal to
-- 		|:swapname| (unless no swap file).
-- 		If buffer {expr} has no swap file, returns an empty string.
--- @return string
function vim.fn.swapname(expr) end

-- The result is a Number which is the state of the modifiers for
-- 		the last obtained character with getchar() or in another way.
-- 		These values are added together:
-- 			2	shift
-- 			4	control
-- 			8	alt (meta)
-- 			16	meta (when it's different from ALT)
-- 			32	mouse double click
-- 			64	mouse triple click
-- 			96	mouse quadruple click (== 32 + 64)
-- 			128	command (Macintosh only)
-- 		Only the modifiers that have not been included in the
-- 		character itself are obtained.  Thus Shift-a results in "A"
-- 		without a modifier.
--- @return number
function vim.fn.getcharmod() end

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

-- Set a callback for buffer {buf} to {expr}.  When {expr} is an
-- 		empty string the callback is removed.  This has only effect if
-- 		{buf} has 'buftype' set to "prompt".
--
-- 		This callback will be invoked when pressing CTRL-C in Insert
-- 		mode.  Without setting a callback Vim will exit Insert mode,
-- 		as in any buffer.
--- @return none
function vim.fn.prompt_setinterrupt(buf, text) end

-- Set the text of the buffer in popup win {id}. {text} is the
-- 		same as supplied to |popup_create()|, except that a buffer
-- 		number is not allowed.
-- 		Does not change the window size or position, other than caused
-- 		by the different text.
--
-- 		Can also be used as a |method|: >
-- 			GetPopup()->popup_settext('hello')
--- @return none
function vim.fn.popup_settext(id, text) end

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

-- Clears all matches previously defined for the current window
-- 		by |matchadd()| and the |:match| commands.
--- @return none
function vim.fn.clearmatches() end

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

-- If {id} is a hidden popup, show it now.
-- 		For {id} see `popup_hide()`.
-- 		If {id} is the info popup it will be positioned next to the
-- 		current popup menu item.
--- @return none
function vim.fn.popup_show(id) end

-- Invoke listener callbacks for buffer {buf}.  If there are no
-- 		pending changes then no callbacks are invoked.
--
-- 		{buf} refers to a buffer name or number. For the accepted
-- 		values, see |bufname()|.  When {buf} is omitted the current
-- 		buffer is used.
--
-- 		Can also be used as a |method|: >
-- 			GetBuffer()->listener_flush()
--- @return none
function vim.fn.listener_flush(buf) end

-- The result is a Number, which is |TRUE| when the IME status is
-- 		active.
-- 		See 'imstatusfunc'.
--- @return number
function vim.fn.getimstatus() end

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

-- Get the |window-ID| for the specified window.
-- 		When {win} is missing use the current window.
-- 		With {win} this is the window number.  The top window has
-- 		number 1.
-- 		Without {tab} use the current tab, otherwise the tab with
-- 		number {tab}.  The first tab has number one.
-- 		Return zero if the window cannot be found.
--- @return number
function vim.fn.win_getid(win, tab) end

-- Characters in {string} are queued for processing as if they
-- 		come from a mapping or were typed by the user.
--
-- 		By default the string is added to the end of the typeahead
-- 		buffer, thus if a mapping is still being executed the
-- 		characters come after them.  Use the 'i' flag to insert before
-- 		other characters, they will be executed next, before any
-- 		characters from a mapping.
--
-- 		The function does not wait for processing of keys contained in
-- 		{string}.
--
-- 		To include special keys into {string}, use double-quotes
-- 		and "\..." notation |expr-quote|. For example,
-- 		feedkeys("\<CR>") simulates pressing of the <Enter> key. But
-- 		feedkeys('\<CR>') pushes 5 characters.
-- 		The |<Ignore>| keycode may be used to exit the
-- 		wait-for-character without doing anything.
--
-- 		{mode} is a String, which can contain these character flags:
-- 		'm'	Remap keys. This is default.  If {mode} is absent,
-- 			keys are remapped.
-- 		'n'	Do not remap keys.
-- 		't'	Handle keys as if typed; otherwise they are handled as
-- 			if coming from a mapping.  This matters for undo,
-- 			opening folds, etc.
-- 		'i'	Insert the string instead of appending (see above).
-- 		'x'	Execute commands until typeahead is empty.  This is
-- 			similar to using ":normal!".  You can call feedkeys()
-- 			several times without 'x' and then one time with 'x'
-- 			(possibly with an empty {string}) to execute all the
-- 			typeahead.  Note that when Vim ends in Insert mode it
-- 			will behave as if <Esc> is typed, to avoid getting
-- 			stuck, waiting for a character to be typed before the
-- 			script continues.
-- 			Note that if you manage to call feedkeys() while
-- 			executing commands, thus calling it recursively, the
-- 			all typehead will be consumed by the last call.
-- 		'!'	When used with 'x' will not end Insert mode. Can be
-- 			used in a test when a timer is set to exit Insert mode
-- 			a little later.  Useful for testing CursorHoldI.
--
-- 		Return value is always 0.
--- @return number
function vim.fn.feedkeys(string, mode) end

-- Return a String that represents the time value of {time}.
-- 		This is the number of seconds, a dot and the number of
-- 		microseconds.  Example: >
-- 			let start = reltime()
-- 			call MyFunction()
-- 			echo reltimestr(reltime(start))
-- <		Note that overhead for the commands will be added to the time.
-- 		Leading spaces are used to make the string align nicely.  You
-- 		can use split() to remove it. >
-- 			echo split(reltimestr(reltime(start)))[0]
-- <		Also see |profiling|.
--- @return string
function vim.fn.reltimestr(time) end

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

-- Add a callback function that will be invoked when changes have
-- 		been made to buffer {buf}.
-- 		{buf} refers to a buffer name or number. For the accepted
-- 		values, see |bufname()|.  When {buf} is omitted the current
-- 		buffer is used.
-- 		Returns a unique ID that can be passed to |listener_remove()|.
--
-- 		The {callback} is invoked with five arguments:
-- 		    a:bufnr	the buffer that was changed
-- 		    a:start	first changed line number
-- 		    a:end	first line number below the change
-- 		    a:added	number of lines added, negative if lines were
-- 				deleted
-- 		    a:changes	a List of items with details about the changes
--
-- 		Example: >
-- 	    func Listener(bufnr, start, end, added, changes)
-- 	      echo 'lines ' .. a:start .. ' until ' .. a:end .. ' changed'
-- 	    endfunc
-- 	    call listener_add('Listener', bufnr)
--
-- <		The List cannot be changed.  Each item in a:changes is a
-- 		dictionary with these entries:
-- 		    lnum	the first line number of the change
-- 		    end		the first line below the change
-- 		    added	number of lines added; negative if lines were
-- 				deleted
-- 		    col		first column in "lnum" that was affected by
-- 				the change; one if unknown or the whole line
-- 				was affected; this is a byte index, first
-- 				character has a value of one.
-- 		When lines are inserted the values are:
-- 		    lnum	line above which the new line is added
-- 		    end		equal to "lnum"
-- 		    added	number of lines inserted
-- 		    col		1
-- 		When lines are deleted the values are:
-- 		    lnum	the first deleted line
-- 		    end		the line below the first deleted line, before
-- 				the deletion was done
-- 		    added	negative, number of lines deleted
-- 		    col		1
-- 		When lines are changed:
-- 		    lnum	the first changed line
-- 		    end		the line below the last changed line
-- 		    added	0
-- 		    col		first column with a change or 1
--
-- 		The entries are in the order the changes were made, thus the
-- 		most recent change is at the end.  The line numbers are valid
-- 		when the callback is invoked, but later changes may make them
-- 		invalid, thus keeping a copy for later might not work.
--
-- 		The {callback} is invoked just before the screen is updated,
-- 		when |listener_flush()| is called or when a change is being
-- 		made that changes the line count in a way it causes a line
-- 		number in the list of changes to become invalid.
--
-- 		The {callback} is invoked with the text locked, see
-- 		|textlock|.  If you do need to make changes to the buffer, use
-- 		a timer to do this later |timer_start()|.
--
-- 		The {callback} is not invoked when the buffer is first loaded.
-- 		Use the |BufReadPost| autocmd event to handle the initial text
-- 		of a buffer.
-- 		The {callback} is also not invoked when the buffer is
-- 		unloaded, use the |BufUnload| autocmd event for that.
--
-- 		Can also be used as a |method|, the base is passed as the
-- 		second argument: >
-- 			GetBuffer()->listener_add(callback)
--- @return number
function vim.fn.listener_add(callback, buf) end

-- Return a Float that represents the time value of {time}.
-- 		Unit of time is seconds.
-- 		Example:
-- 			let start = reltime()
-- 			call MyFunction()
-- 			let seconds = reltimefloat(reltime(start))
-- 		See the note of reltimestr() about overhead.
--  		Also see |profiling|.
--- @return float
function vim.fn.reltimefloat(time) end

-- Create directory {name}.
-- 		If {path} is "p" then intermediate directories are created as
-- 		necessary.  Otherwise it must be "".
-- 		If {prot} is given it is used to set the protection bits of
-- 		the new directory.  The default is 0755 (rwxr-xr-x: r/w for
-- 		the user readable for others).  Use 0700 to make it unreadable
-- 		for others.
--
-- 		{prot} is applied for all parts of {name}.  Thus if you create
-- 		/tmp/foo/bar then /tmp/foo will be created with 0700. Example: >
-- 			:call mkdir($HOME . "/tmp/foo/bar", "p", 0700)
-- <		This function is not available in the |sandbox|.
--
-- 		If you try to create an existing directory with {path} set to
-- 		"p" mkdir() will silently exit.
--- @return number
function vim.fn.mkdir(name, path, prot) end

-- cursor in the window.  This is counting screen cells from the
-- 		left side of the window.  The leftmost column is one.
--- @return number
function vim.fn.wincol() end

-- Write |List| {list} to file {fname}.  Each list item is
-- 		separated with a NL.  Each list item must be a String or
-- 		Number.
-- 		When {flags} contains "b" then binary mode is used: There will
-- 		not be a NL after the last list item.  An empty item at the
-- 		end does cause the last line in the file to end in a NL.
--
-- 		When {flags} contains "a" then append mode is used, lines are
-- 		appended to the file: >
-- 			:call writefile(["foo"], "event.log", "a")
-- 			:call writefile(["bar"], "event.log", "a")
-- <
-- 		When {flags} contains "S" fsync() call is not used, with "s"
-- 		it is used, 'fsync' option applies by default. No fsync()
-- 		means that writefile() will finish faster, but writes may be
-- 		left in OS buffers and not yet written to disk. Such changes
-- 		will disappear if system crashes before OS does writing.
--
-- 		All NL characters are replaced with a NUL character.
-- 		Inserting CR characters needs to be done before passing {list}
-- 		to writefile().
-- 		An existing file is overwritten, if possible.
-- 		When the write fails -1 is returned, otherwise 0.  There is an
-- 		error message if the file can't be created or when writing
-- 		fails.
-- 		Also see |readfile()|.
-- 		To copy a file byte for byte: >
-- 			:let fl = readfile("foo", "b")
-- 			:call writefile(fl, "foocopy", "b")
--- @param list any[]
--- @return number
function vim.fn.writefile(list, fname, flags) end

-- Return the power of {x} to the exponent {y} as a |Float|.
-- 		{x} and {y} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo pow(3, 3)
-- <			27.0 >
-- 			:echo pow(2, 16)
-- <			65536.0 >
-- 			:echo pow(32, 0.20)
-- <			2.0
--- @return float
function vim.fn.pow(x, y) end

-- Cleanup unused |Lists| and |Dictionaries| that have circular
-- 		references.
--
-- 		There is hardly ever a need to invoke this function, as it is
-- 		automatically done when Vim runs out of memory or is waiting
-- 		for the user to press a key after 'updatetime'.  Items without
-- 		circular references are always freed when they become unused.
-- 		This is useful if you have deleted a very big |List| and/or
-- 		|Dictionary| with circular references in a script that runs
-- 		for a long time.
--
-- 		When the optional {atexit} argument is one, garbage
-- 		collection will also be done when exiting Vim, if it wasn't
-- 		done before.  This is useful when checking for memory leaks.
--
-- 		The garbage collection is not done immediately but only when
-- 		it's safe to perform.  This is when waiting for the user to
-- 		type a character.
--- @return none
function vim.fn.garbagecollect(atexit) end

