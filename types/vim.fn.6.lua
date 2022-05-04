--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

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

-- Get the output of {cmd} as a |string| (use |systemlist()| to
-- 		get a |List|). {cmd} is treated exactly as in |jobstart()|.
-- 		Not to be used for interactive commands.
--
-- 		If {input} is a string it is written to a pipe and passed as
-- 		stdin to the command.  The string is written as-is, line
-- 		separators are not changed.
-- 		If {input} is a |List| it is written to the pipe as
-- 		|writefile()| does with {binary} set to "b" (i.e. with
-- 		a newline between each list item, and newlines inside list
-- 		items converted to NULs).
-- 		When {input} is given and is a valid buffer id, the content of
-- 		the buffer is written to the file line by line, each line
-- 		terminated by NL (and NUL where the text has NL).
-- 								*E5677*
-- 		Note: system() cannot write to or read from backgrounded ("&")
-- 		shell commands, e.g.: >
-- 		    :echo system("cat - &", "foo"))
-- <		which is equivalent to: >
-- 		    $ echo foo | bash -c 'cat - &'
-- <		The pipes are disconnected (unless overridden by shell
-- 		redirection syntax) before input can reach it. Use
-- 		|jobstart()| instead.
--
-- 		Note: Use |shellescape()| or |::S| with |expand()| or
-- 		|fnamemodify()| to escape special characters in a command
-- 		argument.  Newlines in {cmd} may cause the command to fail.
-- 		The characters in 'shellquote' and 'shellxquote' may also
-- 		cause trouble.
--
-- 		Result is a String.  Example: >
-- 		    :let files = system("ls " .  shellescape(expand('%:h')))
-- 		    :let files = system('ls ' . expand('%:h:S'))
--
-- <		To make the result more system-independent, the shell output
-- 		is filtered to replace <CR> with <NL> for Macintosh, and
-- 		<CR><NL> with <NL> for DOS-like systems.
-- 		To avoid the string being truncated at a NUL, all NUL
-- 		characters are replaced with SOH (0x01).
--
-- 		The command executed is constructed using several options when
-- 		{cmd} is a string: 'shell' 'shellcmdflag' {cmd}
--
-- 		The resulting error code can be found in |v:shell_error|.
-- 		This function will fail in |restricted-mode|.
--
-- 		Note that any wrong value in the options mentioned above may
-- 		make the function fail.  It has also been reported to fail
-- 		when using a security agent application.
-- 		Unlike ":!cmd" there is no automatic check for changed files.
-- 		Use |:checktime| to force a check.
--- @return string
function vim.fn.system(cmd, input) end

-- Deactivates UI events on the channel.
--
--                 Removes the client from the list of UIs. |nvim_list_uis()|
function vim.fn.nvim_ui_detach() end

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

-- Return a string with a single character, which has the number
-- 		value {expr}.  Examples: >
-- 			nr2char(64)		returns "@"
-- 			nr2char(32)		returns " "
-- <		Example for "utf-8": >
-- 			nr2char(300)		returns I with bow character
-- <		UTF-8 encoding is always used, {utf8} option has no effect,
-- 		and exists only for backwards-compatibility.
-- 		Note that a NUL character in the file is specified with
-- 		nr2char(10), because NULs are represented with newline
-- 		characters.  nr2char(0) is a real NUL and terminates the
-- 		string, thus results in an empty string.
--
-- nvim_...({...})					*E5555* *nvim_...()* *eval-api*
-- 		Call nvim |api| functions. The type checking of arguments will
-- 		be stricter than for most other builtins. For instance,
-- 		if Integer is expected, a |Number| must be passed in, a
-- 		|String| will not be autoconverted.
-- 		Buffer numbers, as returned by |bufnr()| could be used as
-- 		first argument to nvim_buf_... functions.  All functions
-- 		expecting an object (buffer, window or tabpage) can
-- 		also take the numerical value 0 to indicate the current
-- 		(focused) object.
--- @return string
function vim.fn.nr2char(expr, utf8) end

-- TODO: Documentation
function vim.fn.nvim_ui_set_option(name, value) end

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

