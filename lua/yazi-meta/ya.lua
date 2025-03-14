--- @meta ya

--- @see https://yazi-rs.github.io/docs/plugins/utils
---
--- @class YaziYa
_G.ya = ...

--- Hide Yazi to the secondary screen by returning to the terminal, completely controlled by the requested plugin.
--- This method returns a permit for this resource. When it's necessary to restore the TUI display, call its drop() method.
--- ```lua
--- local permit = ya.hide()
---
--- permit:drop()
--- ```
--- Note that since there's always only one available terminal control resource,
--- ya.hide() cannot be called again before the previous permit is dropped,
--- otherwise an error will be thrown, effectively avoiding deadlocks.
---
--- This function is only available in the async context.
---
--- @return yazi.ya.permit permit
function ya.hide() end

--- Send a command to the [manager] without waiting for the executor to execute.
--- ```lua
--- ya.mgr_emit("my-cmd", { "hello", 123, foo = true, bar_baz = "world" })
---
--- -- Equivalent to:
--- -- my-cmd "hello" "123" --foo --bar-baz="world"
--- ```
---
--- @param cmd string the command name, which is a string.
--- @param args table<number|string, yazi.SendableType> the arguments of the command, which is a table with a number or string key and sendable values.
function ya.mgr_emit(cmd, args) end

--- Request user input.
---
--- @param opts yazi.ya.input.Opts
function ya.input(opts) end

--- Send a foreground notification to the user.
---
--- @param opts yazi.ya.notify.Opts The options of the notification.
function ya.notify(opts) end

--- Append messages to the log file at the debug level.
--- ```lua
--- ya.dbg("Hello", "World!")                       -- Multiple arguments are supported
--- ya.dbg({ foo = "bar", baz = 123, qux = true })  -- Any type of data is supported
--- ```
---
--- @param msg any The message to be logged.
--- @param ...any
function ya.dbg(msg, ...) end

--- Append messages to the log file at the error level.
--- @see ya.dbg
function ya.err(msg, ...) end

--- @see https://yazi-rs.github.io/docs/plugins/overview#async-context
---
--- You can also obtain a small amount of app data from the sync context by calling a "sync function"
--- ```lua
--- -- ~/.config/yazi/plugins/my-async-plugin.yazi/main.lua
--- local set_state = ya.sync(function(state, a)
---   -- You can get/set the state of the plugin through `state` parameter
---   -- in the `sync()` block
---   state.a = a
--- end)
---
--- local get_state = ya.sync(function(state, b)
---   -- You can access all app data through the `cx`,
---   -- within the `sync()` block, in an async plugin
---   local h = cx.active.current.hovered
---   return h and state.a .. tostring(h.url) or b
--- end)
---
--- return {
---   entry = function()
---     set_state("hello from a")
---     local h = get_state("hello from b")
---     -- Do some time-consuming work, such as reading file, network request, etc.
---     -- It will execute concurrently with the main thread
---   end,
--- }
--- ```
---
--- @generic R
--- @param fn fun(self, ...):R
--- @return fun(...):R
function ya.sync(fn) end

--- ```
--- ```

--- @class yazi.ya.permit
--- @field drop fun(self)

--- @class yazi.ya.input.Opts
--- @field title string The title of the input
--- @field value? string The default value of the input
--- @field position yazi.ya.input.position The position of the input
--- @field realtime? boolean Whether to report user input in real time
---
--- The number of seconds to wait for the user to stop typing, which is a positive float.
--- Can only be used when realtime = true.
--- @field debounce? integer

--- @class yazi.ya.input.position
--- @field [1] "top-left"|"top-center"|"top-right"|"bottom-left"|"bottom-center"|"bottom-right"|"center"|"hovered" The origin position of the input
--- @field x? integer The X offset from the origin position, which is an positive or negative integer.
--- @field y? integer The Y offset from the origin position, which is an positive or negative integer.
--- @field w integer The width of the input, which is an positive integer.
--- @field h? integer The height of the input, which is an positive integer.

--- @class yazi.ya.notify.Opts
--- @field title string The title of the notification, which is a string.
--- @field content string The content of the notification, which is a string.
--- @field timeout number The timeout of the notification, which is an non-negative float in seconds.
--- @field level? yazi.ya.notify.level The level of the notification. Default is "info"

--- @alias yazi.SendableType yazi.SendableType[]
--- |boolean
--- |number
--- |string
--- |nil
--- |yazi.Url

--- @alias yazi.ya.notify.level "info"|"warn"|"error"
