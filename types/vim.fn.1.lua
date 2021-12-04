--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Deletes a match with ID {id} previously defined by |matchadd()|
-- 		or one of the |:match| commands.  Returns 0 if successful,
-- 		otherwise -1.  See example for |matchadd()|.  All matches can
-- 		be deleted in one operation by |clearmatches()|.
--- @return number
function vim.fn.matchdelete(id) end

-- {list}.
-- 		If you want a list to remain unmodified make a copy first: >
-- 			:let revlist = reverse(copy(mylist))
--- @param list any[]
--- @return list
function vim.fn.reverse(list) end

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

-- Show {expr} inside the balloon.  For the GUI {expr} is used as
-- 		a string.  For a terminal {expr} can be a list, which contains
-- 		the lines of the balloon.  If {expr} is not a list it will be
-- 		split with |balloon_split()|.
-- 		If {expr} is an empty string any existing balloon is removed.
--
-- 		Example: >
-- 			func GetBalloonContent()
-- 			   " ... initiate getting the content
-- 			   return ''
-- 			endfunc
-- 			set balloonexpr=GetBalloonContent()
--
-- 			func BalloonCallback(result)
-- 			  call balloon_show(a:result)
-- 			endfunc
-- <		Can also be used as a |method|: >
-- 			GetText()->balloon_show()
-- <
-- 		The intended use is that fetching the content of the balloon
-- 		is initiated from 'balloonexpr'.  It will invoke an
-- 		asynchronous method, in which a callback invokes
-- 		balloon_show().  The 'balloonexpr' itself can return an
-- 		empty string or a placeholder.
--
-- 		When showing a balloon is not possible nothing happens, no
-- 		error message.
-- 		{only available when compiled with the |+balloon_eval| or
-- 		|+balloon_eval_term| feature}
--- @return none
function vim.fn.balloon_show(expr) end

-- Return a |Blob| that is null. Only useful for testing.
--- @return blob
function vim.fn.test_null_blob() end

-- Like ch_read() but reads binary data and returns a |Blob|.
-- 		See |channel-more|.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_readblob()
--- @return blob
function vim.fn.ch_readblob(handle, options) end

-- Just like |popup_create()| but with these default options: >
-- 			call popup_create({what}, #{
-- 				\ pos: 'center',
-- 				\ zindex: 200,
-- 				\ drag: 1,
-- 				\ border: [],
-- 				\ padding: [],
-- 				\ mapping: 0,
-- 				\})
-- <		Use {options} to change the properties. E.g. add a 'filter'
-- 		option with value 'popup_filter_yesno'.  Example: >
-- 			call popup_create('do you want to quit (Yes/no)?', #{
-- 				\ filter: 'popup_filter_yesno',
-- 				\ callback: 'QuitCallback',
-- 				\ })
--
-- <		By default the dialog can be dragged, so that text below it
-- 		can be read if needed.
--
-- 		Can also be used as a |method|: >
-- 			GetText()->popup_dialog({})
--- @return number
function vim.fn.popup_dialog(what, options) end

