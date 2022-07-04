--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

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

-- Get the channel handle that {job} is using.
-- 		To check if the job has no channel: >
-- 			if string(job_getchannel()) == 'channel fail'
-- <
-- 		Can also be used as a |method|: >
-- 			GetJob()->job_getchannel()
--- @return channel
function vim.fn.job_getchannel(job) end

-- Return a list of signs placed in a buffer or all the buffers.
-- 		This is similar to the |:sign-place-list| command.
--
-- 		If the optional buffer name {expr} is specified, then only the
-- 		list of signs placed in that buffer is returned.  For the use
-- 		of {expr}, see |bufname()|. The optional {dict} can contain
-- 		the following entries:
-- 		   group	select only signs in this group
-- 		   id		select sign with this identifier
-- 		   lnum		select signs placed in this line. For the use
-- 				of {lnum}, see |line()|.
-- 		If {group} is '*', then signs in all the groups including the
-- 		global group are returned. If {group} is not supplied or is an
-- 		empty string, then only signs in the global group are
-- 		returned.  If no arguments are supplied, then signs in the
-- 		global group placed in all the buffers are returned.
-- 		See |sign-group|.
--
-- 		Each list item in the returned value is a dictionary with the
-- 		following entries:
-- 			bufnr	number of the buffer with the sign
-- 			signs	list of signs placed in {bufnr}. Each list
-- 				item is a dictionary with the below listed
-- 				entries
--
-- 		The dictionary for each sign contains the following entries:
-- 			group	sign group. Set to '' for the global group.
-- 			id	identifier of the sign
-- 			lnum	line number where the sign is placed
-- 			name	name of the defined sign
-- 			priority	sign priority
--
-- 		The returned signs in a buffer are ordered by their line
-- 		number and priority.
--
-- 		Returns an empty list on failure or if there are no placed
-- 		signs.
--
-- 		Examples: >
-- 			" Get a List of signs placed in eval.c in the
-- 			" global group
-- 			echo sign_getplaced("eval.c")
--
-- 			" Get a List of signs in group 'g1' placed in eval.c
-- 			echo sign_getplaced("eval.c", {'group' : 'g1'})
--
-- 			" Get a List of signs placed at line 10 in eval.c
-- 			echo sign_getplaced("eval.c", {'lnum' : 10})
--
-- 			" Get sign with identifier 10 placed in a.py
-- 			echo sign_getplaced("a.py", {'id' : 10})
--
-- 			" Get sign with id 20 in group 'g1' placed in a.py
-- 			echo sign_getplaced("a.py", {'group' : 'g1',
-- 							\  'id' : 20})
--
-- 			" Get a List of all the placed signs
-- 			echo sign_getplaced()
-- <
--- @param dict dictionary
--- @return list
function vim.fn.sign_getplaced(expr, dict) end

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

-- the left hand side of the GUI Vim window.  The result will be
-- 		-1 if the information is not available.
-- 		The value can be used with `:winpos`.
--- @return number
function vim.fn.getwinposx() end

-- Return a |String| that is null. Only useful for testing.
--- @return string
function vim.fn.test_null_string() end

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

-- Shorten directory names in the path {expr} and return the
-- 		result.  The tail, the file name, is kept as-is.  The other
-- 		components in the path are reduced to single letters.  Leading
-- 		'~' and '.' characters are kept.  Example: >
-- 			:echo pathshorten('~/.config/nvim/autoload/file1.vim')
-- <			~/.c/n/a/file1.vim ~
-- 		It doesn't matter if the path exists or not.
--- @return string
function vim.fn.pathshorten(expr) end