-- TODO: Documentation
function vim.fn.nvim_ui_try_resize(width, height) end

-- Become the server {name}.  This fails if already running as a
-- 		server, when |v:servername| is not empty.
--- @return none
function vim.fn.remote_startserver(name) end

-- The result is a Number, which is non-zero if a highlight group
-- 		called {name} exists.  This is when the group has been
-- 		defined in some way.  Not necessarily when highlighting has
-- 		been defined for it, it may also have been used for a syntax
-- 		item.
--- @return number
function vim.fn.hlexists(name) end

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

-- Return the current text in the balloon.  Only for the string,
-- 		not used for the List.
--- @return string
function vim.fn.balloon_gettext() end

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

-- Insert {item} at the start of |List| {list}.
-- 		If {idx} is specified insert {item} before the item with index
-- 		{idx}.  If {idx} is zero it goes before the first item, just
-- 		like omitting {idx}.  A negative {idx} is also possible, see
-- 		|list-index|.  -1 inserts just before the last item.
-- 		Returns the resulting |List|.  Examples: >
-- 			:let mylist = insert([2, 3, 5], 1)
-- 			:call insert(mylist, 4, -1)
-- 			:call insert(mylist, 6, len(mylist))
-- <		The last example can be done simpler with |add()|.
-- 		Note that when {item} is a |List| it is inserted as a single
-- 		item.  Use |extend()| to concatenate |Lists|.
--- @param list any[]
--- @return list
function vim.fn.insert(list, item, idx) end

-- Split {msg} into lines to be displayed in a balloon.  The
-- 		splits are made for the current window size and optimize to
-- 		show debugger output.
-- 		Returns a |List| with the split lines.
-- 		Can also be used as a |method|: >
-- 			GetText()->balloon_split()->balloon_show()
--
-- <		{only available when compiled with the |+balloon_eval_term|
-- 		feature}
--- @return list
function vim.fn.balloon_split(msg) end

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

-- Sort the items in {list} in-place.  Returns {list}.
--
-- 		If you want a list to remain unmodified make a copy first: >
-- 			:let sortedlist = sort(copy(mylist))
--
-- <		When {func} is omitted, is empty or zero, then sort() uses the
-- 		string representation of each item to sort on.  Numbers sort
-- 		after Strings, |Lists| after Numbers.  For sorting text in the
-- 		current buffer use |:sort|.
--
-- 		When {func} is given and it is '1' or 'i' then case is
-- 		ignored.
--
-- 		When {func} is given and it is 'n' then all items will be
-- 		sorted numerical (Implementation detail: This uses the
-- 		strtod() function to parse numbers, Strings, Lists, Dicts and
-- 		Funcrefs will be considered as being 0).
--
-- 		When {func} is given and it is 'N' then all items will be
-- 		sorted numerical. This is like 'n' but a string containing
-- 		digits will be used as the number they represent.
--
-- 		When {func} is given and it is 'f' then all items will be
-- 		sorted numerical. All values must be a Number or a Float.
--
-- 		When {func} is a |Funcref| or a function name, this function
-- 		is called to compare items.  The function is invoked with two
-- 		items as argument and must return zero if they are equal, 1 or
-- 		bigger if the first one sorts after the second one, -1 or
-- 		smaller if the first one sorts before the second one.
--
-- 		{dict} is for functions with the "dict" attribute.  It will be
-- 		used to set the local variable "self". |Dictionary-function|
--
-- 		The sort is stable, items which compare equal (as number or as
-- 		string) will keep their relative position. E.g., when sorting
-- 		on numbers, text strings will sort next to each other, in the
-- 		same order as they were originally.
--
-- 		Also see |uniq()|.
--
-- 		Example: >
-- 			func MyCompare(i1, i2)
-- 			   return a:i1 == a:i2 ? 0 : a:i1 > a:i2 ? 1 : -1
-- 			endfunc
-- 			let sortedlist = sort(mylist, "MyCompare")
-- <		A shorter compare version for this specific simple case, which
-- 		ignores overflow: >
-- 			func MyCompare(i1, i2)
-- 			   return a:i1 - a:i2
-- 			endfunc
-- <
--- @param list any[]
--- @param dict dictionary
--- @return list
function vim.fn.sort(list, func, dict) end

