--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

--- @return number
function vim.fn.searchpair(start, middle, _end, flags, ...) end

-- Return 1 if {expr} is a positive infinity, or -1 a negative
-- 		infinity, otherwise 0. >
-- 			:echo isinf(1.0 / 0.0)
-- <			1 >
-- 			:echo isinf(-1.0 / 0.0)
-- <			-1
--- @return number
function vim.fn.isinf(expr) end

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

-- Return the current |command-line-window| type. Possible return
-- 		values are the same as |getcmdtype()|. Returns an empty string
-- 		when not in the command-line window.
--- @return string
function vim.fn.getcmdwintype() end

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

-- Returns a list of server addresses, or empty if all servers
-- 		were stopped. |serverstart()| |serverstop()|
-- 		Example: >
-- 			:echo serverlist()
--- @return string
function vim.fn.serverlist() end

-- Returns 1 if the terminal of {buf} is using the alternate
-- 		screen.
-- 		{buf} is used as with |term_getsize()|.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getaltscreen()
--- @return number
function vim.fn.term_getaltscreen(buf) end

-- Evaluate MzScheme expression {expr} and return its result
-- 		converted to Vim data structures.
-- 		Numbers and strings are returned as they are.
-- 		Pairs (including lists and improper lists) and vectors are
-- 		returned as Vim |Lists|.
-- 		Hash tables are represented as Vim |Dictionary| type with keys
-- 		converted to strings.
-- 		All other types are converted to string with display function.
-- 		Examples: >
-- 		    :mz (define l (list 1 2 3))
-- 		    :mz (define h (make-hash)) (hash-set! h "list" l)
-- 		    :echo mzeval("l")
-- 		    :echo mzeval("h")
-- <
-- 		Can also be used as a |method|: >
-- 			GetExpr()->mzeval()
-- <
-- 		{only available when compiled with the |+mzscheme| feature}
function vim.fn.mzeval(expr) end

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

-- Return the hyperbolic cosine of {expr} as a |Float| in the range
-- 		[1, inf].
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo cosh(0.5)
-- <			1.127626 >
-- 			:echo cosh(-0.5)
-- <			-1.127626
--- @return float
function vim.fn.cosh(expr) end

-- Return the exponential of {expr} as a |Float| in the range
-- 		[0, inf].
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo exp(2)
-- <			7.389056 >
-- 			:echo exp(-1)
-- <			0.367879
--- @return float
function vim.fn.exp(expr) end

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

-- Without argument: The result is the badly spelled word under
-- 		or after the cursor.  The cursor is moved to the start of the
-- 		bad word.  When no bad word is found in the cursor line the
-- 		result is an empty string and the cursor doesn't move.
--
-- 		With argument: The result is the first word in {sentence} that
-- 		is badly spelled.  If there are no spelling mistakes the
-- 		result is an empty string.
--
-- 		The return value is a list with two items:
-- 		- The badly spelled word or an empty string.
-- 		- The type of the spelling error:
-- 			"bad"		spelling mistake
-- 			"rare"		rare word
-- 			"local"		word only valid in another region
-- 			"caps"		word should start with Capital
-- 		Example: >
-- 			echo spellbadword("the quik brown fox")
-- <			['quik', 'bad'] ~
--
-- 		The spelling information for the current window is used.  The
-- 		'spell' option must be set and the value of 'spelllang' is
-- 		used.
--- @return string
function vim.fn.spellbadword() end

-- Get the status of terminal {buf}. This returns a comma
-- 		separated list of these items:
-- 			running		job is running
-- 			finished	job has finished
-- 			normal		in Terminal-Normal mode
-- 		One of "running" or "finished" is always present.
--
-- 		{buf} must be the buffer number of a terminal window. If the
-- 		buffer does not exist or is not a terminal window, an empty
-- 		string is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getstatus()
--- @return string
function vim.fn.term_getstatus(buf) end

-- Return the number of lines that scrolled to above the top of
-- 		terminal {buf}.  This is the offset between the row number
-- 		used for |term_getline()| and |getline()|, so that: >
-- 			term_getline(buf, N)
-- <		is equal to: >
-- 			getline(N + term_getscrolled(buf))
-- <		(if that line exists).
--
-- 		{buf} is used as with |term_getsize()|.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getscrolled()
--- @return number
function vim.fn.term_getscrolled(buf) end