-- Create or replace or add to the quickfix list.
--
-- 		When {what} is not present, use the items in {list}.  Each
-- 		item must be a dictionary.  Non-dictionary items in {list} are
-- 		ignored.  Each dictionary item can contain the following
-- 		entries:
--
-- 		    bufnr	buffer number; must be the number of a valid
-- 				buffer
-- 		    filename	name of a file; only used when "bufnr" is not
-- 				present or it is invalid.
-- 		    module	name of a module; if given it will be used in
-- 				quickfix error window instead of the filename
-- 		    lnum	line number in the file
-- 		    pattern	search pattern used to locate the error
-- 		    col		column number
-- 		    vcol	when non-zero: "col" is visual column
-- 				when zero: "col" is byte index
-- 		    nr		error number
-- 		    text	description of the error
-- 		    type	single-character error type, 'E', 'W', etc.
-- 		    valid	recognized error message
--
-- 		The "col", "vcol", "nr", "type" and "text" entries are
-- 		optional.  Either "lnum" or "pattern" entry can be used to
-- 		locate a matching error line.
-- 		If the "filename" and "bufnr" entries are not present or
-- 		neither the "lnum" or "pattern" entries are present, then the
-- 		item will not be handled as an error line.
-- 		If both "pattern" and "lnum" are present then "pattern" will
-- 		be used.
-- 		If the "valid" entry is not supplied, then the valid flag is
-- 		set when "bufnr" is a valid buffer or "filename" exists.
-- 		If you supply an empty {list}, the quickfix list will be
-- 		cleared.
-- 		Note that the list is not exactly the same as what
-- 		|getqflist()| returns.
--
-- 		{action} values:				*E927*
-- 		'a'	The items from {list} are added to the existing
-- 			quickfix list. If there is no existing list, then a
-- 			new list is created.
--
-- 		'r'	The items from the current quickfix list are replaced
-- 			with the items from {list}.  This can also be used to
-- 			clear the list: >
-- 				:call setqflist([], 'r')
-- <
-- 		'f'	All the quickfix lists in the quickfix stack are
-- 			freed.
--
-- 		If {action} is not present or is set to ' ', then a new list
-- 		is created. The new quickfix list is added after the current
-- 		quickfix list in the stack and all the following lists are
-- 		freed. To add a new quickfix list at the end of the stack,
-- 		set "nr" in {what} to "$".
--
-- 		If the optional {what} dictionary argument is supplied, then
-- 		only the items listed in {what} are set. The first {list}
-- 		argument is ignored.  The following items can be specified in
-- 		{what}:
-- 		    context	quickfix list context. See |quickfix-context|
-- 		    efm		errorformat to use when parsing text from
-- 				"lines". If this is not present, then the
-- 				'errorformat' option value is used.
-- 		    id		quickfix list identifier |quickfix-ID|
-- 		    items	list of quickfix entries. Same as the {list}
-- 				argument.
-- 		    lines	use 'errorformat' to parse a list of lines and
-- 				add the resulting entries to the quickfix list
-- 				{nr} or {id}.  Only a |List| value is supported.
-- 		    nr		list number in the quickfix stack; zero
-- 				means the current quickfix list and "$" means
-- 				the last quickfix list
-- 		    title	quickfix list title text
-- 		Unsupported keys in {what} are ignored.
-- 		If the "nr" item is not present, then the current quickfix list
-- 		is modified. When creating a new quickfix list, "nr" can be
-- 		set to a value one greater than the quickfix stack size.
-- 		When modifying a quickfix list, to guarantee that the correct
-- 		list is modified, "id" should be used instead of "nr" to
-- 		specify the list.
--
-- 		Examples (See also |setqflist-examples|): >
-- 		   :call setqflist([], 'r', {'title': 'My search'})
-- 		   :call setqflist([], 'r', {'nr': 2, 'title': 'Errors'})
-- 		   :call setqflist([], 'a', {'id':qfid, 'lines':["F1:10:L10"]})
-- <
-- 		Returns zero for success, -1 for failure.
--
-- 		This function can be used to create a quickfix list
-- 		independent of the 'errorformat' setting.  Use a command like
-- 		`:cc 1` to jump to the first position.
--- @param list any[]
--- @return number
function vim.fn.setqflist(list, action, what) end

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

-- {expr} can be a list or a dictionary.  For a dictionary,
-- 		it returns the minimum of all values in the dictionary.
-- 		If {expr} is neither a list nor a dictionary, or one of the
-- 		items in {expr} cannot be used as a Number this results in
-- 		an error.  An empty |List| or |Dictionary| results in zero.
--- @return number
function vim.fn.min(expr) end

--- @param list any[]
--- @return list
function vim.fn.sign_placelist(list) end