-- Attach a text property at position {lnum}, {col}.  {col} is
-- 		counted in bytes, use one for the first column.
-- 		If {lnum} is invalid an error is given. *E966*
-- 		If {col} is invalid an error is given. *E964*
--
-- 		{props} is a dictionary with these fields:
-- 		   length	length of text in bytes, can only be used
-- 				for a property that does not continue in
-- 				another line; can be zero
-- 		   end_lnum	line number for the end of text
-- 		   end_col	column just after the text; not used when
-- 				"length" is present; when {col} and "end_col"
-- 				are equal, and "end_lnum" is omitted or equal
-- 				to {lnum}, this is a zero-width text property
-- 		   bufnr	buffer to add the property to; when omitted
-- 				the current buffer is used
-- 		   id		user defined ID for the property; when omitted
-- 				zero is used
-- 		   type		name of the text property type
-- 		All fields except "type" are optional.
--
-- 		It is an error when both "length" and "end_lnum" or "end_col"
-- 		are given.  Either use "length" or "end_col" for a property
-- 		within one line, or use "end_lnum" and "end_col" for a
-- 		property that spans more than one line.
-- 		When neither "length" nor "end_col" are given the property
-- 		will be zero-width.  That means it will not be highlighted but
-- 		will move with the text, as a kind of mark.
-- 		The property can end exactly at the last character of the
-- 		text, or just after it.  In the last case, if text is appended
-- 		to the line, the text property size will increase, also when
-- 		the property type does not have "end_incl" set.
--
-- 		"type" will first be looked up in the buffer the property is
-- 		added to. When not found, the global property types are used.
-- 		If not found an error is given.
--
-- 		See |text-properties| for information about text properties.
--
-- 		Can also be used as a |method|: >
-- 			GetLnum()->prop_add(col, props)
--- @return none
function vim.fn.prop_add(lnum, col, props) end

-- Expand special items in {expr} like what is done for an Ex
-- 		command such as `:edit`.  This expands special keywords, like
-- 		with |expand()|, and environment variables, anywhere in
-- 		{expr}.  Returns the expanded string.
-- 		Example: >
-- 			:echo expandcmd('make %<.o')
--- @return string
function vim.fn.expandcmd(expr) end

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

-- On MS-Windows, when {filename} is a shortcut (a .lnk file),
-- 		returns the path the shortcut points to in a simplified form.
-- 		On Unix, repeat resolving symbolic links in all path
-- 		components of {filename} and return the simplified result.
-- 		To cope with link cycles, resolving of symbolic links is
-- 		stopped after 100 iterations.
-- 		On other systems, return the simplified {filename}.
-- 		The simplification step is done as by |simplify()|.
-- 		resolve() keeps a leading path component specifying the
-- 		current directory (provided the result is still a relative
-- 		path name) and also keeps a trailing path separator.
--- @return string
function vim.fn.resolve(filename) end

-- Preserve typeahead (also from mappings) and clear it, so that
-- 		a following prompt gets input from the user.  Should be
-- 		followed by a matching inputrestore() after the prompt.  Can
-- 		be used several times, in which case there must be just as
-- 		many inputrestore() calls.
-- 		Returns 1 when out of memory, 0 otherwise.
--- @return number
function vim.fn.inputsave() end

-- Like |strpart()| but using character index and length instead
-- 		of byte index and length.
-- 		When a character index is used where a character does not
-- 		exist it is assumed to be one character.  For example: >
-- 			strcharpart('abc', -1, 2)
-- <		results in 'a'.
--- @return string
function vim.fn.strcharpart(str, start, len) end

-- Returns a |List| with Numbers:
-- 		- If only {expr} is specified: [0, 1, ..., {expr} - 1]
-- 		- If {max} is specified: [{expr}, {expr} + 1, ..., {max}]
-- 		- If {stride} is specified: [{expr}, {expr} + {stride}, ...,
-- 		  {max}] (increasing {expr} with {stride} each time, not
-- 		  producing a value past {max}).
-- 		When the maximum is one before the start the result is an
-- 		empty list.  When the maximum is more than one before the
-- 		start this is an error.
-- 		Examples: >
-- 			range(4)		" [0, 1, 2, 3]
-- 			range(2, 4)		" [2, 3, 4]
-- 			range(2, 9, 3)		" [2, 5, 8]
-- 			range(2, -2, -1)	" [2, 1, 0, -1, -2]
-- 			range(0)		" []
-- 			range(2, 0)		" error!
-- <
--- @return list
function vim.fn.range(expr, max, stride) end

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

-- The result is a Number, which is the height of window {nr}.
-- 		{nr} can be the window number or the |window-ID|.
-- 		When {nr} is zero, the height of the current window is
-- 		returned.  When window {nr} doesn't exist, -1 is returned.
-- 		An existing window always has a height of zero or more.
-- 		This excludes any window toolbar line.
-- 		Examples: >
--   :echo "The current window has " . winheight(0) . " lines."
--- @return number
function vim.fn.winheight(nr) end

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

-- The result is a Number, which is the current screen row of the
-- 		cursor.  The top line has number one.
-- 		This function is mainly used for testing.
-- 		Alternatively you can use |winline()|.
--
-- 		Note: Same restrictions as with |screencol()|.
--- @return number
function vim.fn.screenrow() end

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