-- Stop playing all sounds.
-- 		{only available when compiled with the |+sound| feature}
--- @return none
function vim.fn.sound_clear() end

-- Open a new window displaying the difference between the two
-- 		files.  The files must have been created with
-- 		|term_dumpwrite()|.
-- 		Returns the buffer number or zero when the diff fails.
-- 		Also see |terminal-diff|.
-- 		NOTE: this does not work with double-width characters yet.
--
-- 		The top part of the buffer contains the contents of the first
-- 		file, the bottom part of the buffer contains the contents of
-- 		the second file.  The middle part shows the differences.
-- 		The parts are separated by a line of equals.
--
-- 		If the {options} argument is present, it must be a Dict with
-- 		these possible members:
-- 		   "term_name"	     name to use for the buffer name, instead
-- 				     of the first file name.
-- 		   "term_rows"	     vertical size to use for the terminal,
-- 				     instead of using 'termwinsize'
-- 		   "term_cols"	     horizontal size to use for the terminal,
-- 				     instead of using 'termwinsize'
-- 		   "vertical"	     split the window vertically
-- 		   "curwin"	     use the current window, do not split the
-- 				     window; fails if the current buffer
-- 				     cannot be |abandon|ed
-- 		   "bufnr"	     do not create a new buffer, use the
-- 				     existing buffer "bufnr".  This buffer
-- 				     must have been previously created with
-- 				     term_dumpdiff() or term_dumpload() and
-- 				     visible in a window.
-- 		   "norestore"	     do not add the terminal window to a
-- 				     session file
--
-- 		Each character in the middle part indicates a difference. If
-- 		there are multiple differences only the first in this list is
-- 		used:
-- 			X	different character
-- 			w	different width
-- 			f	different foreground color
-- 			b	different background color
-- 			a	different attribute
-- 			+	missing position in first file
-- 			-	missing position in second file
--
-- 		Using the "s" key the top and bottom parts are swapped.  This
-- 		makes it easy to spot a difference.
--
-- 		Can also be used as a |method|: >
-- 			GetFilename()->term_dumpdiff(otherfile)
-- <
--- @return number
function vim.fn.term_dumpdiff(filename, filename, options) end

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

-- Escape the characters in {chars} that occur in {string} with a
-- 		backslash.  Example: >
-- 			:echo escape('c:\program files\vim', ' \')
-- <		results in: >
-- 			c:\\program\ files\\vim
-- <		Also see |shellescape()| and |fnameescape()|.
--- @return string
function vim.fn.escape(string, chars) end

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

-- Close popup {id}.  The window and the associated buffer will
-- 		be deleted.
--
-- 		If the popup has a callback it will be called just before the
-- 		popup window is deleted.  If the optional {result} is present
-- 		it will be passed as the second argument of the callback.
-- 		Otherwise zero is passed to the callback.
--
-- 		Can also be used as a |method|: >
-- 			GetPopup()->popup_close()
--- @return none
function vim.fn.popup_close(id, result) end

-- Like |screenchar()|, but return the attribute.  This is a rather
-- 		arbitrary number that can only be used to compare to the
-- 		attribute at other positions.
--- @return number
function vim.fn.screenattr(row, col) end

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

-- Tells Nvim the number of elements displaying in the popumenu,
--                 to decide <PageUp> and <PageDown> movement.
--
--                 Parameters: ~
--                     {height}  Popupmenu height, must be greater than zero.
function vim.fn.nvim_ui_pum_set_height(height) end

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

-- The result is a String, which is {expr} with all unprintable
-- 		characters translated into printable characters |'isprint'|.
-- 		Like they are shown in a window.  Example: >
-- 			echo strtrans(@a)
-- <		This displays a newline in register a as "^@" instead of
-- 		starting a new line.
--- @return string
function vim.fn.strtrans(expr) end

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

-- Return the reference count of {expr}.  When {expr} is of a
-- 		type that does not have a reference count, returns -1.  Only
-- 		to be used for testing.
--
-- 		Can also be used as a |method|: >
-- 			GetVarname()->test_refcount()
--- @return number
function vim.fn.test_refcount(expr) end

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

-- TODO: Documentation
function vim.fn.nvim_ui_set_option(name, value) end

-- Show the {what} above the position from 'ballooneval' and
-- 		close it when the mouse moves.  This works like: >
-- 		  let pos = screenpos(v:beval_winnr, v:beval_lnum, v:beval_col)
-- 		  call popup_create({what}, #{
-- 			\ pos: 'botleft',
-- 			\ line: pos.row - 1,
-- 			\ col: pos.col,
-- 			\ mousemoved: 'WORD',
-- 			\ })
-- <		Use {options} to change the properties.
-- 		See |popup_beval_example| for an example.
--
-- 		Can also be used as a |method|: >
-- 			GetText()->popup_beval({})
-- <
--- @return number
function vim.fn.popup_beval(what, options) end

