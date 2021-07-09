--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Like |gettabwinvar()| for the current tabpage.
-- 		Examples: >
-- 			:let list_is_on = getwinvar(2, '&list')
-- 			:echo "myvar = " . getwinvar(1, 'myvar')
function vim.fn.getwinvar(nr, varname, def) end

-- Restores a list of matches saved by |getmatches() for the
-- 		current window|.  Returns 0 if successful, otherwise -1.  All
-- 		current matches are cleared before the list is restored.  See
-- 		example for |getmatches()|.
--- @param list any[]
--- @return number
function vim.fn.setmatches(list) end

-- Set the file permissions for {fname} to {mode}.
-- 		{mode} must be a string with 9 characters.  It is of the form
-- 		"rwxrwxrwx", where each group of "rwx" flags represent, in
-- 		turn, the permissions of the owner of the file, the group the
-- 		file belongs to, and other users.  A '-' character means the
-- 		permission is off, any other character means on.  Multi-byte
-- 		characters are not supported.
--
-- 		For example "rw-r-----" means read-write for the user,
-- 		readable by the group, not accessible by others.  "xx-x-----"
-- 		would do the same thing.
--
-- 		Returns non-zero for success, zero for failure.
--
-- 		To read permissions see |getfperm()|.
--- @return number
function vim.fn.setfperm(fname, mode) end

-- Convert a file pattern, as used by glob(), into a search
-- 		pattern.  The result can be used to match with a string that
-- 		is a file name.  E.g. >
-- 			if filename =~ glob2regpat('Make*.mak')
-- <		This is equivalent to: >
-- 			if filename =~ '^Make.*\.mak$'
-- <		When {expr} is an empty string the result is "^$", match an
-- 		empty string.
-- 		Note that the result depends on the system.  On MS-Windows
-- 		a backslash usually means a path separator.
--- @return string
function vim.fn.glob2regpat(expr) end

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

-- The result is a String, which is the read, write, and execute
-- 		permissions of the given file {fname}.
-- 		If {fname} does not exist or its directory cannot be read, an
-- 		empty string is returned.
-- 		The result is of the form "rwxrwxrwx", where each group of
-- 		"rwx" flags represent, in turn, the permissions of the owner
-- 		of the file, the group the file belongs to, and other users.
-- 		If a user does not have a given permission the flag for this
-- 		is replaced with the string "-".  Examples: >
-- 			:echo getfperm("/etc/passwd")
-- 			:echo getfperm(expand("~/.config/nvim/init.vim"))
-- <		This will hopefully (from a security point of view) display
-- 		the string "rw-r--r--" or even "rw-------".
--
-- 		For setting permissions use |setfperm()|.
--- @return string
function vim.fn.getfperm(fname) end

-- The result is a Number, which is 1 if |Dictionary| {dict} has
-- 		an entry with key {key}.  Zero otherwise.
--- @param dict dictionary
--- @return number
function vim.fn.has_key(dict, key) end

-- Set environment variable {name} to {val}.
-- 		When {val} is |v:null| the environment variable is deleted.
-- 		See also |expr-env|.
--- @return none
function vim.fn.setenv(name, val) end

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

-- Get the Job associated with {channel}.
-- 		If there is no job calling |job_status()| on the returned Job
-- 		will result in "fail".
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_getjob()
--- @return job
function vim.fn.ch_getjob(channel) end

-- Set prompt for buffer {buf} to {text}.  You most likely want
-- 		{text} to end in a space.
-- 		The result is only visible if {buf} has 'buftype' set to
-- 		"prompt".  Example: >
-- 			call prompt_setprompt(bufnr(''), 'command: ')
--- @return none
function vim.fn.prompt_setprompt(buf, text) end

