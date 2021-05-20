--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

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

-- Filter that can be used for a popup. It handles only the keys
-- 		'y', 'Y' and 'n' or 'N'.  Invokes the "callback" of the
-- 		popup menu with the 1 for 'y' or 'Y' and zero for 'n' or 'N'
-- 		as the second argument.  Pressing Esc and 'x' works like
-- 		pressing 'n'.  CTRL-C invokes the callback with -1.  Other
-- 		keys are ignored.
-- 		See the example here: |popup_dialog-example|
--- @return number
function vim.fn.popup_filter_yesno(id, key) end

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

-- Tell Nvim to resize a grid. Triggers a grid_resize event with
--                 the requested grid size or the maximum size if it exceeds size
--                 limits.
--
--                 On invalid grid handle, fails with error.
--
--                 Parameters: ~
--                     {grid}    The handle of the grid to be changed.
--                     {width}   The new requested width.
--                     {height}  The new requested height.
function vim.fn.nvim_ui_try_resize_grid(grid, width, height) end

-- Return a List with all text properties in line {lnum}.
--
-- 		When {props} contains a "bufnr" item, use this buffer instead
-- 		of the current buffer.
--
-- 		The properties are ordered by starting column and priority.
-- 		Each property is a Dict with these entries:
-- 		   col		starting column
-- 		   length	length in bytes, one more if line break is
-- 				included
-- 		   id		property ID
-- 		   type		name of the property type, omitted if
-- 				the type was deleted
-- 		   start	when TRUE property starts in this line
-- 		   end		when TRUE property ends in this line
--
-- 		When "start" is zero the property started in a previous line,
-- 		the current one is a continuation.
-- 		When "end" is zero the property continues in the next line.
-- 		The line break after this line is included.
--
-- 		See |text-properties| for information about text properties.
--
-- 		Can also be used as a |method|: >
-- 			GetLnum()->prop_list()
-- <
--- @return list
function vim.fn.prop_list(lnum, props) end

-- Return a |List| with all the key-value pairs of {dict}.  Each
-- 		|List| item is a list with two items: the key of a {dict}
-- 		entry and the value of this entry.  The |List| is in arbitrary
-- 		order.
--- @param dict dictionary
--- @return list
function vim.fn.items(dict) end

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

-- The result is a Number, which is |TRUE| if a buffer called
-- 		{expr} exists and is listed (has the 'buflisted' option set).
-- 		The {expr} argument is used like with |bufexists()|.
--- @return number
function vim.fn.buflisted(expr) end

-- Add a text property type {name}.  If a property type with this
-- 		name already exists an error is given.  Nothing is returned.
-- 		{props} is a dictionary with these optional fields:
-- 		   bufnr	define the property only for this buffer; this
-- 				avoids name collisions and automatically
-- 				clears the property types when the buffer is
-- 				deleted.
-- 		   highlight	name of highlight group to use
-- 		   priority	when a character has multiple text
-- 				properties the one with the highest priority
-- 				will be used; negative values can be used, the
-- 				default priority is zero
-- 		   combine	when TRUE combine the highlight with any
-- 				syntax highlight; when omitted or FALSE syntax
-- 				highlight will not be used
-- 		   start_incl	when TRUE inserts at the start position will
-- 				be included in the text property
-- 		   end_incl	when TRUE inserts at the end position will be
-- 				included in the text property
--
-- 		See |text-properties| for information about text properties.
--
-- 		Can also be used as a |method|: >
-- 			GetPropName()->prop_type_add(props)
--- @return none
function vim.fn.prop_type_add(name, props) end

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

-- Return the arc sine of {expr} measured in radians, as a |Float|
-- 		in the range of [-pi/2, pi/2].
-- 		{expr} must evaluate to a |Float| or a |Number| in the range
-- 		[-1, 1].
-- 		Examples: >
-- 			:echo asin(0.8)
-- <			0.927295 >
-- 			:echo asin(-0.5)
-- <			-0.523599
--- @return float
function vim.fn.asin(expr) end

-- This is for testing: If the memory allocation with {id} is
-- 		called, then decrement {countdown}, and when it reaches zero
-- 		let memory allocation fail {repeat} times.  When {repeat} is
-- 		smaller than one it fails one time.
--
-- 		Can also be used as a |method|: >
-- 			GetAllocId()->test_alloc_fail()
--- @return none
function vim.fn.test_alloc_fail(id, countdown, _repeat) end