-- Resize the pseudo terminal window of |job-id| {job} to {width}
-- 		columns and {height} rows.
-- 		Fails if the job was not started with `"pty":v:true`.
--- @return number
function vim.fn.jobresize(id, width, height) end

-- The result is a copy of the {src} string with all characters
-- 		which appear in {fromstr} replaced by the character in that
-- 		position in the {tostr} string.  Thus the first character in
-- 		{fromstr} is translated into the first character in {tostr}
-- 		and so on.  Exactly like the unix "tr" command.
-- 		This code also deals with multibyte characters properly.
--
-- 		Examples: >
-- 			echo tr("hello there", "ht", "HT")
-- <		returns "Hello THere" >
-- 			echo tr("<blob>", "<>", "{}")
-- <		returns "{blob}"
--- @return string
function vim.fn.tr(src, fromstr, tostr) end

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

-- Return the current time, measured as seconds since 1st Jan
-- 		1970.  See also |strftime()| and |getftime()|.
--- @return number
function vim.fn.localtime() end

-- Deactivates UI events on the channel.
--
--                 Removes the client from the list of UIs. |nvim_list_uis()|
function vim.fn.nvim_ui_detach() end

-- The result is a list with two numbers, the result of
-- 		getwinposx() and getwinposy() combined:
-- 			[x-pos, y-pos]
-- 		{timeout} can be used to specify how long to wait in msec for
-- 		a response from the terminal.  When omitted 100 msec is used.
--- @return list
function vim.fn.getwinpos(timeout) end

-- The result is a Number, which is |TRUE| when a file with the
-- 		name {file} exists, and can be read.  If {file} doesn't exist,
-- 		or is a directory, the result is |FALSE|.  {file} is any
-- 		expression, which is used as a String.
-- 		If you don't care about the file being readable you can use
-- 		|glob()|.
--- @return number
function vim.fn.filereadable(file) end

-- Returns a 2-tuple (Array), where item 0 is the current channel
--                 id and item 1 is the |api-metadata| map (Dictionary).
--
--                 Return: ~
--                     2-tuple [{channel-id}, {api-metadata}]
--
--                 Attributes: ~
--                     {fast}
function vim.fn.nvim_get_api_info() end

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

-- Returns a positive number if there are available strings
-- 		from {serverid}.  Copies any reply string into the variable
-- 		{retvar} if specified.  {retvar} must be a string with the
-- 		name of a variable.
-- 		Returns zero if none are available.
-- 		Returns -1 if something is wrong.
-- 		See also |clientserver|.
-- 		This function is not available in the |sandbox|.
-- 		Examples: >
-- 			:let repl = ""
-- 			:echo "PEEK: ".remote_peek(id, "repl").": ".repl
--- @return number
function vim.fn.remote_peek(serverid, retvar) end

-- The result is a Number, which is the foldlevel of line {lnum}
-- 		in the current buffer.  For nested folds the deepest level is
-- 		returned.  If there is no fold at line {lnum}, zero is
-- 		returned.  It doesn't matter if the folds are open or closed.
-- 		When used while updating folds (from 'foldexpr') -1 is
-- 		returned for lines where folds are still to be updated and the
-- 		foldlevel is unknown.  As a special case the level of the
-- 		previous line is usually available.
--- @return number
function vim.fn.foldlevel(lnum) end

-- The result is a String, which is the name of the machine on
-- 		which Vim is currently running.  Machine names greater than
-- 		256 characters long are truncated.
--- @return string
function vim.fn.hostname() end

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

