---@meta

--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

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

-- Returns Dictionary of |api-metadata|.
--
-- 		View it in a nice human-readable format: >
-- 		       :lua print(vim.inspect(vim.fn.api_info()))
--- @return dict
function vim.fn.api_info() end

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

-- the first file.  argc() - 1 is the last one.  See |arglist|.
--- @return number
function vim.fn.argidx() end

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

-- Run {cmd} and add an error message to |v:errors| if it does
-- 		NOT produce a beep or visual bell.
-- 		Also see |assert_fails()| and |assert-return|.
--- @return number
function vim.fn.assert_beeps(cmd) end

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

-- When the files {fname-one} and {fname-two} do not contain
-- 		exactly the same text an error message is added to |v:errors|.
-- 		Also see |assert-return|.
-- 		When {fname-one} or {fname-two} does not exist the error will
-- 		mention that.
--- @return number
function vim.fn.assert_equalfile(fname_one, fname_two) end

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

-- Run {cmd} and add an error message to |v:errors| if it does
-- 		NOT produce an error.  Also see |assert-return|.
-- 		When {error} is given it must match in |v:errmsg|.
-- 		Note that beeping is not considered an error, and some failing
-- 		commands only beep.  Use |assert_beeps()| for those.
--- @return number
function vim.fn.assert_fails(cmd, error) end

-- When {actual} is not false an error message is added to
-- 		|v:errors|, like with |assert_equal()|.
-- 		Also see |assert-return|.
-- 		A value is false when it is zero or |v:false|. When "{actual}"
-- 		is not a number or |v:false| the assert fails.
-- 		When {msg} is omitted an error in the form
-- 		"Expected False but got {actual}" is produced.
--- @return number
function vim.fn.assert_false(actual, msg) end

-- This asserts number and |Float| values.  When {actual}  is lower
-- 		than {lower} or higher than {upper} an error message is added
-- 		to |v:errors|.  Also see |assert-return|.
-- 		When {msg} is omitted an error in the form
-- 		"Expected range {lower} - {upper}, but got {actual}" is
-- 		produced.
--- @return number
function vim.fn.assert_inrange(lower, upper, actual, msg) end

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

-- Return the principal value of the arc tangent of {expr}, in
-- 		the range [-pi/2, +pi/2] radians, as a |Float|.
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo atan(100)
-- <			1.560797 >
-- 			:echo atan(-4.01)
-- <			-1.326405
--- @return float
function vim.fn.atan(expr) end

-- Return the arc tangent of {expr1} / {expr2}, measured in
-- 		radians, as a |Float| in the range [-pi, pi].
-- 		{expr1} and {expr2} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo atan2(-1, 1)
-- <			-0.785398 >
-- 			:echo atan2(1, -1)
-- <			2.356194
--- @return float
function vim.fn.atan2(expr, expr) end

-- Return the current text in the balloon.  Only for the string,
-- 		not used for the List.
--- @return string
function vim.fn.balloon_gettext() end

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

-- Put up a directory requester.  This only works when
-- 		"has("browse")" returns |TRUE| (only in some GUI versions).
-- 		On systems where a directory browser is not supported a file
-- 		browser is used.  In that case: select a file in the directory
-- 		to be used.
-- 		The input fields are:
-- 		    {title}	title for the requester
-- 		    {initdir}	directory to start browsing in
-- 		When the "Cancel" button is hit, something went wrong, or
-- 		browsing is not possible, an empty string is returned.
--- @return string
function vim.fn.browsedir(title, initdir) end

-- Add a buffer to the buffer list with {name}.
-- 		If a buffer for file {name} already exists, return that buffer
-- 		number.  Otherwise return the buffer number of the newly
-- 		created buffer.  When {name} is an empty string then a new
-- 		buffer is always created.
-- 		The buffer will not have' 'buflisted' set.
--- @return number
function vim.fn.bufadd(name) end

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

-- The result is a Number, which is |TRUE| if a buffer called
-- 		{expr} exists and is listed (has the 'buflisted' option set).
-- 		The {expr} argument is used like with |bufexists()|.
--- @return number
function vim.fn.buflisted(expr) end

-- Ensure the buffer {expr} is loaded.  When the buffer name
-- 		refers to an existing file then the file is read.  Otherwise
-- 		the buffer will be empty.  If the buffer was already loaded
-- 		then there is no change.
-- 		If there is an existing swap file for the file of the buffer,
-- 		there will be no dialog, the buffer will be loaded anyway.
-- 		The {expr} argument is used like with |bufexists()|.
--- @return number
function vim.fn.bufload(expr) end

-- The result is a Number, which is |TRUE| if a buffer called
-- 		{expr} exists and is loaded (shown in a window or hidden).
-- 		The {expr} argument is used like with |bufexists()|.
--- @return number
function vim.fn.bufloaded(expr) end

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

-- The result is the number of a buffer, as it is displayed by
-- 		the ":ls" command.  For the use of {expr}, see |bufname()|
-- 		above.
-- 		If the buffer doesn't exist, -1 is returned.  Or, if the
-- 		{create} argument is present and not zero, a new, unlisted,
-- 		buffer is created and its number is returned.
-- 		bufnr("$") is the last buffer: >
-- 			:let last_buffer = bufnr("$")
-- <		The result is a Number, which is the highest buffer number
-- 		of existing buffers.  Note that not all buffers with a smaller
-- 		number necessarily exist, because ":bwipeout" may have removed
-- 		them.  Use bufexists() to test for the existence of a buffer.
--- @return number
function vim.fn.bufnr(expr, create) end

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

-- Return the line number that contains the character at byte
-- 		count {byte} in the current buffer.  This includes the
-- 		end-of-line character, depending on the 'fileformat' option
-- 		for the current buffer.  The first character has byte count
-- 		one.
-- 		Also see |line2byte()|, |go| and |:goto|.
--- @return number
function vim.fn.byte2line(byte) end

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

-- Like byteidx(), except that a composing character is counted
-- 		as a separate character.  Example: >
-- 			let s = 'e' . nr2char(0x301)
-- 			echo byteidx(s, 1)
-- 			echo byteidxcomp(s, 1)
-- 			echo byteidxcomp(s, 2)
-- <		The first and third echo result in 3 ('e' plus composing
-- 		character is 3 bytes), the second echo results in 1 ('e' is
-- 		one byte).
--- @return number
function vim.fn.byteidxcomp(expr, nr) end

-- Call function {func} with the items in |List| {arglist} as
-- 		arguments.
-- 		{func} can either be a |Funcref| or the name of a function.
-- 		a:firstline and a:lastline are set to the cursor line.
-- 		Returns the return value of the called function.
-- 		{dict} is for functions with the "dict" attribute.  It will be
-- 		used to set the local variable "self". |Dictionary-function|
--- @param dict dictionary
function vim.fn.call(func, arglist, dict) end

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

-- Close {handle}.  See |channel-close|.
-- 		{handle} can be a Channel or a Job that has a Channel.
-- 		A close callback is not invoked.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_close()
--- @return none
function vim.fn.ch_close(handle) end