-- The result is the Number of the current entry in {history}.
-- 		See |hist-names| for the possible values of {history}.
-- 		If an error occurred, -1 is returned.
--
-- 		Example: >
-- 			:let inp_index = histnr("expr")
--- @return number
function vim.fn.histnr(history) end

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

-- Set the command to write in a session file to restore the job
-- 		in this terminal.  The line written in the session file is: >
-- 			terminal ++curwin ++cols=%d ++rows=%d {command}
-- <		Make sure to escape the command properly.
--
-- 		Use an empty {command} to run 'shell'.
-- 		Use "NONE" to not restore this window.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_setrestore(command)
--- @return none
function vim.fn.term_setrestore(buf, command) end

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

-- Removes a watcher added  with |dictwatcheradd()|. All three
-- 		arguments must match the ones passed to |dictwatcheradd()| in
-- 		order for the watcher to be successfully deleted.
--- @param dict dictionary
--- @return stop
function vim.fn.dictwatcherdel(dict, pattern, callback) end

-- Modify the tag stack of the window {nr} using {dict}.
-- 		{nr} can be the window number or the |window-ID|.
--
-- 		For a list of supported items in {dict}, refer to
-- 		|gettagstack()|. "curidx" takes effect before changing the tag
-- 		stack.
-- 							*E962*
-- 		How the tag stack is modified depends on the {action}
-- 		argument:
-- 		- If {action} is not present or is set to 'r', then the tag
-- 		  stack is replaced.
-- 		- If {action} is set to 'a', then new entries from {dict} are
-- 		  pushed (added) onto the tag stack.
-- 		- If {action} is set to 't', then all the entries from the
-- 		  current entry in the tag stack or "curidx" in {dict} are
-- 		  removed and then new entries are pushed to the stack.
--
-- 		The current index is set to one after the length of the tag
-- 		stack after the modification.
--
-- 		Returns zero for success, -1 for failure.
--
-- 		Examples:
-- 		    Set current index of the tag stack to 4: >
-- 			call settagstack(1005, {'curidx' : 4})
--
-- <		    Empty the tag stack of window 3: >
-- 			call settagstack(3, {'items' : []})
--
-- <		    Push a new item onto the tag stack: >
-- 			let pos = [bufnr('myfile.txt'), 10, 1, 0]
-- 			let newtag = [{'tagname' : 'mytag', 'from' : pos}]
-- 			call settagstack(2, {'items' : newtag}, 'a')
--
-- <		    Save and restore the tag stack: >
-- 			let stack = gettagstack(1003)
-- 			" do something else
-- 			call settagstack(1003, stack)
-- 			unlet stack
-- <
--- @param dict dictionary
--- @return number
function vim.fn.settagstack(nr, dict, action) end

-- Returns a list with |window-ID|s for windows that contain
-- 		buffer {bufnr}.  When there is none the list is empty.
--- @return list
function vim.fn.win_findbuf(bufnr) end

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

-- Sends {event} to {channel} via |RPC| and returns immediately.
-- 		If {channel} is 0, the event is broadcast to all channels.
-- 		Example: >
-- 			:au VimLeave call rpcnotify(0, "leaving")
--- @return sends
function vim.fn.rpcnotify(channel, event, ...) end

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

-- The result is a Dict with the screen position of the text
-- 		character in window {winid} at buffer line {lnum} and column
-- 		{col}.  {col} is a one-based byte index.
-- 		The Dict has these members:
-- 			row	screen row
-- 			col	first screen column
-- 			endcol	last screen column
-- 			curscol	cursor screen column
-- 		If the specified position is not visible, all values are zero.
-- 		The "endcol" value differs from "col" when the character
-- 		occupies more than one screen cell.  E.g. for a Tab "col" can
-- 		be 1 and "endcol" can be 8.
-- 		The "curscol" value is where the cursor would be placed.  For
-- 		a Tab it would be the same as "endcol", while for a double
-- 		width character it would be the same as "col".
--- @return dict
function vim.fn.screenpos(winid, lnum, col) end

-- Stop all timers.  The timer callbacks will no longer be
-- 		invoked.  Useful if some timers is misbehaving.  If there are
-- 		no timers there is no error.
--- @return none
function vim.fn.timer_stopall() end

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

