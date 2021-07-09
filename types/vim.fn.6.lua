--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- The opposite of `assert_equal()`: add an error message to
-- 		|v:errors| when {expected} and {actual} are equal.
-- 		Also see |assert-return|.
--- @return number
function vim.fn.assert_notequal(exp, act, msg) end

-- The result is a Number, which is the number of the first
-- 		window associated with buffer {expr}.  For the use of {expr},
-- 		see |bufname()| above.  If buffer {expr} doesn't exist or
-- 		there is no such window, -1 is returned.  Example: >
--
-- 	echo "A window containing buffer 1 is " . (bufwinnr(1))
--
-- <		The number can be used with |CTRL-W_w| and ":wincmd w"
-- 		|:wincmd|.
-- 		Only deals with the current tab page.
--- @return number
function vim.fn.bufwinnr(expr) end

-- The result is a Number, which is the syntax ID at the position
-- 		{lnum} and {col} in the current window.
-- 		The syntax ID can be used with |synIDattr()| and
-- 		|synIDtrans()| to obtain syntax information about text.
--
-- 		{col} is 1 for the leftmost column, {lnum} is 1 for the first
-- 		line.  'synmaxcol' applies, in a longer line zero is returned.
-- 		Note that when the position is after the last character,
-- 		that's where the cursor can be in Insert mode, synID() returns
-- 		zero.
--
-- 		When {trans} is |TRUE|, transparent items are reduced to the
-- 		item that they reveal.  This is useful when wanting to know
-- 		the effective color.  When {trans} is |FALSE|, the transparent
-- 		item is returned.  This is useful when wanting to know which
-- 		syntax item is effective (e.g. inside parens).
-- 		Warning: This function can be very slow.  Best speed is
-- 		obtained by going through the file in forward direction.
--
-- 		Example (echoes the name of the syntax item under the cursor): >
-- 			:echo synIDattr(synID(line("."), col("."), 1), "name")
-- <
--- @return number
function vim.fn.synID(lnum, col, trans) end

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

-- Get item {idx} from |List| {list}.  When this item is not
-- 		available return {default}.  Return zero when {default} is
-- 		Get item with key {key} from |Dictionary| {dict}.  When this
-- 		item is not available return {default}.  Return zero when
-- 		{default} is omitted.  Useful example: >
-- 			let val = get(g:, 'var_name', 'default')
-- <		This gets the value of g:var_name if it exists, and uses
-- 		Get item {what} from Funcref {func}.  Possible values for
-- 		{what} are:
-- 			"name"	The function name
-- 			"func"	The function
-- 			"dict"	The dictionary
-- 			"args"	The list with arguments
function vim.fn.get(func, what) end

-- turn the result of |string()| back into the original value.
-- 		This works for Numbers, Floats, Strings and composites of
-- 		them.  Also works for |Funcref|s that refer to existing
-- 		functions.
function vim.fn.eval(string) end

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

-- the left hand side of the GUI Vim window.  The result will be
-- 		-1 if the information is not available.
-- 		The value can be used with `:winpos`.
--- @return number
function vim.fn.getwinposx() end

-- Convert string {expr} to a number.
-- 		{base} is the conversion base, it can be 2, 8, 10 or 16.
-- 		When {base} is omitted base 10 is used.  This also means that
-- 		a leading zero doesn't cause octal conversion to be used, as
-- 		with the default String to Number conversion.
-- 		When {base} is 16 a leading "0x" or "0X" is ignored.  With a
-- 		different base the result will be zero. Similarly, when {base}
-- 		is 8 a leading "0" is ignored, and when {base} is 2 a leading
-- 		"0b" or "0B" is ignored.
-- 		Text after the number is silently ignored.
--- @return number
function vim.fn.str2nr(expr, base) end

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

-- Returns a list with all property type names.
--
-- 		{props} can contain a "bufnr" item.  When it is given, use
-- 		this buffer instead of the global property types.
--
-- 		See |text-properties| for information about text properties.
--- @return list
function vim.fn.prop_type_list(props) end