-- Returns a 2-tuple (Array), where item 0 is the current channel
--                 id and item 1 is the |api-metadata| map (Dictionary).
--
--                 Return: ~
--                     2-tuple [{channel-id}, {api-metadata}]
--
--                 Attributes: ~
--                     {fast}
function vim.fn.nvim_get_api_info() end

-- Set prompt callback for buffer {buf} to {expr}.  When {expr}
-- 		is an empty string the callback is removed.  This has only
-- 		effect if {buf} has 'buftype' set to "prompt".
--
-- 		The callback is invoked when pressing Enter.  The current
-- 		buffer will always be the prompt buffer.  A new line for a
-- 		prompt is added before invoking the callback, thus the prompt
-- 		for which the callback was invoked will be in the last but one
-- 		line.
-- 		If the callback wants to add text to the buffer, it must
-- 		insert it above the last line, since that is where the current
-- 		prompt is.  This can also be done asynchronously.
-- 		The callback is invoked with one argument, which is the text
-- 		that was entered at the prompt.  This can be an empty string
-- 		if the user only typed Enter.
-- 		Example: >
-- 		   call prompt_setcallback(bufnr(''), function('s:TextEntered'))
-- 		   func s:TextEntered(text)
-- 		     if a:text == 'exit' || a:text == 'quit'
-- 		       stopinsert
-- 		       close
-- 		     else
-- 		       call append(line('$') - 1, 'Entered: "' . a:text . '"')
-- 		       " Reset 'modified' to allow the buffer to be closed.
-- 		       set nomodified
-- 		     endif
-- 		   endfunc
--- @return none
function vim.fn.prompt_setcallback(buf, expr) end

-- Return the sine of {expr}, measured in radians, as a |Float|.
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo sin(100)
-- <			-0.506366 >
-- 			:echo sin(-4.01)
-- <			0.763301
--- @return float
function vim.fn.sin(expr) end

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

-- Get the virtual text (annotation) for a buffer line.
--
--                 The virtual text is returned as list of lists, whereas the
--                 inner lists have either one or two elements. The first element
--                 is the actual text, the optional second element is the
--                 highlight group.
--
--                 The format is exactly the same as given to
--                 nvim_buf_set_virtual_text().
--
--                 If there is no virtual text associated with the given line, an
--                 empty list is returned.
--
--                 Parameters: ~
--                     {buffer}  Buffer handle, or 0 for current buffer
--                     {line}    Line to get the virtual text from (zero-indexed)
--
--                 Return: ~
--                     List of virtual text chunks
function vim.fn.nvim_buf_get_virtual_text(buffer, lnum) end

-- Evaluate Lua expression {expr} and return its result converted
-- 		to Vim data structures. See |lua-eval| for more details.
function vim.fn.luaeval(expr, expr) end

-- The result is a Number, which is the size in bytes of the
-- 		given file {fname}.
-- 		If {fname} is a directory, 0 is returned.
-- 		If the file {fname} can't be found, -1 is returned.
-- 		If the size of {fname} is too big to fit in a Number then -2
-- 		is returned.
--- @return number
function vim.fn.getfsize(fname) end

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

-- Stop all timers.  The timer callbacks will no longer be
-- 		invoked.  Useful if some timers is misbehaving.  If there are
-- 		no timers there is no error.
--- @return none
function vim.fn.timer_stopall() end

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