-- Returns a list of tags matching the regular expression {expr}.
--
-- 		If {filename} is passed it is used to prioritize the results
-- 		in the same way that |:tselect| does. See |tag-priority|.
-- 		{filename} should be the full path of the file.
--
-- 		Each list item is a dictionary with at least the following
-- 		entries:
-- 			name		Name of the tag.
-- 			filename	Name of the file where the tag is
-- 					defined.  It is either relative to the
-- 					current directory or a full path.
-- 			cmd		Ex command used to locate the tag in
-- 					the file.
-- 			kind		Type of the tag.  The value for this
-- 					entry depends on the language specific
-- 					kind values.  Only available when
-- 					using a tags file generated by
-- 					Exuberant ctags or hdrtag.
-- 			static		A file specific tag.  Refer to
-- 					|static-tag| for more information.
-- 		More entries may be present, depending on the content of the
-- 		tags file: access, implementation, inherits and signature.
-- 		Refer to the ctags documentation for information about these
-- 		fields.  For C code the fields "struct", "class" and "enum"
-- 		may appear, they give the name of the entity the tag is
-- 		contained in.
--
-- 		The ex-command "cmd" can be either an ex search pattern, a
-- 		line number or a line number followed by a byte number.
--
-- 		If there are no matching tags, then an empty list is returned.
--
-- 		To get an exact tag match, the anchors '^' and '$' should be
-- 		used in {expr}.  This also make the function work faster.
-- 		Refer to |tag-regexp| for more information about the tag
-- 		search regular expression pattern.
--
-- 		Refer to |'tags'| for information about how the tags file is
-- 		located by Vim. Refer to |tags-file-format| for the format of
-- 		the tags file generated by the different ctags tools.
--- @return list
function vim.fn.taglist(expr, filename) end

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

-- The result is a String, the entry with Number {index} from
-- 		{history}.  See |hist-names| for the possible values of
-- 		{history}, and |:history-indexing| for {index}.  If there is
-- 		no such entry, an empty String is returned.  When {index} is
-- 		omitted, the most recent item from the history is used.
--
-- 		Examples:
-- 		Redo the second last search from history. >
-- 			:execute '/' . histget("search", -2)
--
-- <		Define an Ex command ":H {num}" that supports re-execution of
-- 		the {num}th entry from the output of |:history|. >
-- 			:command -nargs=1 H execute histget("cmd", 0+<args>)
--- @return string
function vim.fn.histget(history, index) end

-- The result is the Number of the current entry in {history}.
-- 		See |hist-names| for the possible values of {history}.
-- 		If an error occurred, -1 is returned.
--
-- 		Example: >
-- 			:let inp_index = histnr("expr")
--- @return number
function vim.fn.histnr(history) end

-- in the window.  This is counting screen lines from the top of
-- 		the window.  The first line is one.
-- 		If the cursor was moved the view on the file will be updated
-- 		first, this may cause a scroll.
--- @return number
function vim.fn.winline() end

-- When {expr} is a |List| then this returns the index of the
-- 		first item where {pat} matches.  Each item is used as a
-- 		String, |Lists| and |Dictionaries| are used as echoed.
--
-- 		Otherwise, {expr} is used as a String.  The result is a
-- 		Number, which gives the index (byte offset) in {expr} where
-- 		{pat} matches.
--
-- 		A match at the first character or |List| item returns zero.
-- 		If there is no match -1 is returned.
--
-- 		For getting submatches see |matchlist()|.
-- 		Example: >
-- 			:echo match("testing", "ing")	" results in 4
-- 			:echo match([1, 'x'], '\a')	" results in 1
-- <		See |string-match| for how {pat} is used.
-- 								*strpbrk()*
-- 		Vim doesn't have a strpbrk() function.  But you can do: >
-- 			:let sepidx = match(line, '[.,;: \t]')
-- <								*strcasestr()*
-- 		Vim doesn't have a strcasestr() function.  But you can add
-- 		"\c" to the pattern to ignore case: >
-- 			:let idx = match(haystack, '\cneedle')
-- <
-- 		If {start} is given, the search starts from byte index
-- 		{start} in a String or item {start} in a |List|.
-- 		The result, however, is still the index counted from the
-- 		first character/item.  Example: >
-- 			:echo match("testing", "ing", 2)
-- <		result is again "4". >
-- 			:echo match("testing", "ing", 4)
-- <		result is again "4". >
-- 			:echo match("testing", "t", 2)
-- <		result is "3".
-- 		For a String, if {start} > 0 then it is like the string starts
-- 		{start} bytes later, thus "^" will match at {start}.  Except
-- 		when {count} is given, then it's like matches before the
-- 		{start} byte are ignored (this is a bit complicated to keep it
-- 		backwards compatible).
-- 		For a String, if {start} < 0, it will be set to 0.  For a list
-- 		the index is counted from the end.
-- 		If {start} is out of range ({start} > strlen({expr}) for a
-- 		String or {start} > len({expr}) for a |List|) -1 is returned.
--
-- 		When {count} is given use the {count}'th match.  When a match
-- 		is found in a String the search for the next one starts one
-- 		character further.  Thus this example results in 1: >
-- 			echo match("testing", "..", 0, 2)
-- <		In a |List| the search continues in the next item.
-- 		Note that when {count} is added the way {start} works changes,
-- 		see above.
--
-- 		See |pattern| for the patterns that are accepted.
-- 		The 'ignorecase' option is used to set the ignore-caseness of
-- 		the pattern.  'smartcase' is NOT used.  The matching is always
-- 		done like 'magic' is set and 'cpoptions' is empty.
--- @return number
function vim.fn.match(expr, pat, start, count) end

