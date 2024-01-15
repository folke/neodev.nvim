---@meta



-- Decode a Base64 encoded string.
-- 
-- Parameters: ~
--   • {str}  (`string`) Base64 encoded string
-- 
-- Return: ~
--     (`string`) Decoded string
--- @param str string
function vim.base64.decode(str) end

-- Encode {str} using Base64.
-- 
-- Parameters: ~
--   • {str}  (`string`) String to encode
-- 
-- Return: ~
--     (`string`) Encoded string
--- @param str string
function vim.base64.encode(str) end

-- Invokes |vim-function| or |user-function| {func} with arguments {...}.
-- See also |vim.fn|.
-- Equivalent to: 
-- ```lua
--     vim.fn[func]({...})
-- ```
--- @param func fun()
function vim.call(func, ...) end

-- Run diff on strings {a} and {b}. Any indices returned by this function,
-- either directly or via callback arguments, are 1-based.
-- 
-- Examples: 
-- ```lua
--     vim.diff('a\n', 'b\nc\n')
--     -- =>
--     -- @@ -1 +1,2 @@
--     -- -a
--     -- +b
--     -- +c
-- 
--     vim.diff('a\n', 'b\nc\n', {result_type = 'indices'})
--     -- =>
--     -- {
--     --   {1, 1, 1, 2}
--     -- }
-- ```
-- 
-- Parameters: ~
--   • {a}     (`string`) First string to compare
--   • {b}     (`string`) Second string to compare
--   • {opts}  (`table<string,any>`) Optional parameters:
--             • `on_hunk` (callback): Invoked for each hunk in the diff.
--               Return a negative number to cancel the callback for any
--               remaining hunks. Args:
--               • `start_a` (integer): Start line of hunk in {a}.
--               • `count_a` (integer): Hunk size in {a}.
--               • `start_b` (integer): Start line of hunk in {b}.
--               • `count_b` (integer): Hunk size in {b}.
-- 
--             • `result_type` (string): Form of the returned diff:
--               • "unified": (default) String in unified format.
--               • "indices": Array of hunk locations. Note: This option is
--                 ignored if `on_hunk` is used.
-- 
--             • `linematch` (boolean|integer): Run linematch on the
--               resulting hunks from xdiff. When integer, only hunks upto
--               this size in lines are run through linematch. Requires
--               `result_type = indices`, ignored otherwise.
--             • `algorithm` (string): Diff algorithm to use. Values:
--               • "myers" the default algorithm
--               • "minimal" spend extra time to generate the smallest
--                 possible diff
--               • "patience" patience diff algorithm
--               • "histogram" histogram diff algorithm
-- 
--             • `ctxlen` (integer): Context length
--             • `interhunkctxlen` (integer): Inter hunk context length
--             • `ignore_whitespace` (boolean): Ignore whitespace
--             • `ignore_whitespace_change` (boolean): Ignore whitespace
--               change
--             • `ignore_whitespace_change_at_eol` (boolean) Ignore
--               whitespace change at end-of-line.
--             • `ignore_cr_at_eol` (boolean) Ignore carriage return at
--               end-of-line
--             • `ignore_blank_lines` (boolean) Ignore blank lines
--             • `indent_heuristic` (boolean): Use the indent heuristic for
--               the internal diff library.
-- 
-- Return: ~
--     (`string|table?`) See {opts.result_type}. `nil` if {opts.on_hunk} is
--     given.
--- @param opts table<string, any>
function vim.diff(a, b, opts) end

-- The result is a String, which is the text {str} converted from encoding
-- {from} to encoding {to}. When the conversion fails `nil` is returned. When
-- some characters could not be converted they are replaced with "?". The
-- encoding names are whatever the iconv() library function can accept, see
-- ":Man 3 iconv".
-- 
-- Parameters: ~
--   • {str}   (`string`) Text to convert
--   • {from}  (`number`) Encoding of {str}
--   • {to}    (`number`) Target encoding
--   • {opts}  (`table<string,any>?`)
-- 
-- Return: ~
--     (`string?`) Converted string if conversion succeeds, `nil` otherwise.
--- @param str string
--- @param from number
--- @param to number
--- @param opts table<string, any>
function vim.iconv(str, from, to, opts) end

