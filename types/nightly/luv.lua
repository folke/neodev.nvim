---@meta

---@class vim.loop
vim.loop = {}

---@class vim.loop.Timer
---@field start fun(timer: vim.loop.Timer, timeout: integer, repeat: integer, callback: fun())
---@field stop fun(timer: vim.loop.Timer)

---@class vim.loop.Handle
---@field close fun(handle: vim.loop.Handle)
---@field is_closing fun(handle: vim.loop.Handle): boolean
---@field is_active fun(handle: vim.loop.Handle): boolean

---@class vim.loop.Stream: vim.loop.Handle
---@field shutdown fun(stream: vim.loop.Stream, callback?: fun()): boolean
---@field read_start fun(stream: vim.loop.Stream, callback? fun(err: string?, chunk: string): 0|'fail'
---@field read_stop fun(stream: vim.loop.Stream): 0|'fail'
---@field write fun(stream: vim.loop.Stream, data: string, callback?: function)
---@field try_write fun(stream: vim.loop.Stream, data: string)

---@class vim.loop.Pipe: vim.loop.Stream

---@class vim.loop.Prepare: vim.loop.Handle
---@field start fun(prepare: vim.loop.Prepare, callback: function): 0|'fail'
---@field stop fun(prepare: vim.loop.Prepare): 0|'fail'

---@class vim.loop.Check: vim.loop.Handle
---@field start fun(check: vim.loop.Check, callback: function): 0|'fail'
---@field stop fun(check: vim.loop.Check): 0|'fail'

---@class vim.loop.Process: vim.loop.Handle
---@field kill fun(process: vim.loop.Process, signum: integer|string): 0|'fail'
---@field get_pid fun(process: vim.loop.Process): integer

---@class vim.loop.TCP: vim.loop.Stream
---@field connect fun(tcp: vim.loop.TCP, host: string, port: integer, callback?: fun(err?: string))

---@alias vim.loop.StatTime {sec: integer, nsec: integer}

---@class vim.loop.Stat
---@field dev integer
---@field mode integer
---@field nlink integer
---@field uid integer
---@field gid integer
---@field rdev integer
---@field ino integer
---@field size integer
---@field blksize integer
---@field blocks integer
---@field flags integer
---@field gen integer
---@field atime vim.loop.StatTime
---@field mtime vim.loop.StatTime
---@field ctime vim.loop.StatTime
---@field birthtime vim.loop.StatTime
---@field type "link"|"directory"|"file"


-- > method form `stream:accept(client_stream)`
-- 
-- Parameters:
-- - `stream`: `userdata` for sub-type of |uv_stream_t|
-- - `client_stream`: `userdata` for sub-type of |uv_stream_t|
-- 
-- This call is used in conjunction with |uv.listen()| to accept
-- incoming connections. Call this function after receiving a
-- callback to accept the connection.
-- 
-- When the connection callback is called it is guaranteed that
-- this function will complete successfully the first time. If
-- you attempt to use it more than once, it may fail. It is
-- suggested to only call this function once per connection call.
-- 
-- Returns: `0` or `fail`
-- 
-- ```lua
--     server:listen(128, function (err)
--       local client = uv.new_tcp()
--       server:accept(client)
--     end)
-- ```
--- @return 0
function vim.loop.accept(stream, client_stream) end

-- > method form `async:send(...)`
-- 
-- Parameters:
-- - `async`: `uv_async_t userdata`
-- - `...`: `threadargs`
-- 
-- Wakeup the event loop and call the async handle's callback.
-- 
-- Returns: `0` or `fail`
-- 
-- Note: It's safe to call this function from any thread. The
-- callback will be called on the loop thread.
-- 
-- WARNING: libuv will coalesce calls to `uv.async_send(async)`,
-- that is, not every call to it will yield an execution of the
-- callback. For example: if `uv.async_send()` is called 5 times
-- in a row before the callback is called, the callback will only
-- be called once. If `uv.async_send()` is called again after the
-- callback was called, it will be called again.
--- @return 0
function vim.loop.async_send(async, ...) end

-- Returns an estimate of the default amount of parallelism a
-- program should use. Always returns a non-zero value.
-- 
-- On Linux, inspects the calling thread’s CPU affinity mask to
-- determine if it has been pinned to specific CPUs.
-- 
-- On Windows, the available parallelism may be underreported on
-- systems with more than 64 logical CPUs.
-- 
-- On other platforms, reports the number of CPUs that the
-- operating system considers to be online.
-- 
-- Returns: `integer`
function vim.loop.available_parallelism() end

-- Get backend file descriptor. Only kqueue, epoll, and event
-- ports are supported.
-- 
-- This can be used in conjunction with `uv.run("nowait")` to
-- poll in one thread and run the event loop's callbacks in
-- another
-- 
-- Returns: `integer` or `nil`
-- 
-- Note: Embedding a kqueue fd in another kqueue pollset doesn't
-- work on all platforms. It's not an error to add the fd but it
-- never generates events.
--- @return number
function vim.loop.backend_fd() end

-- Get the poll timeout. The return value is in milliseconds, or
-- -1 for no timeout.
-- 
-- Returns: `integer`
function vim.loop.backend_timeout() end

-- > method form `req:cancel()`
-- 
-- Parameters:
-- - `req`: `userdata` for sub-type of |uv_req_t|
-- 
-- Cancel a pending request. Fails if the request is executing or
-- has finished executing. Only cancellation of |uv_fs_t|,
-- `uv_getaddrinfo_t`, `uv_getnameinfo_t` and `uv_work_t`
-- requests is currently supported.
-- 
-- Returns: `0` or `fail`
function vim.loop.cancel(req) end

-- Parameters:
-- - `cwd`: `string`
-- 
-- Sets the current working directory with the string `cwd`.
-- 
-- Returns: `0` or `fail`
function vim.loop.chdir(cwd) end

-- > method form `check:start(callback)`
-- 
-- Parameters:
-- - `check`: `uv_check_t userdata`
-- - `callback`: `callable`
-- 
-- Start the handle with the given callback.
-- 
-- Returns: `0` or `fail`
--- @param callback fun()
function vim.loop.check_start(check, callback) end

-- > method form `check:stop()`
-- 
-- Parameters:
-- - `check`: `uv_check_t userdata`
-- 
-- Stop the handle, the callback will no longer be called.
-- 
-- Returns: `0` or `fail`
function vim.loop.check_stop(check) end

-- > method form `handle:close([callback])`
-- 
-- Parameters:
-- - `handle`: `userdata` for sub-type of |uv_handle_t|
-- - `callback`: `callable` or `nil`
-- 
-- Request handle to be closed. `callback` will be called
-- asynchronously after this call. This MUST be called on each
-- handle before memory is released.
-- 
-- Handles that wrap file descriptors are closed immediately but
-- `callback` will still be deferred to the next iteration of the
-- event loop. It gives you a chance to free up any resources
-- associated with the handle.
-- 
-- In-progress requests, like `uv_connect_t` or `uv_write_t`, are
-- cancelled and have their callbacks called asynchronously with
-- `ECANCELED`.
-- 
-- Returns: Nothing.
--- @param callback? fun()
function vim.loop.close(handle, callback) end

-- Returns information about the CPU(s) on the system as a table
-- of tables for each CPU found.
-- 
-- Returns: `table` or `fail`
-- - `[1, 2, 3, ..., n]` : `table`
--   - `model` : `string`
--   - `speed` : `number`
--   - `times` : `table`
--     - `user` : `number`
--     - `nice` : `number`
--     - `sys` : `number`
--     - `idle` : `number`
--     - `irq` : `number`
--- @return table
function vim.loop.cpu_info() end

-- Returns the current working directory.
-- 
-- Returns: `string` or `fail`
function vim.loop.cwd() end

-- Disables inheritance for file descriptors / handles that this
-- process inherited from its parent. The effect is that child
-- processes spawned by this process don't accidentally inherit
-- these handles.
-- 
-- It is recommended to call this function as early in your
-- program as possible, before the inherited file descriptors can
-- be closed or duplicated.
-- 
-- Returns: Nothing.
-- 
-- Note: This function works on a best-effort basis: there is no
-- guarantee that libuv can discover all file descriptors that
-- were inherited. In general it does a better job on Windows
-- than it does on Unix.
function vim.loop.disable_stdio_inheritance() end

-- Returns the executable path.
-- 
-- Returns: `string` or `fail`
function vim.loop.exepath() end

-- > method form `handle:fileno()`
-- 
-- Parameters:
-- - `handle`: `userdata` for sub-type of |uv_handle_t|
-- 
-- Gets the platform dependent file descriptor equivalent.
-- 
-- The following handles are supported: TCP, pipes, TTY, UDP and
-- poll. Passing any other handle type will fail with `EINVAL`.
-- 
-- If a handle doesn't have an attached file descriptor yet or
-- the handle itself has been closed, this function will return
-- `EBADF`.
-- 
-- Returns: `integer` or `fail`
-- 
-- WARNING: Be very careful when using this function. libuv
-- assumes it's in control of the file descriptor so any change
-- to it may lead to malfunction.
--- @return number
function vim.loop.fileno(handle) end

-- Parameters:
-- - `path`: `string`
-- - `mode`: `integer`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `permission`: `boolean` or `nil`
-- 
-- Equivalent to `access(2)` on Unix. Windows uses
-- `GetFileAttributesW()`. Access `mode` can be an integer or a
-- string containing `"R"` or `"W"` or `"X"`. Returns `true` or
-- `false` indicating access permission.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_access(path, mode, callback) end

-- Parameters:
-- - `path`: `string`
-- - `mode`: `integer`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `success`: `boolean` or `nil`
-- 
-- Equivalent to `chmod(2)`.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_chmod(path, mode, callback) end

-- Parameters:
-- - `path`: `string`
-- - `uid`: `integer`
-- - `gid`: `integer`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `success`: `boolean` or `nil`
-- 
-- Equivalent to `chown(2)`.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_chown(path, uid, gid, callback) end

-- Parameters:
-- - `fd`: `integer`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `success`: `boolean` or `nil`
-- 
-- Equivalent to `close(2)`.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_close(fd, callback) end

-- > method form `dir:closedir([callback])`
-- 
-- Parameters:
-- - `dir`: `luv_dir_t userdata`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `success`: `boolean` or `nil`
-- 
-- Closes a directory stream returned by a successful
-- |uv.fs_opendir()| call.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_closedir(dir, callback) end

-- Parameters:
-- - `path`: `string`
-- - `new_path`: `string`
-- - `flags`: `table`, `integer`, or `nil`
--   - `excl`: `boolean`
--   - `ficlone`: `boolean`
--   - `ficlone_force`: `boolean`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `success`: `boolean` or `nil`
-- 
-- Copies a file from path to new_path. If the `flags` parameter
-- is omitted, then the 3rd parameter will be treated as the
-- `callback`.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param flags? any
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_copyfile(path, new_path, flags, callback) end

-- > method form `fs_event:getpath()`
-- 
-- Get the path being monitored by the handle.
-- 
-- Returns: `string` or `fail`
function vim.loop.fs_event_getpath() end

-- > method form `fs_event:start(path, flags, callback)`
-- 
-- Parameters:
-- - `fs_event`: `uv_fs_event_t userdata`
-- - `path`: `string`
-- - `flags`: `table`
--   - `watch_entry`: `boolean` or `nil` (default: `false`)
--   - `stat`: `boolean` or `nil` (default: `false`)
--   - `recursive`: `boolean` or `nil` (default: `false`)
-- - `callback`: `callable`
--   - `err`: `nil` or `string`
--   - `filename`: `string`
--   - `events`: `table`
--     - `change`: `boolean` or `nil`
--     - `rename`: `boolean` or `nil`
-- 
-- Start the handle with the given callback, which will watch the
-- specified path for changes.
-- 
-- Returns: `0` or `fail`
--- @param callback fun()
function vim.loop.fs_event_start(fs_event, path, flags, callback) end

-- > method form `fs_event:stop()`
-- 
-- Stop the handle, the callback will no longer be called.
-- 
-- Returns: `0` or `fail`
function vim.loop.fs_event_stop() end

-- Parameters:
-- - `fd`: `integer`
-- - `mode`: `integer`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `success`: `boolean` or `nil`
-- 
-- Equivalent to `fchmod(2)`.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_fchmod(fd, mode, callback) end

-- Parameters:
-- - `fd`: `integer`
-- - `uid`: `integer`
-- - `gid`: `integer`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `success`: `boolean` or `nil`
-- 
-- Equivalent to `fchown(2)`.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_fchown(fd, uid, gid, callback) end

-- Parameters:
-- - `fd`: `integer`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `success`: `boolean` or `nil`
-- 
-- Equivalent to `fdatasync(2)`.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_fdatasync(fd, callback) end

-- Parameters:
-- - `fd`: `integer`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `stat`: `table` or `nil` (see `uv.fs_stat`)
-- 
-- Equivalent to `fstat(2)`.
-- 
-- Returns (sync version): `table` or `fail` (see `uv.fs_stat`)
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return vim.loop.Stat?
function vim.loop.fs_fstat(fd, callback) end

-- Parameters:
-- - `fd`: `integer`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `success`: `boolean` or `nil`
-- 
-- Equivalent to `fsync(2)`.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_fsync(fd, callback) end

-- Parameters:
-- - `fd`: `integer`
-- - `offset`: `integer`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `success`: `boolean` or `nil`
-- 
-- Equivalent to `ftruncate(2)`.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_ftruncate(fd, offset, callback) end

-- Parameters:
-- - `fd`: `integer`
-- - `atime`: `number`
-- - `mtime`: `number`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `success`: `boolean` or `nil`
-- 
-- Equivalent to `futime(2)`.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_futime(fd, atime, mtime, callback) end

-- Parameters:
-- - `fd`: `integer`
-- - `uid`: `integer`
-- - `gid`: `integer`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `success`: `boolean` or `nil`
-- 
-- Equivalent to `lchown(2)`.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_lchown(fd, uid, gid, callback) end

-- Parameters:
-- - `path`: `string`
-- - `new_path`: `string`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `success`: `boolean` or `nil`
-- 
-- Equivalent to `link(2)`.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_link(path, new_path, callback) end

-- Parameters:
-- - `fd`: `integer`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `stat`: `table` or `nil` (see `uv.fs_stat`)
-- 
-- Equivalent to `lstat(2)`.
-- 
-- Returns (sync version): `table` or `fail` (see |uv.fs_stat()|)
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return vim.loop.Stat?
function vim.loop.fs_lstat(path, callback) end

-- Parameters:
-- - `path`: `string`
-- - `atime`: `number`
-- - `mtime`: `number`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `success`: `boolean` or `nil`
-- 
-- Equivalent to `lutime(2)`.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_lutime(path, atime, mtime, callback) end

-- Parameters:
-- - `path`: `string`
-- - `mode`: `integer`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `success`: `boolean` or `nil`
-- 
-- Equivalent to `mkdir(2)`.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_mkdir(path, mode, callback) end

-- Parameters:
-- - `template`: `string`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `path`: `string` or `nil`
-- 
-- Equivalent to `mkdtemp(3)`.
-- 
-- Returns (sync version): `string` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return string
function vim.loop.fs_mkdtemp(template, callback) end

-- Parameters:
-- - `template`: `string`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `fd`: `integer` or `nil`
--   - `path`: `string` or `nil`
-- 
-- Equivalent to `mkstemp(3)`. Returns a temporary file handle
-- and filename.
-- 
-- Returns (sync version): `integer, string` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return integer, string
function vim.loop.fs_mkstemp(template, callback) end

-- Parameters:
-- - `path`: `string`
-- - `flags`: `string` or `integer`
-- - `mode`: `integer`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `fd`: `integer` or `nil`
-- 
-- Equivalent to `open(2)`. Access `flags` may be an integer or
-- one of: `"r"`, `"rs"`, `"sr"`, `"r+"`, `"rs+"`, `"sr+"`,
-- `"w"`, `"wx"`, `"xw"`, `"w+"`, `"wx+"`, `"xw+"`, `"a"`,
-- `"ax"`, `"xa"`, `"a+"`, `"ax+"`, or "`xa+`".
-- 
-- Returns (sync version): `integer` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
-- 
-- Note: On Windows, libuv uses `CreateFileW` and thus the file
-- is always opened in binary mode. Because of this, the
-- `O_BINARY` and `O_TEXT` flags are not supported.
--- @param callback? fun()
--- @return number
function vim.loop.fs_open(path, flags, mode, callback) end

-- Parameters:
-- - `path`: `string`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `dir`: `luv_dir_t userdata` or `nil`
-- - `entries`: `integer` or `nil`
-- 
-- Opens path as a directory stream. Returns a handle that the
-- user can pass to |uv.fs_readdir()|. The `entries` parameter
-- defines the maximum number of entries that should be returned
-- by each call to |uv.fs_readdir()|.
-- 
-- Returns (sync version): `luv_dir_t userdata` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @param entries? any
--- @return userdata
function vim.loop.fs_opendir(path, callback, entries) end

-- > method form `fs_poll:getpath()`
-- 
-- Get the path being monitored by the handle.
-- 
-- Returns: `string` or `fail`
function vim.loop.fs_poll_getpath() end

-- > method form `fs_poll:start(path, interval, callback)`
-- 
-- Parameters:
-- - `fs_event`: `uv_fs_event_t userdata`
-- - `path`: `string`
-- - `interval`: `integer`
-- - `callback`: `callable`
--   - `err`: `nil` or `string`
--   - `prev`: `table` or `nil` (see `uv.fs_stat`)
--   - `curr`: `table` or `nil` (see `uv.fs_stat`)
-- 
-- Check the file at `path` for changes every `interval`
-- milliseconds.
-- 
-- Note: For maximum portability, use multi-second intervals.
-- Sub-second intervals will not detect all changes on many file
-- systems.
-- 
-- Returns: `0` or `fail`
--- @param callback fun()
function vim.loop.fs_poll_start(fs_poll, path, interval, callback) end

-- > method form `fs_poll:stop()`
-- 
-- Stop the handle, the callback will no longer be called.
-- 
-- Returns: `0` or `fail`
function vim.loop.fs_poll_stop() end

-- Parameters:
-- - `fd`: `integer`
-- - `size`: `integer`
-- - `offset`: `integer` or `nil`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `data`: `string` or `nil`
-- 
-- Equivalent to `preadv(2)`. Returns any data. An empty string
-- indicates EOF.
-- 
-- If `offset` is nil or omitted, it will default to `-1`, which
-- indicates "use and update the current file offset."
-- 
-- Note: When `offset` is >= 0, the current file offset will not
-- be updated by the read.
-- 
-- Returns (sync version): `string` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param offset? any
--- @param callback? fun()
--- @return string
function vim.loop.fs_read(fd, size, offset, callback) end

-- > method form `dir:readdir([callback])`
-- 
-- Parameters:
-- - `dir`: `luv_dir_t userdata`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `entries`: `table` or `nil` (see below)
-- 
-- Iterates over the directory stream `luv_dir_t` returned by a
-- successful |uv.fs_opendir()| call. A table of data tables is
-- returned where the number of entries `n` is equal to or less
-- than the `entries` parameter used in the associated
-- |uv.fs_opendir()| call.
-- 
-- Returns (sync version): `table` or `fail`
-- - `[1, 2, 3, ..., n]` : `table`
--   - `name` : `string`
--   - `type` : `string`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return table
function vim.loop.fs_readdir(dir, callback) end

-- Parameters:
-- - `path`: `string`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `path`: `string` or `nil`
-- 
-- Equivalent to `readlink(2)`.
-- 
-- Returns (sync version): `string` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return string
function vim.loop.fs_readlink(path, callback) end

-- Parameters:
-- - `path`: `string`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `path`: `string` or `nil`
-- 
-- Equivalent to `realpath(3)`.
-- 
-- Returns (sync version): `string` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return string
function vim.loop.fs_realpath(path, callback) end

-- Parameters:
-- - `path`: `string`
-- - `new_path`: `string`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `success`: `boolean` or `nil`
-- 
-- Equivalent to `rename(2)`.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_rename(path, new_path, callback) end

-- Parameters:
-- - `path`: `string`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `success`: `boolean` or `nil`
-- 
-- Equivalent to `rmdir(2)`.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_rmdir(path, callback) end

-- Parameters:
-- - `path`: `string`
-- - `callback`: `callable`
--   - `err`: `nil` or `string`
--   - `success`: `uv_fs_t userdata` or `nil`
-- 
-- Equivalent to `scandir(3)`, with a slightly different API.
-- Returns a handle that the user can pass to
-- |uv.fs_scandir_next()|.
-- 
-- Note: This function can be used synchronously or
-- asynchronously. The request userdata is always synchronously
-- returned regardless of whether a callback is provided and the
-- same userdata is passed to the callback if it is provided.
-- 
-- Returns: `uv_fs_t userdata` or `fail`
--- @param callback? fun()
function vim.loop.fs_scandir(path, callback) end

-- Parameters:
-- - `fs`: `uv_fs_t userdata`
-- 
-- Called on a |uv_fs_t| returned by |uv.fs_scandir()| to get the
-- next directory entry data as a `name, type` pair. When there
-- are no more entries, `nil` is returned.
-- 
-- Note: This function only has a synchronous version. See
-- |uv.fs_opendir()| and its related functions for an
-- asynchronous version.
-- 
-- Returns: `string, string` or `nil` or `fail`
--- @return string?, "file"|"link"|"directory"|nil
function vim.loop.fs_scandir_next(fs) end

-- Parameters:
-- - `out_fd`: `integer`
-- - `in_fd`: `integer`
-- - `in_offset`: `integer`
-- - `size`: `integer`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `bytes`: `integer` or `nil`
-- 
-- Limited equivalent to `sendfile(2)`. Returns the number of
-- bytes written.
-- 
-- Returns (sync version): `integer` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return number
function vim.loop.fs_sendfile(out_fd, in_fd, in_offset, size, callback) end

-- Parameters:
-- - `path`: `string`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `stat`: `table` or `nil` (see below)
-- 
-- Equivalent to `stat(2)`.
-- 
-- Returns (sync version): `table` or `fail`
-- - `dev` : `integer`
-- - `mode` : `integer`
-- - `nlink` : `integer`
-- - `uid` : `integer`
-- - `gid` : `integer`
-- - `rdev` : `integer`
-- - `ino` : `integer`
-- - `size` : `integer`
-- - `blksize` : `integer`
-- - `blocks` : `integer`
-- - `flags` : `integer`
-- - `gen` : `integer`
-- - `atime` : `table`
--   - `sec` : `integer`
--   - `nsec` : `integer`
-- - `mtime` : `table`
--   - `sec` : `integer`
--   - `nsec` : `integer`
-- - `ctime` : `table`
--   - `sec` : `integer`
--   - `nsec` : `integer`
-- - `birthtime` : `table`
--   - `sec` : `integer`
--   - `nsec` : `integer`
-- - `type` : `string`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return vim.loop.Stat?
function vim.loop.fs_stat(path, callback) end

-- Parameters:
-- - `path`: `string`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `table` or `nil` (see below)
-- 
-- Equivalent to `statfs(2)`.
-- 
-- Returns `table` or `nil`
-- - `type` : `integer`
-- - `bsize` : `integer`
-- - `blocks` : `integer`
-- - `bfree` : `integer`
-- - `bavail` : `integer`
-- - `files` : `integer`
-- - `ffree` : `integer`
--- @param callback? fun()
function vim.loop.fs_statfs(path, callback) end

-- Parameters:
-- - `path`: `string`
-- - `new_path`: `string`
-- - `flags`: `table`, `integer`, or `nil`
--   - `dir`: `boolean`
--   - `junction`: `boolean`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `success`: `boolean` or `nil`
-- 
-- Equivalent to `symlink(2)`. If the `flags` parameter is
-- omitted, then the 3rd parameter will be treated as the
-- `callback`.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param flags? any
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_symlink(path, new_path, flags, callback) end

-- Parameters:
-- - `path`: `string`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `success`: `boolean` or `nil`
-- 
-- Equivalent to `unlink(2)`.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_unlink(path, callback) end

-- Parameters:
-- - `path`: `string`
-- - `atime`: `number`
-- - `mtime`: `number`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `success`: `boolean` or `nil`
-- 
-- Equivalent to `utime(2)`.
-- 
-- Returns (sync version): `boolean` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param callback? fun()
--- @return boolean
function vim.loop.fs_utime(path, atime, mtime, callback) end

-- Parameters:
-- - `fd`: `integer`
-- - `data`: `buffer`
-- - `offset`: `integer` or `nil`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `bytes`: `integer` or `nil`
-- 
-- Equivalent to `pwritev(2)`. Returns the number of bytes
-- written.
-- 
-- If `offset` is nil or omitted, it will default to `-1`, which
-- indicates "use and update the current file offset."
-- 
-- Note: When `offset` is >= 0, the current file offset will not
-- be updated by the write.
-- 
-- Returns (sync version): `integer` or `fail`
-- 
-- Returns (async version): `uv_fs_t userdata`
--- @param offset? any
--- @param callback? fun()
--- @return number
function vim.loop.fs_write(fd, data, offset, callback) end

-- Gets the amount of memory available to the process in bytes
-- based on limits imposed by the OS. If there is no such
-- constraint, or the constraint is unknown, 0 is returned. Note
-- that it is not unusual for this value to be less than or
-- greater than the total system memory.
-- 
-- Returns: `number`
function vim.loop.get_constrained_memory() end

-- Returns the current free system memory in bytes.
-- 
-- Returns: `number`
function vim.loop.get_free_memory() end

-- Returns the title of the current process.
-- 
-- Returns: `string` or `fail`
function vim.loop.get_process_title() end

-- Returns the current total system memory in bytes.
-- 
-- Returns: `number`
function vim.loop.get_total_memory() end

-- Parameters:
-- - `host`: `string` or `nil`
-- - `service`: `string` or `nil`
-- - `hints`: `table` or `nil`
--   - `family`: `string` or `integer` or `nil`
--   - `socktype`: `string` or `integer` or `nil`
--   - `protocol`: `string` or `integer` or `nil`
--   - `addrconfig`: `boolean` or `nil`
--   - `v4mapped`: `boolean` or `nil`
--   - `all`: `boolean` or `nil`
--   - `numerichost`: `boolean` or `nil`
--   - `passive`: `boolean` or `nil`
--   - `numericserv`: `boolean` or `nil`
--   - `canonname`: `boolean` or `nil`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `addresses`: `table` or `nil` (see below)
-- 
-- Equivalent to `getaddrinfo(3)`. Either `node` or `service` may
-- be `nil` but not both.
-- 
-- Valid hint strings for the keys that take a string:
-- - `family`: `"unix"`, `"inet"`, `"inet6"`, `"ipx"`,
--   `"netlink"`, `"x25"`, `"ax25"`, `"atmpvc"`, `"appletalk"`,
--   or `"packet"`
-- - `socktype`: `"stream"`, `"dgram"`, `"raw"`, `"rdm"`, or
--   `"seqpacket"`
-- - `protocol`: will be looked up using the `getprotobyname(3)`
--   function (examples: `"ip"`, `"icmp"`, `"tcp"`, `"udp"`, etc)
-- 
-- Returns (sync version): `table` or `fail`
-- - `[1, 2, 3, ..., n]` : `table`
--   - `addr` : `string`
--   - `family` : `string`
--   - `port` : `integer` or `nil`
--   - `socktype` : `string`
--   - `protocol` : `string`
--   - `canonname` : `string` or `nil`
-- 
-- Returns (async version): `uv_getaddrinfo_t userdata` or `fail`
--- @param hints? any
--- @param callback? fun()
--- @return table
function vim.loop.getaddrinfo(host, service, hints, callback) end

-- Returns the group ID of the process.
-- 
-- Returns: `integer`
-- 
-- Note: This is not a libuv function and is not supported on
-- Windows.
--- @return number
function vim.loop.getgid() end

-- Parameters:
-- - `address`: `table`
--   - `ip`: `string` or `nil`
--   - `port`: `integer` or `nil`
--   - `family`: `string` or `integer` or `nil`
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `host`: `string` or `nil`
--   - `service`: `string` or `nil`
-- 
-- Equivalent to `getnameinfo(3)`.
-- 
-- When specified, `family` must be one of `"unix"`, `"inet"`,
-- `"inet6"`, `"ipx"`, `"netlink"`, `"x25"`, `"ax25"`,
-- `"atmpvc"`, `"appletalk"`, or `"packet"`.
-- 
-- Returns (sync version): `string, string` or `fail`
-- 
-- Returns (async version): `uv_getnameinfo_t userdata` or `fail`
--- @param callback? fun()
--- @return string, string
function vim.loop.getnameinfo(address, callback) end

-- DEPRECATED: Please use |uv.os_getpid()| instead.
function vim.loop.getpid() end

-- Returns the resource usage.
-- 
-- Returns: `table` or `fail`
-- - `utime` : `table` (user CPU time used)
--   - `sec` : `integer`
--   - `usec` : `integer`
-- - `stime` : `table` (system CPU time used)
--   - `sec` : `integer`
--   - `usec` : `integer`
-- - `maxrss` : `integer` (maximum resident set size)
-- - `ixrss` : `integer` (integral shared memory size)
-- - `idrss` : `integer` (integral unshared data size)
-- - `isrss` : `integer` (integral unshared stack size)
-- - `minflt` : `integer` (page reclaims (soft page faults))
-- - `majflt` : `integer` (page faults (hard page faults))
-- - `nswap` : `integer` (swaps)
-- - `inblock` : `integer` (block input operations)
-- - `oublock` : `integer` (block output operations)
-- - `msgsnd` : `integer` (IPC messages sent)
-- - `msgrcv` : `integer` (IPC messages received)
-- - `nsignals` : `integer` (signals received)
-- - `nvcsw` : `integer` (voluntary context switches)
-- - `nivcsw` : `integer` (involuntary context switches)
--- @return table
function vim.loop.getrusage() end

-- Cross-platform implementation of `gettimeofday(2)`. Returns
-- the seconds and microseconds of a unix time as a pair.
-- 
-- Returns: `integer, integer` or `fail`
function vim.loop.gettimeofday() end

-- Returns the user ID of the process.
-- 
-- Returns: `integer`
-- 
-- Note: This is not a libuv function and is not supported on
-- Windows.
--- @return number
function vim.loop.getuid() end

-- Parameters:
-- - `fd`: `integer`
-- 
-- Used to detect what type of stream should be used with a given
-- file descriptor `fd`. Usually this will be used during
-- initialization to guess the type of the stdio streams.
-- 
-- Returns: `string`
function vim.loop.guess_handle(fd) end

-- > method form `handle:get_type()`
-- 
-- Parameters:
-- - `handle`: `userdata` for sub-type of |uv_handle_t|
-- 
-- Returns the name of the struct for a given handle (e.g.
-- `"pipe"` for |uv_pipe_t|) and the libuv enum integer for the
-- handle's type (`uv_handle_type`).
-- 
-- Returns: `string, integer`
function vim.loop.handle_get_type(handle) end

-- > method form `handle:has_ref()`
-- 
-- Parameters:
-- - `handle`: `userdata` for sub-type of |uv_handle_t|
-- 
-- Returns `true` if the handle referenced, `false` if not.
-- 
-- Returns: `boolean` or `fail`
-- 
-- See |luv-reference-counting|.
--- @return boolean
function vim.loop.has_ref(handle) end

-- Returns a current high-resolution time in nanoseconds as a
-- number. This is relative to an arbitrary time in the past. It
-- is not related to the time of day and therefore not subject to
-- clock drift. The primary use is for measuring time between
-- intervals.
-- 
-- Returns: `number`
function vim.loop.hrtime() end

-- > method form `idle:start(callback)`
-- 
-- Parameters:
-- - `idle`: `uv_idle_t userdata`
-- - `callback`: `callable`
-- 
-- Start the handle with the given callback.
-- 
-- Returns: `0` or `fail`
--- @param callback fun()
function vim.loop.idle_start(idle, callback) end

-- > method form `idle:stop()`
-- 
-- Parameters:
-- - `idle`: `uv_idle_t userdata`
-- 
-- Stop the handle, the callback will no longer be called.
-- 
-- Returns: `0` or `fail`
function vim.loop.idle_stop(check) end

-- Parameters:
-- - `ifindex`: `integer`
-- 
-- Retrieves a network interface identifier suitable for use in
-- an IPv6 scoped address. On Windows, returns the numeric
-- `ifindex` as a string. On all other platforms,
-- |uv.if_indextoname()| is used.
-- 
-- Returns: `string` or `fail`
function vim.loop.if_indextoiid(ifindex) end

-- Parameters:
-- - `ifindex`: `integer`
-- 
-- IPv6-capable implementation of `if_indextoname(3)`.
-- 
-- Returns: `string` or `fail`
function vim.loop.if_indextoname(ifindex) end

-- Returns address information about the network interfaces on
-- the system in a table. Each table key is the name of the
-- interface while each associated value is an array of address
-- information where fields are `ip`, `family`, `netmask`,
-- `internal`, and `mac`.
-- 
-- Returns: `table`
-- - `[name(s)]` : `table`
--   - `ip` : `string`
--   - `family` : `string`
--   - `netmask` : `string`
--   - `internal` : `boolean`
--   - `mac` : `string`
--- @return table
function vim.loop.interface_addresses() end

-- > method form `handle:is_active()`
-- 
-- Parameters:
-- - `handle`: `userdata` for sub-type of |uv_handle_t|
-- 
-- Returns `true` if the handle is active, `false` if it's
-- inactive. What "active” means depends on the type of handle:
-- 
--   - A |uv_async_t| handle is always active and cannot be
--     deactivated, except by closing it with |uv.close()|.
-- 
--   - A |uv_pipe_t|, |uv_tcp_t|, |uv_udp_t|, etc.
--     handle - basically any handle that deals with I/O - is
--     active when it is doing something that involves I/O, like
--     reading, writing, connecting, accepting new connections,
--     etc.
-- 
--   - A |uv_check_t|, |uv_idle_t|, |uv_timer_t|,
--     etc. handle is active when it has been started with a call
--     to |uv.check_start()|, |uv.idle_start()|,
--     |uv.timer_start()| etc. until it has been stopped with a
--     call to its respective stop function.
-- 
-- Returns: `boolean` or `fail`
function vim.loop.is_active(handle) end

-- > method form `handle:is_closing()`
-- 
-- Parameters:
-- - `handle`: `userdata` for sub-type of |uv_handle_t|
-- 
-- Returns `true` if the handle is closing or closed, `false`
-- otherwise.
-- 
-- Returns: `boolean` or `fail`
-- 
-- Note: This function should only be used between the
-- initialization of the handle and the arrival of the close
-- callback.
--- @return boolean
function vim.loop.is_closing(handle) end

-- > method form `stream:is_readable()`
-- 
-- Parameters:
-- - `stream`: `userdata` for sub-type of |uv_stream_t|
-- 
-- Returns `true` if the stream is readable, `false` otherwise.
-- 
-- Returns: `boolean`
function vim.loop.is_readable(stream) end

-- > method form `stream:is_writable()`
-- 
-- Parameters:
-- - `stream`: `userdata` for sub-type of |uv_stream_t|
-- 
-- Returns `true` if the stream is writable, `false` otherwise.
-- 
-- Returns: `boolean`
function vim.loop.is_writable(stream) end

-- Parameters:
-- - `pid`: `integer`
-- - `signum`: `integer` or `string`
-- 
-- Sends the specified signal to the given PID. Check the
-- documentation on |uv_signal_t| for signal support, specially
-- on Windows.
-- 
-- Returns: `0` or `fail`
function vim.loop.kill(pid, signum) end

-- > method form `stream:listen(backlog, callback)`
-- 
-- Parameters:
-- - `stream`: `userdata` for sub-type of |uv_stream_t|
-- - `backlog`: `integer`
-- - `callback`: `callable`
--   - `err`: `nil` or `string`
-- 
-- Start listening for incoming connections. `backlog` indicates
-- the number of connections the kernel might queue, same as
-- `listen(2)`. When a new incoming connection is received the
-- callback is called.
-- 
-- Returns: `0` or `fail`
--- @param callback fun()
function vim.loop.listen(stream, backlog, callback) end

-- Returns the load average as a triad. Not supported on Windows.
-- 
-- Returns: `number, number, number`
function vim.loop.loadavg() end

-- Returns `true` if there are referenced active handles, active
-- requests, or closing handles in the loop; otherwise, `false`.
-- 
-- Returns: `boolean` or `fail`
function vim.loop.loop_alive() end

-- Closes all internal loop resources. In normal execution, the
-- loop will automatically be closed when it is garbage collected
-- by Lua, so it is not necessary to explicitly call
-- `loop_close()`. Call this function only after the loop has
-- finished executing and all open handles and requests have been
-- closed, or it will return `EBUSY`.
-- 
-- Returns: `0` or `fail`
function vim.loop.loop_close() end

-- Parameters:
-- - `option`: `string`
-- - `...`: depends on `option`, see below
-- 
-- Set additional loop options. You should normally call this
-- before the first call to uv_run() unless mentioned otherwise.
-- 
-- Supported options:
-- 
--   - `"block_signal"`: Block a signal when polling for new
--     events. The second argument to loop_configure() is the
--     signal name (as a lowercase string) or the signal number.
--     This operation is currently only implemented for
--     `"sigprof"` signals, to suppress unnecessary wakeups when
--     using a sampling profiler. Requesting other signals will
--     fail with `EINVAL`.
--   - `"metrics_idle_time"`: Accumulate the amount of idle time
--     the event loop spends in the event provider. This option
--     is necessary to use `metrics_idle_time()`.
-- 
-- An example of a valid call to this function is:
-- 
-- ```lua
--     uv.loop_configure("block_signal", "sigprof")
-- ```
-- 
-- Returns: `0` or `fail`
-- 
-- Note: Be prepared to handle the `ENOSYS` error; it means the
-- loop option is not supported by the platform.
--- @return 0
function vim.loop.loop_configure(option, ...) end

-- If the loop is running, returns a string indicating the mode
-- in use. If the loop is not running, `nil` is returned instead.
-- 
-- Returns: `string` or `nil`
function vim.loop.loop_mode() end

-- Retrieve the amount of time the event loop has been idle in
-- the kernel’s event provider (e.g. `epoll_wait`). The call is
-- thread safe.
-- 
-- The return value is the accumulated time spent idle in the
-- kernel’s event provider starting from when the |uv_loop_t| was
-- configured to collect the idle time.
-- 
-- Note: The event loop will not begin accumulating the event
-- provider’s idle time until calling `loop_configure` with
-- `"metrics_idle_time"`.
-- 
-- Returns: `number`
function vim.loop.metrics_idle_time() end

-- Parameters:
-- - `callback`: `callable` or `nil`
--   - `...`: `threadargs` passed to/from
--     `uv.async_send(async, ...)`
-- 
-- Creates and initializes a new |uv_async_t|. Returns the Lua
-- userdata wrapping it. A `nil` callback is allowed.
-- 
-- Returns: `uv_async_t userdata` or `fail`
-- 
-- Note: Unlike other handle initialization functions, this
-- immediately starts the handle.
--- @param callback? fun()
--- @return userdata
function vim.loop.new_async(callback) end

-- Creates and initializes a new |uv_check_t|. Returns the Lua
-- userdata wrapping it.
-- 
-- Returns: `uv_check_t userdata` or `fail`
--- @return vim.loop.Check
function vim.loop.new_check() end

-- Creates and initializes a new |uv_fs_event_t|. Returns the Lua
-- userdata wrapping it.
-- 
-- Returns: `uv_fs_event_t userdata` or `fail`
function vim.loop.new_fs_event() end

-- Creates and initializes a new |uv_fs_poll_t|. Returns the Lua
-- userdata wrapping it.
-- 
-- Returns: `uv_fs_poll_t userdata` or `fail`
function vim.loop.new_fs_poll() end

-- Creates and initializes a new |uv_idle_t|. Returns the Lua
-- userdata wrapping it.
-- 
-- Returns: `uv_idle_t userdata` or `fail`
function vim.loop.new_idle() end

-- Parameters:
-- - `ipc`: `boolean` or `nil` (default: `false`)
-- 
-- Creates and initializes a new |uv_pipe_t|. Returns the Lua
-- userdata wrapping it. The `ipc` argument is a boolean to
-- indicate if this pipe will be used for handle passing between
-- processes.
-- 
-- Returns: `uv_pipe_t userdata` or `fail`
--- @param ipc? any
--- @return vim.loop.Pipe
function vim.loop.new_pipe(ipc) end

-- Parameters:
-- - `fd`: `integer`
-- 
-- Initialize the handle using a file descriptor.
-- 
-- The file descriptor is set to non-blocking mode.
-- 
-- Returns: `uv_poll_t userdata` or `fail`
function vim.loop.new_poll(fd) end

-- Creates and initializes a new |uv_prepare_t|. Returns the Lua
-- userdata wrapping it.
-- 
-- Returns: `uv_prepare_t userdata` or `fail`
--- @return vim.loop.Prepare
function vim.loop.new_prepare() end

-- Creates and initializes a new |uv_signal_t|. Returns the Lua
-- userdata wrapping it.
-- 
-- Returns: `uv_signal_t userdata` or `fail`
function vim.loop.new_signal() end

-- Parameters:
-- - `fd`: `integer`
-- 
-- Initialize the handle using a socket descriptor. On Unix this
-- is identical to |uv.new_poll()|. On windows it takes a SOCKET
-- handle.
-- 
-- The socket is set to non-blocking mode.
-- 
-- Returns: `uv_poll_t userdata` or `fail`
function vim.loop.new_socket_poll(fd) end

-- Parameters:
-- - `flags`: `string` or `nil`
-- 
-- Creates and initializes a new |uv_tcp_t|. Returns the Lua
-- userdata wrapping it. Flags may be a family string: `"unix"`,
-- `"inet"`, `"inet6"`, `"ipx"`, `"netlink"`, `"x25"`, `"ax25"`,
-- `"atmpvc"`, `"appletalk"`, or `"packet"`.
-- 
-- Returns: `uv_tcp_t userdata` or `fail`
--- @param flags? any
--- @return vim.loop.TCP
function vim.loop.new_tcp(flags) end

-- Parameters:
-- - `options`: `table` or `nil`
--   - `stack_size`: `integer` or `nil`
-- - `entry`: `function`
-- - `...`: `threadargs` passed to `entry`
-- 
-- Creates and initializes a `luv_thread_t` (not `uv_thread_t`).
-- Returns the Lua userdata wrapping it and asynchronously
-- executes `entry`, which can be either a Lua function or a Lua
-- function dumped to a string. Additional arguments `...` are
-- passed to the `entry` function and an optional `options` table
-- may be provided. Currently accepted `option` fields are
-- `stack_size`.
-- 
-- Returns: `luv_thread_t userdata` or `fail`
--- @param options? table<string, any>
--- @param entry? any
--- @param ...? any
function vim.loop.new_thread(options, entry, ...) end

-- Creates and initializes a new |uv_timer_t|. Returns the Lua
-- userdata wrapping it.
-- 
-- Returns: `uv_timer_t userdata` or `fail`
-- 
-- ```lua
--     -- Creating a simple setTimeout wrapper
--     local function setTimeout(timeout, callback)
--       local timer = uv.new_timer()
--       timer:start(timeout, 0, function ()
--         timer:stop()
--         timer:close()
--         callback()
--       end)
--       return timer
--     end
-- 
--     -- Creating a simple setInterval wrapper
--     local function setInterval(interval, callback)
--       local timer = uv.new_timer()
--       timer:start(interval, interval, function ()
--         callback()
--       end)
--       return timer
--     end
-- 
--     -- And clearInterval
--     local function clearInterval(timer)
--       timer:stop()
--       timer:close()
--     end
-- ```
--- @return vim.loop.Timer
function vim.loop.new_timer() end

-- Parameters:
-- - `fd`: `integer`
-- - `readable`: `boolean`
-- 
-- Initialize a new TTY stream with the given file descriptor.
-- Usually the file descriptor will be:
-- 
--  - 0 - stdin
--  - 1 - stdout
--  - 2 - stderr
-- 
-- On Unix this function will determine the path of the fd of the
-- terminal using ttyname_r(3), open it, and use it if the passed
-- file descriptor refers to a TTY. This lets libuv put the tty
-- in non-blocking mode without affecting other processes that
-- share the tty.
-- 
-- This function is not thread safe on systems that don’t support
-- ioctl TIOCGPTN or TIOCPTYGNAME, for instance OpenBSD and
-- Solaris.
-- 
-- Returns: `uv_tty_t userdata` or `fail`
-- 
-- Note: If reopening the TTY fails, libuv falls back to blocking
-- writes.
--- @return userdata
function vim.loop.new_tty(fd, readable) end

-- Parameters:
-- - `flags`: `table` or `nil`
--   - `family`: `string` or `nil`
--   - `mmsgs`: `integer` or `nil` (default: `1`)
-- 
-- Creates and initializes a new |uv_udp_t|. Returns the Lua
-- userdata wrapping it. The actual socket is created lazily.
-- 
-- When specified, `family` must be one of `"unix"`, `"inet"`,
-- `"inet6"`, `"ipx"`, `"netlink"`, `"x25"`, `"ax25"`,
-- `"atmpvc"`, `"appletalk"`, or `"packet"`.
-- 
-- When specified, `mmsgs` determines the number of messages able
-- to be received at one time via `recvmmsg(2)` (the allocated
-- buffer will be sized to be able to fit the specified number of
-- max size dgrams). Only has an effect on platforms that support
-- `recvmmsg(2)`.
-- 
-- Note: For backwards compatibility reasons, `flags` can also be
-- a string or integer. When it is a string, it will be treated
-- like the `family` key above. When it is an integer, it will be
-- used directly as the `flags` parameter when calling
-- `uv_udp_init_ex`.
-- 
-- Returns: `uv_udp_t userdata` or `fail`
--- @param flags? any
function vim.loop.new_udp(flags) end

-- Parameters:
-- - `work_callback`: `function`
--   - `...`: `threadargs` passed to/from
--     `uv.queue_work(work_ctx, ...)`
-- - `after_work_callback`: `function`
--   - `...`: `threadargs` returned from `work_callback`
-- 
-- Creates and initializes a new `luv_work_ctx_t` (not
-- `uv_work_t`). Returns the Lua userdata wrapping it.
-- 
-- Returns: `luv_work_ctx_t userdata`
function vim.loop.new_work(work_callback, after_work_callback) end

-- Returns the current timestamp in milliseconds. The timestamp
-- is cached at the start of the event loop tick, see
-- |uv.update_time()| for details and rationale.
-- 
-- The timestamp increases monotonically from some arbitrary
-- point in time. Don't make assumptions about the starting
-- point, you will only get disappointed.
-- 
-- Returns: `integer`
-- 
-- Note: Use |uv.hrtime()| if you need sub-millisecond
-- granularity.
--- @return number
function vim.loop.now() end

-- Returns all environmental variables as a dynamic table of
-- names associated with their corresponding values.
-- 
-- Returns: `table`
-- 
-- WARNING: This function is not thread safe.
--- @return table
function vim.loop.os_environ() end

-- Returns password file information.
-- 
-- Returns: `table`
-- - `username` : `string`
-- - `uid` : `integer`
-- - `gid` : `integer`
-- - `shell` : `string`
-- - `homedir` : `string`
--- @return table
function vim.loop.os_get_passwd() end

-- Parameters:
-- - `name`: `string`
-- - `size`: `integer` (default = `LUAL_BUFFERSIZE`)
-- 
-- Returns the environment variable specified by `name` as
-- string. The internal buffer size can be set by defining
-- `size`. If omitted, `LUAL_BUFFERSIZE` is used. If the
-- environment variable exceeds the storage available in the
-- internal buffer, `ENOBUFS` is returned. If no matching
-- environment variable exists, `ENOENT` is returned.
-- 
-- Returns: `string` or `fail`
-- 
-- WARNING: This function is not thread safe.
--- @param size? any
--- @return string
function vim.loop.os_getenv(name, size) end

-- Returns the hostname.
-- 
-- Returns: `string`
function vim.loop.os_gethostname() end

-- Returns the current process ID.
-- 
-- Returns: `number`
function vim.loop.os_getpid() end

-- Returns the parent process ID.
-- 
-- Returns: `number`
function vim.loop.os_getppid() end

-- Parameters:
-- - `pid`: `integer`
-- 
-- Returns the scheduling priority of the process specified by
-- `pid`.
-- 
-- Returns: `number` or `fail`
function vim.loop.os_getpriority(pid) end

-- Returns: `string` or `fail`
-- 
-- WARNING: This function is not thread safe.
--- @return string
function vim.loop.os_homedir() end

-- Parameters:
-- - `name`: `string`
-- - `value`: `string`
-- 
-- Sets the environmental variable specified by `name` with the
-- string `value`.
-- 
-- Returns: `boolean` or `fail`
-- 
-- WARNING: This function is not thread safe.
--- @return boolean
function vim.loop.os_setenv(name, value) end

-- Parameters:
-- - `pid`: `integer`
-- - `priority`: `integer`
-- 
-- Sets the scheduling priority of the process specified by
-- `pid`. The `priority` range is between -20 (high priority) and
-- 19 (low priority).
-- 
-- Returns: `boolean` or `fail`
function vim.loop.os_setpriority(pid, priority) end

-- Returns: `string` or `fail`
-- 
-- WARNING: This function is not thread safe.
--- @return string
function vim.loop.os_tmpdir() end

-- Returns system information.
-- 
-- Returns: `table`
-- - `sysname` : `string`
-- - `release` : `string`
-- - `version` : `string`
-- - `machine` : `string`
--- @return table
function vim.loop.os_uname() end

-- Returns: `boolean` or `fail`
-- 
-- WARNING: This function is not thread safe.
--- @return boolean
function vim.loop.os_unsetenv() end

-- Parameters:
-- - `read_flags`: `table` or `nil`
--   - `nonblock`: `boolean` (default: `false`)
-- - `write_flags`: `table` or `nil`
--   - `nonblock`: `boolean` (default: `false`)
-- 
-- Create a pair of connected pipe handles. Data may be written
-- to the `write` fd and read from the `read` fd. The resulting
-- handles can be passed to `pipe_open`, used with `spawn`, or
-- for any other purpose.
-- 
-- Flags:
--  - `nonblock`: Opens the specified socket handle for
--    `OVERLAPPED` or `FIONBIO`/`O_NONBLOCK` I/O usage. This is
--    recommended for handles that will be used by libuv, and not
--    usually recommended otherwise.
-- 
-- Equivalent to `pipe(2)` with the `O_CLOEXEC` flag set.
-- 
-- Returns: `table` or `fail`
-- - `read` : `integer` (file descriptor)
-- - `write` : `integer` (file descriptor)
-- 
-- ```lua
--     -- Simple read/write with pipe_open
--     local fds = uv.pipe({nonblock=true}, {nonblock=true})
-- 
--     local read_pipe = uv.new_pipe()
--     read_pipe:open(fds.read)
-- 
--     local write_pipe = uv.new_pipe()
--     write_pipe:open(fds.write)
-- 
--     write_pipe:write("hello")
--     read_pipe:read_start(function(err, chunk)
--       assert(not err, err)
--       print(chunk)
--     end)
-- ```
--- @return table
function vim.loop.pipe(read_flags, write_flags) end

-- > method form `pipe:bind(name)`
-- 
-- Parameters:
-- - `pipe`: `uv_pipe_t userdata`
-- - `name`: `string`
-- 
-- Bind the pipe to a file path (Unix) or a name (Windows).
-- 
-- Returns: `0` or `fail`
-- 
-- Note: Paths on Unix get truncated to
-- sizeof(sockaddr_un.sun_path) bytes, typically between 92 and
-- 108 bytes.
--- @return 0
function vim.loop.pipe_bind(pipe, name) end

-- > method form `pipe:chmod(flags)`
-- 
-- Parameters:
-- - `pipe`: `uv_pipe_t userdata`
-- - `flags`: `string`
-- 
-- Alters pipe permissions, allowing it to be accessed from
-- processes run by different users. Makes the pipe writable or
-- readable by all users. `flags` are: `"r"`, `"w"`, `"rw"`, or
-- `"wr"` where `r` is `READABLE` and `w` is `WRITABLE`. This
-- function is blocking.
-- 
-- Returns: `0` or `fail`
function vim.loop.pipe_chmod(pipe, flags) end

-- > method form `pipe:connect(name, [callback])`
-- 
-- Parameters:
-- - `pipe`: `uv_pipe_t userdata`
-- - `name`: `string`
-- - `callback`: `callable` or `nil`
--   - `err`: `nil` or `string`
-- 
-- Connect to the Unix domain socket or the named pipe.
-- 
-- Returns: `uv_connect_t userdata` or `fail`
-- 
-- Note: Paths on Unix get truncated to
-- sizeof(sockaddr_un.sun_path) bytes, typically between 92 and
-- 108 bytes.
--- @param callback? fun()
--- @return userdata
function vim.loop.pipe_connect(pipe, name, callback) end

-- > method form `pipe:getpeername()`
-- 
-- Parameters:
-- - `pipe`: `uv_pipe_t userdata`
-- 
-- Get the name of the Unix domain socket or the named pipe to
-- which the handle is connected.
-- 
-- Returns: `string` or `fail`
function vim.loop.pipe_getpeername(pipe) end

-- > method form `pipe:getsockname()`
-- 
-- Parameters:
-- - `pipe`: `uv_pipe_t userdata`
-- 
-- Get the name of the Unix domain socket or the named pipe.
-- 
-- Returns: `string` or `fail`
function vim.loop.pipe_getsockname(pipe) end

-- > method form `pipe:open(fd)`
-- 
-- Parameters:
-- - `pipe`: `uv_pipe_t userdata`
-- - `fd`: `integer`
-- 
-- Open an existing file descriptor or |uv_handle_t| as a
-- pipe.
-- 
-- Returns: `0` or `fail`
-- 
-- Note: The file descriptor is set to non-blocking mode.
--- @return 0
function vim.loop.pipe_open(pipe, fd) end

-- > method form `pipe:pending_count()`
-- 
-- Parameters:
-- - `pipe`: `uv_pipe_t userdata`
-- 
-- Returns the pending pipe count for the named pipe.
-- 
-- Returns: `integer`
function vim.loop.pipe_pending_count(pipe) end

-- > method form `pipe:pending_instances(count)`
-- 
-- Parameters:
-- - `pipe`: `uv_pipe_t userdata`
-- - `count`: `integer`
-- 
-- Set the number of pending pipe instance handles when the pipe
-- server is waiting for connections.
-- 
-- Returns: Nothing.
-- 
-- Note: This setting applies to Windows only.
function vim.loop.pipe_pending_instances(pipe, count) end

-- > method form `pipe:pending_type()`
-- 
-- Parameters:
-- - `pipe`: `uv_pipe_t userdata`
-- 
-- Used to receive handles over IPC pipes.
-- 
-- First - call |uv.pipe_pending_count()|, if it's > 0 then
-- initialize a handle of the given type, returned by
-- `uv.pipe_pending_type()` and call `uv.accept(pipe, handle)` .
-- 
-- Returns: `string`
function vim.loop.pipe_pending_type(pipe) end

-- > method form `poll:start(events, callback)`
-- 
-- Parameters:
-- - `poll`: `uv_poll_t userdata`
-- - `events`: `string` or `nil` (default: `"rw"`)
-- - `callback`: `callable`
--   - `err`: `nil` or `string`
--   - `events`: `string` or `nil`
-- 
-- Starts polling the file descriptor. `events` are: `"r"`,
-- `"w"`, `"rw"`, `"d"`, `"rd"`, `"wd"`, `"rwd"`, `"p"`, `"rp"`,
-- `"wp"`, `"rwp"`, `"dp"`, `"rdp"`, `"wdp"`, or `"rwdp"` where
-- `r` is `READABLE`, `w` is `WRITABLE`, `d` is `DISCONNECT`, and
-- `p` is `PRIORITIZED`. As soon as an event is detected the
-- callback will be called with status set to 0, and the detected
-- events set on the events field.
-- 
-- The user should not close the socket while the handle is
-- active. If the user does that anyway, the callback may be
-- called reporting an error status, but this is not guaranteed.
-- 
-- Returns: `0` or `fail`
-- 
-- Note Calling `uv.poll_start()` on a handle that is already
-- active is fine. Doing so will update the events mask that is
-- being watched for.
--- @param callback fun()
--- @return 0
function vim.loop.poll_start(poll, events, callback) end

-- > method form `poll:stop()`
-- 
-- Parameters:
-- - `poll`: `uv_poll_t userdata`
-- 
-- Stop polling the file descriptor, the callback will no longer
-- be called.
-- 
-- Returns: `0` or `fail`
function vim.loop.poll_stop(poll) end

-- > method form `prepare:start(callback)`
-- 
-- Parameters:
-- - `prepare`: `uv_prepare_t userdata`
-- - `callback`: `callable`
-- 
-- Start the handle with the given callback.
-- 
-- Returns: `0` or `fail`
--- @param callback fun()
function vim.loop.prepare_start(prepare, callback) end

-- > method form `prepare:stop()`
-- 
-- Parameters:
-- - `prepare`: `uv_prepare_t userdata`
-- 
-- Stop the handle, the callback will no longer be called.
-- 
-- Returns: `0` or `fail`
function vim.loop.prepare_stop(prepare) end

-- The same as |uv.print_all_handles()| except only active
-- handles are printed.
-- 
-- Returns: Nothing.
-- 
-- Note: This is not available on Windows.
-- 
-- WARNING: This function is meant for ad hoc debugging, there
-- are no API/ABI stability guarantees.
function vim.loop.print_active_handles() end

-- Prints all handles associated with the main loop to stderr.
-- The format is `[flags] handle-type handle-address` . Flags are
-- `R` for referenced, `A` for active and `I` for internal.
-- 
-- Returns: Nothing.
-- 
-- Note: This is not available on Windows.
-- 
-- WARNING: This function is meant for ad hoc debugging, there
-- are no API/ABI stability guarantees.
function vim.loop.print_all_handles() end

-- > method form `process:get_pid()`
-- 
-- Parameters:
-- - `process`: `uv_process_t userdata`
-- 
-- Returns the handle's pid.
-- 
-- Returns: `integer`
function vim.loop.process_get_pid(process) end

-- > method form `process:kill(signum)`
-- 
-- Parameters:
-- - `process`: `uv_process_t userdata`
-- - `signum`: `integer` or `string`
-- 
-- Sends the specified signal to the given process handle. Check
-- the documentation on |uv_signal_t| for signal support,
-- specially on Windows.
-- 
-- Returns: `0` or `fail`
function vim.loop.process_kill(process, signum) end

-- > method form `work_ctx:queue(...)`
-- 
-- Parameters:
-- - `work_ctx`: `luv_work_ctx_t userdata`
-- - `...`: `threadargs`
-- 
-- Queues a work request which will run `work_callback` in a new
-- Lua state in a thread from the threadpool with any additional
-- arguments from `...`. Values returned from `work_callback` are
-- passed to `after_work_callback`, which is called in the main
-- loop thread.
-- 
-- Returns: `boolean` or `fail`
function vim.loop.queue_work(work_ctx, ...) end

-- Parameters:
-- - `len`: `integer`
-- - `flags`: `nil` (see below)
-- - `callback`: `callable` (async version) or `nil` (sync
--   version)
--   - `err`: `nil` or `string`
--   - `bytes`: `string` or `nil`
-- 
-- Fills a string of length `len` with cryptographically strong
-- random bytes acquired from the system CSPRNG. `flags` is
-- reserved for future extension and must currently be `nil` or
-- `0` or `{}`.
-- 
-- Short reads are not possible. When less than `len` random
-- bytes are available, a non-zero error value is returned or
-- passed to the callback. If the callback is omitted, this
-- function is completed synchronously.
-- 
-- The synchronous version may block indefinitely when not enough
-- entropy is available. The asynchronous version may not ever
-- finish when the system is low on entropy.
-- 
-- Returns (sync version): `string` or `fail`
-- 
-- Returns (async version): `0` or `fail`
--- @param callback? fun()
--- @return string
function vim.loop.random(len, flags, callback) end

-- > method form `stream:read_start(callback)`
-- 
-- Parameters:
-- - `stream`: `userdata` for sub-type of |uv_stream_t|
-- - `callback`: `callable`
--   - `err`: `nil` or `string`
--   - `data`: `string` or `nil`
-- 
-- Read data from an incoming stream. The callback will be made
-- several times until there is no more data to read or
-- |uv.read_stop()| is called. When we've reached EOF, `data`
-- will be `nil`.
-- 
-- Returns: `0` or `fail`
-- 
-- ```lua
--     stream:read_start(function (err, chunk)
--       if err then
--         -- handle read error
--       elseif chunk then
--         -- handle data
--       else
--         -- handle disconnect
--       end
--     end)
-- ```
--- @param callback fun()
--- @return 0
function vim.loop.read_start(stream, callback) end

-- > method form `stream:read_stop()`
-- 
-- Parameters:
-- - `stream`: `userdata` for sub-type of |uv_stream_t|
-- 
-- Stop reading data from the stream. The read callback will no
-- longer be called.
-- 
-- This function is idempotent and may be safely called on a
-- stopped stream.
-- 
-- Returns: `0` or `fail`
function vim.loop.read_stop(stream) end

-- > method form `handle:recv_buffer_size([size])`
-- 
-- Parameters:
-- - `handle`: `userdata` for sub-type of |uv_handle_t|
-- - `size`: `integer` or `nil` (default: `0`)
-- 
-- Gets or sets the size of the receive buffer that the operating
-- system uses for the socket.
-- 
-- If `size` is omitted (or `0`), this will return the current
-- send buffer size; otherwise, this will use `size` to set the
-- new send buffer size.
-- 
-- This function works for TCP, pipe and UDP handles on Unix and
-- for TCP and UDP handles on Windows.
-- 
-- Returns:
-- - `integer` or `fail` (if `size` is `nil` or `0`)
-- - `0` or `fail` (if `size` is not `nil` and not `0`)
-- 
-- Note: Linux will set double the size and return double the
-- size of the original set value.
--- @param size? any
function vim.loop.recv_buffer_size(handle, size) end

-- > method form `handle:ref()`
-- 
-- Parameters:
-- - `handle`: `userdata` for sub-type of |uv_handle_t|
-- 
-- Reference the given handle. References are idempotent, that
-- is, if a handle is already referenced calling this function
-- again will have no effect.
-- 
-- Returns: Nothing.
-- 
-- See |luv-reference-counting|.
function vim.loop.ref(handle) end

-- > method form `req:get_type()`
-- 
-- Parameters:
-- - `req`: `userdata` for sub-type of |uv_req_t|
-- 
-- Returns the name of the struct for a given request (e.g.
-- `"fs"` for |uv_fs_t|) and the libuv enum integer for the
-- request's type (`uv_req_type`).
-- 
-- Returns: `string, integer`
function vim.loop.req_get_type(req) end

-- Returns the resident set size (RSS) for the current process.
-- 
-- Returns: `integer` or `fail`
function vim.loop.resident_set_memory() end

-- Parameters:
-- - `mode`: `string` or `nil` (default: `"default"`)
-- 
-- This function runs the event loop. It will act differently
-- depending on the specified mode:
-- 
--   - `"default"`: Runs the event loop until there are no more
--     active and referenced handles or requests. Returns `true`
--     if |uv.stop()| was called and there are still active
--     handles or requests. Returns `false` in all other cases.
-- 
--   - `"once"`: Poll for I/O once. Note that this function
--     blocks if there are no pending callbacks. Returns `false`
--     when done (no active handles or requests left), or `true`
--     if more callbacks are expected (meaning you should run the
--     event loop again sometime in the future).
-- 
--   - `"nowait"`: Poll for I/O once but don't block if there are
--     no pending callbacks. Returns `false` if done (no active
--     handles or requests left), or `true` if more callbacks are
--     expected (meaning you should run the event loop again
--     sometime in the future).
-- 
-- Returns: `boolean` or `fail`
-- 
-- Note: Luvit will implicitly call `uv.run()` after loading user
-- code, but if you use the luv bindings directly, you need to
-- call this after registering your initial set of event
-- callbacks to start the event loop.
--- @param mode? any
--- @return boolean
function vim.loop.run(mode) end

-- > method form `handle:send_buffer_size([size])`
-- 
-- Parameters:
-- - `handle`: `userdata` for sub-type of |uv_handle_t|
-- - `size`: `integer` or `nil` (default: `0`)
-- 
-- Gets or sets the size of the send buffer that the operating
-- system uses for the socket.
-- 
-- If `size` is omitted (or `0`), this will return the current
-- send buffer size; otherwise, this will use `size` to set the
-- new send buffer size.
-- 
-- This function works for TCP, pipe and UDP handles on Unix and
-- for TCP and UDP handles on Windows.
-- 
-- Returns:
-- - `integer` or `fail` (if `size` is `nil` or `0`)
-- - `0` or `fail` (if `size` is not `nil` and not `0`)
-- 
-- Note: Linux will set double the size and return double the
-- size of the original set value.
--- @param size? any
function vim.loop.send_buffer_size(handle, size) end

-- Parameters:
-- - `title`: `string`
-- 
-- Sets the title of the current process with the string `title`.
-- 
-- Returns: `0` or `fail`
function vim.loop.set_process_title(title) end

-- Parameters:
-- - `id`: `integer`
-- 
-- Sets the group ID of the process with the integer `id`.
-- 
-- Returns: Nothing.
-- 
-- Note: This is not a libuv function and is not supported on
-- Windows.
function vim.loop.setgid(id) end

-- Parameters:
-- - `id`: `integer`
-- 
-- Sets the user ID of the process with the integer `id`.
-- 
-- Returns: Nothing.
-- 
-- Note: This is not a libuv function and is not supported on
-- Windows.
function vim.loop.setuid(id) end

-- > method form `stream:shutdown([callback])`
-- 
-- Parameters:
-- - `stream`: `userdata` for sub-type of |uv_stream_t|
-- - `callback`: `callable` or `nil`
--   - `err`: `nil` or `string`
-- 
-- Shutdown the outgoing (write) side of a duplex stream. It
-- waits for pending write requests to complete. The callback is
-- called after shutdown is complete.
-- 
-- Returns: `uv_shutdown_t userdata` or `fail`
--- @param callback? fun()
function vim.loop.shutdown(stream, callback) end

-- > method form `signal:start(signum, callback)`
-- 
-- Parameters:
-- - `signal`: `uv_signal_t userdata`
-- - `signum`: `integer` or `string`
-- - `callback`: `callable`
--   - `signum`: `string`
-- 
-- Start the handle with the given callback, watching for the
-- given signal.
-- 
-- Returns: `0` or `fail`
--- @param callback fun()
function vim.loop.signal_start(signal, signum, callback) end

-- > method form `signal:start_oneshot(signum, callback)`
-- 
-- Parameters:
-- - `signal`: `uv_signal_t userdata`
-- - `signum`: `integer` or `string`
-- - `callback`: `callable`
--   - `signum`: `string`
-- 
-- Same functionality as |uv.signal_start()| but the signal
-- handler is reset the moment the signal is received.
-- 
-- Returns: `0` or `fail`
--- @param callback fun()
function vim.loop.signal_start_oneshot(signal, signum, callback) end

-- > method form `signal:stop()`
-- 
-- Parameters:
-- - `signal`: `uv_signal_t userdata`
-- 
-- Stop the handle, the callback will no longer be called.
-- 
-- Returns: `0` or `fail`
function vim.loop.signal_stop(signal) end

-- Parameters:
-- - `msec`: `integer`
-- 
-- Pauses the thread in which this is called for a number of
-- milliseconds.
-- 
-- Returns: Nothing.
function vim.loop.sleep(msec) end

-- Parameters:
-- - `socktype`: `string`, `integer` or `nil` (default: `stream`)
-- - `protocol`: `string`, `integer` or `nil` (default: 0)
-- - `flags1`: `table` or `nil`
--   - `nonblock`: `boolean` (default: `false`)
-- - `flags2`: `table` or `nil`
--   - `nonblock`: `boolean` (default: `false`)
-- 
-- Create a pair of connected sockets with the specified
-- properties. The resulting handles can be passed to
-- |uv.tcp_open()|, used with |uv.spawn()|, or for any other
-- purpose.
-- 
-- When specified as a string, `socktype` must be one of
-- `"stream"`, `"dgram"`, `"raw"`, `"rdm"`, or `"seqpacket"`.
-- 
-- When `protocol` is set to 0 or nil, it will be automatically
-- chosen based on the socket's domain and type. When `protocol`
-- is specified as a string, it will be looked up using the
-- `getprotobyname(3)` function (examples: `"ip"`, `"icmp"`,
-- `"tcp"`, `"udp"`, etc).
-- 
-- Flags:
--  - `nonblock`: Opens the specified socket handle for
--    `OVERLAPPED` or `FIONBIO`/`O_NONBLOCK` I/O usage. This is
--    recommended for handles that will be used by libuv, and not
--    usually recommended otherwise.
-- 
-- Equivalent to `socketpair(2)` with a domain of `AF_UNIX`.
-- 
-- Returns: `table` or `fail`
-- - `[1, 2]` : `integer` (file descriptor)
-- 
-- ```lua
--     -- Simple read/write with tcp
--     local fds = uv.socketpair(nil, nil, {nonblock=true}, {nonblock=true})
-- 
--     local sock1 = uv.new_tcp()
--     sock1:open(fds[1])
-- 
--     local sock2 = uv.new_tcp()
--     sock2:open(fds[2])
-- 
--     sock1:write("hello")
--     sock2:read_start(function(err, chunk)
--       assert(not err, err)
--       print(chunk)
--     end)
-- ```
--- @param socktype? any
--- @param protocol? any
--- @param flags1? any
--- @param flags2? any
--- @return table
function vim.loop.socketpair(socktype, protocol, flags1, flags2) end

-- Parameters:
-- - `path`: `string`
-- - `options`: `table` (see below)
-- - `on_exit`: `callable`
--   - `code`: `integer`
--   - `signal`: `integer`
-- 
-- Initializes the process handle and starts the process. If the
-- process is successfully spawned, this function will return the
-- handle and pid of the child process.
-- 
-- Possible reasons for failing to spawn would include (but not
-- be limited to) the file to execute not existing, not having
-- permissions to use the setuid or setgid specified, or not
-- having enough memory to allocate for the new process.
-- 
-- ```lua
--     local stdin = uv.new_pipe()
--     local stdout = uv.new_pipe()
--     local stderr = uv.new_pipe()
-- 
--     print("stdin", stdin)
--     print("stdout", stdout)
--     print("stderr", stderr)
-- 
--     local handle, pid = uv.spawn("cat", {
--       stdio = {stdin, stdout, stderr}
--     }, function(code, signal) -- on exit
--       print("exit code", code)
--       print("exit signal", signal)
--     end)
-- 
--     print("process opened", handle, pid)
-- 
--     uv.read_start(stdout, function(err, data)
--       assert(not err, err)
--       if data then
--         print("stdout chunk", stdout, data)
--       else
--         print("stdout end", stdout)
--       end
--     end)
-- 
--     uv.read_start(stderr, function(err, data)
--       assert(not err, err)
--       if data then
--         print("stderr chunk", stderr, data)
--       else
--         print("stderr end", stderr)
--       end
--     end)
-- 
--     uv.write(stdin, "Hello World")
-- 
--     uv.shutdown(stdin, function()
--       print("stdin shutdown", stdin)
--       uv.close(handle, function()
--         print("process closed", handle, pid)
--       end)
--     end)
-- ```
-- 
-- The `options` table accepts the following fields:
-- 
--   - `options.args` - Command line arguments as a list of
--     string. The first string should be the path to the
--     program. On Windows, this uses CreateProcess which
--     concatenates the arguments into a string. This can cause
--     some strange errors. (See `options.verbatim` below for
--     Windows.)
--   - `options.stdio` - Set the file descriptors that will be
--     made available to the child process. The convention is
--     that the first entries are stdin, stdout, and stderr.
--     (Note: On Windows, file descriptors after the third are
--     available to the child process only if the child processes
--     uses the MSVCRT runtime.)
--   - `options.env` - Set environment variables for the new
--     process.
--   - `options.cwd` - Set the current working directory for the
--     sub-process.
--   - `options.uid` - Set the child process' user id.
--   - `options.gid` - Set the child process' group id.
--   - `options.verbatim` - If true, do not wrap any arguments in
--     quotes, or perform any other escaping, when converting the
--     argument list into a command line string. This option is
--     only meaningful on Windows systems. On Unix it is silently
--     ignored.
--   - `options.detached` - If true, spawn the child process in a
--     detached state - this will make it a process group leader,
--     and will effectively enable the child to keep running
--     after the parent exits. Note that the child process will
--     still keep the parent's event loop alive unless the parent
--     process calls |uv.unref()| on the child's process handle.
--   - `options.hide` - If true, hide the subprocess console
--     window that would normally be created. This option is only
--     meaningful on Windows systems. On Unix it is silently
--     ignored.
-- 
-- The `options.stdio` entries can take many shapes.
-- 
--   - If they are numbers, then the child process inherits that
--     same zero-indexed fd from the parent process.
--   - If |uv_stream_t| handles are passed in, those are used as
--     a read-write pipe or inherited stream depending if the
--     stream has a valid fd.
--   - Including `nil` placeholders means to ignore that fd in
--     the child process.
-- 
-- When the child process exits, `on_exit` is called with an exit
-- code and signal.
-- 
-- Returns: `uv_process_t userdata`, `integer`
--- @param options table<string, any>
--- @return vim.loop.Process
function vim.loop.spawn(path, options, on_exit) end

-- Stop the event loop, causing |uv.run()| to end as soon as
-- possible. This will happen not sooner than the next loop
-- iteration. If this function was called before blocking for
-- I/O, the loop won't block for I/O on this iteration.
-- 
-- Returns: Nothing.
function vim.loop.stop() end

-- > method form `stream:get_write_queue_size()`
-- 
-- Returns the stream's write queue size.
-- 
-- Returns: `integer`
function vim.loop.stream_get_write_queue_size() end

-- > method form `stream:set_blocking(blocking)`
-- 
-- Parameters:
-- - `stream`: `userdata` for sub-type of |uv_stream_t|
-- - `blocking`: `boolean`
-- 
-- Enable or disable blocking mode for a stream.
-- 
-- When blocking mode is enabled all writes complete
-- synchronously. The interface remains unchanged otherwise, e.g.
-- completion or failure of the operation will still be reported
-- through a callback which is made asynchronously.
-- 
-- Returns: `0` or `fail`
-- 
-- WARNING: Relying too much on this API is not recommended. It
-- is likely to change significantly in the future. Currently
-- this only works on Windows and only for |uv_pipe_t| handles.
-- Also libuv currently makes no ordering guarantee when the
-- blocking mode is changed after write requests have already
-- been submitted. Therefore it is recommended to set the
-- blocking mode immediately after opening or creating the
-- stream.
--- @return 0
function vim.loop.stream_set_blocking(stream, blocking) end

-- > method form `tcp:bind(host, port, [flags])`
-- 
-- Parameters:
-- - `tcp`: `uv_tcp_t userdata`
-- - `host`: `string`
-- - `port`: `integer`
-- - `flags`: `table` or `nil`
--   - `ipv6only`: `boolean`
-- 
-- Bind the handle to an host and port. `host` should be an IP
-- address and not a domain name. Any `flags` are set with a
-- table with field `ipv6only` equal to `true` or `false`.
-- 
-- When the port is already taken, you can expect to see an
-- `EADDRINUSE` error from either `uv.tcp_bind()`, |uv.listen()|
-- or |uv.tcp_connect()|. That is, a successful call to this
-- function does not guarantee that the call to |uv.listen()| or
-- |uv.tcp_connect()| will succeed as well.
-- 
-- Use a port of `0` to let the OS assign an ephemeral port.  You
-- can look it up later using |uv.tcp_getsockname()|.
-- 
-- Returns: `0` or `fail`
--- @param flags? any
function vim.loop.tcp_bind(tcp, host, port, flags) end

-- > method form `tcp:close_reset([callback])`
-- 
-- Parameters:
-- - `tcp`: `uv_tcp_t userdata`
-- - `callback`: `callable` or `nil`
-- 
-- Resets a TCP connection by sending a RST packet. This is
-- accomplished by setting the SO_LINGER socket option with a
-- linger interval of zero and then calling |uv.close()|. Due to
-- some platform inconsistencies, mixing of |uv.shutdown()| and
-- `uv.tcp_close_reset()` calls is not allowed.
-- 
-- Returns: `0` or `fail`
--- @param callback? fun()
function vim.loop.tcp_close_reset(callback) end

-- > method form `tcp:connect(host, port, callback)`
-- 
-- Parameters:
-- - `tcp`: `uv_tcp_t userdata`
-- - `host`: `string`
-- - `port`: `integer`
-- - `callback`: `callable`
--    - `err`: `nil` or `string`
-- 
-- Establish an IPv4 or IPv6 TCP connection.
-- 
-- Returns: `uv_connect_t userdata` or `fail`
-- 
-- ```lua
--     local client = uv.new_tcp()
--     client:connect("127.0.0.1", 8080, function (err)
--       -- check error and carry on.
--     end)
-- ```
--- @param callback fun()
--- @return userdata
function vim.loop.tcp_connect(tcp, host, port, callback) end

-- > method form `tcp:getpeername()`
-- 
-- Parameters:
-- - `tcp`: `uv_tcp_t userdata`
-- 
-- Get the address of the peer connected to the handle.
-- 
-- Returns: `table` or `fail`
-- - `ip` : `string`
-- - `family` : `string`
-- - `port` : `integer`
--- @return table
function vim.loop.tcp_getpeername(tcp) end

-- > method form `tcp:getsockname()`
-- 
-- Parameters:
-- - `tcp`: `uv_tcp_t userdata`
-- 
-- Get the current address to which the handle is bound.
-- 
-- Returns: `table` or `fail`
-- - `ip` : `string`
-- - `family` : `string`
-- - `port` : `integer`
--- @return table
function vim.loop.tcp_getsockname(tcp) end

-- > method form `tcp:keepalive(enable, [delay])`
-- 
-- Parameters:
-- - `tcp`: `uv_tcp_t userdata`
-- - `enable`: `boolean`
-- - `delay`: `integer` or `nil`
-- 
-- Enable / disable TCP keep-alive. `delay` is the initial delay
-- in seconds, ignored when enable is `false`.
-- 
-- Returns: `0` or `fail`
--- @param delay? any
function vim.loop.tcp_keepalive(tcp, enable, delay) end

-- > method form `tcp:nodelay(enable)`
-- 
-- Parameters:
-- - `tcp`: `uv_tcp_t userdata`
-- - `enable`: `boolean`
-- 
-- Enable / disable Nagle's algorithm.
-- 
-- Returns: `0` or `fail`
function vim.loop.tcp_nodelay(tcp, enable) end

-- > method form `tcp:open(sock)`
-- 
-- Parameters:
-- - `tcp`: `uv_tcp_t userdata`
-- - `sock`: `integer`
-- 
-- Open an existing file descriptor or SOCKET as a TCP handle.
-- 
-- Returns: `0` or `fail`
-- 
-- Note: The passed file descriptor or SOCKET is not checked for
-- its type, but it's required that it represents a valid stream
-- socket.
--- @return 0
function vim.loop.tcp_open(tcp, sock) end

-- > method form `tcp:simultaneous_accepts(enable)`
-- 
-- Parameters:
-- - `tcp`: `uv_tcp_t userdata`
-- - `enable`: `boolean`
-- 
-- Enable / disable simultaneous asynchronous accept requests
-- that are queued by the operating system when listening for new
-- TCP connections.
-- 
-- This setting is used to tune a TCP server for the desired
-- performance. Having simultaneous accepts can significantly
-- improve the rate of accepting connections (which is why it is
-- enabled by default) but may lead to uneven load distribution
-- in multi-process setups.
-- 
-- Returns: `0` or `fail`
function vim.loop.tcp_simultaneous_accepts(tcp, enable) end

-- > method form `tcp:write_queue_size()`
-- 
-- DEPRECATED: Please use |uv.stream_get_write_queue_size()|
-- instead.
function vim.loop.tcp_write_queue_size(tcp) end

-- > method form `thread:equal(other_thread)`
-- 
-- Parameters:
-- - `thread`: `luv_thread_t userdata`
-- - `other_thread`: `luv_thread_t userdata`
-- 
-- Returns a boolean indicating whether two threads are the same.
-- This function is equivalent to the `__eq` metamethod.
-- 
-- Returns: `boolean`
function vim.loop.thread_equal(thread, other_thread) end

-- > method form `thread:join()`
-- 
-- Parameters:
-- - `thread`: `luv_thread_t userdata`
-- 
-- Waits for the `thread` to finish executing its entry function.
-- 
-- Returns: `boolean` or `fail`
function vim.loop.thread_join(thread) end

-- Returns the handle for the thread in which this is called.
-- 
-- Returns: `luv_thread_t`
function vim.loop.thread_self() end

-- > method form `timer:again()`
-- 
-- Parameters:
-- - `timer`: `uv_timer_t userdata`
-- 
-- Stop the timer, and if it is repeating restart it using the
-- repeat value as the timeout. If the timer has never been
-- started before it raises `EINVAL`.
-- 
-- Returns: `0` or `fail`
function vim.loop.timer_again(timer) end

-- > method form `timer:get_due_in()`
-- 
-- Parameters:
-- - `timer`: `uv_timer_t userdata`
-- 
-- Get the timer due value or 0 if it has expired. The time is
-- relative to |uv.now()|.
-- 
-- Returns: `integer`
-- 
-- Note: New in libuv version 1.40.0.
--- @return number
function vim.loop.timer_get_due_in(timer) end

-- > method form `timer:get_repeat()`
-- 
-- Parameters:
-- - `timer`: `uv_timer_t userdata`
-- 
-- Get the timer repeat value.
-- 
-- Returns: `integer`
function vim.loop.timer_get_repeat(timer) end

-- > method form `timer:set_repeat(repeat)`
-- 
-- Parameters:
-- - `timer`: `uv_timer_t userdata`
-- - `repeat`: `integer`
-- 
-- Set the repeat interval value in milliseconds. The timer will
-- be scheduled to run on the given interval, regardless of the
-- callback execution duration, and will follow normal timer
-- semantics in the case of a time-slice overrun.
-- 
-- For example, if a 50 ms repeating timer first runs for 17 ms,
-- it will be scheduled to run again 33 ms later. If other tasks
-- consume more than the 33 ms following the first timer
-- callback, then the callback will run as soon as possible.
-- 
-- Returns: Nothing.
function vim.loop.timer_set_repeat(timer, repeat_) end

-- > method form `timer:start(timeout, repeat, callback)`
-- 
-- Parameters:
-- - `timer`: `uv_timer_t userdata`
-- - `timeout`: `integer`
-- - `repeat`: `integer`
-- - `callback`: `callable`
-- 
-- Start the timer. `timeout` and `repeat` are in milliseconds.
-- 
-- If `timeout` is zero, the callback fires on the next event
-- loop iteration. If `repeat` is non-zero, the callback fires
-- first after `timeout` milliseconds and then repeatedly after
-- `repeat` milliseconds.
-- 
-- Returns: `0` or `fail`
--- @param callback fun()
function vim.loop.timer_start(timer, timeout, repeat_, callback) end

-- > method form `timer:stop()`
-- 
-- Parameters:
-- - `timer`: `uv_timer_t userdata`
-- 
-- Stop the timer, the callback will not be called anymore.
-- 
-- Returns: `0` or `fail`
function vim.loop.timer_stop(timer) end

-- Parameters:
-- - `errcode`: `integer`
-- 
-- Returns the libuv error message and error name (both in string
-- form, see `err` and `name` in |luv-error-handling|) equivalent
-- to the given platform dependent error code: POSIX error codes
-- on Unix (the ones stored in errno), and Win32 error codes on
-- Windows (those returned by GetLastError() or
-- WSAGetLastError()).
-- 
-- Returns: `string, string` or `nil`
function vim.loop.translate_sys_error(errcode) end

-- > method form `stream:try_write(data)`
-- 
-- Parameters:
-- - `stream`: `userdata` for sub-type of |uv_stream_t|
-- - `data`: `buffer`
-- 
-- Same as |uv.write()|, but won't queue a write request if it
-- can't be completed immediately.
-- 
-- Will return number of bytes written (can be less than the
-- supplied buffer size).
-- 
-- Returns: `integer` or `fail`
function vim.loop.try_write(stream, data) end

-- > method form `stream:try_write2(data, send_handle)`
-- 
-- Parameters:
-- - `stream`: `userdata` for sub-type of |uv_stream_t|
-- - `data`: `buffer`
-- - `send_handle`: `userdata` for sub-type of |uv_stream_t|
-- 
-- Like |uv.write2()|, but with the properties of
-- |uv.try_write()|. Not supported on Windows, where it returns
-- `UV_EAGAIN`.
-- 
-- Will return number of bytes written (can be less than the
-- supplied buffer size).
-- 
-- Returns: `integer` or `fail`
function vim.loop.try_write2(stream, data, send_handle) end

-- Get the current state of whether console virtual terminal
-- sequences are handled by libuv or the console. The return
-- value is `"supported"` or `"unsupported"`.
-- 
-- This function is not implemented on Unix, where it returns
-- `ENOTSUP`.
-- 
-- Returns: `string` or `fail`
function vim.loop.tty_get_vterm_state() end

-- > method form `tty:get_winsize()`
-- 
-- Parameters:
-- - `tty`: `uv_tty_t userdata`
-- 
-- Gets the current Window width and height.
-- 
-- Returns: `integer, integer` or `fail`
function vim.loop.tty_get_winsize(tty) end

-- To be called when the program exits. Resets TTY settings to
-- default values for the next process to take over.
-- 
-- This function is async signal-safe on Unix platforms but can
-- fail with error code `EBUSY` if you call it when execution is
-- inside |uv.tty_set_mode()|.
-- 
-- Returns: `0` or `fail`
function vim.loop.tty_reset_mode() end

-- > method form `tty:set_mode(mode)`
-- 
-- Parameters:
-- - `tty`: `uv_tty_t userdata`
-- - `mode`: `integer`
-- 
-- Set the TTY using the specified terminal mode.
-- 
-- Parameter `mode` is a C enum with the following values:
-- 
--   - 0 - UV_TTY_MODE_NORMAL: Initial/normal terminal mode
--   - 1 - UV_TTY_MODE_RAW: Raw input mode (On Windows,
--     ENABLE_WINDOW_INPUT is also enabled)
--   - 2 - UV_TTY_MODE_IO: Binary-safe I/O mode for IPC
--     (Unix-only)
-- 
-- Returns: `0` or `fail`
function vim.loop.tty_set_mode(tty, mode) end

-- Parameters:
-- - `state`: `string`
-- 
-- Controls whether console virtual terminal sequences are
-- processed by libuv or console. Useful in particular for
-- enabling ConEmu support of ANSI X3.64 and Xterm 256 colors.
-- Otherwise Windows10 consoles are usually detected
-- automatically. State should be one of: `"supported"` or
-- `"unsupported"`.
-- 
-- This function is only meaningful on Windows systems. On Unix
-- it is silently ignored.
-- 
-- Returns: none
function vim.loop.tty_set_vterm_state(state) end

-- > method form `udp:bind(host, port, [flags])`
-- 
-- Parameters:
-- - `udp`: `uv_udp_t userdata`
-- - `host`: `string`
-- - `port`: `number`
-- - `flags`: `table` or `nil`
--   - `ipv6only`: `boolean`
--   - `reuseaddr`: `boolean`
-- 
-- Bind the UDP handle to an IP address and port. Any `flags` are
-- set with a table with fields `reuseaddr` or `ipv6only` equal
-- to `true` or `false`.
-- 
-- Returns: `0` or `fail`
--- @param flags? any
function vim.loop.udp_bind(udp, host, port, flags) end

-- > method form `udp:connect(host, port)`
-- 
-- Parameters:
-- - `udp`: `uv_udp_t userdata`
-- - `host`: `string`
-- - `port`: `integer`
-- 
-- Associate the UDP handle to a remote address and port, so
-- every message sent by this handle is automatically sent to
-- that destination. Calling this function with a NULL addr
-- disconnects the handle. Trying to call `uv.udp_connect()` on
-- an already connected handle will result in an `EISCONN` error.
-- Trying to disconnect a handle that is not connected will
-- return an `ENOTCONN` error.
-- 
-- Returns: `0` or `fail`
function vim.loop.udp_connect(udp, host, port) end

-- > method form `udp:get_send_queue_count()`
-- 
-- Returns the handle's send queue count.
-- 
-- Returns: `integer`
function vim.loop.udp_get_send_queue_count() end

-- > method form `udp:get_send_queue_size()`
-- 
-- Returns the handle's send queue size.
-- 
-- Returns: `integer`
function vim.loop.udp_get_send_queue_size() end

-- > method form `udp:getpeername()`
-- 
-- Parameters:
-- - `udp`: `uv_udp_t userdata`
-- 
-- Get the remote IP and port of the UDP handle on connected UDP
-- handles.
-- 
-- Returns: `table` or `fail`
-- - `ip` : `string`
-- - `family` : `string`
-- - `port` : `integer`
--- @return table
function vim.loop.udp_getpeername(udp) end

-- > method form `udp:getsockname()`
-- 
-- Parameters:
-- - `udp`: `uv_udp_t userdata`
-- 
-- Get the local IP and port of the UDP handle.
-- 
-- Returns: `table` or `fail`
-- - `ip` : `string`
-- - `family` : `string`
-- - `port` : `integer`
--- @return table
function vim.loop.udp_getsockname(udp) end

-- > method form `udp:open(fd)`
-- 
-- Parameters:
-- - `udp`: `uv_udp_t userdata`
-- - `fd`: `integer`
-- 
-- Opens an existing file descriptor or Windows SOCKET as a UDP
-- handle.
-- 
-- Unix only: The only requirement of the sock argument is that
-- it follows the datagram contract (works in unconnected mode,
-- supports sendmsg()/recvmsg(), etc). In other words, other
-- datagram-type sockets like raw sockets or netlink sockets can
-- also be passed to this function.
-- 
-- The file descriptor is set to non-blocking mode.
-- 
-- Note: The passed file descriptor or SOCKET is not checked for
-- its type, but it's required that it represents a valid
-- datagram socket.
-- 
-- Returns: `0` or `fail`
function vim.loop.udp_open(udp, fd) end

-- > method form `udp:recv_start(callback)`
-- 
-- Parameters:
-- - `udp`: `uv_udp_t userdata`
-- - `callback`: `callable`
--   - `err`: `nil` or `string`
--   - `data`: `string` or `nil`
--   - `addr`: `table` or `nil`
--     - `ip`: `string`
--     - `port`: `integer`
--     - `family`: `string`
--   - `flags`: `table`
--     - `partial`: `boolean` or `nil`
--     - `mmsg_chunk`: `boolean` or `nil`
-- 
-- Prepare for receiving data. If the socket has not previously
-- been bound with |uv.udp_bind()| it is bound to `0.0.0.0` (the
-- "all interfaces" IPv4 address) and a random port number.
-- 
-- Returns: `0` or `fail`
--- @param callback fun()
function vim.loop.udp_recv_start(udp, callback) end

-- > method form `udp:recv_stop()`
-- 
-- Parameters:
-- - `udp`: `uv_udp_t userdata`
-- 
-- Stop listening for incoming datagrams.
-- 
-- Returns: `0` or `fail`
function vim.loop.udp_recv_stop(udp) end

-- > method form `udp:send(data, host, port, callback)`
-- 
-- Parameters:
-- - `udp`: `uv_udp_t userdata`
-- - `data`: `buffer`
-- - `host`: `string`
-- - `port`: `integer`
-- - `callback`: `callable`
--   - `err`: `nil` or `string`
-- 
-- Send data over the UDP socket. If the socket has not
-- previously been bound with |uv.udp_bind()| it will be bound to
-- `0.0.0.0` (the "all interfaces" IPv4 address) and a random
-- port number.
-- 
-- Returns: `uv_udp_send_t userdata` or `fail`
--- @param callback fun()
function vim.loop.udp_send(udp, data, host, port, callback) end

-- > method form `udp:set_broadcast(on)`
-- 
-- Parameters:
-- - `udp`: `uv_udp_t userdata`
-- - `on`: `boolean`
-- 
-- Set broadcast on or off.
-- 
-- Returns: `0` or `fail`
function vim.loop.udp_set_broadcast(udp, on) end

-- > method form
-- > `udp:set_membership(multicast_addr, interface_addr, membership)`
-- 
-- Parameters:
-- - `udp`: `uv_udp_t userdata`
-- - `multicast_addr`: `string`
-- - `interface_addr`: `string` or `nil`
-- - `membership`: `string`
-- 
-- Set membership for a multicast address. `multicast_addr` is
-- multicast address to set membership for. `interface_addr` is
-- interface address. `membership` can be the string `"leave"` or
-- `"join"`.
-- 
-- Returns: `0` or `fail`
function vim.loop.udp_set_membership(udp, multicast_addr, interface_addr, membership) end

-- > method form `udp:set_multicast_interface(interface_addr)`
-- 
-- Parameters:
-- - `udp`: `uv_udp_t userdata`
-- - `interface_addr`: `string`
-- 
-- Set the multicast interface to send or receive data on.
-- 
-- Returns: `0` or `fail`
function vim.loop.udp_set_multicast_interface(udp, interface_addr) end

-- > method form `udp:set_multicast_loop(on)`
-- 
-- Parameters:
-- - `udp`: `uv_udp_t userdata`
-- - `on`: `boolean`
-- 
-- Set IP multicast loop flag. Makes multicast packets loop back
-- to local sockets.
-- 
-- Returns: `0` or `fail`
function vim.loop.udp_set_multicast_loop(udp, on) end

-- > method form `udp:set_multicast_ttl(ttl)`
-- 
-- Parameters:
-- - `udp`: `uv_udp_t userdata`
-- - `ttl`: `integer`
-- 
-- Set the multicast ttl.
-- 
-- `ttl` is an integer 1 through 255.
-- 
-- Returns: `0` or `fail`
function vim.loop.udp_set_multicast_ttl(udp, ttl) end

-- > method form
-- > `udp:set_source_membership(multicast_addr, interface_addr, source_addr, membership)`
-- 
-- Parameters:
-- - `udp`: `uv_udp_t userdata`
-- - `multicast_addr`: `string`
-- - `interface_addr`: `string` or `nil`
-- - `source_addr`: `string`
-- - `membership`: `string`
-- 
-- Set membership for a source-specific multicast group.
-- `multicast_addr` is multicast address to set membership for.
-- `interface_addr` is interface address. `source_addr` is source
-- address. `membership` can be the string `"leave"` or `"join"`.
-- 
-- Returns: `0` or `fail`
function vim.loop.udp_set_source_membership(udp, multicast_addr, interface_addr, source_addr, membership) end

-- > method form `udp:set_ttl(ttl)`
-- 
-- Parameters:
-- - `udp`: `uv_udp_t userdata`
-- - `ttl`: `integer`
-- 
-- Set the time to live.
-- 
-- `ttl` is an integer 1 through 255.
-- 
-- Returns: `0` or `fail`
function vim.loop.udp_set_ttl(udp, ttl) end

-- > method form `udp:try_send(data, host, port)`
-- 
-- Parameters:
-- - `udp`: `uv_udp_t userdata`
-- - `data`: `buffer`
-- - `host`: `string`
-- - `port`: `integer`
-- 
-- Same as |uv.udp_send()|, but won't queue a send request if it
-- can't be completed immediately.
-- 
-- Returns: `integer` or `fail`
function vim.loop.udp_try_send(udp, data, host, port) end

-- > method form `handle:unref()`
-- 
-- Parameters:
-- - `handle`: `userdata` for sub-type of |uv_handle_t|
-- 
-- Un-reference the given handle. References are idempotent, that
-- is, if a handle is not referenced calling this function again
-- will have no effect.
-- 
-- Returns: Nothing.
function vim.loop.unref(handle) end

-- Update the event loop's concept of "now". Libuv caches the
-- current time at the start of the event loop tick in order to
-- reduce the number of time-related system calls.
-- 
-- You won't normally need to call this function unless you have
-- callbacks that block the event loop for longer periods of
-- time, where "longer" is somewhat subjective but probably on
-- the order of a millisecond or more.
-- 
-- Returns: Nothing.
function vim.loop.update_time() end

-- Returns the current system uptime in seconds.
-- 
-- Returns: `number` or `fail`
function vim.loop.uptime() end

-- Returns the libuv version packed into a single integer. 8 bits
-- are used for each component, with the patch number stored in
-- the 8 least significant bits. For example, this would be
-- 0x010203 in libuv 1.2.3.
-- 
-- Returns: `integer`
function vim.loop.version() end

-- Returns the libuv version number as a string. For example,
-- this would be "1.2.3" in libuv 1.2.3. For non-release
-- versions, the version suffix is included.
-- 
-- Returns: `string`
function vim.loop.version_string() end

-- Parameters:
-- - `callback`: `callable`
--   - `handle`: `userdata` for sub-type of |uv_handle_t|
-- 
-- Walk the list of handles: `callback` will be executed with
-- each handle.
-- 
-- Returns: Nothing.
-- 
-- ```lua
--     -- Example usage of uv.walk to close all handles that
--     -- aren't already closing.
--     uv.walk(function (handle)
--       if not handle:is_closing() then
--         handle:close()
--       end
--     end)
-- ```
--- @param callback fun()
function vim.loop.walk(callback) end

-- > method form `stream:write(data, [callback])`
-- 
-- Parameters:
-- - `stream`: `userdata` for sub-type of |uv_stream_t|
-- - `data`: `buffer`
-- - `callback`: `callable` or `nil`
--   - `err`: `nil` or `string`
-- 
-- Write data to stream.
-- 
-- `data` can either be a Lua string or a table of strings. If a
-- table is passed in, the C backend will use writev to send all
-- strings in a single system call.
-- 
-- The optional `callback` is for knowing when the write is
-- complete.
-- 
-- Returns: `uv_write_t userdata` or `fail`
--- @param callback? fun()
function vim.loop.write(stream, data, callback) end

-- > method form `stream:write2(data, send_handle, [callback])`
-- 
-- Parameters:
-- - `stream`: `userdata` for sub-type of |uv_stream_t|
-- - `data`: `buffer`
-- - `send_handle`: `userdata` for sub-type of |uv_stream_t|
-- - `callback`: `callable` or `nil`
--   - `err`: `nil` or `string`
-- 
-- Extended write function for sending handles over a pipe. The
-- pipe must be initialized with `ipc` option `true`.
-- 
-- Returns: `uv_write_t userdata` or `fail`
-- 
-- Note: `send_handle` must be a TCP socket or pipe, which is a
-- server or a connection (listening or connected state). Bound
-- sockets or pipes will be assumed to be servers.
--- @param callback? fun()
--- @return userdata
function vim.loop.write2(stream, data, send_handle, callback) end

