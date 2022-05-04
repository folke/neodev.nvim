--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Just like |function()|, but the returned Funcref will lookup
-- 		the function by reference, not by name.  This matters when the
-- 		function {name} is redefined later.
--
-- 		Unlike |function()|, {name} must be an existing user function.
-- 		Also for autoloaded functions. {name} cannot be a builtin
-- 		function.
--- @param dict dictionary
--- @return funcref
function vim.fn.funcref(name, arglist, dict) end

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

-- Restores a list of matches saved by |getmatches() for the
-- 		current window|.  Returns 0 if successful, otherwise -1.  All
-- 		current matches are cleared before the list is restored.  See
-- 		example for |getmatches()|.
--- @param list any[]
--- @return number
function vim.fn.setmatches(list) end

-- The result is a Number.  If the line {lnum} is in a closed
-- 		fold, the result is the number of the last line in that fold.
-- 		If the line {lnum} is not in a closed fold, -1 is returned.
--- @return number
function vim.fn.foldclosedend(lnum) end

-- a client to a Vim server. |remote_send()|
-- 		On Win32 systems this might not work, the OS does not always
-- 		allow a window to bring itself to the foreground.  Use
-- 		|remote_foreground()| instead.
-- 		{only in the Win32 GUI and console version}
--- @return number
function vim.fn.foreground() end

-- Set tab-local variable {varname} to {val} in tab page {tabnr}.
-- 		|t:var|
-- 		Note that the variable name without "t:" must be used.
-- 		Tabs are numbered starting with one.
-- 		This function is not available in the |sandbox|.
--- @return set
function vim.fn.settabvar(nr, varname, val) end

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

-- Returns a list with all property type names.
--
-- 		{props} can contain a "bufnr" item.  When it is given, use
-- 		this buffer instead of the global property types.
--
-- 		See |text-properties| for information about text properties.
--- @return list
function vim.fn.prop_type_list(props) end

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

-- Return a pseudo-random Number generated with an xoshiro128**
-- 		algorithm using seed {expr}.  The returned number is 32 bits,
-- 		also on 64 bits systems, for consistency.
-- 		{expr} can be initialized by |srand()| and will be updated by
-- 		rand().  If {expr} is omitted, an internal seed value is used
-- 		and updated.
--
-- 		Examples: >
-- 			:echo rand()
-- 			:let seed = srand()
-- 			:echo rand(seed)
-- 			:echo rand(seed) % 16  " random number 0 - 15
-- <
--- @return number
function vim.fn.rand(expr) end

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

-- The result is a List of Numbers.  The first number is the same
-- 		as what |screenchar()| returns.  Further numbers are
-- 		composing characters on top of the base character.
-- 		This is mainly to be used for testing.
-- 		Returns an empty List when row or col is out of range.
--
-- 		Can also be used as a |method|: >
-- 			GetRow()->screenchars(col)
--- @return list
function vim.fn.screenchars(row, col) end

-- The result is a String that contains the base character and
-- 		any composing characters at position [row, col] on the screen.
-- 		This is like |screenchars()| but returning a String with the
-- 		characters.
-- 		This is mainly to be used for testing.
-- 		Returns an empty String when row or col is out of range.
--
-- 		Can also be used as a |method|: >
-- 			GetRow()->screenstring(col)
--- @return string
function vim.fn.screenstring(row, col) end

--- @param list any[]
--- @return list
function vim.fn.sign_unplacelist(list) end

-- Stop playing all sounds.
-- 		{only available when compiled with the |+sound| feature}
--- @return none
function vim.fn.sound_clear() end

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

-- Like `sound_playevent()` but play sound file {path}.  {path}
-- 		must be a full path.  On Ubuntu you may find files to play
-- 		with this command: >
-- 		    :!find /usr/share/sounds -type f | grep -v index.theme
--
-- <		Can also be used as a |method|: >
-- 			GetSoundPath()->sound_playfile()
--
-- <		{only available when compiled with the |+sound| feature}
--- @return number
function vim.fn.sound_playfile(path, callback) end

-- Bitwise invert.  The argument is converted to a number.  A
-- 		List, Dict or Float argument causes an error.  Example: >
-- 			:let bits = invert(bits)
--- @return number
function vim.fn.invert(expr) end