-- Return a |List| with the lines starting from {lnum} to {end}
-- 		(inclusive) in the buffer {expr}.  If {end} is omitted, a
-- 		|List| with only the line {lnum} is returned.
--
-- 		For the use of {expr}, see |bufname()| above.
--
-- 		For {lnum} and {end} "$" can be used for the last line of the
-- 		buffer.  Otherwise a number must be used.
--
-- 		When {lnum} is smaller than 1 or bigger than the number of
-- 		lines in the buffer, an empty |List| is returned.
--
-- 		When {end} is greater than the number of lines in the buffer,
-- 		it is treated as {end} is set to the number of lines in the
-- 		buffer.  When {end} is before {lnum} an empty |List| is
-- 		returned.
--
-- 		This function works only for loaded buffers.  For unloaded and
-- 		non-existing buffers, an empty |List| is returned.
--
-- 		Example: >
-- 			:let lines = getbufline(bufnr("myfile"), 1, "$")
--- @return list
function vim.fn.getbufline(expr, lnum, _end) end

-- Pops and restores the |context| at the top of the
-- 		|context-stack|.
--- @return none
function vim.fn.ctxpop() end

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

-- Return the logarithm of Float {expr} to base 10 as a |Float|.
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo log10(1000)
-- <			3.0 >
-- 			:echo log10(0.01)
-- <			-2.0
--- @return float
function vim.fn.log10(expr) end

-- {feature} argument is a feature name like "nvim-0.2.1" or
-- 		"win32", see below.  See also |exists()|.
--
-- 		Vim's compile-time feature-names (prefixed with "+") are not
-- 		recognized because Nvim is always compiled with all possible
-- 		features. |feature-compile|
--
-- 		Feature names can be:
-- 		1.  Nvim version. For example the "nvim-0.2.1" feature means
-- 		    that Nvim is version 0.2.1 or later: >
-- 			:if has("nvim-0.2.1")
--
-- <		2.  Runtime condition or other pseudo-feature. For example the
-- 		    "win32" feature checks if the current system is Windows: >
-- 			:if has("win32")
-- <							*feature-list*
-- 		    List of supported pseudo-feature names:
-- 		        acl		|ACL| support
-- 			bsd		BSD system (not macOS, use "mac" for that).
-- 		        iconv		Can use |iconv()| for conversion.
-- 		        +shellslash	Can use backslashes in filenames (Windows)
-- 			clipboard	|clipboard| provider is available.
-- 			mac		MacOS system.
-- 			nvim		This is Nvim.
-- 			python2		Legacy Vim |python2| interface. |has-python|
-- 			python3		Legacy Vim |python3| interface. |has-python|
-- 			pythonx		Legacy Vim |python_x| interface. |has-pythonx|
-- 			ttyin		input is a terminal (tty)
-- 			ttyout		output is a terminal (tty)
-- 			unix		Unix system.
-- 			*vim_starting*	True during |startup|.
-- 			win32		Windows system (32 or 64 bit).
-- 			win64		Windows system (64 bit).
-- 			wsl		WSL (Windows Subsystem for Linux) system
--
-- 							*has-patch*
-- 		3.  Vim patch. For example the "patch123" feature means that
-- 		    Vim patch 123 at the current |v:version| was included: >
-- 			:if v:version > 602 || v:version == 602 && has("patch148")
--
-- <		4.  Vim version. For example the "patch-7.4.237" feature means
-- 		    that Nvim is Vim-compatible to version 7.4.237 or later. >
-- 			:if has("patch-7.4.237")
--- @return number
function vim.fn.has(feature) end

-- Return the value of environment variable {name}.
-- 		When the variable does not exist |v:null| is returned.  That
-- 		is different from a variable set to an empty string.
-- 		See also |expr-env|.
--- @return string
function vim.fn.getenv(name) end

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

-- Returns a |Dictionary| representing the |context| at {index}
-- 		from the top of the |context-stack| (see |context-dict|).
-- 		If {index} is not given, it is assumed to be 0 (i.e.: top).
--- @return dict
function vim.fn.ctxget(index) end

-- Returns the full path of {expr} if it is an executable and
-- 		given as a (partial or full) path or is found in $PATH.
-- 		Returns empty string otherwise.
-- 		If {expr} starts with "./" the |current-directory| is used.
--- @return string
function vim.fn.exepath(expr) end

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

