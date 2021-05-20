--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

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

-- Return the position and size of popup {id}.  Returns a Dict
-- 		with these entries:
-- 		    col		screen column of the popup, one-based
-- 		    line	screen line of the popup, one-based
-- 		    width	width of the whole popup in screen cells
-- 		    height	height of the whole popup in screen cells
-- 		    core_col	screen column of the text box
-- 		    core_line	screen line of the text box
-- 		    core_width	width of the text box in screen cells
-- 		    core_height	height of the text box in screen cells
-- 		    firstline	line of the buffer at top (1 unless scrolled)
-- 				(not the value of the "firstline" property)
-- 		    lastline	line of the buffer at the bottom (updated when
-- 				the popup is redrawn)
-- 		    scrollbar	non-zero if a scrollbar is displayed
-- 		    visible	one if the popup is displayed, zero if hidden
-- 		Note that these are the actual screen positions.  They differ
-- 		from the values in `popup_getoptions()` for the sizing and
-- 		positioning mechanism applied.
--
-- 		The "core_" values exclude the padding and border.
--
-- 		If popup window {id} is not found an empty Dict is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetPopup()->popup_getpos()
--- @return dict
function vim.fn.popup_getpos(id) end

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

-- Move popup {id} to the position specified with {options}.
-- 		{options} may contain the items from |popup_create()| that
-- 		specify the popup position:
-- 			line
-- 			col
-- 			pos
-- 			maxheight
-- 			minheight
-- 			maxwidth
-- 			minwidth
-- 			fixed
-- 		For {id} see `popup_hide()`.
-- 		For other options see |popup_setoptions()|.
--
-- 		Can also be used as a |method|: >
-- 			GetPopup()->popup_move(options)
--- @return none
function vim.fn.popup_move(id, options) end

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

-- Override options in popup {id} with entries in {options}.
-- 		These options can be set:
-- 			border
-- 			borderchars
-- 			borderhighlight
-- 			callback
-- 			close
-- 			cursorline
-- 			drag
-- 			filter
-- 			firstline
-- 			flip
-- 			highlight
-- 			mapping
-- 			mask
-- 			moved
-- 			padding
-- 			resize
-- 			scrollbar
-- 			scrollbarhighlight
-- 			thumbhighlight
-- 			time
-- 			title
-- 			wrap
-- 			zindex
-- 		The options from |popup_move()| can also be used.
-- 		For "hidden" use |popup_hide()| and |popup_show()|.
-- 		"tabpage" cannot be changed.
--
-- 		Can also be used as a |method|: >
-- 			GetPopup()->popup_setoptions(options)
--- @return none
function vim.fn.popup_setoptions(id, options) end

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

-- Remove all text properties from line {lnum}.
-- 		When {lnum-end} is given, remove all text properties from line
-- 		{lnum} to {lnum-end} (inclusive).
--
-- 		When {props} contains a "bufnr" item use this buffer,
-- 		otherwise use the current buffer.
--
-- 		See |text-properties| for information about text properties.
--
-- 		Can also be used as a |method|: >
-- 			GetLnum()->prop_clear()
-- <
--- @return none
function vim.fn.prop_clear(lnum, lnum_end, props) end

-- {not implemented yet}
-- 		Search for a text property as specified with {props}:
-- 		   id		property with this ID
-- 		   type		property with this type name
-- 		   bufnr	buffer to search in; when present a
-- 				start position with "lnum" and "col"
-- 				must be given; when omitted the
-- 				current buffer is used
-- 		   lnum		start in this line (when omitted start
-- 				at the cursor)
-- 		   col		start at this column (when omitted
-- 				and "lnum" is given: use column 1,
-- 				otherwise start at the cursor)
-- 		   skipstart	do not look for a match at the start
-- 				position
--
-- 		{direction} can be "f" for forward and "b" for backward.  When
-- 		omitted forward search is performed.
--
-- 		If a match is found then a Dict is returned with the entries
-- 		as with prop_list(), and additionally an "lnum" entry.
-- 		If no match is found then an empty Dict is returned.
--
-- 		See |text-properties| for information about text properties.
--- @return dict
function vim.fn.prop_find(props, direction) end

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