-- The result is a Number, which is a unix timestamp representing
-- 		the date and time in {timestring}, which is expected to match
-- 		the format specified in {format}.
--
-- 		The accepted {format} depends on your system, thus this is not
-- 		portable!  See the manual page of the C function strptime()
-- 		for the format.  Especially avoid "%c".  The value of $TZ also
-- 		matters.
--
-- 		If the {timestring} cannot be parsed with {format} zero is
-- 		returned.  If you do not know the format of {timestring} you
-- 		can try different {format} values until you get a non-zero
-- 		result.
--
-- 		See also |strftime()|.
-- 		Examples: >
-- 		  :echo strptime("%Y %b %d %X", "1997 Apr 27 11:49:23")
-- <		  862156163 >
-- 		  :echo strftime("%c", strptime("%y%m%d %T", "970427 11:53:55"))
-- <		  Sun Apr 27 11:53:55 1997 >
-- 		  :echo strftime("%c", strptime("%Y%m%d%H%M%S", "19970427115355") + 3600)
-- <		  Sun Apr 27 12:53:55 1997
--
-- 		Not available on all systems.  To check use: >
-- 			:if exists("*strptime")
--- @return number
function vim.fn.strptime(format, timestring) end

-- The result is a Number, which is the number of characters
-- 		in String {expr}.
-- 		When {skipcc} is omitted or zero, composing characters are
-- 		counted separately.
-- 		When {skipcc} set to 1, Composing characters are ignored.
-- 		Also see |strlen()|, |strdisplaywidth()| and |strwidth()|.
--
-- 		{skipcc} is only available after 7.4.755.  For backward
-- 		compatibility, you can define a wrapper function: >
-- 		    if has("patch-7.4.755")
-- 		      function s:strchars(str, skipcc)
-- 			return strchars(a:str, a:skipcc)
-- 		      endfunction
-- 		    else
-- 		      function s:strchars(str, skipcc)
-- 			if a:skipcc
-- 			  return strlen(substitute(a:str, ".", "x", "g"))
-- 			else
-- 			  return strchars(a:str)
-- 			endif
-- 		      endfunction
-- 		    endif
--- @return number
function vim.fn.strchars(expr, skipcc) end

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

-- Get character {index} from {str}.  This uses a character
-- 		index, not a byte index.  Composing characters are considered
-- 		separate characters here.
-- 		Also see |strcharpart()| and |strchars()|.
--- @return number
function vim.fn.strgetchar(str, index) end

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

-- Get the name of the controlling terminal associated with
-- 		terminal window {buf}.  {buf} is used as with |term_getsize()|.
--
-- 		When {input} is omitted or 0, return the name for writing
-- 		(stdout). When {input} is 1 return the name for reading
-- 		(stdin). On UNIX, both return same name.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_gettty()
--- @return string
function vim.fn.term_gettty(buf, input) end

-- Returns the single letter name of the register being executed.
-- 		Returns an empty string when no register is being executed.
-- 		See |@|.
--- @return string
function vim.fn.reg_executing() end

-- Return a list with the buffer numbers of all buffers for
-- 		terminal windows.
--- @return list
function vim.fn.term_list() end

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

-- Return all of environment variables as dictionary. You can
-- 		check if an environment variable exists like this: >
-- 			:echo has_key(environ(), 'HOME')
-- <		Note that the variable name may be CamelCase; to ignore case
-- 		use this: >
-- 			:echo index(keys(environ()), 'HOME', 0, 1) != -1
--- @return dict
function vim.fn.environ() end

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

-- Wait for pending updates of {buf} to be handled.
-- 		{buf} is used as with |term_getsize()|.
-- 		{time} is how long to wait for updates to arrive in msec.  If
-- 		not set then 10 msec will be used.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_wait()
--- @return number
function vim.fn.term_wait(buf, time) end

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

-- This is for testing: If the memory allocation with {id} is
-- 		called, then decrement {countdown}, and when it reaches zero
-- 		let memory allocation fail {repeat} times.  When {repeat} is
-- 		smaller than one it fails one time.
--
-- 		Can also be used as a |method|: >
-- 			GetAllocId()->test_alloc_fail()
--- @return none
function vim.fn.test_alloc_fail(id, countdown, _repeat) end