-- Returns true if the code is executing as part of a "fast" event handler,
-- where most of the API is disabled. These are low-level events (e.g.
-- |lua-loop-callbacks|) which can be invoked whenever Nvim polls for input.
-- When this is `false` most API functions are callable (but may be subject
-- to other restrictions such as |textlock|).
function vim.in_fast_event() end

-- Decodes (or "unpacks") the JSON-encoded {str} to a Lua object.
-- 
-- • Decodes JSON "null" as |vim.NIL| (controllable by {opts}, see below).
-- • Decodes empty object as |vim.empty_dict()|.
-- • Decodes empty array as `{}` (empty Lua table).
-- 
-- Example: 
-- ```lua
--     vim.print(vim.json.decode('{"bar":[],"foo":{},"zub":null}'))
--     -- { bar = {}, foo = vim.empty_dict(), zub = vim.NIL }
-- ```
-- 
-- Parameters: ~
--   • {str}   (`string`) Stringified JSON data.
--   • {opts}  (`table<string,any>?`) Options table with keys:
--             • luanil: (table) Table with keys:
--               • object: (boolean) When true, converts `null` in JSON
--                 objects to Lua `nil` instead of |vim.NIL|.
--               • array: (boolean) When true, converts `null` in JSON arrays
--                 to Lua `nil` instead of |vim.NIL|.
-- 
-- Return: ~
--     (`any`)
--- @param str string
--- @param opts table<string, any>
function vim.json.decode(str, opts) end

-- Encodes (or "packs") Lua object {obj} as JSON in a Lua string.
-- 
-- Parameters: ~
--   • {obj}  (`any`)
-- 
-- Return: ~
--     (`string`)
function vim.json.encode(obj) end

-- Returns a pattern that matches only if the input string at the current
-- position is preceded by `patt`. Pattern `patt` must match only strings
-- with some fixed length, and it cannot contain captures. Like the and
-- predicate, this pattern never consumes any input, independently of success
-- or failure.
-- 
-- Parameters: ~
--   • {pattern}  (`vim.lpeg.Pattern`)
-- 
-- Return: ~
--     (`vim.lpeg.Pattern`)
function vim.lpeg.B(pattern) end

-- Creates a simple capture, which captures the substring of the subject that
-- matches `patt`. The captured value is a string. If `patt` has other
-- captures, their values are returned after this one.
-- 
-- Example: 
-- ```lua
--     local function split (s, sep)
--       sep = lpeg.P(sep)
--       local elem = lpeg.C((1 - sep)^0)
--       local p = elem * (sep * elem)^0
--       return lpeg.match(p, s)
--     end
--     local a, b, c = split('a,b,c', ',')
--     assert(a == 'a')
--     assert(b == 'b')
--     assert(c == 'c')
-- ```
-- 
-- Parameters: ~
--   • {patt}  (`vim.lpeg.Pattern`)
-- 
-- Return: ~
--     (`vim.lpeg.Capture`)
function vim.lpeg.C(patt) end

-- Creates an argument capture. This pattern matches the empty string and
-- produces the value given as the nth extra argument given in the call to `lpeg.match` .
-- 
-- Parameters: ~
--   • {n}  (`integer`)
-- 
-- Return: ~
--     (`vim.lpeg.Capture`)
function vim.lpeg.Carg(n) end

-- Creates a back capture. This pattern matches the empty string and produces
-- the values produced by the most recent group capture named `name` (where
-- `name` can be any Lua value). Most recent means the last complete
-- outermost group capture with the given name. A Complete capture means that
-- the entire pattern corresponding to the capture has matched. An Outermost
-- capture means that the capture is not inside another complete capture. In
-- the same way that LPeg does not specify when it evaluates captures, it
-- does not specify whether it reuses values previously produced by the group
-- or re-evaluates them.
-- 
-- Parameters: ~
--   • {name}  (`any`)
-- 
-- Return: ~
--     (`vim.lpeg.Capture`)
function vim.lpeg.Cb(name) end