-- Close {handle}.  See |channel-close|.
-- 		{handle} can be a Channel or a Job that has a Channel.
-- 		A close callback is not invoked.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_close()
--- @return none
function vim.fn.ch_close(handle) end

-- Like |screenchar()|, but return the attribute.  This is a rather
-- 		arbitrary number that can only be used to compare to the
-- 		attribute at other positions.
--- @return number
function vim.fn.screenattr(row, col) end

-- Close the "in" part of {handle}.  See |channel-close-in|.
-- 		{handle} can be a Channel or a Job that has a Channel.
-- 		A close callback is not invoked.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_close_in()
--- @return none
function vim.fn.ch_close_in(handle) end

-- The result is a Number, which is the character at position
-- 		[row, col] on the screen.  This works for every possible
-- 		screen position, also status lines, window separators and the
-- 		command line.  The top left position is row one, column one
-- 		The character excludes composing characters.  For double-byte
-- 		encodings it may only be the first byte.
-- 		This is mainly to be used for testing.
-- 		Returns -1 when row or col is out of range.
--- @return number
function vim.fn.screenchar(row, col) end

-- Send {expr} over {handle}.  The {expr} is encoded
-- 		according to the type of channel.  The function cannot be used
-- 		with a raw channel.  See |channel-use|.
-- 		{handle} can be a Channel or a Job that has a Channel.
-- 								*E917*
-- 		{options} must be a Dictionary.  It must not have a "callback"
-- 		entry.  It can have a "timeout" entry to specify the timeout
-- 		for this specific request.
--
-- 		ch_evalexpr() waits for a response and returns the decoded
-- 		expression.  When there is an error or timeout it returns an
-- 		empty string.
--
-- 		Note that while waiting for the response, Vim handles other
-- 		messages.  You need to make sure this doesn't cause trouble.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_evalexpr(expr)
function vim.fn.ch_evalexpr(handle, expr, options) end

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

-- Returns a list with |window-ID|s for windows that contain
-- 		buffer {bufnr}.  When there is none the list is empty.
--- @return list
function vim.fn.win_findbuf(bufnr) end

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

--- @return number
function vim.fn.searchpair(start, middle, _end, flags, ...) end

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

--- @return list
function vim.fn.searchpairpos(start, middle, _end, flags, ...) end