-- Deactivates buffer-update events on the channel.
--
--                 Parameters: ~
--                     {buffer}  Buffer handle, or 0 for current buffer
--
--                 Return: ~
--                     False if detach failed (because the buffer isn't loaded);
--                     otherwise True.
--
--                 See also: ~
--                     |nvim_buf_attach()|
--                     |api-lua-detach| for detaching Lua callbacks
function vim.fn.nvim_buf_detach(buffer) end

-- Change options for {job}.  Supported are:
-- 		   "stoponexit"	|job-stoponexit|
-- 		   "exit_cb"	|job-exit_cb|
--
-- 		Can also be used as a |method|: >
-- 			GetJob()->job_setoptions(options)
--- @return none
function vim.fn.job_setoptions(job, options) end

-- Return the smallest integral value greater than or equal to
-- 		{expr} as a |Float| (round up).
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			echo ceil(1.456)
-- <			2.0  >
-- 			echo ceil(-5.456)
-- <			-5.0  >
-- 			echo ceil(4.0)
-- <			4.0
--- @return float
function vim.fn.ceil(expr) end

-- The result is a Number, which is |TRUE| when a directory
-- 		with the name {directory} exists.  If {directory} doesn't
-- 		exist, or isn't a directory, the result is |FALSE|.  {directory}
-- 		is any expression, which is used as a String.
--- @return number
function vim.fn.isdirectory(directory) end

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

-- Like |strpart()| but using character index and length instead
-- 		of byte index and length.
-- 		When a character index is used where a character does not
-- 		exist it is assumed to be one character.  For example: >
-- 			strcharpart('abc', -1, 2)
-- <		results in 'a'.
--- @return string
function vim.fn.strcharpart(str, start, len) end

-- Set the function name prefix to be used for the |terminal-api|
-- 		function in terminal {buf}.  For example: >
-- 		    :call term_setapi(buf, "Myapi_")
-- 		    :call term_setapi(buf, "")
-- <
-- 		The default is "Tapi_".  When {expr} is an empty string then
-- 		no |terminal-api| function can be used for {buf}.
--- @return none
function vim.fn.term_setapi(buf, expr) end

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

-- Returns a String with 64 hex characters, which is the SHA256
-- 		checksum of {string}.
--- @return string
function vim.fn.sha256(string) end

-- Show the {what} for 3 seconds at the top of the Vim window.
-- 		This works like: >
-- 			call popup_create({what}, #{
-- 				\ line: 1,
-- 				\ col: 10,
-- 				\ minwidth: 20,
-- 				\ time: 3000,
-- 				\ tabpage: -1,
-- 				\ zindex: 300,
-- 				\ drag: 1,
-- 				\ highlight: 'WarningMsg',
-- 				\ border: [],
-- 				\ close: 'click',
-- 				\ padding: [0,1,0,1],
-- 				\ })
-- <		The PopupNotification highlight group is used instead of
-- 		WarningMsg if it is defined.
--
-- 		Without the |+timers| feature the popup will not disappear
-- 		automatically, the user has to click in it.
--
-- 		The position will be adjusted to avoid overlap with other
-- 		notifications.
-- 		Use {options} to change the properties.
--
-- 		Can also be used as a |method|: >
-- 			GetText()->popup_notification({})
--- @return number
function vim.fn.popup_notification(what, options) end

-- The result is a Number, which is non-zero if a highlight group
-- 		called {name} exists.  This is when the group has been
-- 		defined in some way.  Not necessarily when highlighting has
-- 		been defined for it, it may also have been used for a syntax
-- 		item.
--- @return number
function vim.fn.hlexists(name) end

-- Sets the |context| at {index} from the top of the
-- 		|context-stack| to that represented by {context}.
-- 		{context} is a Dictionary with context data (|context-dict|).
-- 		If {index} is not given, it is assumed to be 0 (i.e.: top).
--- @return none
function vim.fn.ctxset(context, index) end

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

-- Subscribes to event broadcasts.
--
--                 Parameters: ~
--                     {event}  Event type string
function vim.fn.nvim_subscribe(event) end

-- The result is a Number, which is |TRUE| if a buffer called
-- 		{expr} exists and is listed (has the 'buflisted' option set).
-- 		The {expr} argument is used like with |bufexists()|.
--- @return number
function vim.fn.buflisted(expr) end

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