-- Close the "in" part of {handle}.  See |channel-close-in|.
-- 		{handle} can be a Channel or a Job that has a Channel.
-- 		A close callback is not invoked.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_close_in()
--- @return none
function vim.fn.ch_close_in(handle) end

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

-- Like ch_read() but reads binary data and returns a |Blob|.
-- 		See |channel-more|.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_readblob()
--- @return blob
function vim.fn.ch_readblob(handle, options) end

-- Like ch_read() but for a JS and JSON channel does not decode
-- 		the message.  For a NL channel it does not block waiting for
-- 		the NL to arrive, but otherwise works like ch_read().
-- 		See |channel-more|.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_readraw()
--- @return string
function vim.fn.ch_readraw(handle, options) end

-- Send {expr} over {handle}.  The {expr} is encoded
-- 		according to the type of channel.  The function cannot be used
-- 		with a raw channel.
-- 		See |channel-use|.				*E912*
-- 		{handle} can be a Channel or a Job that has a Channel.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_sendexpr(expr)
function vim.fn.ch_sendexpr(handle, expr, options) end

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

-- Return the status of {handle}:
-- 			"fail"		failed to open the channel
-- 			"open"		channel can be used
-- 			"buffered"	channel can be read, not written to
-- 			"closed"	channel can not be used
-- 		{handle} can be a Channel or a Job that has a Channel.
-- 		"buffered" is used when the channel was closed but there is
-- 		still data that can be obtained with |ch_read()|.
--
-- 		If {options} is given it can contain a "part" entry to specify
-- 		the part of the channel to return the status for: "out" or
-- 		"err".  For example, to get the error status: >
-- 			ch_status(job, {"part": "err"})
-- <
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_status()
--- @return string
function vim.fn.ch_status(handle, options) end

-- Close a channel or a specific stream associated with it.
-- 		For a job, {stream} can be one of "stdin", "stdout",
-- 		"stderr" or "rpc" (closes stdin/stdout for a job started
-- 		with `"rpc":v:true`) If {stream} is omitted, all streams
-- 		are closed. If the channel is a pty, this will then close the
-- 		pty master, sending SIGHUP to the job process.
-- 		For a socket, there is only one stream, and {stream} should be
-- 		ommited.
--- @return number
function vim.fn.chanclose(id, stream) end

-- Return the number of the most recent change.  This is the same
-- 		number as what is displayed with |:undolist| and can be used
-- 		with the |:undo| command.
-- 		When a change was made it is the number of that change.  After
-- 		redo it is the number of the redone change.  After undo it is
-- 		one less than the number of the undone change.
--- @return number
function vim.fn.changenr() end

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

-- Return number value of the first char in {expr}.  Examples: >
-- 			char2nr(" ")		returns 32
-- 			char2nr("ABC")		returns 65
-- 			char2nr("á")		returns 225
-- 			char2nr("á"[0])		returns 195
-- 			char2nr("\<M-x>")	returns 128
-- <		Non-ASCII characters are always treated as UTF-8 characters.
-- 		{utf8} is ignored, it exists only for backwards-compatibility.
-- 		A combining character is a separate character.
-- 		|nr2char()| does the opposite.
--- @return number
function vim.fn.char2nr(expr, utf8) end

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

-- Get the amount of indent for line {lnum} according the C
-- 		indenting rules, as with 'cindent'.
-- 		The indent is counted in spaces, the value of 'tabstop' is
-- 		relevant.  {lnum} is used just like in |getline()|.
-- 		When {lnum} is invalid -1 is returned.
-- 		See |C-indenting|.
--- @return number
function vim.fn.cindent(lnum) end

-- Clears all matches previously defined for the current window
-- 		by |matchadd()| and the |:match| commands.
--- @return none
function vim.fn.clearmatches() end

-- position given with {expr}.  The accepted positions are:
-- 		    .	    the cursor position
-- 		    $	    the end of the cursor line (the result is the
-- 			    number of bytes in the cursor line plus one)
-- 		    'x	    position of mark x (if the mark is not set, 0 is
-- 			    returned)
-- 		    v       In Visual mode: the start of the Visual area (the
-- 			    cursor is the end).  When not in Visual mode
-- 			    returns the cursor position.  Differs from |'<| in
-- 			    that it's updated right away.
-- 		Additionally {expr} can be [lnum, col]: a |List| with the line
-- 		and column number. Most useful when the column is "$", to get
-- 		the last column of a specific line.  When "lnum" or "col" is
-- 		out of range then col() returns zero.
-- 		To get the line number use |line()|.  To get both use
-- 		|getpos()|.
-- 		For the screen column position use |virtcol()|.
-- 		Note that only marks in the current file can be used.
-- 		Examples: >
-- 			col(".")		column of cursor
-- 			col("$")		length of cursor line plus one
-- 			col("'t")		column of mark t
-- 			col("'" . markname)	column of mark markname
-- <		The first column is 1.  0 is returned for an error.
-- 		For an uppercase mark the column may actually be in another
-- 		buffer.
-- 		For the cursor position, when 'virtualedit' is active, the
-- 		column is one higher if the cursor is after the end of the
-- 		line.  This can be used to obtain the column in Insert mode: >
-- 			:imap <F2> <C-O>:let save_ve = &ve<CR>
-- 				\<C-O>:set ve=all<CR>
-- 				\<C-O>:echo col(".") . "\n" <Bar>
-- 				\let &ve = save_ve<CR>
-- <
--- @return number
function vim.fn.col(expr) end

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

-- Add {expr} to the list of matches.  Only to be used by the
-- 		function specified with the 'completefunc' option.
-- 		Returns 0 for failure (empty string or out of memory),
-- 		1 when the match was added, 2 when the match was already in
-- 		the list.
-- 		See |complete-functions| for an explanation of {expr}.  It is
-- 		the same as one item in the list that 'omnifunc' would return.
--- @return number
function vim.fn.complete_add(expr) end

-- Check for a key typed while looking for completion matches.
-- 		This is to be used when looking for matches takes some time.
-- 		Returns |TRUE| when searching for matches is to be aborted,
-- 		zero otherwise.
-- 		Only to be used by the function specified with the
-- 		'completefunc' option.
--- @return number
function vim.fn.complete_check() end