-- The result is a String, which is whatever the user typed on
-- 		the command-line.  The {prompt} argument is either a prompt
-- 		string, or a blank string (for no prompt).  A '\n' can be used
-- 		in the prompt to start a new line.
--
-- 		In the second form it accepts a single dictionary with the
-- 		following keys, any of which may be omitted:
--
-- 		Key           Default  Description ~
-- 		prompt        ""       Same as {prompt} in the first form.
-- 		default       ""       Same as {text} in the first form.
-- 		completion    nothing  Same as {completion} in the first form.
-- 		cancelreturn  ""       Same as {cancelreturn} from
-- 		                       |inputdialog()|. Also works with
-- 		                       input().
-- 		highlight     nothing  Highlight handler: |Funcref|.
--
-- 		The highlighting set with |:echohl| is used for the prompt.
-- 		The input is entered just like a command-line, with the same
-- 		editing commands and mappings.  There is a separate history
-- 		for lines typed for input().
-- 		Example: >
-- 			:if input("Coffee or beer? ") == "beer"
-- 			:  echo "Cheers!"
-- 			:endif
-- <
-- 		If the optional {text} argument is present and not empty, this
-- 		is used for the default reply, as if the user typed this.
-- 		Example: >
-- 			:let color = input("Color? ", "white")
--
-- <		The optional {completion} argument specifies the type of
-- 		completion supported for the input.  Without it completion is
-- 		not performed.  The supported completion types are the same as
-- 		that can be supplied to a user-defined command using the
-- 		"-complete=" argument.  Refer to |:command-completion| for
-- 		more information.  Example: >
-- 			let fname = input("File: ", "", "file")
--
-- <					*input()-highlight* *E5400* *E5402*
-- 		The optional `highlight` key allows specifying function which
-- 		will be used for highlighting user input.  This function
-- 		receives user input as its only argument and must return
-- 		a list of 3-tuples [hl_start_col, hl_end_col + 1, hl_group]
-- 		where
-- 			hl_start_col is the first highlighted column,
-- 			hl_end_col is the last highlighted column (+ 1!),
-- 			hl_group is |:hi| group used for highlighting.
-- 					      *E5403* *E5404* *E5405* *E5406*
-- 		Both hl_start_col and hl_end_col + 1 must point to the start
-- 		of the multibyte character (highlighting must not break
-- 		multibyte characters), hl_end_col + 1 may be equal to the
-- 		input length.  Start column must be in range [0, len(input)),
-- 		end column must be in range (hl_start_col, len(input)],
-- 		sections must be ordered so that next hl_start_col is greater
-- 		then or equal to previous hl_end_col.
--
-- 		Example (try some input with parentheses): >
-- 			highlight RBP1 guibg=Red ctermbg=red
-- 			highlight RBP2 guibg=Yellow ctermbg=yellow
-- 			highlight RBP3 guibg=Green ctermbg=green
-- 			highlight RBP4 guibg=Blue ctermbg=blue
-- 			let g:rainbow_levels = 4
-- 			function! RainbowParens(cmdline)
-- 			  let ret = []
-- 			  let i = 0
-- 			  let lvl = 0
-- 			  while i < len(a:cmdline)
-- 			    if a:cmdline[i] is# '('
-- 			      call add(ret, [i, i + 1, 'RBP' . ((lvl % g:rainbow_levels) + 1)])
-- 			      let lvl += 1
-- 			    elseif a:cmdline[i] is# ')'
-- 			      let lvl -= 1
-- 			      call add(ret, [i, i + 1, 'RBP' . ((lvl % g:rainbow_levels) + 1)])
-- 			    endif
-- 			    let i += 1
-- 			  endwhile
-- 			  return ret
-- 			endfunction
-- 			call input({'prompt':'>','highlight':'RainbowParens'})
-- <
-- 		Highlight function is called at least once for each new
-- 		displayed input string, before command-line is redrawn.  It is
-- 		expected that function is pure for the duration of one input()
-- 		call, i.e. it produces the same output for the same input, so
-- 		output may be memoized.  Function is run like under |:silent|
-- 		modifier. If the function causes any errors, it will be
-- 		skipped for the duration of the current input() call.
--
-- 		Highlighting is disabled if command-line contains arabic
-- 		characters.
--
-- 		NOTE: This function must not be used in a startup file, for
-- 		the versions that only run in GUI mode (e.g., the Win32 GUI).
-- 		Note: When input() is called from within a mapping it will
-- 		consume remaining characters from that mapping, because a
-- 		mapping is handled like the characters were typed.
-- 		Use |inputsave()| before input() and |inputrestore()|
-- 		after input() to avoid that.  Another solution is to avoid
-- 		that further characters follow in the mapping, e.g., by using
-- 		|:execute| or |:normal|.
--
-- 		Example with a mapping: >
-- 			:nmap \x :call GetFoo()<CR>:exe "/" . Foo<CR>
-- 			:function GetFoo()
-- 			:  call inputsave()
-- 			:  let g:Foo = input("enter search pattern: ")
-- 			:  call inputrestore()
-- 			:endfunction
--- @return string
function vim.fn.input(prompt, text, completion) end

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

-- Returns a list of server addresses, or empty if all servers
-- 		were stopped. |serverstart()| |serverstop()|
-- 		Example: >
-- 			:echo serverlist()
--- @return string
function vim.fn.serverlist() end

-- different from using {expr} directly.
-- 		When {expr} is a |List| a shallow copy is created.  This means
-- 		that the original |List| can be changed without changing the
-- 		copy, and vice versa.  But the items are identical, thus
-- 		changing an item changes the contents of both |Lists|.
-- 		A |Dictionary| is copied in a similar way as a |List|.
-- 		Also see |deepcopy()|.
function vim.fn.copy(expr) end