-- Return the line number that contains the character at byte
-- 		count {byte} in the current buffer.  This includes the
-- 		end-of-line character, depending on the 'fileformat' option
-- 		for the current buffer.  The first character has byte count
-- 		one.
-- 		Also see |line2byte()|, |go| and |:goto|.
--- @return number
function vim.fn.byte2line(byte) end

-- Unsubscribes to event broadcasts.
--
--                 Parameters: ~
--                     {event}  Event type string
function vim.fn.nvim_unsubscribe(event) end

-- Return the Number 1 if {expr} is empty, zero otherwise.
-- 		A |List| or |Dictionary| is empty when it does not have any
-- 		items.  A Number is empty when its value is zero.  Special
-- 		variable is empty when it is |v:false| or |v:null|.
--- @return number
function vim.fn.empty(expr) end

-- Spawns {cmd} as a job.
-- 		If {cmd} is a List it runs directly (no 'shell').
-- 		If {cmd} is a String it runs in the 'shell', like this: >
-- 		  :call jobstart(split(&shell) + split(&shellcmdflag) + ['{cmd}'])
-- <		(See |shell-unquoting| for details.)
--
-- 		Example: >
-- 		  :call jobstart('nvim -h', {'on_stdout':{j,d,e->append(line('.'),d)}})
-- <
-- 		Returns |job-id| on success, 0 on invalid arguments (or job
-- 		table is full), -1 if {cmd}[0] or 'shell' is not executable.
-- 		The returned job-id is a valid |channel-id| representing the
-- 		job's stdio streams. Use |chansend()| (or |rpcnotify()| and
-- 		|rpcrequest()| if "rpc" was enabled) to send data to stdin and
-- 		|chanclose()| to close the streams without stopping the job.
--
-- 		See |job-control| and |RPC|.
--
-- 		NOTE: on Windows if {cmd} is a List:
-- 		  - cmd[0] must be an executable (not a "built-in"). If it is
-- 		    in $PATH it can be called by name, without an extension: >
-- 		      :call jobstart(['ping', 'neovim.io'])
-- <		    If it is a full or partial path, extension is required: >
-- 		      :call jobstart(['System32\ping.exe', 'neovim.io'])
-- <		  - {cmd} is collapsed to a string of quoted args as expected
-- 		    by CommandLineToArgvW https://msdn.microsoft.com/bb776391
-- 		    unless cmd[0] is some form of "cmd.exe".
--
-- 							*jobstart-options*
-- 		{opts} is a dictionary with these keys:
-- 		  clear_env:  (boolean) `env` defines the job environment
-- 			      exactly, instead of merging current environment.
-- 		  cwd:	      (string, default=|current-directory|) Working
-- 			      directory of the job.
-- 		  detach:     (boolean) Detach the job process: it will not be
-- 			      killed when Nvim exits. If the process exits
-- 			      before Nvim, `on_exit` will be invoked.
-- 		  env:	      (dict) Map of environment variable name:value
-- 			      pairs extending (or replacing if |clear_env|)
-- 			      the current environment.
-- 		  height:     (number) Height of the `pty` terminal.
-- 		  |on_exit|:    (function) Callback invoked when the job exits.
-- 		  |on_stdout|:  (function) Callback invoked when the job emits
-- 			      stdout data.
-- 		  |on_stderr|:  (function) Callback invoked when the job emits
-- 			      stderr data.
-- 		  pty:	      (boolean) Connect the job to a new pseudo
-- 			      terminal, and its streams to the master file
-- 			      descriptor. Then  `on_stderr` is ignored,
-- 			      `on_stdout` receives all output.
-- 		  rpc:	      (boolean) Use |msgpack-rpc| to communicate with
-- 			      the job over stdio. Then `on_stdout` is ignored,
-- 			      but `on_stderr` can still be used.
-- 		  stderr_buffered: (boolean) Collect data until EOF (stream closed)
-- 			      before invoking `on_stderr`. |channel-buffered|
-- 		  stdout_buffered: (boolean) Collect data until EOF (stream
-- 			      closed) before invoking `on_stdout`. |channel-buffered|
-- 		  TERM:	      (string) Sets the `pty` $TERM environment variable.
-- 		  width:      (number) Width of the `pty` terminal.
--
-- 		{opts} is passed as |self| dictionary to the callback; the
-- 		caller may set other keys to pass application-specific data.
--
-- 		Returns:
-- 		  - |channel-id| on success
-- 		  - 0 on invalid arguments
-- 		  - -1 if {cmd}[0] is not executable.
-- 		See also |job-control|, |channel|, |msgpack-rpc|.
--- @return number
function vim.fn.jobstart(cmd, opts) end

