---@meta

--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

--- @class vim.treesitter.LanguageTree
vim.treesitter.LanguageTree = {}

-- Adds a child language to this tree.
--
-- If the language already exists as a child, it will first be removed.
--- @param lang any # The language to add.
function vim.treesitter.LanguageTree:add_child(lang) end

-- Returns a map of language to child tree.
function vim.treesitter.LanguageTree:children() end

-- Determines whether {range} is contained in this language tree
--- @param range any # A range, that is a `{ start_line, start_col, end_line,
--              end_col }` table.
function vim.treesitter.LanguageTree:contains(range) end

-- Destroys this language tree and all its children.
--
-- Any cleanup logic should be performed here.
--
-- Note: This DOES NOT remove this tree from a parent. Instead, `remove_child` must be called on the parent to remove it.
function vim.treesitter.LanguageTree:destroy() end

-- Invokes the callback for each LanguageTree and it's children recursively
--- @param fn fun(...) # The function to invoke. This is invoked with arguments
--                     (tree: LanguageTree, lang: string)
--- @param include_self any # Whether to include the invoking tree in the results.
function vim.treesitter.LanguageTree:for_each_child(fn, include_self) end

-- Invokes the callback for each treesitter trees recursively.
--
-- Note, this includes the invoking language tree's trees as well.
--- @param fn fun(...) # The callback to invoke. The callback is invoked with arguments
--             (tree: TSTree, languageTree: LanguageTree)
function vim.treesitter.LanguageTree:for_each_tree(fn) end

-- Gets the set of included regions
function vim.treesitter.LanguageTree:included_regions() end

-- Invalidates this parser and all its children
function vim.treesitter.LanguageTree:invalidate(reload) end

-- Determines whether this tree is valid. If the tree is invalid, call `parse()` . This will return the updated tree.
function vim.treesitter.LanguageTree:is_valid() end

-- Gets the language of this tree node.
function vim.treesitter.LanguageTree:lang() end

-- Gets the appropriate language that contains {range}
--- @param range any # A text range, see |LanguageTree:contains|
function vim.treesitter.LanguageTree:language_for_range(range) end

-- Gets the smallest named node that contains {range}
--- @param range any # (table) A text range
--- @param opts any # (table) Options table
function vim.treesitter.LanguageTree:named_node_for_range(range, opts) end

-- Parses all defined regions using a treesitter parser for the language this
-- tree represents. This will run the injection query for this language to
-- determine if any child languages should be created.
function vim.treesitter.LanguageTree:parse() end

-- Registers callbacks for the parser.
--- @param cbs any # (table) An |nvim_buf_attach()|-like table argument with the
--             following keys :
--             • `on_bytes` : see |nvim_buf_attach()|, but this will be called after the parsers callback.
--             • `on_changedtree` : a callback that will be called every time
--               the tree has syntactical changes. It will only be passed one
--               argument, which is a table of the ranges (as node ranges)
--               that changed.
--             • `on_child_added` : emitted when a child is added to the
--               tree.
--             • `on_child_removed` : emitted when a child is removed from
--               the tree.
function vim.treesitter.LanguageTree:register_cbs(cbs) end

-- Removes a child language from this tree.
--- @param lang any # The language to remove.
function vim.treesitter.LanguageTree:remove_child(lang) end

-- Sets the included regions that should be parsed by this parser. A region
-- is a set of nodes and/or ranges that will be parsed in the same context.
--
-- For example, `{ { node1 }, { node2} }` is two separate regions. This will
-- be parsed by the parser in two different contexts... thus resulting in two
-- separate trees.
--
-- `{ { node1, node2 } }` is a single region consisting of two nodes. This
-- will be parsed by the parser in a single context... thus resulting in a
-- single tree.
--
-- This allows for embedded languages to be parsed together across different
-- nodes, which is useful for templating languages like ERB and EJS.
--
-- Note, this call invalidates the tree and requires it to be parsed again.
--- @param regions any # (table) list of regions this tree should manage and parse.
function vim.treesitter.LanguageTree:set_included_regions(regions) end

-- Returns the source content of the language tree (bufnr or string).
function vim.treesitter.LanguageTree:source() end

-- Gets the tree that contains {range}
--- @param range any # (table) A text range
--- @param opts any # (table) Options table
function vim.treesitter.LanguageTree:tree_for_range(range, opts) end

-- Returns all trees this language tree contains. Does not include child
-- languages.
function vim.treesitter.LanguageTree:trees() end

--- @class vim.treesitter.Query
vim.treesitter.Query = {}

-- Iterate over all captures from all matches inside {node}
--
-- {source} is needed if the query contains predicates, then the caller must
-- ensure to use a freshly parsed tree consistent with the current text of
-- the buffer (if relevant). {start_row} and {end_row} can be used to limit
-- matches inside a row range (this is typically used with root node as the
-- node, i e to get syntax highlight matches in the current viewport). When
-- omitted the start and end row values are used from the given node.
--
-- The iterator returns three values, a numeric id identifying the capture,
-- the captured node, and metadata from any directives processing the match.
-- The following example shows how to get captures by name:
--
--
-- ```lua
--
--  for id, node, metadata in query:iter_captures(tree:root(), bufnr, first, last) do
--    local name = query.captures[id] -- name of the capture in the query
--    -- typically useful info about the node:
--    local type = node:type() -- type of the captured node
--    local row1, col1, row2, col2 = node:range() -- range of the capture
--    ... use the info here ...
--  end
--
-- ```
--- @param node any # The node under which the search will occur
--- @param source any # The source buffer or string to extract text from
--- @param start any # The starting line of the search
--- @param stop any # The stopping line of the search (end-exclusive)
--- @return any # The matching capture id
--- @return any # The captured node
function vim.treesitter.Query:iter_captures(node, source, start, stop) end

-- Iterates the matches of self on a given range.
--
-- Iterate over all matches within a node. The arguments are the same as for
-- |query:iter_captures()| but the iterated values are different: an
-- (1-based) index of the pattern in the query, a table mapping capture
-- indices to nodes, and metadata from any directives processing the match.
-- If the query has more than one pattern the capture table might be sparse,
-- and e.g. `pairs()` method should be used over `ipairs`. Here an example
-- iterating over all captures in every match:
--
--
-- ```lua
--
--  for pattern, match, metadata in cquery:iter_matches(tree:root(), bufnr, first, last) do
--    for id, node in pairs(match) do
--      local name = query.captures[id]
--      -- `node` was captured by the `name` capture in the match
--
--      local node_data = metadata[id] -- Node level metadata
--
--      ... use the info here ...
--    end
--  end
--
-- ```
--- @param node any # The node under which the search will occur
--- @param source any # The source buffer or string to search
--- @param start any # The starting line of the search
--- @param stop any # The stopping line of the search (end-exclusive)
--- @return any # The matching pattern id
--- @return any # The matching match
function vim.treesitter.Query:iter_matches(node, source, start, stop) end

--- @class vim.treesitter.TSHighlighter
vim.treesitter.TSHighlighter = {}

-- Removes all internal references to the highlighter
function vim.treesitter.TSHighlighter:destroy() end

-- Gets the query used for
--- @param lang any # A language used by the highlighter.
function vim.treesitter.TSHighlighter:get_query(lang) end

-- Represents a single treesitter parser for a language. The language can
-- contain child languages with in its range, hence the tree.
--- @param source any # Can be a bufnr or a string of text to parse
--- @param lang any # The language this tree represents
--- @param opts any # Options table
function vim.treesitter.new(source, lang, opts) end