-- Convert a list of VimL objects to msgpack. Returned value is
-- 		|readfile()|-style list. Example: >
-- 			call writefile(msgpackdump([{}]), 'fname.mpack', 'b')
-- <		This will write the single 0x80 byte to `fname.mpack` file
-- 		(dictionary with zero items is represented by 0x80 byte in
-- 		messagepack).
--
-- 		Limitations:				*E5004* *E5005*
-- 		1. |Funcref|s cannot be dumped.
-- 		2. Containers that reference themselves cannot be dumped.
-- 		3. Dictionary keys are always dumped as STR strings.
-- 		4. Other strings are always dumped as BIN strings.
-- 		5. Points 3. and 4. do not apply to |msgpack-special-dict|s.
--- @param list any[]
--- @return list
function vim.fn.msgpackdump(list) end

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

-- for the current buffer.  This is the 'tags' option expanded.
--- @return list
function vim.fn.tagfiles() end

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

-- The result is a String, which is the name of a file that
-- 		doesn't exist.  It can be used for a temporary file.  Example: >
-- 			:let tmpfile = tempname()
-- 			:exe "redir > " . tmpfile
-- <		For Unix, the file will be in a private directory |tempfile|.
-- 		For MS-Windows forward slashes are used when the 'shellslash'
-- 		option is set or when 'shellcmdflag' starts with '-'.
--- @return string
function vim.fn.tempname() end

-- Like |append()| but append the text in buffer {expr}.
--
-- 		For the use of {expr}, see |bufname()|.
--
-- 		{lnum} is used like with |append()|.  Note that using |line()|
-- 		would use the current buffer, not the one appending to.
-- 		Use "$" to append at the end of the buffer.
--
-- 		On success 0 is returned, on failure 1 is returned.
--
-- 		If {expr} is not a valid buffer or {lnum} is not valid, an
-- 		error message is given. Example: >
-- 			:let failed = appendbufline(13, 0, "# THE START")
-- <
--- @return number
function vim.fn.appendbufline(expr, lnum, text) end

-- Like |garbagecollect()|, but executed right away.  This must
-- 		only be called directly to avoid any structure to exist
-- 		internally, and |v:testing| must have been set before calling
-- 		any function.
--- @return none
function vim.fn.test_garbagecollect_now() end

-- Return the reference count of {expr}.  When {expr} is of a
-- 		type that does not have a reference count, returns -1.  Only
-- 		to be used for testing.
--
-- 		Can also be used as a |method|: >
-- 			GetVarname()->test_refcount()
--- @return number
function vim.fn.test_refcount(expr) end

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

-- Get the |window-ID| for the popup info window, as it used by
-- 		the popup menu.  See |complete-popup|.  The info popup is
-- 		hidden when not used, it can be deleted with |popup_clear()|
-- 		and |popup_close()|.  Use |popup_show()| to reposition it to
-- 		the item in the popup menu.
-- 		Returns zero if there is none.
--- @return number
function vim.fn.popup_findinfo() end

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

-- Stop all timers.  The timer callbacks will no longer be
-- 		invoked.  Useful if some timers is misbehaving.  If there are
-- 		no timers there is no error.
--- @return none
function vim.fn.timer_stopall() end

-- Return the line number of the first line at or above {lnum}
-- 		that is not blank.  Example: >
-- 			let ind = indent(prevnonblank(v:lnum - 1))
-- <		When {lnum} is invalid or there is no non-blank line at or
-- 		above it, zero is returned.
-- 		Also see |nextnonblank()|.
--- @return number
function vim.fn.prevnonblank(lnum) end

-- The result is a copy of the String given, with all uppercase
-- 		characters turned into lowercase (just like applying |gu| to
-- 		the string).
--- @return string
function vim.fn.tolower(expr) end

-- Returns a list with |window-ID|s for windows that contain
-- 		buffer {bufnr}.  When there is none the list is empty.
--- @return list
function vim.fn.win_findbuf(bufnr) end

-- The result is a copy of the String given, with all lowercase
-- 		characters turned into uppercase (just like applying |gU| to
-- 		the string).
--- @return string
function vim.fn.toupper(expr) end

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