-- Returns the text that is displayed for the closed fold at line
-- 		{lnum}.  Evaluates 'foldtext' in the appropriate context.
-- 		When there is no closed fold at {lnum} an empty string is
-- 		returned.
-- 		{lnum} is used like with |getline()|.  Thus "." is the current
-- 		line, "'m" mark m, etc.
-- 		Useful when exporting folded text, e.g., to HTML.
--- @return string
function vim.fn.foldtextresult(lnum) end

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

-- When {actual} is not false an error message is added to
-- 		|v:errors|, like with |assert_equal()|.
-- 		Also see |assert-return|.
-- 		A value is false when it is zero or |v:false|. When "{actual}"
-- 		is not a number or |v:false| the assert fails.
-- 		When {msg} is omitted an error in the form
-- 		"Expected False but got {actual}" is produced.
--- @return number
function vim.fn.assert_false(actual, msg) end

-- The result is a String, which is the contents of register
-- 		{regname}.  Example: >
-- 			:let cliptext = getreg('*')
-- <		When {regname} was not set the result is an empty string.
--
-- 		getreg('=') returns the last evaluated value of the expression
-- 		register.  (For use in maps.)
-- 		getreg('=', 1) returns the expression itself, so that it can
-- 		be restored with |setreg()|.  For other registers the extra
-- 		argument is ignored, thus you can always give it.
--
-- 		If {list} is present and |TRUE|, the result type is changed
-- 		to |List|. Each list item is one text line. Use it if you care
-- 		about zero bytes possibly present inside register: without
-- 		third argument both NLs and zero bytes are represented as NLs
-- 		(see |NL-used-for-Nul|).
-- 		When the register was not set an empty list is returned.
--
-- 		If {regname} is not specified, |v:register| is used.
--- @param list any[]
--- @return string
function vim.fn.getreg(regname, _1, list) end

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

-- Returns the properties of property type {name}.  This is a
-- 		dictionary with the same fields as was given to
-- 		prop_type_add().
-- 		When the property type {name} does not exist, an empty
-- 		dictionary is returned.
--
-- 		{props} can contain a "bufnr" item.  When it is given, use
-- 		this buffer instead of the global property types.
--
-- 		See |text-properties| for information about text properties.
--
-- 		Can also be used as a |method|: >
-- 			GetPropName()->prop_type_get()
--- @return dict
function vim.fn.prop_type_get(name, props) end

-- Returns |standard-path| locations of various default files and
-- 		directories.
--
-- 		{what}       Type    Description ~
-- 		cache        String  Cache directory. Arbitrary temporary
-- 		                     storage for plugins, etc.
-- 		config       String  User configuration directory. The
-- 		                     |init.vim| is stored here.
-- 		config_dirs  List    Additional configuration directories.
-- 		data         String  User data directory. The |shada-file|
-- 		                     is stored here.
-- 		data_dirs    List    Additional data directories.
--
-- 		Example: >
-- 			:echo stdpath("config")
--- @return string/list
function vim.fn.stdpath(what) end

-- {expr} in bytes.
-- 		If the argument is a Number it is first converted to a String.
-- 		For other types an error is given.
-- 		If you want to count the number of multi-byte characters use
-- 		|strchars()|.
-- 		Also see |len()|, |strdisplaywidth()| and |strwidth()|.
--- @return number
function vim.fn.strlen(expr) end

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

-- cursor in the window.  This is counting screen cells from the
-- 		left side of the window.  The leftmost column is one.
--- @return number
function vim.fn.wincol() end

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

-- The result is a Number, which gives the byte index in
-- 		{haystack} of the last occurrence of the String {needle}.
-- 		When {start} is specified, matches beyond this index are
-- 		ignored.  This can be used to find a match before a previous
-- 		match: >
-- 			:let lastcomma = strridx(line, ",")
-- 			:let comma2 = strridx(line, ",", lastcomma - 1)
-- <		The search is done case-sensitive.
-- 		For pattern searches use |match()|.
-- 		-1 is returned if the {needle} does not occur in {haystack}.
-- 		If the {needle} is empty the length of {haystack} is returned.
-- 		See also |stridx()|.  Examples: >
-- 		  :echo strridx("an angry armadillo", "an")	     3
-- <							*strrchr()*
-- 		When used with a single character it works similar to the C
-- 		function strrchr().
--- @return number
function vim.fn.strridx(haystack, needle, start) end