-- Characters in {string} are queued for processing as if they
-- 		were typed by the user. This uses a low level input buffer.
-- 		This function works only when with |+unix| or GUI is running.
--
-- 		Can also be used as a |method|: >
-- 			GetText()->test_feedinput()
--- @return none
function vim.fn.test_feedinput(string) end

-- Like |garbagecollect()|, but executed right away.  This must
-- 		only be called directly to avoid any structure to exist
-- 		internally, and |v:testing| must have been set before calling
-- 		any function.
--- @return none
function vim.fn.test_garbagecollect_now() end

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

-- This function checks if an executable with the name {expr}
-- 		exists.  {expr} must be the name of the program without any
-- 		arguments.
-- 		executable() uses the value of $PATH and/or the normal
-- 		searchpath for programs.		*PATHEXT*
-- 		On Windows the ".exe", ".bat", etc. can
-- 		optionally be included.  Then the extensions in $PATHEXT are
-- 		tried.  Thus if "foo.exe" does not exist, "foo.exe.bat" can be
-- 		found.  If $PATHEXT is not set then ".exe;.com;.bat;.cmd" is
-- 		used.  A dot by itself can be used in $PATHEXT to try using
-- 		the name without an extension.  When 'shell' looks like a
-- 		Unix shell, then the name is also tried without adding an
-- 		extension.
-- 		On Windows it only checks if the file exists and
-- 		is not a directory, not if it's really executable.
-- 		On Windows an executable in the same directory as Vim is
-- 		always found (it is added to $PATH at |startup|).
-- 		The result is a Number:
-- 			1	exists
-- 			0	does not exist
-- 			-1	not implemented on this system
-- 		|exepath()| can be used to get the full path of an executable.
--- @return number
function vim.fn.executable(expr) end

-- Return a |Channel| that is null. Only useful for testing.
-- 		{only available when compiled with the +channel feature}
--- @return channel
function vim.fn.test_null_channel() end

-- Return a |Dict| that is null. Only useful for testing.
--- @return dict
function vim.fn.test_null_dict() end

-- Return a |Partial| that is null. Only useful for testing.
--- @return funcref
function vim.fn.test_null_partial() end

-- The result is a Number, which is the last modification time of
-- 		the given file {fname}.  The value is measured as seconds
-- 		since 1st Jan 1970, and may be passed to strftime().  See also
-- 		|localtime()| and |strftime()|.
-- 		If the file {fname} can't be found -1 is returned.
--- @return number
function vim.fn.getftime(fname) end

-- Return a |String| that is null. Only useful for testing.
--- @return string
function vim.fn.test_null_string() end

-- The result is a String, which is {expr} with all unprintable
-- 		characters translated into printable characters |'isprint'|.
-- 		Like they are shown in a window.  Example: >
-- 			echo strtrans(@a)
-- <		This displays a newline in register a as "^@" instead of
-- 		starting a new line.
--- @return string
function vim.fn.strtrans(expr) end

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

-- Return a list with the tab number and window number of window
-- 		with ID {expr}: [tabnr, winnr].
-- 		Return [0, 0] if the window cannot be found.
--- @return list
function vim.fn.win_id2tabwin(expr) end

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

-- Return the screen position of window {nr} as a list with two
-- 		numbers: [row, col].  The first window always has position
-- 		[1, 1], unless there is a tabline, then it is [2, 1].
-- 		{nr} can be the window number or the |window-ID|.
-- 		Return [0, 0] if the window cannot be found in the current
-- 		tabpage.
--- @return list
function vim.fn.win_screenpos(nr) end

-- associated with window {nr}.  {nr} can be the window number or
-- 		the |window-ID|.
-- 		When {nr} is zero, the number of the buffer in the current
-- 		window is returned.
-- 		When window {nr} doesn't exist, -1 is returned.
-- 		Example: >
--   :echo "The file in the current window is " . bufname(winbufnr(0))
-- <
--- @return number
function vim.fn.winbufnr(nr) end

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