-- The result is a Number, which is non-zero if a highlight group
-- 		called {name} exists.  This is when the group has been
-- 		defined in some way.  Not necessarily when highlighting has
-- 		been defined for it, it may also have been used for a syntax
-- 		item.
--- @return number
function vim.fn.hlexists(name) end

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

-- The result is a Number, which is the last modification time of
-- 		the given file {fname}.  The value is measured as seconds
-- 		since 1st Jan 1970, and may be passed to strftime().  See also
-- 		|localtime()| and |strftime()|.
-- 		If the file {fname} can't be found -1 is returned.
--- @return number
function vim.fn.getftime(fname) end

-- Returns a list with all property type names.
--
-- 		{props} can contain a "bufnr" item.  When it is given, use
-- 		this buffer instead of the global property types.
--
-- 		See |text-properties| for information about text properties.
--- @return list
function vim.fn.prop_type_list(props) end

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
function vim.fn.sign_placelist(list) end

--- @param list any[]
--- @return list
function vim.fn.sign_unplacelist(list) end

-- Stop playing all sounds.
-- 		{only available when compiled with the |+sound| feature}
--- @return none
function vim.fn.sound_clear() end

-- The result is a Number, which is the width of window {nr}.
-- 		{nr} can be the window number or the |window-ID|.
-- 		When {nr} is zero, the width of the current window is
-- 		returned.  When window {nr} doesn't exist, -1 is returned.
-- 		An existing window always has a width of zero or more.
-- 		Examples: >
--   :echo "The current window has " . winwidth(0) . " columns."
--   :if winwidth(0) <= 50
--   :  50 wincmd |
--   :endif
-- <		For getting the terminal or screen size, see the 'columns'
-- 		option.
--- @return number
function vim.fn.winwidth(nr) end

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

-- Stop playing sound {id}.  {id} must be previously returned by
-- 		`sound_playevent()` or `sound_playfile()`.
--
-- 		On MS-Windows, this does not work for event sound started by
-- 		`sound_playevent()`. To stop event sounds, use `sound_clear()`.
--
-- 		Can also be used as a |method|: >
-- 			soundid->sound_stop()
--
-- <		{only available when compiled with the |+sound| feature}
--- @return none
function vim.fn.sound_stop(id) end

-- Initialize seed used by |rand()|:
-- 		- If {expr} is not given, seed values are initialized by
-- 		  reading from /dev/urandom, if possible, or using time(NULL)
-- 		  a.k.a. epoch time otherwise; this only has second accuracy.
-- 		- If {expr} is given it must be a Number.  It is used to
-- 		  initialize the seed values.  This is useful for testing or
-- 		  when a predictable sequence is intended.
--
-- 		Examples: >
-- 			:let seed = srand()
-- 			:let seed = srand(userinput)
-- 			:echo rand(seed)
--- @return list
function vim.fn.srand(expr) end

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

-- Open a new window displaying the contents of {filename}
-- 		The file must have been created with |term_dumpwrite()|.
-- 		Returns the buffer number or zero when it fails.
-- 		Also see |terminal-diff|.
--
-- 		For {options} see |term_dumpdiff()|.
--
-- 		Can also be used as a |method|: >
-- 			GetFilename()->term_dumpload()
-- <
--- @return number
function vim.fn.term_dumpload(filename, options) end

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

-- Returns 1 if the terminal of {buf} is using the alternate
-- 		screen.
-- 		{buf} is used as with |term_getsize()|.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getaltscreen()
--- @return number
function vim.fn.term_getaltscreen(buf) end