-- Returns a Dictionary with information about Insert mode
-- 		completion.  See |ins-completion|.
-- 		The items are:
-- 		   mode		Current completion mode name string.
-- 				See |complete_info_mode| for the values.
-- 		   pum_visible	|TRUE| if popup menu is visible.
-- 				See |pumvisible()|.
-- 		   items	List of completion matches.  Each item is a
-- 				dictionary containing the entries "word",
-- 				"abbr", "menu", "kind", "info" and "user_data".
-- 				See |complete-items|.
-- 		   selected	Selected item index.  First index is zero.
-- 				Index is -1 if no item is selected (showing
-- 				typed text only)
-- 		   inserted	Inserted string. [NOT IMPLEMENT YET]
--
-- 							*complete_info_mode*
-- 		mode values are:
-- 		   ""		     Not in completion mode
-- 		   "keyword"	     Keyword completion |i_CTRL-X_CTRL-N|
-- 		   "ctrl_x"	     Just pressed CTRL-X |i_CTRL-X|
-- 		   "whole_line"	     Whole lines |i_CTRL-X_CTRL-L|
-- 		   "files"	     File names |i_CTRL-X_CTRL-F|
-- 		   "tags"	     Tags |i_CTRL-X_CTRL-]|
-- 		   "path_defines"    Definition completion |i_CTRL-X_CTRL-D|
-- 		   "path_patterns"   Include completion |i_CTRL-X_CTRL-I|
-- 		   "dictionary"	     Dictionary |i_CTRL-X_CTRL-K|
-- 		   "thesaurus"	     Thesaurus |i_CTRL-X_CTRL-T|
-- 		   "cmdline"	     Vim Command line |i_CTRL-X_CTRL-V|
-- 		   "function"	     User defined completion |i_CTRL-X_CTRL-U|
-- 		   "omni"	     Omni completion |i_CTRL-X_CTRL-O|
-- 		   "spell"	     Spelling suggestions |i_CTRL-X_s|
-- 		   "eval"            |complete()| completion
-- 		   "unknown"	     Other internal modes
--
-- 		If the optional {what} list argument is supplied, then only
-- 		the items listed in {what} are returned.  Unsupported items in
-- 		{what} are silently ignored.
--
-- 		To get the position and size of the popup menu, see
-- 		|pum_getpos()|. It's also available in |v:event| during the
-- 		|CompleteChanged| event.
--
-- 		Examples: >
-- 			" Get all items
-- 			call complete_info()
-- 			" Get only 'mode'
-- 			call complete_info(['mode'])
-- 			" Get only 'mode' and 'pum_visible'
-- 			call complete_info(['mode', 'pum_visible'])
-- <
--- @return dict
function vim.fn.complete_info(what) end

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

-- different from using {expr} directly.
-- 		When {expr} is a |List| a shallow copy is created.  This means
-- 		that the original |List| can be changed without changing the
-- 		copy, and vice versa.  But the items are identical, thus
-- 		changing an item changes the contents of both |Lists|.
-- 		A |Dictionary| is copied in a similar way as a |List|.
-- 		Also see |deepcopy()|.
function vim.fn.copy(expr) end

-- Return the cosine of {expr}, measured in radians, as a |Float|.
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo cos(100)
-- <			0.862319 >
-- 			:echo cos(-4.01)
-- <			-0.646043
--- @return float
function vim.fn.cos(expr) end

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

-- Returns a |Dictionary| representing the |context| at {index}
-- 		from the top of the |context-stack| (see |context-dict|).
-- 		If {index} is not given, it is assumed to be 0 (i.e.: top).
--- @return dict
function vim.fn.ctxget(index) end

-- Pops and restores the |context| at the top of the
-- 		|context-stack|.
--- @return none
function vim.fn.ctxpop() end

-- Pushes the current editor state (|context|) on the
-- 		|context-stack|.
-- 		If {types} is given and is a |List| of |String|s, it specifies
-- 		which |context-types| to include in the pushed context.
-- 		Otherwise, all context types are included.
--- @return none
function vim.fn.ctxpush(types) end

-- Sets the |context| at {index} from the top of the
-- 		|context-stack| to that represented by {context}.
-- 		{context} is a Dictionary with context data (|context-dict|).
-- 		If {index} is not given, it is assumed to be 0 (i.e.: top).
--- @return none
function vim.fn.ctxset(context, index) end

-- Returns the size of the |context-stack|.
--- @return number
function vim.fn.ctxsize() end

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

-- Specifically used to interrupt a program being debugged.  It
-- 		will cause process {pid} to get a SIGTRAP.  Behavior for other
-- 		processes is undefined. See |terminal-debugger|.
-- 		{Sends a SIGINT to a process {pid} other than MS-Windows}
--- @return number
function vim.fn.debugbreak(pid) end

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

-- Adds a watcher to a dictionary. A dictionary watcher is
-- 		identified by three components:
--
-- 		- A dictionary({dict});
-- 		- A key pattern({pattern}).
-- 		- A function({callback}).
--
-- 		After this is called, every change on {dict} and on keys
-- 		matching {pattern} will result in {callback} being invoked.
--
-- 		For example, to watch all global variables: >
-- 			silent! call dictwatcherdel(g:, '*', 'OnDictChanged')
-- 			function! OnDictChanged(d,k,z)
-- 			  echomsg string(a:k) string(a:z)
-- 			endfunction
-- 			call dictwatcheradd(g:, '*', 'OnDictChanged')
-- <
-- 		For now {pattern} only accepts very simple patterns that can
-- 		contain a '*' at the end of the string, in which case it will
-- 		match every key that begins with the substring before the '*'.
-- 		That means if '*' is not the last character of {pattern}, only
-- 		keys that are exactly equal as {pattern} will be matched.
--
-- 		The {callback} receives three arguments:
--
-- 		- The dictionary being watched.
-- 		- The key which changed.
-- 		- A dictionary containing the new and old values for the key.
--
-- 		The type of change can be determined by examining the keys
-- 		present on the third argument:
--
-- 		- If contains both `old` and `new`, the key was updated.
-- 		- If it contains only `new`, the key was added.
-- 		- If it contains only `old`, the key was deleted.
--
-- 		This function can be used by plugins to implement options with
-- 		validation and parsing logic.
--- @param dict dictionary
--- @return start
function vim.fn.dictwatcheradd(dict, pattern, callback) end

-- Removes a watcher added  with |dictwatcheradd()|. All three
-- 		arguments must match the ones passed to |dictwatcheradd()| in
-- 		order for the watcher to be successfully deleted.
--- @param dict dictionary
--- @return stop
function vim.fn.dictwatcherdel(dict, pattern, callback) end

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

-- Returns the number of filler lines above line {lnum}.
-- 		These are the lines that were inserted at this point in
-- 		another diff'ed window.  These filler lines are shown in the
-- 		display but don't exist in the buffer.
-- 		{lnum} is used like with |getline()|.  Thus "." is the current
-- 		line, "'m" mark m, etc.
-- 		Returns 0 if the current window is not in diff mode.
--- @return number
function vim.fn.diff_filler(lnum) end

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

-- Return the Number 1 if {expr} is empty, zero otherwise.
-- 		A |List| or |Dictionary| is empty when it does not have any
-- 		items.  A Number is empty when its value is zero.  Special
-- 		variable is empty when it is |v:false| or |v:null|.
--- @return number
function vim.fn.empty(expr) end

-- Return all of environment variables as dictionary. You can
-- 		check if an environment variable exists like this: >
-- 			:echo has_key(environ(), 'HOME')
-- <		Note that the variable name may be CamelCase; to ignore case
-- 		use this: >
-- 			:echo index(keys(environ()), 'HOME', 0, 1) != -1
--- @return dict
function vim.fn.environ() end