-- The result is the value of option or local buffer variable
-- 		{varname} in buffer {expr}.  Note that the name without "b:"
-- 		must be used.
-- 		When {varname} is empty returns a dictionary with all the
-- 		buffer-local variables.
-- 		When {varname} is equal to "&" returns a dictionary with all
-- 		the buffer-local options.
-- 		Otherwise, when {varname} starts with "&" returns the value of
-- 		a buffer-local option.
-- 		This also works for a global or buffer-local option, but it
-- 		doesn't work for a global variable, window-local variable or
-- 		window-local option.
-- 		For the use of {expr}, see |bufname()| above.
-- 		When the buffer or variable doesn't exist {def} or an empty
-- 		string is returned, there is no error message.
-- 		Examples: >
-- 			:let bufmodified = getbufvar(1, "&mod")
-- 			:echo "todo myvar = " . getbufvar("todo", "myvar")
function vim.fn.getbufvar(expr, varname, def) end

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

-- Returns the |changelist| for the buffer {expr}. For the use
-- 		of {expr}, see |bufname()| above. If buffer {expr} doesn't
-- 		exist, an empty list is returned.
--
-- 		The returned list contains two entries: a list with the change
-- 		locations and the current position in the list.  Each
-- 		entry in the change list is a dictionary with the following
-- 		entries:
-- 			col		column number
-- 			coladd		column offset for 'virtualedit'
-- 			lnum		line number
-- 		If buffer {expr} is the current buffer, then the current
-- 		position refers to the position in the list. For other
-- 		buffers, it is set to the length of the list.
--- @return list
function vim.fn.getchangelist(expr) end

-- Only for an expression in a |:substitute| command or
-- 		substitute() function.
-- 		Returns the {nr}'th submatch of the matched text.  When {nr}
-- 		is 0 the whole matched text is returned.
-- 		Note that a NL in the string can stand for a line break of a
-- 		multi-line match or a NUL character in the text.
-- 		Also see |sub-replace-expression|.
--
-- 		If {list} is present and non-zero then submatch() returns
-- 		a list of strings, similar to |getline()| with two arguments.
-- 		NL characters in the text represent NUL characters in the
-- 		text.
-- 		Only returns more than one item for |:substitute|, inside
-- 		|substitute()| this list will always contain one or zero
-- 		items, since there are no real line breaks.
--
-- 		When substitute() is used recursively only the submatches in
-- 		the current (deepest) call can be obtained.
--
-- 		Examples: >
-- 			:s/\d\+/\=submatch(0) + 1/
-- 			:echo substitute(text, '\d\+', '\=submatch(0) + 1', '')
-- <		This finds the first number in the line and adds one to it.
-- 		A line break is included as a newline character.
--- @param list any[]
--- @return string
function vim.fn.submatch(nr, list) end

-- The result is a String, which is a copy of {expr}, in which
-- 		the first match of {pat} is replaced with {sub}.
-- 		When {flags} is "g", all matches of {pat} in {expr} are
-- 		replaced.  Otherwise {flags} should be "".
--
-- 		This works like the ":substitute" command (without any flags).
-- 		But the matching with {pat} is always done like the 'magic'
-- 		option is set and 'cpoptions' is empty (to make scripts
-- 		portable).  'ignorecase' is still relevant, use |/\c| or |/\C|
-- 		if you want to ignore or match case and ignore 'ignorecase'.
-- 		'smartcase' is not used.  See |string-match| for how {pat} is
-- 		used.
--
-- 		A "~" in {sub} is not replaced with the previous {sub}.
-- 		Note that some codes in {sub} have a special meaning
-- 		|sub-replace-special|.  For example, to replace something with
-- 		"\n" (two characters), use "\\\\n" or '\\n'.
--
-- 		When {pat} does not match in {expr}, {expr} is returned
-- 		unmodified.
--
-- 		Example: >
-- 			:let &path = substitute(&path, ",\\=[^,]*$", "", "")
-- <		This removes the last component of the 'path' option. >
-- 			:echo substitute("testing", ".*", "\\U\\0", "")
-- <		results in "TESTING".
--
-- 		When {sub} starts with "\=", the remainder is interpreted as
-- 		an expression. See |sub-replace-expression|.  Example: >
-- 			:echo substitute(s, '%\(\x\x\)',
-- 			   \ '\=nr2char("0x" . submatch(1))', 'g')
--
-- <		When {sub} is a Funcref that function is called, with one
-- 		optional argument.  Example: >
-- 		   :echo substitute(s, '%\(\x\x\)', SubNr, 'g')
-- <		The optional argument is a list which contains the whole
-- 		matched string and up to nine submatches, like what
-- 		|submatch()| returns.  Example: >
-- 		   :echo substitute(s, '%\(\x\x\)', {m -> '0x' . m[1]}, 'g')
--- @return string
function vim.fn.substitute(expr, pat, sub, flags) end