-- Start a job and return a Job object.  Unlike |system()| and
-- 		|:!cmd| this does not wait for the job to finish.
-- 		To start a job in a terminal window see |term_start()|.
--
-- 		If the job fails to start then |job_status()| on the returned
-- 		Job object results in "fail" and none of the callbacks will be
-- 		invoked.
--
-- 		{command} can be a String.  This works best on MS-Windows.  On
-- 		Unix it is split up in white-separated parts to be passed to
-- 		execvp().  Arguments in double quotes can contain white space.
--
-- 		{command} can be a List, where the first item is the executable
-- 		and further items are the arguments.  All items are converted
-- 		to String.  This works best on Unix.
--
-- 		On MS-Windows, job_start() makes a GUI application hidden. If
-- 		want to show it, Use |:!start| instead.
--
-- 		The command is executed directly, not through a shell, the
-- 		'shell' option is not used.  To use the shell: >
-- 	let job = job_start(["/bin/sh", "-c", "echo hello"])
-- <		Or: >
-- 	let job = job_start('/bin/sh -c "echo hello"')
-- <		Note that this will start two processes, the shell and the
-- 		command it executes.  If you don't want this use the "exec"
-- 		shell command.
--
-- 		On Unix $PATH is used to search for the executable only when
-- 		the command does not contain a slash.
--
-- 		The job will use the same terminal as Vim.  If it reads from
-- 		stdin the job and Vim will be fighting over input, that
-- 		doesn't work.  Redirect stdin and stdout to avoid problems: >
-- 	let job = job_start(['sh', '-c', "myserver </dev/null >/dev/null"])
-- <
-- 		The returned Job object can be used to get the status with
-- 		|job_status()| and stop the job with |job_stop()|.
--
-- 		Note that the job object will be deleted if there are no
-- 		references to it.  This closes the stdin and stderr, which may
-- 		cause the job to fail with an error.  To avoid this keep a
-- 		reference to the job.  Thus instead of: >
-- 	call job_start('my-command')
-- <		use: >
-- 	let myjob = job_start('my-command')
-- <		and unlet "myjob" once the job is not needed or is past the
-- 		point where it would fail (e.g. when it prints a message on
-- 		startup).  Keep in mind that variables local to a function
-- 		will cease to exist if the function returns.  Use a
-- 		script-local variable if needed: >
-- 	let s:myjob = job_start('my-command')
-- <
-- 		{options} must be a Dictionary.  It can contain many optional
-- 		items, see |job-options|.
--
-- 		Can also be used as a |method|: >
-- 			BuildCommand()->job_start()
--- @return job
function vim.fn.job_start(command, options) end

-- When {actual} is not true an error message is added to
-- 		|v:errors|, like with |assert_equal()|.
-- 		Also see |assert-return|.
-- 		A value is |TRUE| when it is a non-zero number or |v:true|.
-- 		When {actual} is not a number or |v:true| the assert fails.
-- 		When {msg} is omitted an error in the form "Expected True but
-- 		got {actual}" is produced.
--- @return number
function vim.fn.assert_true(actual, msg) end

-- The result is a Number, which is the size in bytes of the
-- 		given file {fname}.
-- 		If {fname} is a directory, 0 is returned.
-- 		If the file {fname} can't be found, -1 is returned.
-- 		If the size of {fname} is too big to fit in a Number then -2
-- 		is returned.
--- @return number
function vim.fn.getfsize(fname) end

-- Returns a String with 64 hex characters, which is the SHA256
-- 		checksum of {string}.
--- @return string
function vim.fn.sha256(string) end

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

-- Return byte index of the {nr}'th character in the string
-- 		{expr}.  Use zero for the first character, it returns zero.
-- 		This function is only useful when there are multibyte
-- 		characters, otherwise the returned value is equal to {nr}.
-- 		Composing characters are not counted separately, their byte
-- 		length is added to the preceding base character.  See
-- 		|byteidxcomp()| below for counting composing characters
-- 		separately.
-- 		Example : >
-- 			echo matchstr(str, ".", byteidx(str, 3))
-- <		will display the fourth character.  Another way to do the
-- 		same: >
-- 			let s = strpart(str, byteidx(str, 3))
-- 			echo strpart(s, 0, byteidx(s, 1))
-- <		Also see |strgetchar()| and |strcharpart()|.
--
-- 		If there are less than {nr} characters -1 is returned.
-- 		If there are exactly {nr} characters the length of the string
-- 		in bytes is returned.
--- @return number
function vim.fn.byteidx(expr, nr) end

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

-- Restores a list of matches saved by |getmatches() for the
-- 		current window|.  Returns 0 if successful, otherwise -1.  All
-- 		current matches are cleared before the list is restored.  See
-- 		example for |getmatches()|.
--- @param list any[]
--- @return number
function vim.fn.setmatches(list) end

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