-- Escape the characters in {chars} that occur in {string} with a
-- 		backslash.  Example: >
-- 			:echo escape('c:\program files\vim', ' \')
-- <		results in: >
-- 			c:\\program\ files\\vim
-- <		Also see |shellescape()| and |fnameescape()|.
--- @return string
function vim.fn.escape(string, chars) end

-- turn the result of |string()| back into the original value.
-- 		This works for Numbers, Floats, Strings and composites of
-- 		them.  Also works for |Funcref|s that refer to existing
-- 		functions.
function vim.fn.eval(string) end

-- Returns 1 when inside an event handler.  That is that Vim got
-- 		interrupted while waiting for the user to type a character,
-- 		e.g., when dropping a file on Vim.  This means interactive
-- 		commands cannot be used.  Otherwise zero is returned.
--- @return number
function vim.fn.eventhandler() end

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

-- Execute {command} and capture its output.
-- 		If {command} is a |String|, returns {command} output.
-- 		If {command} is a |List|, returns concatenated outputs.
-- 		Examples: >
-- 			echo execute('echon "foo"')
-- <			foo >
-- 			echo execute(['echon "foo"', 'echon "bar"'])
-- <			foobar
--
-- 		The optional {silent} argument can have these values:
-- 			""		no `:silent` used
-- 			"silent"	`:silent` used
-- 			"silent!"	`:silent!` used
-- 		The default is "silent".  Note that with "silent!", unlike
-- 		`:redir`, error messages are dropped.
--
-- 		To get a list of lines use |split()| on the result: >
-- 			split(execute('args'), "\n")
--
-- <		This function is not available in the |sandbox|.
-- 		Note: If nested, an outer execute() will not observe output of
-- 		the inner calls.
-- 		Note: Text attributes (highlights) are not captured.
--- @return string
function vim.fn.execute(command) end

-- Returns the full path of {expr} if it is an executable and
-- 		given as a (partial or full) path or is found in $PATH.
-- 		Returns empty string otherwise.
-- 		If {expr} starts with "./" the |current-directory| is used.
--- @return string
function vim.fn.exepath(expr) end

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

-- Expand wildcards and the following special keywords in {expr}.
-- 		'wildignorecase' applies.
--
-- 		If {list} is given and it is |TRUE|, a List will be returned.
-- 		Otherwise the result is a String and when there are several
-- 		matches, they are separated by <NL> characters.
--
-- 		If the expansion fails, the result is an empty string.  A name
-- 		for a non-existing file is not included, unless {expr} does
-- 		not start with '%', '#' or '<', see below.
--
-- 		When {expr} starts with '%', '#' or '<', the expansion is done
-- 		like for the |cmdline-special| variables with their associated
-- 		modifiers.  Here is a short overview:
--
-- 			%		current file name
-- 			#		alternate file name
-- 			#n		alternate file name n
-- 			<cfile>		file name under the cursor
-- 			<afile>		autocmd file name
-- 			<abuf>		autocmd buffer number (as a String!)
-- 			<amatch>	autocmd matched name
-- 			<sfile>		sourced script file or function name
-- 			<slnum>		sourced script line number or function
-- 					line number
-- 			<sflnum>	script file line number, also when in
-- 					a function
-- 			<cword>		word under the cursor
-- 			<cWORD>		WORD under the cursor
-- 			<client>	the {clientid} of the last received
-- 					message |server2client()|
-- 		Modifiers:
-- 			:p		expand to full path
-- 			:h		head (last path component removed)
-- 			:t		tail (last path component only)
-- 			:r		root (one extension removed)
-- 			:e		extension only
--
-- 		Example: >
-- 			:let &tags = expand("%:p:h") . "/tags"
-- <		Note that when expanding a string that starts with '%', '#' or
-- 		'<', any following text is ignored.  This does NOT work: >
-- 			:let doesntwork = expand("%:h.bak")
-- <		Use this: >
-- 			:let doeswork = expand("%:h") . ".bak"
-- <		Also note that expanding "<cfile>" and others only returns the
-- 		referenced file name without further expansion.  If "<cfile>"
-- 		is "~/.cshrc", you need to do another expand() to have the
-- 		"~/" expanded into the path of the home directory: >
-- 			:echo expand(expand("<cfile>"))
-- <
-- 		There cannot be white space between the variables and the
-- 		following modifier.  The |fnamemodify()| function can be used
-- 		to modify normal file names.
--
-- 		When using '%' or '#', and the current or alternate file name
-- 		is not defined, an empty string is used.  Using "%:p" in a
-- 		buffer with no name, results in the current directory, with a
-- 		'/' added.
--
-- 		When {expr} does not start with '%', '#' or '<', it is
-- 		expanded like a file name is expanded on the command line.
-- 		'suffixes' and 'wildignore' are used, unless the optional
-- 		{nosuf} argument is given and it is |TRUE|.
-- 		Names for non-existing files are included.  The "**" item can
-- 		be used to search in a directory tree.  For example, to find
-- 		all "README" files in the current directory and below: >
-- 			:echo expand("**/README")
-- <
-- 		expand() can also be used to expand variables and environment
-- 		variables that are only known in a shell.  But this can be
-- 		slow, because a shell may be used to do the expansion.  See
-- 		|expr-env-expand|.
-- 		The expanded variable is still handled like a list of file
-- 		names.  When an environment variable cannot be expanded, it is
-- 		left unchanged.  Thus ":echo expand('$FOOBAR')" results in
-- 		"$FOOBAR".
--
-- 		See |glob()| for finding existing files.  See |system()| for
-- 		getting the raw output of an external command.
--- @param list any[]
function vim.fn.expand(expr, nosuf, list) end

-- Expand special items in {expr} like what is done for an Ex
-- 		command such as `:edit`.  This expands special keywords, like
-- 		with |expand()|, and environment variables, anywhere in
-- 		{expr}.  Returns the expanded string.
-- 		Example: >
-- 			:echo expandcmd('make %<.o')
--- @return string
function vim.fn.expandcmd(expr) end

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

-- The result is a Number, which is |TRUE| when a file with the
-- 		name {file} exists, and can be read.  If {file} doesn't exist,
-- 		or is a directory, the result is |FALSE|.  {file} is any
-- 		expression, which is used as a String.
-- 		If you don't care about the file being readable you can use
-- 		|glob()|.
--- @return number
function vim.fn.filereadable(file) end

-- The result is a Number, which is 1 when a file with the
-- 		name {file} exists, and can be written.  If {file} doesn't
-- 		exist, or is not writable, the result is 0.  If {file} is a
-- 		directory, and we can write to it, the result is 2.
--- @return number
function vim.fn.filewritable(file) end

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

-- Find directory {name} in {path}.  Supports both downwards and
-- 		upwards recursive directory searches.  See |file-searching|
-- 		for the syntax of {path}.
-- 		Returns the path of the first found match.  When the found
-- 		directory is below the current directory a relative path is
-- 		returned.  Otherwise a full path is returned.
-- 		If {path} is omitted or empty then 'path' is used.
-- 		If the optional {count} is given, find {count}'s occurrence of
-- 		{name} in {path} instead of the first one.
-- 		When {count} is negative return all the matches in a |List|.
-- 		This is quite similar to the ex-command |:find|.
--- @return string
function vim.fn.finddir(name, path, count) end

-- Just like |finddir()|, but find a file instead of a directory.
-- 		Uses 'suffixesadd'.
-- 		Example: >
-- 			:echo findfile("tags.vim", ".;")
-- <		Searches from the directory of the current file upwards until
-- 		it finds the file "tags.vim".
--- @return string
function vim.fn.findfile(name, path, count) end

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

-- Return the remainder of {expr1} / {expr2}, even if the
-- 		division is not representable.  Returns {expr1} - i * {expr2}
-- 		for some integer i such that if {expr2} is non-zero, the
-- 		result has the same sign as {expr1} and magnitude less than
-- 		the magnitude of {expr2}.  If {expr2} is zero, the value
-- 		returned is zero.  The value returned is a |Float|.
-- 		{expr1} and {expr2} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo fmod(12.33, 1.22)
-- <			0.13 >
-- 			:echo fmod(-12.33, 1.22)
-- <			-0.13
--- @return float
function vim.fn.fmod(expr1, expr2) end

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

-- Modify file name {fname} according to {mods}.  {mods} is a
-- 		string of characters like it is used for file names on the
-- 		command line.  See |filename-modifiers|.
-- 		Example: >
-- 			:echo fnamemodify("main.c", ":p:h")
-- <		results in: >
-- 			/home/mool/vim/vim/src
-- <		Note: Environment variables don't work in {fname}, use
-- 		|expand()| first then.
--- @return string
function vim.fn.fnamemodify(fname, mods) end

-- The result is a Number.  If the line {lnum} is in a closed
-- 		fold, the result is the number of the first line in that fold.
-- 		If the line {lnum} is not in a closed fold, -1 is returned.
--- @return number
function vim.fn.foldclosed(lnum) end

-- The result is a Number.  If the line {lnum} is in a closed
-- 		fold, the result is the number of the last line in that fold.
-- 		If the line {lnum} is not in a closed fold, -1 is returned.
--- @return number
function vim.fn.foldclosedend(lnum) end

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

-- the default function used for the 'foldtext' option and should
-- 		only be called from evaluating 'foldtext'.  It uses the
-- 		|v:foldstart|, |v:foldend| and |v:folddashes| variables.
-- 		The returned string looks like this: >
-- 			+-- 45 lines: abcdef
-- <		The number of leading dashes depends on the foldlevel.  The
-- 		"45" is the number of lines in the fold.  "abcdef" is the text
-- 		in the first non-blank line of the fold.  Leading white space,
-- 		"//" or "/*" and the text from the 'foldmarker' and
-- 		'commentstring' options is removed.
-- 		When used to draw the actual foldtext, the rest of the line
-- 		will be filled with the fold char from the 'fillchars'
-- 		setting.
--- @return string
function vim.fn.foldtext() end

-- Returns the text that is displayed for the closed fold at line
-- 		{lnum}.  Evaluates 'foldtext' in the appropriate context.
-- 		When there is no closed fold at {lnum} an empty string is
-- 		returned.
-- 		{lnum} is used like with |getline()|.  Thus "." is the current
-- 		line, "'m" mark m, etc.
-- 		Useful when exporting folded text, e.g., to HTML.
--- @return string
function vim.fn.foldtextresult(lnum) end

-- a client to a Vim server. |remote_send()|
-- 		On Win32 systems this might not work, the OS does not always
-- 		allow a window to bring itself to the foreground.  Use
-- 		|remote_foreground()| instead.
-- 		{only in the Win32 GUI and console version}
--- @return number
function vim.fn.foreground() end

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

-- Return the current |command-line-window| type. Possible return
-- 		values are the same as |getcmdtype()|. Returns an empty string
-- 		when not in the command-line window.
--- @return string
function vim.fn.getcmdwintype() end

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

-- Return the value of environment variable {name}.
-- 		When the variable does not exist |v:null| is returned.  That
-- 		is different from a variable set to an empty string.
-- 		See also |expr-env|.
--- @return string
function vim.fn.getenv(name) end

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

-- The result is a Number, which is the size in bytes of the
-- 		given file {fname}.
-- 		If {fname} is a directory, 0 is returned.
-- 		If the file {fname} can't be found, -1 is returned.
-- 		If the size of {fname} is too big to fit in a Number then -2
-- 		is returned.
--- @return number
function vim.fn.getfsize(fname) end

-- The result is a Number, which is the last modification time of
-- 		the given file {fname}.  The value is measured as seconds
-- 		since 1st Jan 1970, and may be passed to strftime().  See also
-- 		|localtime()| and |strftime()|.
-- 		If the file {fname} can't be found -1 is returned.
--- @return number
function vim.fn.getftime(fname) end

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

-- The result is a Number, which is |TRUE| when the IME status is
-- 		active.
-- 		See 'imstatusfunc'.
--- @return number
function vim.fn.getimstatus() end

-- Returns the |jumplist| for the specified window.
--
-- 		Without arguments use the current window.
-- 		With {winnr} only use this window in the current tab page.
-- 		{winnr} can also be a |window-ID|.
-- 		With {winnr} and {tabnr} use the window in the specified tab
-- 		page.
--
-- 		The returned list contains two entries: a list with the jump
-- 		locations and the last used jump position number in the list.
-- 		Each entry in the jump location list is a dictionary with
-- 		the following entries:
-- 			bufnr		buffer number
-- 			col		column number
-- 			coladd		column offset for 'virtualedit'
-- 			filename	filename if available
-- 			lnum		line number
--- @return list
function vim.fn.getjumplist(winnr, tabnr) end

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

-- This is a unique number, until Vim exits.
--- @return number
function vim.fn.getpid() end

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

-- Get the value of a tab-local variable {varname} in tab page
-- 		{tabnr}. |t:var|
-- 		Tabs are numbered starting with one.
-- 		When {varname} is empty a dictionary with all tab-local
-- 		variables is returned.
-- 		Note that the name without "t:" must be used.
-- 		When the tab or variable doesn't exist {def} or an empty
-- 		string is returned, there is no error message.
function vim.fn.gettabvar(nr, varname, def) end

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

-- The result is a list with two numbers, the result of
-- 		getwinposx() and getwinposy() combined:
-- 			[x-pos, y-pos]
-- 		{timeout} can be used to specify how long to wait in msec for
-- 		a response from the terminal.  When omitted 100 msec is used.
--- @return list
function vim.fn.getwinpos(timeout) end

-- the left hand side of the GUI Vim window.  The result will be
-- 		-1 if the information is not available.
-- 		The value can be used with `:winpos`.
--- @return number
function vim.fn.getwinposx() end

-- the top of the GUI Vim window.  The result will be -1 if the
-- 		information is not available.
-- 		The value can be used with `:winpos`.
--- @return number
function vim.fn.getwinposy() end

-- Like |gettabwinvar()| for the current tabpage.
-- 		Examples: >
-- 			:let list_is_on = getwinvar(2, '&list')
-- 			:echo "myvar = " . getwinvar(1, 'myvar')
function vim.fn.getwinvar(nr, varname, def) end

-- Expand the file wildcards in {expr}.  See |wildcards| for the
-- 		use of special characters.
--
-- 		Unless the optional {nosuf} argument is given and is |TRUE|,
-- 		the 'suffixes' and 'wildignore' options apply: Names matching
-- 		one of the patterns in 'wildignore' will be skipped and
-- 		'suffixes' affect the ordering of matches.
-- 		'wildignorecase' always applies.
--
-- 		When {list} is present and it is |TRUE| the result is a List
-- 		with all matching files. The advantage of using a List is,
-- 		you also get filenames containing newlines correctly.
-- 		Otherwise the result is a String and when there are several
-- 		matches, they are separated by <NL> characters.
--
-- 		If the expansion fails, the result is an empty String or List.
--
-- 		You can also use |readdir()| if you need to do complicated
-- 		things, such as limiting the number of matches.
--
-- 		A name for a non-existing file is not included.  A symbolic
-- 		link is only included if it points to an existing file.
-- 		However, when the {alllinks} argument is present and it is
-- 		|TRUE| then all symbolic links are included.
--
-- 		For most systems backticks can be used to get files names from
-- 		any external command.  Example: >
-- 			:let tagfiles = glob("`find . -name tags -print`")
-- 			:let &tags = substitute(tagfiles, "\n", ",", "g")
-- <		The result of the program inside the backticks should be one
-- 		item per line.  Spaces inside an item are allowed.
--
-- 		See |expand()| for expanding special Vim variables.  See
-- 		|system()| for getting the raw output of an external command.
--- @param list any[]
function vim.fn.glob(expr, nosuf, list, alllinks) end

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

-- The result is a Number, which is 1 if |Dictionary| {dict} has
-- 		an entry with key {key}.  Zero otherwise.
--- @param dict dictionary
--- @return number
function vim.fn.has_key(dict, key) end

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

-- The result is a Number, which is 1 if there is a mapping that
-- 		contains {what} in somewhere in the rhs (what it is mapped to)
-- 		and this mapping exists in one of the modes indicated by
-- 		{mode}.
-- 		When {abbr} is there and it is |TRUE| use abbreviations
-- 		instead of mappings.  Don't forget to specify Insert and/or
-- 		Command-line mode.
-- 		Both the global mappings and the mappings local to the current
-- 		buffer are checked for a match.
-- 		If no matching mapping is found 0 is returned.
-- 		The following characters are recognized in {mode}:
-- 			n	Normal mode
-- 			v	Visual mode
-- 			o	Operator-pending mode
-- 			i	Insert mode
-- 			l	Language-Argument ("r", "f", "t", etc.)
-- 			c	Command-line mode
-- 		When {mode} is omitted, "nvo" is used.
--
-- 		This function is useful to check if a mapping already exists
-- 		to a function in a Vim script.  Example: >
-- 			:if !hasmapto('\ABCdoit')
-- 			:   map <Leader>d \ABCdoit
-- 			:endif
-- <		This installs the mapping to "\ABCdoit" only if there isn't
-- 		already a mapping to "\ABCdoit".
--- @return number
function vim.fn.hasmapto(what, mode, abbr) end

-- Add the String {item} to the history {history} which can be
-- 		one of:					*hist-names*
-- 			"cmd"	 or ":"	  command line history
-- 			"search" or "/"   search pattern history
-- 			"expr"	 or "="   typed expression history
-- 			"input"  or "@"	  input line history
-- 			"debug"  or ">"   debug command history
-- 			empty		  the current or last used history
-- 		The {history} string does not need to be the whole name, one
-- 		character is sufficient.
-- 		If {item} does already exist in the history, it will be
-- 		shifted to become the newest entry.
-- 		The result is a Number: 1 if the operation was successful,
-- 		otherwise 0 is returned.
--
-- 		Example: >
-- 			:call histadd("input", strftime("%Y %b %d"))
-- 			:let date=input("Enter date: ")
-- <		This function is not available in the |sandbox|.
--- @return string
function vim.fn.histadd(history, item) end

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

-- with name {name}.  When the highlight group doesn't exist,
-- 		zero is returned.
-- 		This can be used to retrieve information about the highlight
-- 		group.  For example, to get the background color of the
-- 		"Comment" group: >
-- 	:echo synIDattr(synIDtrans(hlID("Comment")), "bg")
--- @return number
function vim.fn.hlID(name) end

-- The result is a Number, which is non-zero if a highlight group
-- 		called {name} exists.  This is when the group has been
-- 		defined in some way.  Not necessarily when highlighting has
-- 		been defined for it, it may also have been used for a syntax
-- 		item.
--- @return number
function vim.fn.hlexists(name) end

-- The result is a String, which is the name of the machine on
-- 		which Vim is currently running.  Machine names greater than
-- 		256 characters long are truncated.
--- @return string
function vim.fn.hostname() end

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

-- current buffer.  The indent is counted in spaces, the value
-- 		of 'tabstop' is relevant.  {lnum} is used just like in
-- 		|getline()|.
-- 		When {lnum} is invalid -1 is returned.
--- @return number
function vim.fn.indent(lnum) end

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

-- Restore typeahead that was saved with a previous |inputsave()|.
-- 		Should be called the same number of times inputsave() is
-- 		called.  Calling it more often is harmless though.
-- 		Returns 1 when there is nothing to restore, 0 otherwise.
--- @return number
function vim.fn.inputrestore() end

-- Preserve typeahead (also from mappings) and clear it, so that
-- 		a following prompt gets input from the user.  Should be
-- 		followed by a matching inputrestore() after the prompt.  Can
-- 		be used several times, in which case there must be just as
-- 		many inputrestore() calls.
-- 		Returns 1 when out of memory, 0 otherwise.
--- @return number
function vim.fn.inputsave() end

-- This function acts much like the |input()| function with but
-- 		two exceptions:
-- 		a) the user's response will be displayed as a sequence of
-- 		asterisks ("*") thereby keeping the entry secret, and
-- 		b) the user's response will not be recorded on the input
-- 		|history| stack.
-- 		The result is a String, which is whatever the user actually
-- 		typed on the command-line in response to the issued prompt.
-- 		NOTE: Command-line completion is not supported.
--- @return string
function vim.fn.inputsecret(prompt, text) end

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