-- Return the logarithm of Float {expr} to base 10 as a |Float|.
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo log10(1000)
-- <			3.0 >
-- 			:echo log10(0.01)
-- <			-2.0
--- @return float
function vim.fn.log10(expr) end

-- Return the current character search information as a {dict}
-- 		with the following entries:
--
-- 		    char	character previously used for a character
-- 				search (|t|, |f|, |T|, or |F|); empty string
-- 				if no character search has been performed
-- 		    forward	direction of character search; 1 for forward,
-- 				0 for backward
-- 		    until	type of character search; 1 for a |t| or |T|
-- 				character search, 0 for an |f| or |F|
-- 				character search
--
-- 		This can be useful to always have |;| and |,| search
-- 		forward/backward regardless of the direction of the previous
-- 		character search: >
-- 			:nnoremap <expr> ; getcharsearch().forward ? ';' : ','
-- 			:nnoremap <expr> , getcharsearch().forward ? ',' : ';'
-- <		Also see |setcharsearch()|.
--- @return dict
function vim.fn.getcharsearch() end

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

-- Return the position of the cursor in the command line as a
-- 		byte count.  The first column is 1.
-- 		Only works when editing the command line, thus requires use of
-- 		|c_CTRL-\_e| or |c_CTRL-R_=| or an expression mapping.
-- 		Returns 0 otherwise.
-- 		Also see |getcmdtype()|, |setcmdpos()| and |getcmdline()|.
--- @return number
function vim.fn.getcmdpos() end

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

-- Return the current command-line type. Possible return values
-- 		are:
-- 		    :	normal Ex command
-- 		    >	debug mode command |debug-mode|
-- 		    /	forward search command
-- 		    ?	backward search command
-- 		    @	|input()| command
-- 		    -	|:insert| or |:append| command
-- 		    =	|i_CTRL-R_=|
-- 		Only works when editing the command line, thus requires use of
-- 		|c_CTRL-\_e| or |c_CTRL-R_=| or an expression mapping.
-- 		Returns an empty string otherwise.
-- 		Also see |getcmdpos()|, |setcmdpos()| and |getcmdline()|.
--- @return string
function vim.fn.getcmdtype() end

-- The result is a List with currently three items:
-- 		1. The first item in the list is 0 if the character at the
-- 		   position {lnum} and {col} is not part of a concealable
-- 		   region, 1 if it is.
-- 		2. The second item in the list is a string. If the first item
-- 		   is 1, the second item contains the text which will be
-- 		   displayed in place of the concealed text, depending on the
-- 		   current setting of 'conceallevel' and 'listchars'.
-- 		3. The third and final item in the list is a number
-- 		   representing the specific syntax region matched in the
-- 		   line. When the character is not concealed the value is
-- 		   zero. This allows detection of the beginning of a new
-- 		   concealable region if there are two consecutive regions
-- 		   with the same replacement character.  For an example, if
-- 		   the text is "123456" and both "23" and "45" are concealed
-- 		   and replaced by the character "X", then:
-- 			call			returns ~
-- 		   	synconcealed(lnum, 1)   [0, '', 0]
-- 		   	synconcealed(lnum, 2)   [1, 'X', 1]
-- 		   	synconcealed(lnum, 3)   [1, 'X', 1]
-- 		   	synconcealed(lnum, 4)   [1, 'X', 2]
-- 		   	synconcealed(lnum, 5)   [1, 'X', 2]
-- 		   	synconcealed(lnum, 6)   [0, '', 0]
--- @return list
function vim.fn.synconcealed(lnum, col) end

