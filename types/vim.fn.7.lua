--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

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

-- Return the sine of {expr}, measured in radians, as a |Float|.
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo sin(100)
-- <			-0.506366 >
-- 			:echo sin(-4.01)
-- <			0.763301
--- @return float
function vim.fn.sin(expr) end

-- Return the cosine of {expr}, measured in radians, as a |Float|.
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo cos(100)
-- <			0.862319 >
-- 			:echo cos(-4.01)
-- <			-0.646043
--- @return float
function vim.fn.cos(expr) end

-- Return the tangent of {expr}, measured in radians, as a |Float|
-- 		in the range [-inf, inf].
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo tan(10)
-- <			0.648361 >
-- 			:echo tan(-4.01)
-- <			-1.181502
--- @return float
function vim.fn.tan(expr) end

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

-- Return the hyperbolic sine of {expr} as a |Float| in the range
-- 		[-inf, inf].
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo sinh(0.5)
-- <			0.521095 >
-- 			:echo sinh(-0.9)
-- <			-1.026517
--- @return float
function vim.fn.sinh(expr) end

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

-- Return the hyperbolic tangent of {expr} as a |Float| in the
-- 		range [-1, 1].
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo tanh(0.5)
-- <			0.462117 >
-- 			:echo tanh(-1)
-- <			-0.761594
--- @return float
function vim.fn.tanh(expr) end

-- Set a flag to enable the effect of 'autochdir' before Vim
-- 		startup has finished.
--- @return none
function vim.fn.test_autochdir() end

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

-- Move the window {nr} to a new split of the window {target}.
-- 		This is similar to moving to {target}, creating a new window
-- 		using |:split| but having the same contents as window {nr}, and
-- 		then closing {nr}.
--
-- 		Both {nr} and {target} can be window numbers or |window-ID|s.
--
-- 		Returns zero for success, non-zero for failure.
--
-- 		{options} is a Dictionary with the following optional entries:
-- 		  "vertical"	When TRUE, the split is created vertically,
-- 				like with |:vsplit|.
-- 		  "rightbelow"	When TRUE, the split is made below or to the
-- 				right (if vertical).  When FALSE, it is done
-- 				above or to the left (if vertical).  When not
-- 				present, the values of 'splitbelow' and
-- 				'splitright' are used.
--
-- 		Can also be used as a |method|: >
-- 			GetWinid()->win_splitmove(target)
-- <
--- @return number
function vim.fn.win_splitmove(nr, target, options) end

-- Clears all matches previously defined for the current window
-- 		by |matchadd()| and the |:match| commands.
--- @return none
function vim.fn.clearmatches() end

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

-- Add {expr} to the list of matches.  Only to be used by the
-- 		function specified with the 'completefunc' option.
-- 		Returns 0 for failure (empty string or out of memory),
-- 		1 when the match was added, 2 when the match was already in
-- 		the list.
-- 		See |complete-functions| for an explanation of {expr}.  It is
-- 		the same as one item in the list that 'omnifunc' would return.
--- @return number
function vim.fn.complete_add(expr) end

-- {expr} can be a list or a dictionary.  For a dictionary,
-- 		it returns the minimum of all values in the dictionary.
-- 		If {expr} is neither a list nor a dictionary, or one of the
-- 		items in {expr} cannot be used as a Number this results in
-- 		an error.  An empty |List| or |Dictionary| results in zero.
--- @return number
function vim.fn.min(expr) end

-- {expr} can be a list or a dictionary.  For a dictionary,
-- 		it returns the maximum of all values in the dictionary.
-- 		If {expr} is neither a list nor a dictionary, or one of the
-- 		items in {expr} cannot be used as a Number this results in
--                 an error.  An empty |List| or |Dictionary| results in zero.
--- @return number
function vim.fn.max(expr) end

-- This asserts number and |Float| values.  When {actual}  is lower
-- 		than {lower} or higher than {upper} an error message is added
-- 		to |v:errors|.  Also see |assert-return|.
-- 		When {msg} is omitted an error in the form
-- 		"Expected range {lower} - {upper}, but got {actual}" is
-- 		produced.
--- @return number
function vim.fn.assert_inrange(lower, upper, actual, msg) end

-- Return the sound-folded equivalent of {word}.  Uses the first
-- 		language in 'spelllang' for the current window that supports
-- 		soundfolding.  'spell' must be set.  When no sound folding is
-- 		possible the {word} is returned unmodified.
-- 		This can be used for making spelling suggestions.  Note that
-- 		the method can be quite slow.
--- @return string
function vim.fn.soundfold(word) end

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

-- Bitwise XOR on the two arguments.  The arguments are converted
-- 		to a number.  A List, Dict or Float argument causes an error.
-- 		Example: >
-- 			:let bits = xor(bits, 0x80)
-- <
--- @return number
function vim.fn.xor(expr, expr) end

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

-- Return the window number of window with ID {expr}.
-- 		Return 0 if the window cannot be found in the current tabpage.
--- @return number
function vim.fn.win_id2win(expr) end

