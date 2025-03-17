--- @meta fs

--- @class yazi.Fs
---
--- @limit async-context
---
--- @see https://yazi-rs.github.io/docs/plugins/utils#fs

--- This function was added to compensate for the lack of a getcwd in Lua. It is used to retrieve the directory of the last chdir call.
---
--- You probably will never need it, and more likely, you'll need cx.active.current.cwd, which is the current directory where the user is working.
--- Specifically, when the user changes the directory, cx.active.current.cwd gets updated immediately, while synchronizing this update with the filesystem via chdir involves I/O operations, such as checking if the directory is valid.
--- So, there may be some delay, which is particularly noticeable on slow devices. For example, when an HDD wakes up from sleep, it typically takes 3~4 seconds.
--- It is useful if you just need a valid directory as the CWD of a process to start some work that doesn't depend on the CWD.
---
--- @return yazi.Url? url The Url of the current working directory if successful; otherwise, nil.
--- @return yazi.Error? err The error if the operation is failed
function fs.cwd() end

--- Get the Cha of the specified file.
---
--- @param url yazi.Url The url of the file
--- @param follow? boolean Whether to follow the symbolic link
--- @return yazi.Cha? cha The Cha of the file if successful; otherwise, nil.
--- @return yazi.Error? err The error if the operation is failed
function fs.cha(url, follow) end

--- Write data to the specified file.
---
--- @param url yazi.Url The url of the file
--- @param data string The data to be written
--- @return boolean ok Whether the operation is successful
--- @return yazi.Error? err The err if the operation is failed
function fs.write(url, data) end

--- Create the specified file(s) in the filesystem.
---
--- @param type # The type of creation
--- |"dir" Creates a new, empty directory.
--- |"dir_all" Recursively create a directory and all of its parents if they are missing.
--- @param url yazi.Url The url of the target
--- @return boolean ok Whether the operation is successful.
--- @return yazi.Error? err The error if the operation is failed.
function fs.create(type, url) end

--- Remove the specified file(s) in the filesystem.
---
--- @param type # The type of creation
--- |"file" Removes a file from the filesystem.
--- |"dir" Removes an existing, empty directory.
--- |"dir_all" Removes a directory at this url, after removing all its contents. Use carefully!
--- |"dir_clean" Remove all empty directories under it, and if the directory itself is empty afterward, remove it as well.
--- @param url yazi.Url The url of the target
--- @return boolean ok Whether the operation is successful.
--- @return yazi.Error? err The error if the operation is failed.
function fs.remove(type, url) end

--- Reads the contents of a directory.
---
--- @param url yazi.Url The url of the directory
--- @param options? {glob?: string, limit?: integer, resolve?: boolean}
---   glob - A glob pattern to filter files out if provided.
---   limit - The maximum number of files to read, which is an integer, defaults to unlimited.
---   resolve - Whether to resolve symbolic links, defaults to false.
--- @return yazi.fs.Files? files A table of File if successful; otherwise, nil.
--- @return yazi.Error? err The error if the operation is failed.
function fs.read_dir(url, options) end

--- Get a unique name from the given Url to ensure it's unique in the filesystem.
---
--- Note: If the file already exists, the function will append _n to the filename, where n is a number, and keep incrementing it until it finds the first available name.
---
--- @param url yazi.Url The url of the path to get a unique name
--- @return yazi.Url? url  The unique Url of the given path if successful; otherwise, nil.
--- @return yazi.Error? err The error if the operation is failed.
function fs.unique_name(url) end