-- Return the current |command-line-window| type. Possible return
-- 		values are the same as |getcmdtype()|. Returns an empty string
-- 		when not in the command-line window.
--- @return string
function vim.fn.getcmdwintype() end

-- Return a |List|, which is the stack of syntax items at the
-- 		position {lnum} and {col} in the current window.  Each item in
-- 		the List is an ID like what |synID()| returns.
-- 		The first item in the List is the outer region, following are
-- 		items contained in that one.  The last one is what |synID()|
-- 		returns, unless not the whole item is highlighted or it is a
-- 		transparent item.
-- 		This function is useful for debugging a syntax file.
-- 		Example that shows the syntax stack under the cursor: >
-- 			for id in synstack(line("."), col("."))
-- 			   echo synIDattr(id, "name")
-- 			endfor
-- <		When the position specified with {lnum} and {col} is invalid
-- 		nothing is returned.  The position just after the last
-- 		character in a line and the first column in an empty line are
-- 		valid positions.
--- @return list
function vim.fn.synstack(lnum, col) end

-- When v:exception does not contain the string {error} an error
-- 		message is added to |v:errors|.  Also see |assert-return|.
-- 		This can be used to assert that a command throws an exception.
-- 		Using the error number, followed by a colon, avoids problems
-- 		with translations: >
-- 			try
-- 			  commandthatfails
-- 			  call assert_false(1, 'command should have failed')
-- 			catch
-- 			  call assert_exception('E492:')
-- 			endtry
--- @return number
function vim.fn.assert_exception(error, msg) end

-- includes an extra item in the list:
-- 		    [bufnum, lnum, col, off, curswant] ~
--  		The "curswant" number is the preferred column when moving the
-- 		cursor vertically.  Also see |getpos()|.
--
--  		This can be used to save and restore the cursor position: >
--  			let save_cursor = getcurpos()
--  			MoveTheCursorAround
--  			call setpos('.', save_cursor)
-- <		Note that this only works within the window.  See
-- 		|winrestview()| for restoring more state.
--- @return list
function vim.fn.getcurpos() end

-- {expr1} must be a |List| or a |Dictionary|.
-- 		For each item in {expr1} evaluate {expr2} and when the result
-- 		is zero remove the item from the |List| or |Dictionary|.
-- 		{expr2} must be a |string| or |Funcref|.
--
-- 		If {expr2} is a |string|, inside {expr2} |v:val| has the value
-- 		of the current item.  For a |Dictionary| |v:key| has the key
-- 		of the current item and for a |List| |v:key| has the index of
-- 		the current item.
-- 		For a |Dictionary| |v:key| has the key of the current item.
-- 		Examples: >
-- 			call filter(mylist, 'v:val !~ "OLD"')
-- <		Removes the items where "OLD" appears. >
-- 			call filter(mydict, 'v:key >= 8')
-- <		Removes the items with a key below 8. >
-- 			call filter(var, 0)
-- <		Removes all the items, thus clears the |List| or |Dictionary|.
--
-- 		Note that {expr2} is the result of expression and is then
-- 		used as an expression again.  Often it is good to use a
-- 		|literal-string| to avoid having to double backslashes.
--
-- 		If {expr2} is a |Funcref| it must take two arguments:
-- 			1. the key or the index of the current item.
-- 			2. the value of the current item.
-- 		The function must return |TRUE| if the item should be kept.
-- 		Example that keeps the odd items of a list: >
-- 			func Odd(idx, val)
-- 			  return a:idx % 2 == 1
-- 			endfunc
-- 			call filter(mylist, function('Odd'))
-- <		It is shorter when using a |lambda|: >
-- 			call filter(myList, {idx, val -> idx * val <= 42})
-- <		If you do not use "val" you can leave it out: >
-- 			call filter(myList, {idx -> idx % 2 == 1})
-- <
-- 		The operation is done in-place.  If you want a |List| or
-- 		|Dictionary| to remain unmodified make a copy first: >
-- 			:let l = filter(copy(mylist), 'v:val =~ "KEEP"')
--
-- <		Returns {expr1}, the |List| or |Dictionary| that was filtered.
-- 		When an error is encountered while evaluating {expr2} no
-- 		further items in {expr1} are processed. When {expr2} is a
-- 		Funcref errors inside a function are ignored, unless it was
-- 		defined with the "abort" flag.
--- @return list/dict
function vim.fn.filter(expr1, expr2) end