-- Creates a constant capture. This pattern matches the empty string and
-- produces all given values as its captured values.
-- 
-- Parameters: ~
--   • {...}  (`any`)
-- 
-- Return: ~
--     (`vim.lpeg.Capture`)
function vim.lpeg.Cc(...) end

-- Creates a fold capture. If `patt` produces a list of captures C1 C2 ...
-- Cn, this capture will produce the value `func(...func(func(C1, C2),
-- C3)...,Cn)`, that is, it will fold (or accumulate, or reduce) the captures
-- from `patt` using function `func`. This capture assumes that `patt` should
-- produce at least one capture with at least one value (of any type), which
-- becomes the initial value of an accumulator. (If you need a specific
-- initial value, you may prefix a constant captureto `patt`.) For each
-- subsequent capture, LPeg calls `func` with this accumulator as the first
-- argument and all values produced by the capture as extra arguments; the
-- first result from this call becomes the new value for the accumulator. The
-- final value of the accumulator becomes the captured value.
-- 
-- Example: 
-- ```lua
--     local number = lpeg.R("09") ^ 1 / tonumber
--     local list = number * ("," * number) ^ 0
--     local function add(acc, newvalue) return acc + newvalue end
--     local sum = lpeg.Cf(list, add)
--     assert(sum:match("10,30,43") == 83)
-- ```
-- 
-- Parameters: ~
--   • {patt}  (`vim.lpeg.Pattern`)
--   • {func}  (`fun(acc, newvalue)`)
-- 
-- Return: ~
--     (`vim.lpeg.Capture`)
--- @param func fun()
function vim.lpeg.Cf(patt, func) end

-- Creates a group capture. It groups all values returned by `patt` into a
-- single capture. The group may be anonymous (if no name is given) or named
-- with the given name (which can be any non-nil Lua value).
-- 
-- Parameters: ~
--   • {patt}  (`vim.lpeg.Pattern`)
--   • {name}  (`string?`)
-- 
-- Return: ~
--     (`vim.lpeg.Capture`)
function vim.lpeg.Cg(patt, name) end

-- Creates a match-time capture. Unlike all other captures, this one is
-- evaluated immediately when a match occurs (even if it is part of a larger
-- pattern that fails later). It forces the immediate evaluation of all its
-- nested captures and then calls `function`. The given function gets as
-- arguments the entire subject, the current position (after the match of
-- `patt`), plus any capture values produced by `patt`. The first value
-- returned by `function` defines how the match happens. If the call returns
-- a number, the match succeeds and the returned number becomes the new
-- current position. (Assuming a subject sand current position i, the
-- returned number must be in the range [i, len(s) + 1].) If the call returns
-- true, the match succeeds without consuming any input (so, to return true
-- is equivalent to return i). If the call returns false, nil, or no value,
-- the match fails. Any extra values returned by the function become the
-- values produced by the capture.
-- 
-- Parameters: ~
--   • {patt}  (`vim.lpeg.Pattern`)
--   • {fn}    (`function`)
-- 
-- Return: ~
--     (`vim.lpeg.Capture`)
--- @param fn fun()
function vim.lpeg.Cmt(patt, fn) end

-- Creates a position capture. It matches the empty string and captures the
-- position in the subject where the match occurs. The captured value is a
-- number.
-- 
-- Example: 
-- ```lua
--     local I = lpeg.Cp()
--     local function anywhere(p) return lpeg.P({I * p * I + 1 * lpeg.V(1)}) end
--     local match_start, match_end = anywhere("world"):match("hello world!")
--     assert(match_start == 7)
--     assert(match_end == 12)
-- ```
-- 
-- Return: ~
--     (`vim.lpeg.Capture`)
function vim.lpeg.Cp() end

