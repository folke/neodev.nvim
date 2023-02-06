-- This works around a false-error in sumneko where it cannot determine the
-- type of:
--
--  local a = vim.api  -- cannot infer type of a
--
-- By defining an explicit class for vim.api we avoid this error.

---@class vim.api
local api = vim.api
vim.api = api