-- This is similar to |json_decode()| with these differences:
-- 		- Object key names do not have to be in quotes.
-- 		- Strings can be in single quotes.
-- 		- Empty items in an array (between two commas) are allowed and
-- 		  result in v:none items.
--
-- 		Can also be used as a |method|: >
-- 			ReadObject()->js_decode()
function vim.fn.js_decode(string) end

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

--- @return list
function vim.fn.searchpairpos(start, middle, _end, flags, ...) end

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

-- Preserve typeahead (also from mappings) and clear it, so that
-- 		a following prompt gets input from the user.  Should be
-- 		followed by a matching inputrestore() after the prompt.  Can
-- 		be used several times, in which case there must be just as
-- 		many inputrestore() calls.
-- 		Returns 1 when out of memory, 0 otherwise.
--- @return number
function vim.fn.inputsave() end

-- The result is a list with two numbers, the result of
-- 		getwinposx() and getwinposy() combined:
-- 			[x-pos, y-pos]
-- 		{timeout} can be used to specify how long to wait in msec for
-- 		a response from the terminal.  When omitted 100 msec is used.
--- @return list
function vim.fn.getwinpos(timeout) end

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

-- Removes a watcher added  with |dictwatcheradd()|. All three
-- 		arguments must match the ones passed to |dictwatcheradd()| in
-- 		order for the watcher to be successfully deleted.
--- @param dict dictionary
--- @return stop
function vim.fn.dictwatcherdel(dict, pattern, callback) end

-- Return a list with file and directory names in {directory}.
-- 		You can also use |glob()| if you don't need to do complicated
-- 		things, such as limiting the number of matches.
--
-- 		When {expr} is omitted all entries are included.
-- 		When {expr} is given, it is evaluated to check what to do:
-- 			If {expr} results in -1 then no further entries will
-- 			be handled.
--- @return list
function vim.fn.readdir(dir, expr) end

-- Call function {func} with the items in |List| {arglist} as
-- 		arguments.
-- 		{func} can either be a |Funcref| or the name of a function.
-- 		a:firstline and a:lastline are set to the cursor line.
-- 		Returns the return value of the called function.
-- 		{dict} is for functions with the "dict" attribute.  It will be
-- 		used to set the local variable "self". |Dictionary-function|
--- @param dict dictionary
function vim.fn.call(func, arglist, dict) end

-- Remove a matching text property from line {lnum}.  When
-- 		{lnum-end} is given, remove matching text properties from line
-- 		{lnum} to {lnum-end} (inclusive).
-- 		When {lnum} is omitted remove matching text properties from
-- 		all lines.
--
-- 		{props} is a dictionary with these fields:
-- 		   id		remove text properties with this ID
-- 		   type		remove text properties with this type name
-- 		   bufnr	use this buffer instead of the current one
-- 		   all		when TRUE remove all matching text properties,
-- 				not just the first one
-- 		A property matches when either "id" or "type" matches.
-- 		If buffer "bufnr" does not exist you get an error message.
-- 		If buffer "bufnr" is not loaded then nothing happens.
--
-- 		Returns the number of properties that were removed.
--
-- 		See |text-properties| for information about text properties.
--
-- 		Can also be used as a |method|: >
-- 			GetProps()->prop_remove()
--- @return number
function vim.fn.prop_remove(props, lnum, lnum_end) end