-- Get the ANSI color palette in use by terminal {buf}.
-- 		Returns a List of length 16 where each element is a String
-- 		representing a color in hexadecimal "#rrggbb" format.
-- 		Also see |term_setansicolors()| and |g:terminal_ansi_colors|.
-- 		If neither was used returns the default colors.
--
-- 		{buf} is used as with |term_getsize()|.  If the buffer does not
-- 		exist or is not a terminal window, an empty list is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getansicolors()
--
-- <		{only available when compiled with GUI enabled and/or the
-- 		|+termguicolors| feature}
--- @return list
function vim.fn.term_getansicolors(buf) end

-- Given {attr}, a value returned by term_scrape() in the "attr"
-- 		item, return whether {what} is on.  {what} can be one of:
-- 			bold
-- 			italic
-- 			underline
-- 			strike
-- 			reverse
--
-- 		Can also be used as a |method|: >
-- 			GetAttr()->term_getattr()
--- @return number
function vim.fn.term_getattr(attr, what) end

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

-- Get the Job associated with terminal window {buf}.
-- 		{buf} is used as with |term_getsize()|.
-- 		Returns |v:null| when there is no job.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getjob()
--- @return job
function vim.fn.term_getjob(buf) end

-- Like |screenchar()|, but return the attribute.  This is a rather
-- 		arbitrary number that can only be used to compare to the
-- 		attribute at other positions.
--- @return number
function vim.fn.screenattr(row, col) end

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

-- The result is a Number, which is the current screen row of the
-- 		cursor.  The top line has number one.
-- 		This function is mainly used for testing.
-- 		Alternatively you can use |winline()|.
--
-- 		Note: Same restrictions as with |screencol()|.
--- @return number
function vim.fn.screenrow() end

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

-- Return a list with the buffer numbers of all buffers for
-- 		terminal windows.
--- @return list
function vim.fn.term_list() end

--- @return list
function vim.fn.searchpairpos(start, middle, _end, flags, ...) end

-- Send keystrokes {keys} to terminal {buf}.
-- 		{buf} is used as with |term_getsize()|.
--
-- 		{keys} are translated as key sequences. For example, "\<c-x>"
-- 		means the character CTRL-X.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_sendkeys(keys)
--- @return none
function vim.fn.term_sendkeys(buf, keys) end

-- Set the function name prefix to be used for the |terminal-api|
-- 		function in terminal {buf}.  For example: >
-- 		    :call term_setapi(buf, "Myapi_")
-- 		    :call term_setapi(buf, "")
-- <
-- 		The default is "Tapi_".  When {expr} is an empty string then
-- 		no |terminal-api| function can be used for {buf}.
--- @return none
function vim.fn.term_setapi(buf, expr) end

-- Returns a list of server addresses, or empty if all servers
-- 		were stopped. |serverstart()| |serverstop()|
-- 		Example: >
-- 			:echo serverlist()
--- @return string
function vim.fn.serverlist() end

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

-- Make a |List| out of {expr}.  When {pattern} is omitted or
-- 		empty each white-separated sequence of characters becomes an
-- 		item.
-- 		Otherwise the string is split where {pattern} matches,
-- 		removing the matched characters. 'ignorecase' is not used
-- 		here, add \c to ignore case. |/\c|
-- 		When the first or last item is empty it is omitted, unless the
-- 		{keepempty} argument is given and it's non-zero.
-- 		Other empty items are kept when {pattern} matches at least one
-- 		character or when {keepempty} is non-zero.
-- 		Example: >
-- 			:let words = split(getline('.'), '\W\+')
-- <		To split a string in individual characters: >
-- 			:for c in split(mystring, '\zs')
-- <		If you want to keep the separator you can also use '\zs' at
-- 		the end of the pattern: >
-- 			:echo split('abc:def:ghi', ':\zs')
-- <			['abc:', 'def:', 'ghi'] ~
-- 		Splitting a table where the first element can be empty: >
-- 			:let items = split(line, ':', 1)
-- <		The opposite function is |join()|.
--- @return list
function vim.fn.split(expr, pat, keepempty) end

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

-- Wait for pending updates of {buf} to be handled.
-- 		{buf} is used as with |term_getsize()|.
-- 		{time} is how long to wait for updates to arrive in msec.  If
-- 		not set then 10 msec will be used.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_wait()
--- @return number
function vim.fn.term_wait(buf, time) end

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

