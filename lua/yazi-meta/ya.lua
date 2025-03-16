--- @meta ya

--- @class YaziYa
---
--- @see https://yazi-rs.github.io/docs/plugins/utils
_G.ya = ...

--- @class yazi.ya.permit
--- @field drop fun(self) Release terminal control and restore TUI display

--- @limit async-context
---
--- Hide Yazi to the secondary screen by returning to the terminal, completely controlled by the requested plugin.
--- This method returns a permit for this resource. When it's necessary to restore the TUI display, call its drop() method.
--- ```lua
--- local permit = ya.hide()
--- -- Execute terminal operations
--- permit:drop()  -- Restore TUI
--- ```
--- Note that since there's always only one available terminal control resource,
--- ya.hide() cannot be called again before the previous permit is dropped,
--- otherwise an error will be thrown, effectively avoiding deadlocks.
---
--- @return yazi.ya.permit permit
---
--- @see https://yazi-rs.github.io/docs/plugins/utils#ya.hide
function ya.hide() end

--- @class yazi.ya.file_cache.Opts
--- @field file yazi.File The File to be cached.
--- @field skip number The number of units to skip. It's units largely depend on your previewer, such as lines for code, and percentages for videos.

--- Calculate the cached Url corresponding to the given file
--- If the file is not allowed to be cached, such as it's ignored in the user config, or the file itself is a cache, returns nil.
---
--- Example:
--- ```lua
--- local cache_url = ya.file_cache {
---   file = hovered_file,
---   skip = 20  -- Skip 20 lines/percentage
--- }
--- ```
---
--- @param opts yazi.ya.file_cache.Opts The options of the cache
--- @return yazi.Url url
---
--- @see https://yazi-rs.github.io/docs/plugins/utils#ya.file_cache
function ya.file_cache(opts) end

--- @limit sync-context
---
--- Re-render the UI.
--- For example:
--- ```lua
--- local update_state = ya.sync(function(self, new_state)
---   self.state = new_state
---   ya.render()
--- end)
--- ```
---
--- @see https://yazi-rs.github.io/docs/plugins/utils#ya.render
function ya.render() end

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

--- @limit async-context
---
--- Display the given image within the specified area, and the image will downscale to fit that area automatically.
---
--- @param url yazi.Url The Url of the image.
--- @param rect yazi.ui.Rect The Rect of the area.
---
--- @see https://yazi-rs.github.io/docs/plugins/utils#ya.image_show
function ya.image_show(url, rect) end

--- @limit async-context
---
--- Pre-cache the image to a specified url based on user-configured max_width and max_height.
---
--- @param src yazi.Url The source Url of the image.
--- @param dist yazi.Url The destination Url of the image.
---
--- @see https://yazi-rs.github.io/docs/plugins/utils#ya.image_precache
function ya.image_precache(src, dist) end

--- @class yazi.ya.cand
--- @field on string|string[] The key to be prompted, which is a string or a table of strings if multiple keys.
--- @field desc? string The description of the key

--- @limit async-context
---
--- Prompt users with a set of available keys.
---
--- Example:
--- ```lua
--- local idx = ya.which {
---   cands = {
---     { on = "A", desc = "Approve" },
---     { on = {"<Space>", "d"}, desc = "Delete" }
---   }
--- }
--- ```
--- When the user clicks a valid candidate, ya.which returns the 1-based index of that cand
--- otherwise, it returns nil, indicating that the user has canceled the key operation.
---
--- @param opts {cands: yazi.ya.cand[], silent?: boolean}  the options of the prompt.
---   cands -  the key candidates
---   silent - whether to show the UI of key indicator
--- @return integer? index
---
--- @see https://yazi-rs.github.io/docs/plugins/utils#ya.which
function ya.which(opts) end

--- @class yazi.ya.input.Opts
--- @field title string The title of the input
--- @field value? string The default value of the input
--- @field position yazi.ya.input.Position The position of the input
--- @field realtime? boolean Whether to report user input in real time
--- @field debounce? integer
--- The number of seconds to wait for the user to stop typing, which is a positive float.
--- Can only be used when realtime = true.

--- @class yazi.ya.input.receiver
--- @field recv fun(self):string?, yazi.ya.input.event

--- @class yazi.ya.input.Position
--- @field [1] yazi.ya.input.position The origin position of the input
--- @field x? integer The X offset from the origin position, which is an positive or negative integer.
--- @field y? integer The Y offset from the origin position, which is an positive or negative integer.
--- @field w integer The width of the input, which is an positive integer.
--- @field h? integer The height of the input, which is an positive integer.

--- @alias yazi.ya.input.position
--- |"top-left" |"top-center" |"top-right"
--- |"bottom-left" |"bottom-center" |"bottom-center"
--- |"center"
--- |"hovered"

--- @alias yazi.ya.input.event
--- | 0 Unknown error.
--- | 1 The user has confirmed the input.
--- | 2 The user has canceled the input.
--- | 3 The user has changed the input (only if realtime is true).