-- Evaluate Ruby expression {expr} and return its result
-- 		converted to Vim data structures.
-- 		Numbers, floats and strings are returned as they are (strings
-- 		are copied though).
-- 		Arrays are represented as Vim |List| type.
-- 		Hashes are represented as Vim |Dictionary| type.
-- 		Other objects are represented as strings resulted from their
-- 		"Object#to_s" method.
--
-- 		Can also be used as a |method|: >
-- 			GetRubyExpr()->rubyeval()
--
-- <		{only available when compiled with the |+ruby| feature}
function vim.fn.rubyeval(expr) end

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

-- Float, String or a composition of them, then the result can be
-- 		parsed back with |eval()|.
-- 			{expr} type	result ~
-- 			String		'string'
-- 			Number		123
-- 			Float		123.123456 or 1.123456e8 or
-- 					`str2float('inf')`
-- 			Funcref		`function('name')`
-- 			List		[item, item]
-- 			Dictionary	{key: value, key: value}
-- 		Note that in String values the ' character is doubled.
-- 		Also see |strtrans()|.
-- 		Note 2: Output format is mostly compatible with YAML, except
-- 		for infinite and NaN floating-point values representations
-- 		which use |str2float()|.  Strings are also dumped literally,
-- 		only single quote is escaped, which does not allow using YAML
-- 		for parsing back binary strings.  |eval()| should always work for
-- 		strings and floats though and this is the only official
-- 		method, use |msgpackdump()| or |json_encode()| if you need to
-- 		share data with other application.
--- @return string
function vim.fn.string(expr) end

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

-- The result is a Number, which is the size in bytes of the
-- 		given file {fname}.
-- 		If {fname} is a directory, 0 is returned.
-- 		If the file {fname} can't be found, -1 is returned.
-- 		If the size of {fname} is too big to fit in a Number then -2
-- 		is returned.
--- @return number
function vim.fn.getfsize(fname) end

-- Return 1 if {expr} is a positive infinity, or -1 a negative
-- 		infinity, otherwise 0. >
-- 			:echo isinf(1.0 / 0.0)
-- <			1 >
-- 			:echo isinf(-1.0 / 0.0)
-- <			-1
--- @return number
function vim.fn.isinf(expr) end

-- Convert String {expr} to a Float.  This mostly works the same
-- 		as when using a floating point number in an expression, see
-- 		|floating-point-format|.  But it's a bit more permissive.
-- 		E.g., "1e40" is accepted, while in an expression you need to
-- 		write "1.0e40".  The hexadecimal form "0x123" is also
-- 		accepted, but not others, like binary or octal.
-- 		Text after the number is silently ignored.
-- 		The decimal point is always '.', no matter what the locale is
-- 		set to.  A comma ends the number: "12,345.67" is converted to
-- 		12.0.  You can strip out thousands separators with
-- 		|substitute()|: >
-- 			let f = str2float(substitute(text, ',', '', 'g'))
--- @return float
function vim.fn.str2float(expr) end

