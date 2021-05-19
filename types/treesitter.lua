--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

--- @class vim.treesitter.LanguageTree
vim.treesitter.LanguageTree = {}

-- Invokes the callback for each treesitter trees recursively.
--- @param fn fun(...) #The callback to invoke. The callback is invoked
---             with arguments (tree: TSTree, languageTree:
---             LanguageTree)
function vim.treesitter.LanguageTree:for_each_tree(fn) end

-- Determines whether this tree is valid. If the tree is invalid, `parse()` must be called to get the an updated tree.
function vim.treesitter.LanguageTree:is_valid() end

--- @class vim.treesitter.Query
vim.treesitter.Query = {}

-- Iterate over all captures from all matches inside {node}
--- @param node any #The node under which the search will occur
--- @param source any #The source buffer or string to exctract text
---               from
--- @param stop any #The stopping line of the search (end-exclusive)
--- @param start any #The starting line of the search
--- @return any #The matching capture id
function vim.treesitter.Query:iter_captures(node, source, start, stop) end

-- Removes a child language from this tree.
--- @param lang any #The language to remove.
function vim.treesitter.LanguageTree:remove_child(lang) end

-- Gets the language of this tree node.
function vim.treesitter.LanguageTree:lang() end

-- Gets the appropriate language that contains
--- @param range any #A text range, see |LanguageTree:contains|
function vim.treesitter.LanguageTree:language_for_range(range) end

-- Registers callbacks for the parser
--- @param cbs any #An `nvim_buf_attach` -like table argument with the following keys : `on_bytes` : see `nvim_buf_attach` , but this will be called after the parsers callback. `on_changedtree` : a callback that will be called every time the
---             tree has syntactical changes. it will only be
---             passed one argument, that is a table of the ranges
---             (as node ranges) that changed. `on_child_added` : emitted when a child is added to the tree. `on_child_removed` : emitted when a child is removed from the tree.
function vim.treesitter.LanguageTree:register_cbs(cbs) end

-- Parses all defined regions using a treesitter parser for the
-- language this tree represents. This will run the injection
-- query for this language to determine if any child languages
-- should be created.
function vim.treesitter.LanguageTree:parse() end

--- @class vim.treesitter.TSHighlighter
vim.treesitter.TSHighlighter = {}

-- Gets the query used for
--- @param lang any #A language used by the highlighter.
function vim.treesitter.TSHighlighter:get_query(lang) end

-- Invokes the callback for each LanguageTree and it's children
-- recursively
--- @param include_self any #Whether to include the invoking tree in
---                     the results.
--- @param fn fun(...) #The function to invoke. This is invoked
---                     with arguments (tree: LanguageTree, lang:
---                     string)
function vim.treesitter.LanguageTree:for_each_child(fn, include_self) end

-- Adds a child language to this tree.
--- @param lang any #The language to add.
function vim.treesitter.LanguageTree:add_child(lang) end

-- Removes all internal references to the highlighter
function vim.treesitter.TSHighlighter:destroy() end

-- Sets the included regions that should be parsed by this
-- parser. A region is a set of nodes and/or ranges that will be
-- parsed in the same context.
--- @param regions any #A list of regions this tree should manage and
---                parse.
function vim.treesitter.LanguageTree:set_included_regions(regions) end

-- Gets the set of included regions
function vim.treesitter.LanguageTree:included_regions() end

-- Returns all trees this language tree contains. Does not
-- include child languages.
function vim.treesitter.LanguageTree:trees() end

-- Iterates the matches of self on a given range.
--- @param node any #The node under which the search will occur
--- @param source any #The source buffer or string to search
--- @param stop any #The stopping line of the search (end-exclusive)
--- @param start any #The starting line of the search
--- @return any #The matching pattern id
function vim.treesitter.Query:iter_matches(node, source, start, stop) end

-- Determines wether This goes down the tree to recursively check childs.
--- @param range any #A range, that is a `{ start_line, start_col,
---              end_line, end_col }` table.
function vim.treesitter.LanguageTree:contains(range) end

-- Destroys this language tree and all its children.
function vim.treesitter.LanguageTree:destroy() end

-- Invalidates this parser and all its children
function vim.treesitter.LanguageTree:invalidate(reload) end

-- Performs a healthcheck for treesitter integration.
function vim.treesitter.check_health() end

-- Returns a map of language to child tree.
function vim.treesitter.LanguageTree:children() end

-- Returns the source content of the language tree (bufnr or
-- string).
function vim.treesitter.LanguageTree:source() end

-- Lists the parsers currently installed
--- @return any #A list of parsers
function vim.treesitter.list_parsers() end

-- Represents a single treesitter parser for a language. The
-- language can contain child languages with in its range, hence
-- the tree.
--- @param lang any #The language this tree represents
--- @param opts.injections any #A table of language to injection query
---                        strings. This is useful for overriding
---                        the built-in runtime file searching for
---                        the injection language query per
---                        language.
--- @param source any #Can be a bufnr or a string of text to
---                        parse
--- @param opts any #Options table
function vim.treesitter.new(source, lang, opts) end