-- Unstabilized interface for defining syntax hl in lua.
--
--                 This is not yet safe for general use, lua callbacks will need
--                 to be restricted, like textlock and probably other stuff.
--
--                 The API on_line/nvim__put_attr is quite raw and not intended
--                 to be the final shape. Ideally this should operate on chunks
--                 larger than a single line to reduce interpreter overhead, and
--                 generate annotation objects (bufhl/virttext) on the fly but
--                 using the same representation.
function vim.fn.nvim__buf_set_luahl(buffer, opts) end

-- Place the sign defined as {name} at line {lnum} in file {expr}
-- 		and assign {id} and {group} to sign.  This is similar to the
-- 		|:sign-place| command.
--
-- 		If the sign identifier {id} is zero, then a new identifier is
-- 		allocated.  Otherwise the specified number is used. {group} is
-- 		the sign group name. To use the global sign group, use an
-- 		empty string.  {group} functions as a namespace for {id}, thus
-- 		two groups can use the same IDs. Refer to |sign-identifier|
-- 		for more information.
--
-- 		{name} refers to a defined sign.
-- 		{expr} refers to a buffer name or number. For the accepted
-- 		values, see |bufname()|.
--
-- 		The optional {dict} argument supports the following entries:
-- 			lnum		line number in the buffer {expr} where
-- 					the sign is to be placed. For the
-- 					accepted values, see |line()|.
-- 			priority	priority of the sign. See
-- 					|sign-priority| for more information.
--
-- 		If the optional {dict} is not specified, then it modifies the
-- 		placed sign {id} in group {group} to use the defined sign
-- 		{name}.
--
-- 		Returns the sign identifier on success and -1 on failure.
--
-- 		Examples: >
-- 			" Place a sign named sign1 with id 5 at line 20 in
-- 			" buffer json.c
-- 			call sign_place(5, '', 'sign1', 'json.c',
-- 							\ {'lnum' : 20})
--
-- 			" Updates sign 5 in buffer json.c to use sign2
-- 			call sign_place(5, '', 'sign2', 'json.c')
--
-- 			" Place a sign named sign3 at line 30 in
-- 			" buffer json.c with a new identifier
-- 			let id = sign_place(0, '', 'sign3', 'json.c',
-- 							\ {'lnum' : 30})
--
-- 			" Place a sign named sign4 with id 10 in group 'g3'
-- 			" at line 40 in buffer json.c with priority 90
-- 			call sign_place(10, 'g3', 'sign4', 'json.c',
-- 					\ {'lnum' : 40, 'priority' : 90})
--- @param dict dictionary
--- @return number
function vim.fn.sign_place(id, group, name, expr, dict) end

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

-- see |line()|.  For getting the cursor position see
-- 		|getcurpos()|.
-- 		The result is a |List| with four numbers:
-- 		    [bufnum, lnum, col, off]
-- 		"bufnum" is zero, unless a mark like '0 or 'A is used, then it
-- 		is the buffer number of the mark.
-- 		"lnum" and "col" are the position in the buffer.  The first
-- 		column is 1.
-- 		The "off" number is zero, unless 'virtualedit' is used.  Then
-- 		it is the offset in screen columns from the start of the
-- 		character.  E.g., a position within a <Tab> or after the last
-- 		character.
-- 		Note that for '< and '> Visual mode matters: when it is "V"
-- 		(visual line mode) the column of '< is zero and the column of
-- 		'> is a large number.
-- 		This can be used to save and restore the position of a mark: >
-- 			let save_a_mark = getpos("'a")
-- 			...
-- 			call setpos("'a", save_a_mark)
-- <		Also see |getcurpos()| and |setpos()|.
--- @return list
function vim.fn.getpos(expr) end

-- Return the non-negative square root of Float {expr} as a
-- 		|Float|.
-- 		{expr} must evaluate to a |Float| or a |Number|.  When {expr}
-- 		is negative the result is NaN (Not a Number).
-- 		Examples: >
-- 			:echo sqrt(100)
-- <			10.0 >
-- 			:echo sqrt(-4.01)
-- <			nan
-- 		"nan" may be different, it depends on system libraries.
--- @return float
function vim.fn.sqrt(expr) end