-- Set a flag to enable the effect of 'autochdir' before Vim
-- 		startup has finished.
--- @return none
function vim.fn.test_autochdir() end

-- Return the sound-folded equivalent of {word}.  Uses the first
-- 		language in 'spelllang' for the current window that supports
-- 		soundfolding.  'spell' must be set.  When no sound folding is
-- 		possible the {word} is returned unmodified.
-- 		This can be used for making spelling suggestions.  Note that
-- 		the method can be quite slow.
--- @return string
function vim.fn.soundfold(word) end

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

-- Return the line number of the first line at or above {lnum}
-- 		that is not blank.  Example: >
-- 			let ind = indent(prevnonblank(v:lnum - 1))
-- <		When {lnum} is invalid or there is no non-blank line at or
-- 		above it, zero is returned.
-- 		Also see |nextnonblank()|.
--- @return number
function vim.fn.prevnonblank(lnum) end

-- Return the window number of window with ID {expr}.
-- 		Return 0 if the window cannot be found in the current tabpage.
--- @return number
function vim.fn.win_id2win(expr) end

-- Returns the number of filler lines above line {lnum}.
-- 		These are the lines that were inserted at this point in
-- 		another diff'ed window.  These filler lines are shown in the
-- 		display but don't exist in the buffer.
-- 		{lnum} is used like with |getline()|.  Thus "." is the current
-- 		line, "'m" mark m, etc.
-- 		Returns 0 if the current window is not in diff mode.
--- @return number
function vim.fn.diff_filler(lnum) end

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

-- Set prompt for buffer {buf} to {text}.  You most likely want
-- 		{text} to end in a space.
-- 		The result is only visible if {buf} has 'buftype' set to
-- 		"prompt".  Example: >
-- 			call prompt_setprompt(bufnr(''), 'command: ')
--- @return none
function vim.fn.prompt_setprompt(buf, text) end

-- Remove a previously placed sign in one or more buffers.  This
-- 		is similar to the |:sign-unplace| command.
--
-- 		{group} is the sign group name. To use the global sign group,
-- 		use an empty string.  If {group} is set to '*', then all the
-- 		groups including the global group are used.
-- 		The signs in {group} are selected based on the entries in
-- 		{dict}.  The following optional entries in {dict} are
-- 		supported:
-- 			buffer	buffer name or number. See |bufname()|.
-- 			id	sign identifier
-- 		If {dict} is not supplied, then all the signs in {group} are
-- 		removed.
--
-- 		Returns 0 on success and -1 on failure.
--
-- 		Examples: >
-- 			" Remove sign 10 from buffer a.vim
-- 			call sign_unplace('', {'buffer' : "a.vim", 'id' : 10})
--
-- 			" Remove sign 20 in group 'g1' from buffer 3
-- 			call sign_unplace('g1', {'buffer' : 3, 'id' : 20})
--
-- 			" Remove all the signs in group 'g2' from buffer 10
-- 			call sign_unplace('g2', {'buffer' : 10})
--
-- 			" Remove sign 30 in group 'g3' from all the buffers
-- 			call sign_unplace('g3', {'id' : 30})
--
-- 			" Remove all the signs placed in buffer 5
-- 			call sign_unplace('*', {'buffer' : 5})
--
-- 			" Remove the signs in group 'g4' from all the buffers
-- 			call sign_unplace('g4')
--
-- 			" Remove sign 40 from all the buffers
-- 			call sign_unplace('*', {'id' : 40})
--
-- 			" Remove all the placed signs from all the buffers
-- 			call sign_unplace('*')
--- @param dict dictionary
--- @return number
function vim.fn.sign_unplace(group, dict) end

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