-- The result is a String, which is a description of the kind of
-- 		file of the given file {fname}.
-- 		If {fname} does not exist an empty string is returned.
-- 		Here is a table over different kinds of files and their
-- 		results:
-- 			Normal file		"file"
-- 			Directory		"dir"
-- 			Symbolic link		"link"
-- 			Block device		"bdev"
-- 			Character device	"cdev"
-- 			Socket			"socket"
-- 			FIFO			"fifo"
-- 			All other		"other"
-- 		Example: >
-- 			getftype("/home")
-- <		Note that a type such as "link" will only be returned on
-- 		systems that support it.  On some systems only "dir" and
-- 		"file" are returned.
--- @return string
function vim.fn.getftype(fname) end

-- Like |garbagecollect()|, but executed right away.  This must
-- 		only be called directly to avoid any structure to exist
-- 		internally, and |v:testing| must have been set before calling
-- 		any function.
--- @return none
function vim.fn.test_garbagecollect_now() end

-- The result is a Number representing the type of {expr}.
-- 		Instead of using the number directly, it is better to use the
-- 		v:t_ variable that has the value:
-- 		        Number:     0 (|v:t_number|)
-- 			String:     1 (|v:t_string|)
-- 			Funcref:    2 (|v:t_func|)
-- 			List:       3 (|v:t_list|)
-- 			Dictionary: 4 (|v:t_dict|)
-- 			Float:      5 (|v:t_float|)
-- 			Boolean:    6 (|v:true| and |v:false|)
-- 			Null:       7 (|v:null|)
-- 		For backward compatibility, this method can be used: >
-- 			:if type(myvar) == type(0)
-- 			:if type(myvar) == type("")
-- 			:if type(myvar) == type(function("tr"))
-- 			:if type(myvar) == type([])
-- 			:if type(myvar) == type({})
-- 			:if type(myvar) == type(0.0)
-- 			:if type(myvar) == type(v:true)
-- <		In place of checking for |v:null| type it is better to check
-- 		for |v:null| directly as it is the only value of this type: >
-- 			:if myvar is v:null
-- <               To check if the v:t_ variables exist use this: >
--                         :if exists('v:t_number')
--- @return number
function vim.fn.type(name) end

-- Pops and restores the |context| at the top of the
-- 		|context-stack|.
--- @return none
function vim.fn.ctxpop() end

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

-- Returns a String with 64 hex characters, which is the SHA256
-- 		checksum of {string}.
--- @return string
function vim.fn.sha256(string) end

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

-- Return the oldest available reply from {serverid} and consume
-- 		it.  Unless a {timeout} in seconds is given, it blocks until a
-- 		reply is available.
-- 		See also |clientserver|.
-- 		This function is not available in the |sandbox|.
-- 		Example: >
-- 			:echo remote_read(id)
-- <
--- @return string
function vim.fn.remote_read(serverid, timeout) end

-- Positions the cursor at the column (byte count) {col} in the
-- 		line {lnum}.  The first column is one.
--
-- 		When there is one argument {list} this is used as a |List|
-- 		with two, three or four item:
-- 			[{lnum}, {col}]
-- 			[{lnum}, {col}, {off}]
-- 			[{lnum}, {col}, {off}, {curswant}]
-- 		This is like the return value of |getpos()| or |getcurpos()|,
-- 		but without the first item.
--
-- 		Does not change the jumplist.
-- 		If {lnum} is greater than the number of lines in the buffer,
-- 		the cursor will be positioned at the last line in the buffer.
-- 		If {lnum} is zero, the cursor will stay in the current line.
-- 		If {col} is greater than the number of bytes in the line,
-- 		the cursor will be positioned at the last character in the
-- 		line.
-- 		If {col} is zero, the cursor will stay in the current column.
-- 		If {curswant} is given it is used to set the preferred column
-- 		for vertical movement.  Otherwise {col} is used.
--
-- 		When 'virtualedit' is used {off} specifies the offset in
-- 		screen columns from the start of the character.  E.g., a
-- 		position within a <Tab> or after the last character.
-- 		Returns 0 when the position could be set, -1 otherwise.
--- @param list any[]
--- @return number
function vim.fn.cursor(list) end