-- Convert a |readfile()|-style list to a list of VimL objects.
-- 		Example: >
-- 			let fname = expand('~/.config/nvim/shada/main.shada')
-- 			let mpack = readfile(fname, 'b')
-- 			let shada_objects = msgpackparse(mpack)
-- <		This will read ~/.config/nvim/shada/main.shada file to
-- 		`shada_objects` list.
--
-- 		Limitations:
-- 		1. Mapping ordering is not preserved unless messagepack
-- 		   mapping is dumped using generic  mapping
-- 		   (|msgpack-special-map|).
-- 		2. Since the parser aims to preserve all data untouched
-- 		   (except for 1.) some strings are parsed to
-- 		   |msgpack-special-dict| format which is not convenient to
-- 		   use.
-- 							*msgpack-special-dict*
-- 		Some messagepack strings may be parsed to special
-- 		dictionaries. Special dictionaries are dictionaries which
--
-- 		1. Contain exactly two keys: `_TYPE` and `_VAL`.
-- 		2. `_TYPE` key is one of the types found in |v:msgpack_types|
-- 		   variable.
-- 		3. Value for `_VAL` has the following format (Key column
-- 		   contains name of the key from |v:msgpack_types|):
--
-- 		Key	Value ~
-- 		nil	Zero, ignored when dumping.  Not returned by
-- 			|msgpackparse()| since |v:null| was introduced.
-- 		boolean	One or zero.  When dumping it is only checked that
-- 			value is a |Number|.  Not returned by |msgpackparse()|
-- 			since |v:true| and |v:false| were introduced.
-- 		integer	|List| with four numbers: sign (-1 or 1), highest two
-- 			bits, number with bits from 62nd to 31st, lowest 31
-- 			bits. I.e. to get actual number one will need to use
-- 			code like >
-- 				_VAL[0] * ((_VAL[1] << 62)
-- 				           & (_VAL[2] << 31)
-- 				           & _VAL[3])
-- <			Special dictionary with this type will appear in
-- 			|msgpackparse()| output under one of the following
-- 			circumstances:
-- 			1. |Number| is 32-bit and value is either above
-- 			   INT32_MAX or below INT32_MIN.
-- 			2. |Number| is 64-bit and value is above INT64_MAX. It
-- 			   cannot possibly be below INT64_MIN because msgpack
-- 			   C parser does not support such values.
-- 		float	|Float|. This value cannot possibly appear in
-- 			|msgpackparse()| output.
-- 		string	|readfile()|-style list of strings. This value will
-- 			appear in |msgpackparse()| output if string contains
-- 			zero byte or if string is a mapping key and mapping is
-- 			being represented as special dictionary for other
-- 			reasons.
-- 		binary	|readfile()|-style list of strings. This value will
-- 			appear in |msgpackparse()| output if binary string
-- 			contains zero byte.
-- 		array	|List|. This value cannot appear in |msgpackparse()|
-- 			output.
-- 							*msgpack-special-map*
-- 		map	|List| of |List|s with two items (key and value) each.
-- 			This value will appear in |msgpackparse()| output if
-- 			parsed mapping contains one of the following keys:
-- 			1. Any key that is not a string (including keys which
-- 			   are binary strings).
-- 			2. String with NUL byte inside.
-- 			3. Duplicate key.
-- 			4. Empty key.
-- 		ext	|List| with two values: first is a signed integer
-- 			representing extension type. Second is
-- 			|readfile()|-style list of strings.
--- @param list any[]
--- @return list
function vim.fn.msgpackparse(list) end

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

-- Return a |List| with all the values of {dict}.  The |List| is
-- 		in arbitrary order.
--- @param dict dictionary
--- @return list
function vim.fn.values(dict) end

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

-- The result is a Number, which is |TRUE| if a buffer called
-- 		{expr} exists and is listed (has the 'buflisted' option set).
-- 		The {expr} argument is used like with |bufexists()|.
--- @return number
function vim.fn.buflisted(expr) end

-- {expr} in bytes.
-- 		If the argument is a Number it is first converted to a String.
-- 		For other types an error is given.
-- 		If you want to count the number of multi-byte characters use
-- 		|strchars()|.
-- 		Also see |len()|, |strdisplaywidth()| and |strwidth()|.
--- @return number
function vim.fn.strlen(expr) end

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