-- Creates a substitution capture. This function creates a substitution
-- capture, which captures the substring of the subject that matches `patt`,
-- with substitutions. For any capture inside `patt` with a value, the
-- substring that matched the capture is replaced by the capture value (which
-- should be a string). The final captured value is the string resulting from
-- all replacements.
-- 
-- Example: 
-- ```lua
--     local function gsub (s, patt, repl)
--       patt = lpeg.P(patt)
--       patt = lpeg.Cs((patt / repl + 1)^0)
--       return lpeg.match(patt, s)
--     end
--     assert(gsub('Hello, xxx!', 'xxx', 'World') == 'Hello, World!')
-- ```
-- 
-- Parameters: ~
--   • {patt}  (`vim.lpeg.Pattern`)
-- 
-- Return: ~
--     (`vim.lpeg.Capture`)
function vim.lpeg.Cs(patt) end

-- Creates a table capture. This capture returns a table with all values from
-- all anonymous captures made by `patt` inside this table in successive
-- integer keys, starting at 1. Moreover, for each named capture group
-- created by `patt`, the first value of the group is put into the table with
-- the group name as its key. The captured value is only the table.
-- 
-- Parameters: ~
--   • {patt}  (vim.lpeg.Pattern |' `) @return (` vim.lpeg.Capture`)
function vim.lpeg.Ct(patt) end

-- Converts the given value into a proper pattern. This following rules are
-- applied:
-- • If the argument is a pattern, it is returned unmodified.
-- • If the argument is a string, it is translated to a pattern that matches
--   the string literally.
-- • If the argument is a non-negative number `n`, the result is a pattern
--   that matches exactly `n` characters.
-- • If the argument is a negative number `-n`, the result is a pattern that
--   succeeds only if the input string has less than `n` characters left:
--   `lpeg.P(-n)` is equivalent to `-lpeg.P(n)` (see the unary minus
--   operation).
-- • If the argument is a boolean, the result is a pattern that always
--   succeeds or always fails (according to the boolean value), without
--   consuming any input.
-- • If the argument is a table, it is interpreted as a grammar (see
--   Grammars).
-- • If the argument is a function, returns a pattern equivalent to a
--   match-time captureover the empty string.
-- 
-- Parameters: ~
--   • {value}  (`vim.lpeg.Pattern|string|integer|boolean|table|function`)
-- 
-- Return: ~
--     (`vim.lpeg.Pattern`)
function vim.lpeg.P(value) end

-- Returns a pattern that matches any single character belonging to one of
-- the given ranges. Each `range` is a string `xy` of length 2, representing
-- all characters with code between the codes of `x` and `y` (both
-- inclusive). As an example, the pattern `lpeg.R("09")` matches any digit,
-- and `lpeg.R("az", "AZ")` matches any ASCII letter.
-- 
-- Example: 
-- ```lua
--     local pattern = lpeg.R("az") ^ 1 * -1
--     assert(pattern:match("hello") == 6)
-- ```
-- 
-- Parameters: ~
--   • {...}  (`string`)
-- 
-- Return: ~
--     (`vim.lpeg.Pattern`)
function vim.lpeg.R(...) end

-- Returns a pattern that matches any single character that appears in the
-- given string (the `S` stands for Set). As an example, the pattern
-- `lpeg.S("+-*&zwj;/")` matches any arithmetic operator. Note that, if `s`
-- is a character (that is, a string of length 1), then `lpeg.P(s)` is
-- equivalent to `lpeg.S(s)` which is equivalent to `lpeg.R(s..s)`. Note also
-- that both `lpeg.S("")` and `lpeg.R()` are patterns that always fail.
-- 
-- Parameters: ~
--   • {string}  (`string`)
-- 
-- Return: ~
--     (`vim.lpeg.Pattern`)
--- @param string string
function vim.lpeg.S(string) end

-- Creates a non-terminal (a variable) for a grammar. This operation creates
-- a non-terminal (a variable) for a grammar. The created non-terminal refers
-- to the rule indexed by `v` in the enclosing grammar.
-- 
-- Example: 
-- ```lua
--     local b = lpeg.P({"(" * ((1 - lpeg.S "()") + lpeg.V(1)) ^ 0 * ")"})
--     assert(b:match('((string))') == 11)
--     assert(b:match('(') == nil)
-- ```
-- 
-- Parameters: ~
--   • {v}  (`string|integer`)
-- 
-- Return: ~
--     (`vim.lpeg.Pattern`)
function vim.lpeg.V(v) end

-- Matches the given `pattern` against the `subject` string. If the match
-- succeeds, returns the index in the subject of the first character after
-- the match, or the captured values (if the pattern captured any value). An
-- optional numeric argument `init` makes the match start at that position in
-- the subject string. As usual in Lua libraries, a negative value counts
-- from the end. Unlike typical pattern-matching functions, `match` works
-- only in anchored mode; that is, it tries to match the pattern with a
-- prefix of the given subject string (at position `init`), not with an
-- arbitrary substring of the subject. So, if we want to find a pattern
-- anywhere in a string, we must either write a loop in Lua or write a
-- pattern that matches anywhere.
-- 
-- Example: 
-- ```lua
--     local pattern = lpeg.R("az") ^ 1 * -1
--     assert(pattern:match("hello") == 6)
--     assert(lpeg.match(pattern, "hello") == 6)
--     assert(pattern:match("1 hello") == nil)
-- ```
-- 
-- Parameters: ~
--   • {pattern}  (`vim.lpeg.Pattern`)
--   • {subject}  (`string`)
--   • {init}     (`integer?`)
-- 
-- Return: ~
--     (`integer|vim.lpeg.Capture?`)
function vim.lpeg.match(pattern, subject, init) end

-- Sets a limit for the size of the backtrack stack used by LPeg to track
-- calls and choices. The default limit is `400`. Most well-written patterns
-- need little backtrack levels and therefore you seldom need to change this
-- limit; before changing it you should try to rewrite your pattern to avoid
-- the need for extra space. Nevertheless, a few useful patterns may
-- overflow. Also, with recursive grammars, subjects with deep recursion may
-- also need larger limits.
-- 
-- Parameters: ~
--   • {max}  (`integer`)
function vim.lpeg.setmaxstack(max) end

-- Returns the string `"pattern"` if the given value is a pattern, otherwise
-- `nil`.
-- 
-- Return: ~
--     (`"pattern"?`)
function vim.lpeg.type(value) end

-- Returns a string with the running version of LPeg.
-- 
-- Return: ~
--     (`string`)
function vim.lpeg.version() end

-- Decodes (or "unpacks") the msgpack-encoded {str} to a Lua object.
-- 
-- Parameters: ~
--   • {str}  (`string`)
--- @param str string
function vim.mpack.decode(str) end

-- Encodes (or "packs") Lua object {obj} as msgpack in a Lua string.
function vim.mpack.encode(obj) end

-- Parse the Vim regex {re} and return a regex object. Regexes are "magic"
-- and case-sensitive by default, regardless of 'magic' and 'ignorecase'.
-- They can be controlled with flags, see |/magic| and |/ignorecase|.
-- 
-- Parameters: ~
--   • {re}  (`string`)
-- 
-- Return: ~
--     (`vim.regex`)
function vim.regex(re) end

-- Sends {event} to {channel} via |RPC| and returns immediately. If {channel}
-- is 0, the event is broadcast to all channels.
-- 
-- This function also works in a fast callback |lua-loop-callbacks|.
-- 
-- Parameters: ~
--   • {channel}  (`integer`)
--   • {method}   (`string`)
--   • {args}     (`any[]?`)
--   • {...}      (`any?`)
--- @param args any[]
function vim.rpcnotify(channel, method, args, ...) end

-- Sends a request to {channel} to invoke {method} via |RPC| and blocks until
-- a response is received.
-- 
-- Note: NIL values as part of the return value is represented as |vim.NIL|
-- special value
-- 
-- Parameters: ~
--   • {channel}  (`integer`)
--   • {method}   (`string`)
--   • {args}     (`any[]?`)
--   • {...}      (`any?`)
--- @param args any[]
function vim.rpcrequest(channel, method, args, ...) end

-- Schedules {fn} to be invoked soon by the main event-loop. Useful to avoid
-- |textlock| or other temporary restrictions.
-- 
-- Parameters: ~
--   • {fn}  (`function`)
--- @param fn fun()
function vim.schedule(fn) end

-- Check {str} for spelling errors. Similar to the Vimscript function
-- |spellbadword()|.
-- 
-- Note: The behaviour of this function is dependent on: 'spelllang',
-- 'spellfile', 'spellcapcheck' and 'spelloptions' which can all be local to
-- the buffer. Consider calling this with |nvim_buf_call()|.
-- 
-- Example: 
-- ```lua
--     vim.spell.check("the quik brown fox")
--     -- =>
--     -- {
--     --     {'quik', 'bad', 5}
--     -- }
-- ```
-- 
-- Parameters: ~
--   • {str}  (`string`)
-- 
-- Return: ~
--     (`{[1]: string, [2]: string, [3]: string}[]`) List of tuples with
--     three items:
--     • The badly spelled word.
--     • The type of the spelling error: "bad" spelling mistake "rare" rare
--       word "local" word only valid in another region "caps" word should
--       start with Capital
--     • The position in {str} where the word begins.
--- @param str string
function vim.spell.check(str) end

-- Convert UTF-32 or UTF-16 {index} to byte index. If {use_utf16} is not
-- supplied, it defaults to false (use UTF-32). Returns the byte index.
-- 
-- Invalid UTF-8 and NUL is treated like by |vim.str_byteindex()|. An {index}
-- in the middle of a UTF-16 sequence is rounded upwards to the end of that
-- sequence.
-- 
-- Parameters: ~
--   • {str}        (`string`)
--   • {index}      (`number`)
--   • {use_utf16}  (`any?`)
--- @param str string
--- @param index number
function vim.str_byteindex(str, index, use_utf16) end

-- Gets the distance (in bytes) from the last byte of the codepoint
-- (character) that {index} points to.
-- 
-- Examples: 
-- ```lua
--     -- The character 'æ' is stored as the bytes '\xc3\xa6' (using UTF-8)
-- 
--     -- Returns 0 because the index is pointing at the last byte of a character
--     vim.str_utf_end('æ', 2)
-- 
--     -- Returns 1 because the index is pointing at the penultimate byte of a character
--     vim.str_utf_end('æ', 1)
-- ```
-- 
-- Parameters: ~
--   • {str}    (`string`)
--   • {index}  (`number`)
-- 
-- Return: ~
--     (`number`)
--- @param str string
--- @param index number
function vim.str_utf_end(str, index) end

-- Gets a list of the starting byte positions of each UTF-8 codepoint in the
-- given string.
-- 
-- Embedded NUL bytes are treated as terminating the string.
-- 
-- Parameters: ~
--   • {str}  (`string`)
-- 
-- Return: ~
--     (`table`)
--- @param str string
function vim.str_utf_pos(str) end

-- Gets the distance (in bytes) from the starting byte of the codepoint
-- (character) that {index} points to.
-- 
-- The result can be added to {index} to get the starting byte of a
-- character.
-- 
-- Examples: 
-- ```lua
--     -- The character 'æ' is stored as the bytes '\xc3\xa6' (using UTF-8)
-- 
--     -- Returns 0 because the index is pointing at the first byte of a character
--     vim.str_utf_start('æ', 1)
-- 
--     -- Returns -1 because the index is pointing at the second byte of a character
--     vim.str_utf_start('æ', 2)
-- ```
-- 
-- Parameters: ~
--   • {str}    (`string`)
--   • {index}  (`number`)
-- 
-- Return: ~
--     (`number`)
--- @param str string
--- @param index number
function vim.str_utf_start(str, index) end

-- Convert byte index to UTF-32 and UTF-16 indices. If {index} is not
-- supplied, the length of the string is used. All indices are zero-based.
-- 
-- Embedded NUL bytes are treated as terminating the string. Invalid UTF-8
-- bytes, and embedded surrogates are counted as one code point each. An
-- {index} in the middle of a UTF-8 sequence is rounded upwards to the end of
-- that sequence.
-- 
-- Parameters: ~
--   • {str}    (`string`)
--   • {index}  (`number?`)
-- 
-- Return (multiple): ~
--     (`integer`) UTF-32 index
--     (`integer`) UTF-16 index
--- @param str string
--- @param index number
function vim.str_utfindex(str, index) end

-- Compares strings case-insensitively.
-- 
-- Parameters: ~
--   • {a}  (`string`)
--   • {b}  (`string`)
-- 
-- Return: ~
--     (`0|1|-1`) if strings are equal, {a} is greater than {b} or {a} is
--     lesser than {b}, respectively.
function vim.stricmp(a, b) end

-- Attach to ui events, similar to |nvim_ui_attach()| but receive events as
-- Lua callback. Can be used to implement screen elements like popupmenu or
-- message handling in Lua.
-- 
-- {options} should be a dictionary-like table, where `ext_...` options
-- should be set to true to receive events for the respective external
-- element.
-- 
-- {callback} receives event name plus additional parameters. See
-- |ui-popupmenu| and the sections below for event format for respective
-- events.
-- 
-- WARNING: This api is considered experimental. Usability will vary for
-- different screen elements. In particular `ext_messages` behavior is
-- subject to further changes and usability improvements. This is expected to
-- be used to handle messages when setting 'cmdheight' to zero (which is
-- likewise experimental).
-- 
-- Example (stub for a |ui-popupmenu| implementation): 
-- ```lua
--     ns = vim.api.nvim_create_namespace('my_fancy_pum')
-- 
--     vim.ui_attach(ns, {ext_popupmenu=true}, function(event, ...)
--       if event == "popupmenu_show" then
--         local items, selected, row, col, grid = ...
--         print("display pum ", #items)
--       elseif event == "popupmenu_select" then
--         local selected = ...
--         print("selected", selected)
--       elseif event == "popupmenu_hide" then
--         print("FIN")
--       end
--     end)
-- ```
-- 
-- Parameters: ~
--   • {ns}        (`integer`)
--   • {options}   (`table<string, any>`)
--   • {callback}  (`fun()`)
--- @param ns number
--- @param options table<string, any>
--- @param callback fun()
function vim.ui_attach(ns, options, callback) end

-- Detach a callback previously attached with |vim.ui_attach()| for the given
-- namespace {ns}.
-- 
-- Parameters: ~
--   • {ns}  (`integer`)
--- @param ns number
function vim.ui_detach(ns) end

-- Wait for {time} in milliseconds until {callback} returns `true`.
-- 
-- Executes {callback} immediately and at approximately {interval}
-- milliseconds (default 200). Nvim still processes other events during this
-- time.
-- 
-- Cannot be called while in an |api-fast| event.
-- 
-- Examples: 
-- ```lua
--     ---
--     -- Wait for 100 ms, allowing other events to process
--     vim.wait(100, function() end)
-- 
--     ---
--     -- Wait for 100 ms or until global variable set.
--     vim.wait(100, function() return vim.g.waiting_for_var end)
-- 
--     ---
--     -- Wait for 1 second or until global variable set, checking every ~500 ms
--     vim.wait(1000, function() return vim.g.waiting_for_var end, 500)
-- 
--     ---
--     -- Schedule a function to set a value in 100ms
--     vim.defer_fn(function() vim.g.timer_result = true end, 100)
-- 
--     -- Would wait ten seconds if results blocked. Actually only waits  100 ms
--     if vim.wait(10000, function() return vim.g.timer_result end) then
--       print('Only waiting a little bit of time!')
--     end
-- ```
-- 
-- Parameters: ~
--   • {time}       (`integer`) Number of milliseconds to wait
--   • {callback}   (`fun(): boolean?`) Optional callback. Waits until
--                  {callback} returns true
--   • {interval}   (`integer?`) (Approximate) number of milliseconds to wait
--                  between polls
--   • {fast_only}  (`boolean?`) If true, only |api-fast| events will be
--                  processed.
-- 
-- Return: ~
--     (`boolean, -1|-2?`)
--     • If {callback} returns `true` during the {time}: `true, nil`
--     • If {callback} never returns `true` during the {time}: `false, -1`
--     • If {callback} is interrupted during the {time}: `false, -2`
--     • If {callback} errors, the error is raised.
--- @param time number
--- @param condition? fun(): boolean
--- @param interval? number
--- @param fast_only? boolean
--- @return boolean, nil|number
function vim.wait(time, condition, interval, fast_only) end