-- Bitwise invert.  The argument is converted to a number.  A
-- 		List, Dict or Float argument causes an error.  Example: >
-- 			:let bits = invert(bits)
--- @return number
function vim.fn.invert(expr) end

-- The result is a Number, which is |TRUE| when a directory
-- 		with the name {directory} exists.  If {directory} doesn't
-- 		exist, or isn't a directory, the result is |FALSE|.  {directory}
-- 		is any expression, which is used as a String.
--- @return number
function vim.fn.isdirectory(directory) end

-- Return 1 if {expr} is a positive infinity, or -1 a negative
-- 		infinity, otherwise 0. >
-- 			:echo isinf(1.0 / 0.0)
-- <			1 >
-- 			:echo isinf(-1.0 / 0.0)
-- <			-1
--- @return number
function vim.fn.isinf(expr) end

-- The result is a Number, which is |TRUE| when {expr} is the
-- 		name of a locked variable.
-- 		{expr} must be the name of a variable, |List| item or
-- 		|Dictionary| entry, not the variable itself!  Example: >
-- 			:let alist = [0, ['a', 'b'], 2, 3]
-- 			:lockvar 1 alist
-- 			:echo islocked('alist')		" 1
-- 			:echo islocked('alist[1]')	" 0
--
-- <		When {expr} is a variable that does not exist you get an error
-- 		message.  Use |exists()| to check for existence.
--- @return number
function vim.fn.islocked(expr) end

