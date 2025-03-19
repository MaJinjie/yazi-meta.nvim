--- @meta cx

--- @class yazi.Cx
---
--- Properties:
--- @field active yazi.cx.Tab The active tab
--- @field tabs yazi.cx.Tabs All of tabs
--- @field tasks yazi.cx.Tasks All of tasks
--- @field yanked yazi.cx.Yanked The yanked urls
---
--- You can access all app data through the cx within Sync context.
---
--- @see https://yazi-rs.github.io/docs/plugins/types#app-data

------------------------------------ Tasks ------------------------------------

--- @class yazi.cx.Tasks
---
--- Properties:
--- @field progress yazi.cx.Tasks.Progress[]

--- @class yazi.cx.Tasks.Progress
---
--- Properties:
--- @field total number Total number of tasks
--- @field succ number The number of successful tasks
--- @field fail number The number of failed tasks
--- @field found number ...
--- @field processed number ...
---
--- @see https://yazi-rs.github.io/docs/plugins/types#app-data.tasks-tasks

------------------------------------ Tab ------------------------------------

--- @class yazi.cx.Tab
---
--- Properties:
--- @field mode yazi.cx.Mode The tab::Mode of this tab.
--- @field pref yazi.cx.Preference The tab::Preference of this tab.
--- @field current yazi.cx.Folder The current folder within this tab, which is a tab::Folder.
--- @field parent? yazi.cx.Folder The parent folder within this tab, which is a tab::Folder if current has a parent; otherwise, nil.
--- @field selected yazi.cx.Selected  The selected files within this tab, which is a tab::Selected.
--- @field preview yazi.cx.Preview The tab::Preview within this tab.
---
--- @see https://yazi-rs.github.io/docs/plugins/types#app-data.tab-tab

------------------------------------ Tabs ------------------------------------

--- @class yazi.cx.Tabs
---
--- Properties:
--- @field idx integer The index of the active tab
---
--- MetaMethods:
--- @metamethod __len()
--- @metamethod __index(idx) Access the tab::Tab by index
---
--- @see https://yazi-rs.github.io/docs/plugins/types#app-data.mgr-tabs

------------------------------------ Mode ------------------------------------

--- @class yazi.cx.Mode
---
--- Properties:
--- @field is_select boolean Whether the mode is select
--- @field is_unset boolean Whether the mode is unset
--- @field is_visual boolean Whether the mode is select or unset
---
--- MetaMethods:
--- @metamethod __tostring() return "select"|"unset"|"normal"
---
--- Visual mode status.
---
--- @see https://yazi-rs.github.io/docs/plugins/types#app-data.tab-mode

------------------------------------ Preference ------------------------------------

--- @class yazi.cx.Preference
---
--- Properties:
--- @field sort_by string File sorting method.
--- @field sort_sensitive boolean Sort case-sensitively.
--- @field sort_reverse boolean Display files in reverse order.
--- @field sort_dir_first boolean Display directories first.
--- @field sort_translit boolean Transliterate filenames for sorting.
--- @field linemode string Display information associated with the file on the right side of the file list row.
--- @field show_hidden true Show hidden files.
---
--- @see https://yazi-rs.github.io/docs/plugins/types#app-data.tab-preference

------------------------------------ Folder ------------------------------------

--- @class yazi.cx.Folder
---
--- Properties:
--- @field cwd yazi.Url The current working directory of this folder, which is a Url
--- @field offset integer The offset of this folder, which is an integer
--- @field cursor integer The cursor position of this folder, which is an integer
--- @field window yazi.File[] A table of File in the visible area of this folder
--- @field files yazi.cx.Files The fs::Files of this folder
--- @field hovered? yazi.File The hovered File of this folder, or nil if there is no hovered file
---
--- @see https://yazi-rs.github.io/docs/plugins/types#app-data.tab-folder

------------------------------------ Selected ------------------------------------

--- @class yazi.cx.Selected
--- @field [number] yazi.Url
---
--- MetaMethods:
--- @metamethod __len()
--- @metamethod __pairs() Iterate over the selected Urls.
---
--- @see https://yazi-rs.github.io/docs/plugins/types#app-data.tab-selected

------------------------------------ Preview ------------------------------------

--- @class yazi.cx.Preview
---
--- Properties:
--- @field skip integer The number of units to skip. The units largely depend on your previewer, such as lines for code and percentages for videos.
--- @field folder? yazi.cx.Folder The tab::Folder being previewed, or nil if this preview is not for folders
---
--- @see https://yazi-rs.github.io/docs/plugins/types#app-data.tab-preview

------------------------------------ Yanked ------------------------------------

--- @class yazi.cx.Yanked
--- @field [number] yazi.Url
---
--- Properties:
--- @field is_cut boolean Whether the yanked urls are cut.
---
--- MetaMethods:
--- @metamethod __len()
--- @metamethod __pairs() Iterate over the yanked Urls.
---
--- @see https://yazi-rs.github.io/docs/plugins/types#app-data.mgr-yanked

------------------------------------ File ------------------------------------

--- @class yazi.cx.File: yazi.File
---
--- Methods:
--- @field size fun(self: self):integer? The size of this file in bytes, or nil if its a directory and it has not been evaluated
--- @field mime fun(self: self):string? The mime-type of this file, or nil if it's a directory or hasn't been lazily calculated at all
--- @field prefix fun(self: self):string The prefix of this file relative to CWD, which used in the flat view during search.
---   For instance, if CWD is /foo, and the file is /foo/bar/baz, then the prefix is bar/
--- @field icon fun(self: self):yazi.Icon? The Icon of this file, [icon] rules are applied; if no rule matches, returns nil
--- @field style fun(self: self):yazi.ui.Style? The Style of this file, [filetype] rules are applied; if no rule matches, returns nil
--- @field is_hovered fun(self: self):boolean Whether this file is hovered
--- @field is_yanked fun(self: self):boolean Whether this file is yanked
--- @field is_selected fun(self: self):boolean Whether this file is selected
---
--- @field found fun(self: self):[integer, number]? When users find a file using the find command, the status of the file
---   nil - if it doesn't match the user's find keyword
---   {idx, all} - where idx is the position of matched file, and all represents the number of all matched files
---  TODO: Waiting for yazi document
---
--- @see https://yazi-rs.github.io/docs/plugins/types#app-data.fs-file

------------------------------------ Files ------------------------------------

--- @class yazi.cx.Files
--- @field [number] yazi.cx.File
---
--- MetaMethods:
--- @metamethod __len()
--- @metamethod __index(idx) Access the fs::File by index
---
--- @see https://yazi-rs.github.io/docs/plugins/types#app-data.fs-files