-- Same as |match()|, but return the matched string.  Example: >
-- 			:echo matchstr("testing", "ing")
-- <		results in "ing".
-- 		When there is no match "" is returned.
-- 		The {start}, if given, has the same meaning as for |match()|. >
-- 			:echo matchstr("testing", "ing", 2)
-- <		results in "ing". >
-- 			:echo matchstr("testing", "ing", 5)
-- <		result is "".
-- 		When {expr} is a |List| then the matching item is returned.
-- 		The type isn't changed, it's not necessarily a String.
--- @return string
function vim.fn.matchstr(expr, pat, start, count) end

-- Sets the |context| at {index} from the top of the
-- 		|context-stack| to that represented by {context}.
-- 		{context} is a Dictionary with context data (|context-dict|).
-- 		If {index} is not given, it is assumed to be 0 (i.e.: top).
--- @return none
function vim.fn.ctxset(context, index) end

-- Get the value of a tab-local variable {varname} in tab page
-- 		{tabnr}. |t:var|
-- 		Tabs are numbered starting with one.
-- 		When {varname} is empty a dictionary with all tab-local
-- 		variables is returned.
-- 		Note that the name without "t:" must be used.
-- 		When the tab or variable doesn't exist {def} or an empty
-- 		string is returned, there is no error message.
function vim.fn.gettabvar(nr, varname, def) end

-- Return the current time, measured as seconds since 1st Jan
-- 		1970.  See also |strftime()| and |getftime()|.
--- @return number
function vim.fn.localtime() end

-- Get the value of window-local variable {varname} in window
-- 		{winnr} in tab page {tabnr}.
-- 		When {varname} is empty a dictionary with all window-local
-- 		variables is returned.
-- 		When {varname} is equal to "&" get the values of all
-- 		window-local options in a Dictionary.
-- 		Otherwise, when {varname} starts with "&" get the value of a
-- 		window-local option.
-- 		Note that {varname} must be the name without "w:".
-- 		Tabs are numbered starting with one.  For the current tabpage
-- 		use |getwinvar()|.
-- 		{winnr} can be the window number or the |window-ID|.
-- 		When {winnr} is zero the current window is used.
-- 		This also works for a global option, buffer-local option and
-- 		window-local option, but it doesn't work for a global variable
-- 		or buffer-local variable.
-- 		When the tab, window or variable doesn't exist {def} or an
-- 		empty string is returned, there is no error message.
-- 		Examples: >
-- 			:let list_is_on = gettabwinvar(1, 2, '&list')
-- 			:echo "myvar = " . gettabwinvar(3, 1, 'myvar')
-- <
-- 		To obtain all window-local variables use: >
-- 			gettabwinvar({tabnr}, {winnr}, '&')
function vim.fn.gettabwinvar(tabnr, winnr, name, def) end

-- Removes a watcher added  with |dictwatcheradd()|. All three
-- 		arguments must match the ones passed to |dictwatcheradd()| in
-- 		order for the watcher to be successfully deleted.
--- @param dict dictionary
--- @return stop
function vim.fn.dictwatcherdel(dict, pattern, callback) end

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

-- The result is a list with two numbers, the result of
-- 		getwinposx() and getwinposy() combined:
-- 			[x-pos, y-pos]
-- 		{timeout} can be used to specify how long to wait in msec for
-- 		a response from the terminal.  When omitted 100 msec is used.
--- @return list
function vim.fn.getwinpos(timeout) end

-- The result is a Number, which is the translated syntax ID of
-- 		{synID}.  This is the syntax group ID of what is being used to
-- 		highlight the character.  Highlight links given with
-- 		":highlight link" are followed.
--- @return number
function vim.fn.synIDtrans(synID) end

-- with name {name}.  When the highlight group doesn't exist,
-- 		zero is returned.
-- 		This can be used to retrieve information about the highlight
-- 		group.  For example, to get the background color of the
-- 		"Comment" group: >
-- 	:echo synIDattr(synIDtrans(hlID("Comment")), "bg")
--- @return number
function vim.fn.hlID(name) end

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

-- the top of the GUI Vim window.  The result will be -1 if the
-- 		information is not available.
-- 		The value can be used with `:winpos`.
--- @return number
function vim.fn.getwinposy() end

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