-- Without {end} the result is a String, which is line {lnum}
-- 		from the current buffer.  Example: >
-- 			getline(1)
-- <		When {lnum} is a String that doesn't start with a
-- 		digit, |line()| is called to translate the String into a Number.
-- 		To get the line under the cursor: >
-- 			getline(".")
-- <		When {lnum} is smaller than 1 or bigger than the number of
-- 		lines in the buffer, an empty string is returned.
--
-- 		When {end} is given the result is a |List| where each item is
-- 		a line from the current buffer in the range {lnum} to {end},
-- 		including line {end}.
-- 		{end} is used in the same way as {lnum}.
-- 		Non-existing lines are silently omitted.
-- 		When {end} is before {lnum} an empty |List| is returned.
-- 		Example: >
-- 			:let start = line('.')
-- 			:let end = search("^$") - 1
-- 			:let lines = getline(start, end)
--
-- <		To get lines from another buffer see |getbufline()|
--- @return list
function vim.fn.getline(lnum, _end) end

-- The result is a Number, which is the number of display cells
-- 		String {expr} occupies.  A Tab character is counted as one
-- 		cell, alternatively use |strdisplaywidth()|.
-- 		When {expr} contains characters with East Asian Width Class
-- 		Ambiguous, this function's return value depends on 'ambiwidth'.
-- 		Also see |strlen()|, |strdisplaywidth()| and |strchars()|.
--- @return number
function vim.fn.strwidth(expr) end

-- Like |settabwinvar()| for the current tab page.
-- 		Examples: >
-- 			:call setwinvar(1, "&list", 0)
-- 			:call setwinvar(2, "myvar", "foobar")
--- @return set
function vim.fn.setwinvar(nr, varname, val) end

-- Without an argument returns the name of the normal font being
-- 		used.  Like what is used for the Normal highlight group
-- 		|hl-Normal|.
-- 		With an argument a check is done whether {name} is a valid
-- 		font name.  If not then an empty string is returned.
-- 		Otherwise the actual font name is returned, or {name} if the
-- 		GUI does not support obtaining the real name.
-- 		Only works when the GUI is running, thus not in your vimrc or
-- 		gvimrc file.  Use the |GUIEnter| autocommand to use this
-- 		function just after the GUI has started.
--- @return string
function vim.fn.getfontname(name) end

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

-- If {id} is a displayed popup, hide it now. If the popup has a
-- 		filter it will not be invoked for so long as the popup is
-- 		hidden.
-- 		If window {id} does not exist nothing happens.  If window {id}
-- 		exists but is not a popup window an error is given. *E993*
--
-- 		Can also be used as a |method|: >
-- 			GetPopup()->popup_hide()
--- @return none
function vim.fn.popup_hide(id) end

-- {list}.
-- 		If you want a list to remain unmodified make a copy first: >
-- 			:let revlist = reverse(copy(mylist))
--- @param list any[]
--- @return list
function vim.fn.reverse(list) end

-- Returns the effective value of 'shiftwidth'. This is the
-- 		'shiftwidth' value unless it is zero, in which case it is the
-- 		'tabstop' value.  To be backwards compatible in indent
-- 		plugins, use this: >
-- 			if exists('*shiftwidth')
-- 			  func s:sw()
-- 			    return shiftwidth()
-- 			  endfunc
-- 			else
-- 			  func s:sw()
-- 			    return &sw
-- 			  endfunc
-- 			endif
-- <		And then use s:sw() instead of &sw.
--- @return number
function vim.fn.shiftwidth() end

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

