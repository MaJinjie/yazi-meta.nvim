--- @meta shared

------------------------------------ Url ------------------------------------

--- @class yazi.Url
--- @overload fun(path: string):self Create a Url
---
--- Properties:
--- @field frag string The fragment string of the url. Let's say the url archive:///root/my-archive.zip#1.jpg, the fragment 1.jpg
--- @field is_regular boolean Whether the file represented by the url is a regular file
--- @field is_search boolean Whether the file represented by the url from the search result
--- @field is_archive boolean Whether the file represented by the url from an archive
--- @field is_absolute boolean Whether the path represented by the url is absolute
--- @field has_root boolean  Whether the path represented by the url has a root
---
--- Methods:
--- @field name fun(self: self):string? Returns the filename in string if any, otherwise nil
--- @field stem fun(self: self):string? Returns the filename without the extension in string if any, otherwise nil
--- @field join fun(self: self, url: string|self):self Joins with another Url or a string of url, returns a new Url
--- @field parent fun(self: self):self? Returns parent directory Url if any, otherwise nil
--- @field starts_with fun(self: self, url: string|self):boolean Whether the url starts with another Url or a string of url
--- @field ends_with fun(self: self, url: string|self):boolean Whether the url ends with another Url or a string of url
--- @field strip_prefix fun(self: self, url: string|self):self Strips the prefix of another Url or a string of url, returns a new Url
---
--- MetaMethods:
--- @metamethod __eq(another_url)
--- @metamethod __tostring()
--- @metamethod __concat(string)
---
--- Examples:
--- ```lua
--- -- regular file
--- local url = Url("/root/Downloads/logo.png")
---
--- -- `bgm.mp3` from the archive `ost.zip`
--- local url = Url("archive:///root/ost.zip#bgm.mp3")
--- ```
---
--- @see https://yazi-rs.github.io/docs/plugins/types#shared.url

------------------------------------ Cha ------------------------------------

--- @class yazi.Cha
---
--- Properties:
--- @field is_dir boolean Whether this file is a directory
--- @field is_hidden boolean Whether this file is hidden (starts with a dot)
--- @field is_link boolean Whether this file is a symlink
--- @field is_orphan boolean Whether this file is a bad symlink, which points to a non-existent file
--- @field is_dummy boolean Whether the file is dummy, which fails to load complete metadata, possibly the filesystem doesn't support it, such as FUSE.
--- @field is_block boolean Whether this file is a block device
--- @field is_char boolean Whether this file is a character device
--- @field is_fifo boolean Whether this file is a fifo
--- @field is_sock boolean Whether this file is a socket
--- @field is_exec boolean Whether this file is executable
--- @field is_sticky boolean Whether this file has the sticky bit set
--- @field len integer The length of this file, returns an integer representing the size in bytes.
---   Note: that it can't reflect the size of a directory, use size() instead
--- @field atime? integer The accessed time of this file in Unix timestamp, or nil if it doesn't have a valid time
--- @field btime? integer The birth time of this file in Unix timestamp, or nil if it doesn't have a valid time
--- @field mtime? integer The modified time of this file in Unix timestamp, or nil if it doesn't have a valid time
--- @field uid integer (Only Unix) The user id of this file
--- @field gid integer (Only Unix) The group id of this file
--- @field nlink integer (Only Unix) The number of hard links to this file
---
--- Methods:
--- @field perm fun(self: self):string? Unix permissions of this file in string, e.g. drwxr-xr-x. For Windows, it's always nil
---
--- Cha means one file's characteristics.
---
--- @see https://yazi-rs.github.io/docs/plugins/types#shared.cha

------------------------------------ File ------------------------------------

--- @class yazi.File
---
--- Properties:
--- @field url yazi.Url The Url of this file
--- @field cha yazi.Cha The Cha of this file
--- @field link_to yazi.Url? The Url of this file pointing to, if it's a symlink; otherwise, nil
--- @field name string The name of this file
---
--- @see https://yazi-rs.github.io/docs/plugins/types#shared.file

------------------------------------ Icon ------------------------------------

--- @class yazi.Icon
---
--- Properties:
--- @field text string
--- @field style yazi.ui.Style
---
--- @see https://yazi-rs.github.io/docs/plugins/types#shared.icon

------------------------------------ Error ------------------------------------

--- @class yazi.Error
---
--- Properties:
--- @field code integer?
---
--- MetaMethods:
--- @metamethod __tostring()
--- @metamethod __concat(string)
---
--- @see https://yazi-rs.github.io/docs/plugins/types#shared.error

------------------------------------ Range ------------------------------------

--- TODO:

------------------------------------ Window ------------------------------------

--- @class yazi.Window
---
--- Properties:
--- @field rows number The number of rows of this window
--- @field cols number The number of columns of this window
--- @field width number The width of this window in pixels
--- @field height number  The height of this window in pixels

------------------------------------ Others ------------------------------------

--- @alias yazi.SendableType yazi.SendableType[]
--- |boolean
--- |number
--- |string
--- |nil
--- |yazi.Url

--- @alias yazi.Color string|yazi.NamedColor

--- @alias yazi.NamedColor
--- |"reset"
--- |"black"
--- |"white"
--- |"red"
--- |"lightred"
--- |"green"
--- |"lightgreen"
--- |"yellow"
--- |"lightyellow"
--- |"blue"
--- |"lightblue"
--- |"magenta"
--- |"lightmagenta"
--- |"cyan"
--- |"lightcyan"
--- |"gray"
--- |"darkgray"