-- In a nvim launched with the |--headless| option, this opens
-- 		stdin and stdout as a |channel|. This function can only be
-- 		invoked once per instance. See |channel-stdio| for more
-- 		information and examples. Note that stderr is not handled by
-- 		this function, see |v:stderr|.
--
-- 		Returns a |channel| ID. Close the stdio descriptors with |chanclose()|.
-- 		Use |chansend()| to send data to stdout, and
-- 		|rpcrequest()| and |rpcnotify()| to communicate over RPC.
--
-- 		{opts} is a dictionary with these keys:
-- 		  |on_stdin| : callback invoked when stdin is written to.
-- 		  stdin_buffered : read stdin in |channel-buffered| mode.
-- 		  rpc      : If set, |msgpack-rpc| will be used to communicate
-- 			     over stdio
-- 		Returns:
-- 		  - The channel ID on success (this is always 1)
-- 		  - 0 on invalid arguments
--- @param dict dictionary
--- @return number
function vim.fn.stdioopen(dict) end

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

-- Return the PID (process id) of |job-id| {job}.
--- @return number
function vim.fn.jobpid(id) end

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

-- This is a unique number, until Vim exits.
--- @return number
function vim.fn.getpid() end

-- a client to a Vim server. |remote_send()|
-- 		On Win32 systems this might not work, the OS does not always
-- 		allow a window to bring itself to the foreground.  Use
-- 		|remote_foreground()| instead.
-- 		{only in the Win32 GUI and console version}
--- @return number
function vim.fn.foreground() end

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

-- Bitwise invert.  The argument is converted to a number.  A
-- 		List, Dict or Float argument causes an error.  Example: >
-- 			:let bits = invert(bits)
--- @return number
function vim.fn.invert(expr) end

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

-- Returns the single letter name of the register being recorded.
-- 		Returns an empty string string when not recording.  See |q|.
--- @return string
function vim.fn.reg_recording() end

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

-- {expr} can be a list or a dictionary.  For a dictionary,
-- 		it returns the minimum of all values in the dictionary.
-- 		If {expr} is neither a list nor a dictionary, or one of the
-- 		items in {expr} cannot be used as a Number this results in
-- 		an error.  An empty |List| or |Dictionary| results in zero.
--- @return number
function vim.fn.min(expr) end

-- Return the line number of the first line at or below {lnum}
-- 		that is not blank.  Example: >
-- 			if getline(nextnonblank(1)) =~ "Java"
-- <		When {lnum} is invalid or there is no non-blank line at or
-- 		below it, zero is returned.
-- 		See also |prevnonblank()|.
--- @return number
function vim.fn.nextnonblank(lnum) end

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

-- Returns the text that is displayed for the closed fold at line
-- 		{lnum}.  Evaluates 'foldtext' in the appropriate context.
-- 		When there is no closed fold at {lnum} an empty string is
-- 		returned.
-- 		{lnum} is used like with |getline()|.  Thus "." is the current
-- 		line, "'m" mark m, etc.
-- 		Useful when exporting folded text, e.g., to HTML.
--- @return string
function vim.fn.foldtextresult(lnum) end

-- Get the Job associated with {channel}.
-- 		If there is no job calling |job_status()| on the returned Job
-- 		will result in "fail".
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_getjob()
--- @return job
function vim.fn.ch_getjob(channel) end

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

-- The result is a Number, which is |TRUE| if a buffer called
-- 		{expr} exists and is loaded (shown in a window or hidden).
-- 		The {expr} argument is used like with |bufexists()|.
--- @return number
function vim.fn.bufloaded(expr) end

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

-- Create or replace or add to the location list for window {nr}.
-- 		{nr} can be the window number or the |window-ID|.
-- 		When {nr} is zero the current window is used.
--
-- 		For a location list window, the displayed location list is
-- 		modified.  For an invalid window number {nr}, -1 is returned.
-- 		Otherwise, same as |setqflist()|.
-- 		Also see |location-list|.
--
-- 		If the optional {what} dictionary argument is supplied, then
-- 		only the items listed in {what} are set. Refer to |setqflist()|
-- 		for the list of supported keys in {what}.
--- @param list any[]
--- @return number
function vim.fn.setloclist(nr, list, action, what) end

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

-- This asserts number and |Float| values.  When {actual}  is lower
-- 		than {lower} or higher than {upper} an error message is added
-- 		to |v:errors|.  Also see |assert-return|.
-- 		When {msg} is omitted an error in the form
-- 		"Expected range {lower} - {upper}, but got {actual}" is
-- 		produced.
--- @return number
function vim.fn.assert_inrange(lower, upper, actual, msg) end

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

