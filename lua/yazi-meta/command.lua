--- @meta command

--- @class yazi.Command: yazi.command.Command
---
--- @see yazi.command.Command

------------------------------------ Command ------------------------------------

--- @alias yazi.command.Command.cfg
--- |`Command.NULL`
--- |`Command.PIPED`
--- |`Command.INHERIT`

--- @class yazi.command.Command
--- @overload fun(cmd: string):self
---
--- @limit async-context
--- You can invoke external programs through |Command|.
---
--- Example:
--- ```lua
--- local child, err = Command("ls")
--- :args({ "-a", "-l" })
--- :stdout(Command.PIPED)
--- :spawn()
--- ```
--- Compared to Lua's os.execute, it provides many comprehensive and convenient methods, and the entire process is async.
--- It takes better advantage of the benefits of concurrent scheduling.
--- However, it can only be used in async contexts, such as preloaders, previewers, and async functional plugins.
---
--- Properties:
--- @field NULL ... Discard the stream.
--- @field PIPED ... Pipe the stream.
--- @field INHERIT ... Inherit the stream.
---
--- @see https://yazi-rs.github.io/docs/plugins/utils#command

--- Append an argument to the command.
---
--- @param arg string The argument to be appended
--- @return self
function Command:arg(arg) end

--- Append multiple arguments to the command.
---
--- @param args string[] The arguments to be appended
--- @return self
function Command:args(args) end

--- Set the current working directory of the command.
---
--- @param dir string The directory of the command
--- @return self
function Command:cwd(dir) end

--- Append an environment variable to the command.
---
--- @param key string The key of the environment variable
--- @param value string The value of the environment variable
--- @return self
function Command:env(key, value) end

--- Set the stdin of the command.
---
--- @param cfg yazi.command.Command.cfg|integer The configuration of the stdin
--- @return self? stdin If not set, the stdin will be null.
function Command:stdin(cfg) end

--- Set the stdout of the command.
---
--- @param cfg yazi.command.Command.cfg|integer The configuration of the stdout
--- @return self? stdout If not set, the stdout will be null.
function Command:stdout(cfg) end

--- Set the stderr of the command.
---
--- @param cfg yazi.command.Command.cfg|integer The configuration of the stderr
--- @return self? stderr If not set, the stderr will be null.
function Command:stderr(cfg) end

--- Spawn the command.
---
--- @return yazi.command.Child? child The Child of the command if successful; otherwise, nil.
--- @return yazi.Error? err The error if the operation is failed
function Command:spawn() end

--- Spawn the command and wait for it to finish.
---
--- @return yazi.command.Output? output The Output of the command if successful; otherwise, nil.
--- @return yazi.Error? err The error if the operation is failed
function Command:output() end

--- Executes the command as a child process, waiting for it to finish and collecting its exit status.
---
--- @return yazi.command.Status? status The Status of the child process if successful; otherwise, nil.
--- @return yazi.Error? err The error if the operation is failed
function Command:status() end

------------------------------------ Child ------------------------------------

--- @alias yazi.command.Child.event
--- | 0 The data comes from stdout
--- | 1 The data comes from stderr
--- | 2 There's no data to read from both stdout and stderr
--- | 3 Timeout (only available in |read_line_with()|)

--- @class yazi.command.Child
--- This object is created by Command:spawn() and represents a running child process.
--- You can access the runtime data of this process through its proprietary methods.
---
--- @see https://yazi-rs.github.io/docs/plugins/utils#child
local child = ...

--- Let's say "available data source" refers to stdout or stderr that has been set with Command.PIPED, or them both.
--- |read()| reads data from the available data source alternately, and the event indicates the source of the data:
---
--- @param len integer Read the size of the data
--- @return string data Read data
--- @return yazi.command.Child.event event indicates the source of the data
function child:read(len) end

--- Similar to |read()|, but it reads data line by line.
---
--- @return string data Read data
--- @return yazi.command.Child.event event indicates the source of the data
---
--- @see yazi.Child.read
function child:read_line() end

--- Similar to read_line(), but it accepts a table of options.
---
--- @param opts {timeout: integer}
---   timeout - Timeout in milliseconds
--- @return string data Read data
--- @return yazi.command.Child.event event indicates the source of the data
---
--- @see yazi.Child.read
function child:read_line_with(opts) end

--- Writes all bytes from the string |src| to the stdin of the child process.
---
--- Note: Please ensure that the child's stdin is available when calling this method, specifically:
---   1. |stdin(Command.PIPED)| is set.
---   2. |take_stdin()| has never been called.
--- Otherwise, an error will be thrown.
---
--- @param src string Data to be written
--- @return boolean ok Whether the operation is successful
--- @return yazi.Error? err The error if the operation is failed
function child:write_all(src) end

--- Flushes any buffered data to the stdin of the child process.
---
--- @return boolean ok Whether the operation is successful.
--- @return yazi.Error? err The error if the operation is failed.
---
--- @see yazi.Child.write_all View Note
function child:flush() end

--- Wait for the child process to finish.
---
--- @return yazi.command.Status? status The Status of the child process if successful; otherwise, nil.
--- @return yazi.Error? err The error if the operation is failed.
function child:wait() end

--- Wait for the child process to finish and get the output.
---
--- @return yazi.command.Output? output The Output of the child process if successful; otherwise, nil.
--- @return yazi.Error? err The error if the operation is failed.
function child:wait_with_output() end

--- Send a SIGTERM signal to the child process.
---
--- @return boolean ok Whether the operation is successful.
--- @return yazi.Error? err The error if the operation is failed.
function child:start_kill() end

--- Take and return the stdin stream of the child process.
---
--- Note: |self| can only be called once and is only applicable to processes with stdin(Command.PIPED) set; otherwise, it returns nil.
---
--- @return integer stream_id
function child:take_stdin() end

--- Take and return the stdout stream of the child process.
---
--- This is useful when redirecting stdout to another process's stdin, example:
--- ```lua
--- local echo = Command("echo"):arg("Hello"):stdout(Command.PIPED):spawn()
---
--- local rev = Command("rev"):stdin(echo:take_stdout()):stdout(Command.PIPED):output()
---
--- ya.err(rev.stdout) -- "olleH\n"
--- ```
---
--- @return integer stream_id
---
--- @see yazi.Child.take_stdin View Note
function child:take_stdout() end

--- Take and return the stderr stream of the child process.
---
--- @return integer stream_id
---
--- @see yazi.Child.take_stdin Note
--- @see yazi.Child.take_stdout Example
function child:take_stderr() end

------------------------------------ Output ------------------------------------

--- @class yazi.command.Output
---
--- Properties:
--- @field status yazi.command.Status The Status of the child process.
--- @field stdout string The stdout of the child process
--- @field stderr string The stderr of the child process
---
--- @see https://yazi-rs.github.io/docs/plugins/utils#output

------------------------------------ Status ------------------------------------

--- @class yazi.command.Status
---
--- Properties:
--- @field success boolean Whether the child process exited successfully
--- @field code integer The exit code of the child process
---
--- This object represents the exit status of a child process, and it is created by |wait()|, or |output()|.
---
--- @see https://yazi-rs.github.io/docs/plugins/utils#status