-- Return |TRUE| if {expr} is a float with value NaN. >
-- 			echo isnan(0.0 / 0.0)
-- <			1
--- @return number
function vim.fn.isnan(expr) end

-- Return a |List| with all the key-value pairs of {dict}.  Each
-- 		|List| item is a list with two items: the key of a {dict}
-- 		entry and the value of this entry.  The |List| is in arbitrary
-- 		order.
--- @param dict dictionary
--- @return list
function vim.fn.items(dict) end

-- Get the channel handle that {job} is using.
-- 		To check if the job has no channel: >
-- 			if string(job_getchannel()) == 'channel fail'
-- <
-- 		Can also be used as a |method|: >
-- 			GetJob()->job_getchannel()
--- @return channel
function vim.fn.job_getchannel(job) end

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

-- Change options for {job}.  Supported are:
-- 		   "stoponexit"	|job-stoponexit|
-- 		   "exit_cb"	|job-exit_cb|
--
-- 		Can also be used as a |method|: >
-- 			GetJob()->job_setoptions(options)
--- @return none
function vim.fn.job_setoptions(job, options) end

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

-- Stop the {job}.  This can also be used to signal the job.
--
-- 		When {how} is omitted or is "term" the job will be terminated.
-- 		For Unix SIGTERM is sent.  On MS-Windows the job will be
-- 		terminated forcedly (there is no "gentle" way).
-- 		This goes to the process group, thus children may also be
-- 		affected.
--
-- 		Effect for Unix:
-- 			"term"	 SIGTERM (default)
-- 			"hup"	 SIGHUP
-- 			"quit"	 SIGQUIT
-- 			"int"	 SIGINT
-- 			"kill"	 SIGKILL (strongest way to stop)
-- 			number	 signal with that number
--
-- 		Effect for MS-Windows:
-- 			"term"	 terminate process forcedly (default)
-- 			"hup"	 CTRL_BREAK
-- 			"quit"	 CTRL_BREAK
-- 			"int"	 CTRL_C
-- 			"kill"	 terminate process forcedly
-- 			Others	 CTRL_BREAK
--
-- 		On Unix the signal is sent to the process group.  This means
-- 		that when the job is "sh -c command" it affects both the shell
-- 		and the command.
--
-- 		The result is a Number: 1 if the operation could be executed,
-- 		0 if "how" is not supported on the system.
-- 		Note that even when the operation was executed, whether the
-- 		job was actually stopped needs to be checked with
-- 		|job_status()|.
--
-- 		If the status of the job is "dead", the signal will not be
-- 		sent.  This is to avoid to stop the wrong job (esp. on Unix,
-- 		where process numbers are recycled).
--
-- 		When using "kill" Vim will assume the job will die and close
-- 		the channel.
--
-- 		Can also be used as a |method|: >
-- 			GetJob()->job_stop()
--- @return number
function vim.fn.job_stop(job, how) end