-- The result is a String, which is {expr} with all unprintable
-- 		characters translated into printable characters |'isprint'|.
-- 		Like they are shown in a window.  Example: >
-- 			echo strtrans(@a)
-- <		This displays a newline in register a as "^@" instead of
-- 		starting a new line.
--- @return string
function vim.fn.strtrans(expr) end

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

-- Connect a socket to an address. If {mode} is "pipe" then
-- 		{address} should be the path of a named pipe. If {mode} is
-- 		"tcp" then {address} should be of the form "host:port" where
-- 		the host should be an ip adderess or host name, and port the
-- 		port number.
--
-- 		Returns a |channel| ID. Close the socket with |chanclose()|.
-- 		Use |chansend()| to send data over a bytes socket, and
-- 		|rpcrequest()| and |rpcnotify()| to communicate with a RPC
-- 		socket.
--
-- 		{opts} is a dictionary with these keys:
-- 		  |on_data| : callback invoked when data was read from socket
-- 		  data_buffered : read socket data in |channel-buffered| mode.
-- 		  rpc     : If set, |msgpack-rpc| will be used to communicate
-- 			    over the socket.
-- 		Returns:
-- 		  - The channel ID on success (greater than zero)
-- 		  - 0 on invalid arguments or connection failure.
--- @return number
function vim.fn.sockconnect(mode, address, opts) end

-- Return a |List| with all the values of {dict}.  The |List| is
-- 		in arbitrary order.
--- @param dict dictionary
--- @return list
function vim.fn.values(dict) end

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

-- the top of the GUI Vim window.  The result will be -1 if the
-- 		information is not available.
-- 		The value can be used with `:winpos`.
--- @return number
function vim.fn.getwinposy() end

-- the left hand side of the GUI Vim window.  The result will be
-- 		-1 if the information is not available.
-- 		The value can be used with `:winpos`.
--- @return number
function vim.fn.getwinposx() end

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

-- Return a list with the tab number and window number of window
-- 		with ID {expr}: [tabnr, winnr].
-- 		Return [0, 0] if the window cannot be found.
--- @return list
function vim.fn.win_id2tabwin(expr) end

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

-- Return the window number of window with ID {expr}.
-- 		Return 0 if the window cannot be found in the current tabpage.
--- @return number
function vim.fn.win_id2win(expr) end

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

-- Return the screen position of window {nr} as a list with two
-- 		numbers: [row, col].  The first window always has position
-- 		[1, 1], unless there is a tabline, then it is [2, 1].
-- 		{nr} can be the window number or the |window-ID|.
-- 		Return [0, 0] if the window cannot be found in the current
-- 		tabpage.
--- @return list
function vim.fn.win_screenpos(nr) end

-- Return a string which contains characters indicating the
-- 		current state.  Mostly useful in callbacks that want to do
-- 		work that may not always be safe.  Roughly this works like:
-- 		- callback uses state() to check if work is safe to do.
-- 		  Yes: then do it right away.
-- 		  No:  add to work queue and add a |SafeState| and/or
-- 		       |SafeStateAgain| autocommand (|SafeState| triggers at
-- 		       toplevel, |SafeStateAgain| triggers after handling
-- 		       messages and callbacks).
-- 		- When SafeState or SafeStateAgain is triggered and executes
-- 		  your autocommand, check with `state()` if the work can be
-- 		  done now, and if yes remove it from the queue and execute.
-- 		  Remove the autocommand if the queue is now empty.
-- 		Also see |mode()|.
--
-- 		When {what} is given only characters in this string will be
-- 		added.  E.g, this checks if the screen has scrolled: >
-- 			if state('s') == ''
-- 			   " screen has not scrolled
-- <
-- 		These characters indicate the state, generally indicating that
-- 		something is busy:
-- 		    m	halfway a mapping, :normal command, feedkeys() or
-- 			stuffed command
-- 		    o	operator pending or waiting for a command argument,
-- 		        e.g. after |f|
-- 		    a	Insert mode autocomplete active
-- 		    x	executing an autocommand
-- 		    w	blocked on waiting, e.g. ch_evalexpr(), ch_read() and
-- 			ch_readraw() when reading json.
-- 		    S	not triggering SafeState or SafeStateAgain
-- 		    c	callback invoked, including timer (repeats for
-- 			recursiveness up to "ccc")
-- 		    s	screen has scrolled for messages
--- @return string
function vim.fn.state(what) end

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