--- Request user input once.
--- For examples:
--- ```lua
---  local value, event = ya.input {
---  title = "Archive name:",
---  position = { "top-center", y = 3, w = 40 },
---  }
--- ```
---
--- Request user input multiple times.
--- ```lua
--- local receiver = ya.input {
--- title = "Input in realtime:",
--- position = { "center", w = 50 },
--- realtime = true,
--- }
---
--- while true do
--- local value, event = receiver:recv()
--- if not value then
---   break
--- end
---
--- ya.err(value)
--- end
--- ```
--- @overload fun(opts: yazi.ya.input.Opts):yazi.ya.input.receiver A receiver that can accept user input events multiple times
--- @param opts yazi.ya.input.Opts
--- @return string? value The user input value carried by this event, which is a string if the event is non-zero; otherwise, nil.
--- @return yazi.ya.input.event event The event type
---
--- @see https://yazi-rs.github.io/docs/plugins/utils#ya.input
function ya.input(opts) end

--- @class yazi.ya.notify.Opts
--- @field title string The title of the notification, which is a string.
--- @field content string The content of the notification, which is a string.
--- @field timeout number The timeout of the notification, which is an non-negative float in seconds.
--- @field level? yazi.ya.notify.level The level of the notification. Default is "info"

--- @alias yazi.ya.notify.level "info"|"warn"|"error"

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

--- @class yazi.ya.preview.Opts
--- @field area yazi.ui.Rect Rect of the available preview area.
--- @field file yazi.File File to be previewed.
--- @field mime string String of the MIME type of the file.
--- @field skip integer Number of units to skip. The units depend on your previewer, such as lines for code and percentages for videos.

--- @limit async-context
---
--- Preview the file as code into the specified area.
---
--- @param opts yazi.ya.preview.Opts The options of the preview
--- @return string? err Error string if the preview fails; otherwise, nil.
--- @return integer? upper_bound If the preview fails and it's because exceeds the maximum upper bound, return this bound; otherwise, nil.
---
--- @see https://yazi-rs.github.io/docs/plugins/utils#ya.preview_code
function ya.preview_code(opts) end

--- @limit async-context
---
--- Previeww_widgets allow plugin developers to dynamically generate and render custom preview interfaces based on file types and user requirements.
--- By passing in a set of renderable widgets, developers can fully control the layout and display of preview content.
---
--- @param opts yazi.ya.preview.Opts The options of the preview
--- @param widgets yazi.ui.Base[] List of renderable widgets.
---   Each component is a UI component, These components will be rendered in the preview area in the order of the list.
--- @return string? err Error string if the preview fails; otherwise, nil.
--- @return integer? upper_bound If the preview fails and it's because exceeds the maximum upper bound, return this bound; otherwise, nil.
---
--- @see https://yazi-rs.github.io/docs/plugins/utils#ya.preview_widgets
function ya.preview_widgets(opts, widgets) end

--- You can also obtain a small amount of app data from the sync context by calling a "sync function"
---
--- For examples:
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
---
--- @see https://yazi-rs.github.io/docs/plugins/overview#async-context
function ya.sync(fn) end

--- @alias yazi.ya.target_os
---|"linux"
---|"macos"
---|"ios"
---|"freebsd"
---|"dragonfly"
---|"netbsd"
---|"openbsd"
---|"solaris"
---|"android"
---|"windows"

--- Get the specific operating system in use.
---
--- @return yazi.ya.target_os
function ya.target_os() end

--- @alias yazi.ya.target_family
---|"unix"
---|"windows"
---|"wasm"

--- Get the family of the operating system.
---
--- @return yazi.ya.target_family
function ya.target_family() end

--- Get the hash of a given string.
--- It is designed to work with algorithm-independent tasks, such as generating file cache names.
---
--- @param str string The string to calculate the hash for.
--- @return string hash
function ya.hash(str) end

--- Quote characters that may have special meaning in a shell.
---
--- @param str string The string to be quoted.
--- @return string # the string after quoting
function ya.quote(str) end

--- Truncate the text to the specified length.
---
--- @param text string The text to be truncaFed
--- @param opts {max: integer, rtl?: boolean} The options of the truncation.
---   max - the maximum length of the text
---   rtl - whether the text is right-to-left
function ya.truncate(text, opts) end

--- @limit async-context
--- Get the content of the system clipboard.
---
--- @return string
function ya.clipboard() end

--- @limit async-context
--- Set the content of the system clipboard.
---
--- @param text string
function ya.clipboard(text) end

--- Get the current timestamp.
---
--- @return integer timestamp It is a float, the integer part represents the seconds, and the decimal part represents the milliseconds.
function ya.time() end

--- @limit async-context
--- Waits until |secs| has elapsed.
---
--- @param secs integer The number of seconds to sleep, which is a positive float.
function ya.sleep(secs) end

--- @limit unix-os
--- Get the user id of the current user.
---
--- @return integer
function ya.uid() end

--- @limit unix-os
--- Get the group id of the current user.
---
--- @return integer
function ya.gid() end

--- @limit unix-os
--- Get the name of the user.
---
--- @param uid? integer The user id of the user. If not set, it will use the current user's id.
--- @return string? Returns The name of the current user, if successful; otherwise, nil.
function ya.user_name(uid) end

--- @limit unix-os
--- Get the name of the user group.
---
--- @param gid? integer The group id of the user.If not set, it will use the current user's group id.
--- @return string? gname The name of the current group, if successful; otherwise, nil.
function ya.group_name(gid) end

--- @limit unix-os
--- Get the name of the host.
---
--- @return string? hostname The hostname of the current machine, if successful; otherwise, nil.
function ya.host_name() end