-- This is for testing: If the memory allocation with {id} is
-- 		called, then decrement {countdown}, and when it reaches zero
-- 		let memory allocation fail {repeat} times.  When {repeat} is
-- 		smaller than one it fails one time.
--
-- 		Can also be used as a |method|: >
-- 			GetAllocId()->test_alloc_fail()
--- @return none
function vim.fn.test_alloc_fail(id, countdown, _repeat) end

-- Set a flag to enable the effect of 'autochdir' before Vim
-- 		startup has finished.
--- @return none
function vim.fn.test_autochdir() end

-- in the window.  This is counting screen lines from the top of
-- 		the window.  The first line is one.
-- 		If the cursor was moved the view on the file will be updated
-- 		first, this may cause a scroll.
--- @return number
function vim.fn.winline() end

-- Characters in {string} are queued for processing as if they
-- 		were typed by the user. This uses a low level input buffer.
-- 		This function works only when with |+unix| or GUI is running.
--
-- 		Can also be used as a |method|: >
-- 			GetText()->test_feedinput()
--- @return none
function vim.fn.test_feedinput(string) end

-- Set the register {regname} to {value}.
-- 		{value} may be any value returned by |getreg()|, including
-- 		a |List|.
-- 		If {options} contains "a" or {regname} is upper case,
-- 		then the value is appended.
-- 		{options} can also contain a register type specification:
-- 		    "c" or "v"	      |charwise| mode
-- 		    "l" or "V"	      |linewise| mode
-- 		    "b" or "<CTRL-V>" |blockwise-visual| mode
-- 		If a number immediately follows "b" or "<CTRL-V>" then this is
-- 		used as the width of the selection - if it is not specified
-- 		then the width of the block is set to the number of characters
-- 		in the longest line (counting a <Tab> as 1 character).
-- 		If {options} contains "u" or '"', then the unnamed register is
-- 		set to point to register {regname}.
--
-- 		If {options} contains no register settings, then the default
-- 		is to use character mode unless {value} ends in a <NL> for
-- 		string {value} and linewise mode for list {value}. Blockwise
-- 		mode is never selected automatically.
-- 		Returns zero for success, non-zero for failure.
--
-- 							*E883*
-- 		Note: you may not use |List| containing more than one item to
-- 		      set search and expression registers. Lists containing no
-- 		      items act like empty strings.
--
-- 		Examples: >
-- 			:call setreg(v:register, @*)
-- 			:call setreg('*', @%, 'ac')
-- 			:call setreg('a', "1\n2\n3", 'b5')
--
-- <		This example shows using the functions to save and restore a
-- 		register: >
-- 			:let var_a = getreg('a', 1, 1)
-- 			:let var_amode = getregtype('a')
-- 			    ....
-- 			:call setreg('a', var_a, var_amode)
-- <		Note: you may not reliably restore register value
-- 		without using the third argument to |getreg()| as without it
-- 		newlines are represented as newlines AND Nul bytes are
-- 		represented as newlines as well, see |NL-used-for-Nul|.
--
-- 		You can also change the type of a register by appending
-- 		nothing: >
-- 			:call setreg('a', '', 'al')
--- @return number
function vim.fn.setreg(n, v, opt) end

-- Set the flag to call the garbagecollector as if in the main
-- 		loop.  Only to be used in tests.
--- @return none
function vim.fn.test_garbagecollect_soon() end

-- Set tab-local variable {varname} to {val} in tab page {tabnr}.
-- 		|t:var|
-- 		Note that the variable name without "t:" must be used.
-- 		Tabs are numbered starting with one.
-- 		This function is not available in the |sandbox|.
--- @return set
function vim.fn.settabvar(nr, varname, val) end

-- Get the value of an internal variable.  These values for
-- 		{name} are supported:
-- 			need_fileinfo
--
-- 		Can also be used as a |method|: >
-- 			GetName()->test_getvalue()
function vim.fn.test_getvalue(string) end

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