-- Make a copy of {expr}.  For Numbers and Strings this isn't
-- 		different from using {expr} directly.
-- 		When {expr} is a |List| a full copy is created.  This means
-- 		that the original |List| can be changed without changing the
-- 		copy, and vice versa.  When an item is a |List|, a copy for it
-- 		is made, recursively.  Thus changing an item in the copy does
-- 		not change the contents of the original |List|.
-- 		When {noref} is omitted or zero a contained |List| or
-- 		|Dictionary| is only copied once.  All references point to
-- 		this single copy.  With {noref} set to 1 every occurrence of a
-- 		|List| or |Dictionary| results in a new copy.  This also means
-- 		that a cyclic reference causes deepcopy() to fail.
-- 								*E724*
-- 		Nesting is possible up to 100 levels.  When there is an item
-- 		that refers back to a higher level making a deep copy with
-- 		{noref} set to 1 will fail.
-- 		Also see |copy()|.
function vim.fn.deepcopy(expr, noref) end

-- Returns a 2-tuple (Array), where item 0 is the current channel
--                 id and item 1 is the |api-metadata| map (Dictionary).
--
--                 Return: ~
--                     2-tuple [{channel-id}, {api-metadata}]
--
--                 Attributes: ~
--                     {fast}
function vim.fn.nvim_get_api_info() end

-- Get the amount of indent for line {lnum} according the C
-- 		indenting rules, as with 'cindent'.
-- 		The indent is counted in spaces, the value of 'tabstop' is
-- 		relevant.  {lnum} is used just like in |getline()|.
-- 		When {lnum} is invalid -1 is returned.
-- 		See |C-indenting|.
--- @return number
function vim.fn.cindent(lnum) end

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

-- Returns the full path of {expr} if it is an executable and
-- 		given as a (partial or full) path or is found in $PATH.
-- 		Returns empty string otherwise.
-- 		If {expr} starts with "./" the |current-directory| is used.
--- @return string
function vim.fn.exepath(expr) end

-- This is a unique number, until Vim exits.
--- @return number
function vim.fn.getpid() end

-- Confirm() offers the user a dialog, from which a choice can be
-- 		made.  It returns the number of the choice.  For the first
-- 		choice this is 1.
--
-- 		{msg} is displayed in a dialog with {choices} as the
-- 		alternatives.  When {choices} is missing or empty, "&OK" is
-- 		used (and translated).
-- 		{msg} is a String, use '\n' to include a newline.  Only on
-- 		some systems the string is wrapped when it doesn't fit.
--
-- 		{choices} is a String, with the individual choices separated
-- 		by '\n', e.g. >
-- 			confirm("Save changes?", "&Yes\n&No\n&Cancel")
-- <		The letter after the '&' is the shortcut key for that choice.
-- 		Thus you can type 'c' to select "Cancel".  The shortcut does
-- 		not need to be the first letter: >
-- 			confirm("file has been modified", "&Save\nSave &All")
-- <		For the console, the first letter of each choice is used as
-- 		the default shortcut key.
--
-- 		The optional {default} argument is the number of the choice
-- 		that is made if the user hits <CR>.  Use 1 to make the first
-- 		choice the default one.  Use 0 to not set a default.  If
-- 		{default} is omitted, 1 is used.
--
-- 		The optional {type} argument gives the type of dialog.  This
-- 		is only used for the icon of the Win32 GUI.  It can be one of
-- 		these values: "Error", "Question", "Info", "Warning" or
-- 		"Generic".  Only the first character is relevant.
-- 		When {type} is omitted, "Generic" is used.
--
-- 		If the user aborts the dialog by pressing <Esc>, CTRL-C,
-- 		or another valid interrupt key, confirm() returns 0.
--
-- 		An example: >
--    :let choice = confirm("What do you want?", "&Apples\n&Oranges\n&Bananas", 2)
--    :if choice == 0
--    :	echo "make up your mind!"
--    :elseif choice == 3
--    :	echo "tasteful"
--    :else
--    :	echo "I prefer bananas myself."
--    :endif
-- <		In a GUI dialog, buttons are used.  The layout of the buttons
-- 		depends on the 'v' flag in 'guioptions'.  If it is included,
-- 		the buttons are always put vertically.  Otherwise,  confirm()
-- 		tries to put the buttons in one horizontal line.  If they
-- 		don't fit, a vertical layout is used anyway.  For some systems
-- 		the horizontal layout is always used.
--- @return number
function vim.fn.confirm(msg, choices, default, type) end