-- Return the PID (process id) of |job-id| {job}.
--- @return number
function vim.fn.jobpid(id) end

-- Resize the pseudo terminal window of |job-id| {job} to {width}
-- 		columns and {height} rows.
-- 		Fails if the job was not started with `"pty":v:true`.
--- @return number
function vim.fn.jobresize(id, width, height) end

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

-- This is similar to |json_decode()| with these differences:
-- 		- Object key names do not have to be in quotes.
-- 		- Strings can be in single quotes.
-- 		- Empty items in an array (between two commas) are allowed and
-- 		  result in v:none items.
--
-- 		Can also be used as a |method|: >
-- 			ReadObject()->js_decode()
function vim.fn.js_decode(string) end

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

-- Return a |List| with all the keys of {dict}.  The |List| is in
-- 		arbitrary order.
--- @param dict dictionary
--- @return list
function vim.fn.keys(dict) end

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

-- Just like |libcall()|, but used for a function that returns an
-- 		int instead of a string.
-- 		Examples: >
-- 			:echo libcallnr("/usr/lib/libc.so", "getpid", "")
-- 			:call libcallnr("libc.so", "printf", "Hello World!\n")
-- 			:call libcallnr("libc.so", "sleep", 10)
-- <
--- @return number
function vim.fn.libcallnr(lib, func, arg) end

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

-- Get the amount of indent for line {lnum} according the lisp
-- 		indenting rules, as with 'lisp'.
-- 		The indent is counted in spaces, the value of 'tabstop' is
-- 		relevant.  {lnum} is used just like in |getline()|.
-- 		When {lnum} is invalid or Vim was not compiled the
-- 		|+lispindent| feature, -1 is returned.
--- @return number
function vim.fn.lispindent(lnum) end

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

-- Remove a listener previously added with listener_add().
-- 		Returns zero when {id} could not be found, one when {id} was
-- 		removed.
--
-- 		Can also be used as a |method|: >
-- 			GetListenerId()->listener_remove()
--- @return none
function vim.fn.listener_remove(id) end

-- Return the current time, measured as seconds since 1st Jan
-- 		1970.  See also |strftime()| and |getftime()|.
--- @return number
function vim.fn.localtime() end

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

-- Return the logarithm of Float {expr} to base 10 as a |Float|.
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo log10(1000)
-- <			3.0 >
-- 			:echo log10(0.01)
-- <			-2.0
--- @return float
function vim.fn.log10(expr) end

-- Evaluate Lua expression {expr} and return its result converted
-- 		to Vim data structures. See |lua-eval| for more details.
function vim.fn.luaeval(expr, expr) end

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

-- Deletes a match with ID {id} previously defined by |matchadd()|
-- 		or one of the |:match| commands.  Returns 0 if successful,
-- 		otherwise -1.  See example for |matchadd()|.  All matches can
-- 		be deleted in one operation by |clearmatches()|.
--- @return number
function vim.fn.matchdelete(id) end

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