-- Rename the file by the name {from} to the name {to}.  This
-- 		should also work to move files across file systems.  The
-- 		result is a Number, which is 0 if the file was renamed
-- 		successfully, and non-zero when the renaming failed.
-- 		NOTE: If {to} exists it is overwritten without warning.
-- 		This function is not available in the |sandbox|.
--- @return number
function vim.fn.rename(from, to) end

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

-- Return the value of environment variable {name}.
-- 		When the variable does not exist |v:null| is returned.  That
-- 		is different from a variable set to an empty string.
-- 		See also |expr-env|.
--- @return string
function vim.fn.getenv(name) end

-- Ensure the buffer {expr} is loaded.  When the buffer name
-- 		refers to an existing file then the file is read.  Otherwise
-- 		the buffer will be empty.  If the buffer was already loaded
-- 		then there is no change.
-- 		If there is an existing swap file for the file of the buffer,
-- 		there will be no dialog, the buffer will be loaded anyway.
-- 		The {expr} argument is used like with |bufexists()|.
--- @return number
function vim.fn.bufload(expr) end

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

-- Check for a key typed while looking for completion matches.
-- 		This is to be used when looking for matches takes some time.
-- 		Returns |TRUE| when searching for matches is to be aborted,
-- 		zero otherwise.
-- 		Only to be used by the function specified with the
-- 		'completefunc' option.
--- @return number
function vim.fn.complete_check() end

-- The opposite of `assert_equal()`: add an error message to
-- 		|v:errors| when {expected} and {actual} are equal.
-- 		Also see |assert-return|.
--- @return number
function vim.fn.assert_notequal(exp, act, msg) end

-- The opposite of `assert_match()`: add an error message to
-- 		|v:errors| when {pattern} matches {actual}.
-- 		Also see |assert-return|.
--- @return number
function vim.fn.assert_notmatch(pat, text, msg) end

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

-- Report a test failure directly, using {msg}.
-- 		Always returns one.
--- @return number
function vim.fn.assert_report(msg) end

-- When {actual} is not true an error message is added to
-- 		|v:errors|, like with |assert_equal()|.
-- 		Also see |assert-return|.
-- 		A value is |TRUE| when it is a non-zero number or |v:true|.
-- 		When {actual} is not a number or |v:true| the assert fails.
-- 		When {msg} is omitted an error in the form "Expected True but
-- 		got {actual}" is produced.
--- @return number
function vim.fn.assert_true(actual, msg) end

-- {list}.
-- 		If you want a list to remain unmodified make a copy first: >
-- 			:let revlist = reverse(copy(mylist))
--- @param list any[]
--- @return list
function vim.fn.reverse(list) end

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

-- Set environment variable {name} to {val}.
-- 		When {val} is |v:null| the environment variable is deleted.
-- 		See also |expr-env|.
--- @return none
function vim.fn.setenv(name, val) end

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

-- Like |strpart()| but using character index and length instead
-- 		of byte index and length.
-- 		When a character index is used where a character does not
-- 		exist it is assumed to be one character.  For example: >
-- 			strcharpart('abc', -1, 2)
-- <		results in 'a'.
--- @return string
function vim.fn.strcharpart(str, start, len) end

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

-- Return the absolute value of {expr}.  When {expr} evaluates to
-- 		a |Float| abs() returns a |Float|.  When {expr} can be
-- 		converted to a |Number| abs() returns a |Number|.  Otherwise
-- 		abs() gives an error message and returns -1.
-- 		Examples: >
-- 			echo abs(1.456)
-- <			1.456  >
-- 			echo abs(-5.456)
-- <			5.456  >
-- 			echo abs(-4)
-- <			4
--- @return float
function vim.fn.abs(expr) end

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

-- Return the line number that contains the character at byte
-- 		count {byte} in the current buffer.  This includes the
-- 		end-of-line character, depending on the 'fileformat' option
-- 		for the current buffer.  The first character has byte count
-- 		one.
-- 		Also see |line2byte()|, |go| and |:goto|.
--- @return number
function vim.fn.byte2line(byte) end

