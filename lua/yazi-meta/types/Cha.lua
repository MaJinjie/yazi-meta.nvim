--- @meta Cha

--- @see https://yazi-rs.github.io/docs/plugins/types#shared.cha
---
--- Cha means one file's characteristics.
--- @class (exact) yazi.Cha
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
---
--- The length of this file, returns an integer representing the size in bytes.
--- Note: that it can't reflect the size of a directory, use size() instead
--- @field len integer
--- @field atime? integer The accessed time of this file in Unix timestamp, or nil if it doesn't have a valid time
--- @field btime? integer The birth time of this file in Unix timestamp, or nil if it doesn't have a valid time
--- @field mtime? integer The modified time of this file in Unix timestamp, or nil if it doesn't have a valid time
--- @field uid integer (Only Unix) The user id of this file
--- @field gid integer (Only Unix) The group id of this file
--- @field nlink integer (Only Unix) The number of hard links to this file
---
--- Methods:
--- @field perm fun():string? Unix permissions of this file in string, e.g. drwxr-xr-x. For Windows, it's always nil