-- {expr} can be a list or a dictionary.  For a dictionary,
-- 		it returns the maximum of all values in the dictionary.
-- 		If {expr} is neither a list nor a dictionary, or one of the
-- 		items in {expr} cannot be used as a Number this results in
--                 an error.  An empty |List| or |Dictionary| results in zero.
--- @return number
function vim.fn.max(expr) end

-- {expr} can be a list or a dictionary.  For a dictionary,
-- 		it returns the minimum of all values in the dictionary.
-- 		If {expr} is neither a list nor a dictionary, or one of the
-- 		items in {expr} cannot be used as a Number this results in
-- 		an error.  An empty |List| or |Dictionary| results in zero.
--- @return number
function vim.fn.min(expr) end

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

-- Return the line number of the first line at or below {lnum}
-- 		that is not blank.  Example: >
-- 			if getline(nextnonblank(1)) =~ "Java"
-- <		When {lnum} is invalid or there is no non-blank line at or
-- 		below it, zero is returned.
-- 		See also |prevnonblank()|.
--- @return number
function vim.fn.nextnonblank(lnum) end

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

-- Set attrs in nvim__buf_set_lua_hl callbacks
--
--                 TODO(bfredl): This is rather pedestrian. The final interface
--                 should probably be derived from a reformed bufhl/virttext
--                 interface with full support for multi-line ranges etc
function vim.fn.nvim__put_attr(id, c0, c1) end

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

-- Returns a 2-tuple (Array), where item 0 is the current channel
--                 id and item 1 is the |api-metadata| map (Dictionary).
--
--                 Return: ~
--                     2-tuple [{channel-id}, {api-metadata}]
--
--                 Attributes: ~
--                     {fast}
function vim.fn.nvim_get_api_info() end

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

-- Deactivates UI events on the channel.
--
--                 Removes the client from the list of UIs. |nvim_list_uis()|
function vim.fn.nvim_ui_detach() end

-- Tells Nvim the number of elements displaying in the popumenu,
--                 to decide <PageUp> and <PageDown> movement.
--
--                 Parameters: ~
--                     {height}  Popupmenu height, must be greater than zero.
function vim.fn.nvim_ui_pum_set_height(height) end

-- TODO: Documentation
function vim.fn.nvim_ui_set_option(name, value) end

-- TODO: Documentation
function vim.fn.nvim_ui_try_resize(width, height) end

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

-- Unsubscribes to event broadcasts.
--
--                 Parameters: ~
--                     {event}  Event type string
function vim.fn.nvim_unsubscribe(event) end

-- Shorten directory names in the path {expr} and return the
-- 		result.  The tail, the file name, is kept as-is.  The other
-- 		components in the path are reduced to single letters.  Leading
-- 		'~' and '.' characters are kept.  Example: >
-- 			:echo pathshorten('~/.config/nvim/autoload/file1.vim')
-- <			~/.c/n/a/file1.vim ~
-- 		It doesn't matter if the path exists or not.
--- @return string
function vim.fn.pathshorten(expr) end

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

-- windows for the current tab and global popups.
--- @return none
function vim.fn.popup_clear() end

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

-- Open a popup window showing {what}, which is either:
-- 		- a buffer number
-- 		- a string
-- 		- a list of strings
-- 		- a list of text lines with text properties
-- 		When {what} is not a buffer number, a buffer is created with
-- 		'buftype' set to "popup".  That buffer will be wiped out once
-- 		the popup closes.
--
-- 		{options} is a dictionary with many possible entries.
-- 		See |popup_create-arguments| for details.
--
-- 		Returns a window-ID, which can be used with other popup
-- 		functions.  Use `winbufnr()` to get the number of the buffer
-- 		in the window: >
-- 			let winid = popup_create('hello', {})
-- 			let bufnr = winbufnr(winid)
-- 			call setbufline(bufnr, 2, 'second line')
-- <		In case of failure zero is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetText()->popup_create({})
--- @return number
function vim.fn.popup_create(what, options) end

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

-- Filter that can be used for a popup. These keys can be used:
-- 		    j <Down>		select item below
-- 		    k <Up>		select item above
-- 		    <Space> <Enter>	accept current selection
-- 		    x Esc CTRL-C	cancel the menu
-- 		Other keys are ignored.
--
-- 		A match is set on that line to highlight it, see
-- 		|popup_menu()|.
--
-- 		When the current selection is accepted the "callback" of the
-- 		popup menu is invoked with the index of the selected line as
-- 		the second argument.  The first entry has index one.
-- 		Cancelling the menu invokes the callback with -1.
--
-- 		To add shortcut keys, see the example here:
-- 		|popup_menu-shortcut-example|
--- @return number
function vim.fn.popup_filter_menu(id, key) end

-- Filter that can be used for a popup. It handles only the keys
-- 		'y', 'Y' and 'n' or 'N'.  Invokes the "callback" of the
-- 		popup menu with the 1 for 'y' or 'Y' and zero for 'n' or 'N'
-- 		as the second argument.  Pressing Esc and 'x' works like
-- 		pressing 'n'.  CTRL-C invokes the callback with -1.  Other
-- 		keys are ignored.
-- 		See the example here: |popup_dialog-example|
--- @return number
function vim.fn.popup_filter_yesno(id, key) end

-- Get the |window-ID| for the popup info window, as it used by
-- 		the popup menu.  See |complete-popup|.  The info popup is
-- 		hidden when not used, it can be deleted with |popup_clear()|
-- 		and |popup_close()|.  Use |popup_show()| to reposition it to
-- 		the item in the popup menu.
-- 		Returns zero if there is none.
--- @return number
function vim.fn.popup_findinfo() end

-- Get the |window-ID| for the popup preview window.
-- 		Return zero if there is none.
--- @return number
function vim.fn.popup_findpreview() end

-- Return the {options} for popup {id} in a Dict.
-- 		A zero value means the option was not set.  For "zindex" the
-- 		default value is returned, not zero.
--
-- 		The "moved" entry is a list with line number, minimum and
-- 		maximum column, [0, 0, 0] when not set.
--
-- 		The "mousemoved" entry is a list with screen row, minimum and
-- 		maximum screen column, [0, 0, 0] when not set.
--
-- 		"firstline" is the property set on the popup, unlike the
-- 		"firstline" obtained with |popup_getpos()| which is the actual
-- 		buffer line at the top of the popup window.
--
-- 		"border" and "padding" are not included when all values are
-- 		zero.  When all values are one then an empty list is included.
--
-- 		"borderhighlight" is not included when all values are empty.
-- 		"scrollbarhighlight" and "thumbhighlight" are only included
-- 		when set.
--
-- 		"tabpage" will be -1 for a global popup, zero for a popup on
-- 		the current tabpage and a positive number for a popup on
-- 		another tabpage.
--
-- 		"textprop", "textpropid" and "textpropwin" are only present
-- 		when "textprop" was set.
--
-- 		If popup window {id} is not found an empty Dict is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetPopup()->popup_getoptions()
--- @return dict
function vim.fn.popup_getoptions(id) end

