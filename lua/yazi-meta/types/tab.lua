--- @meta tab

--- @see https://yazi-rs.github.io/docs/plugins/types#app-data.tab-tab
---
--- @class (exact) yazi.tab.Tab
---
--- Properties:
--- @field mode yazi.tab.Mode The tab::Mode of this tab.
--- @field pref yazi.tab.Preference The tab::Preference of this tab.
--- @field current yazi.tab.Folder The current folder within this tab, which is a tab::Folder.
--- @field parent yazi.tab.Folder? The parent folder within this tab, which is a tab::Folder if current has a parent; otherwise, nil.
--- @field selected yazi.tab.Selected  The selected files within this tab, which is a tab::Selected.
--- @field preview yazi.tab.Preview The tab::Preview within this tab.

--- Visual mode status.
--- @see https://yazi-rs.github.io/docs/plugins/types#app-data.tab-mode
---
--- @class (exact) yazi.tab.Mode
---
--- Properties:
--- @field is_select boolean Whether the mode is select
--- @field is_unset boolean Whether the mode is unset
--- @field is_visual boolean Whether the mode is select or unset
---
--- MetaMethods:
--- @metamethod __tostring()

--- @see https://yazi-rs.github.io/docs/plugins/types#app-data.tab-preference
---
--- @class (exact) yazi.tab.Preference
---
--- Properties:
--- @field sort_by string File sorting method.
--- @field sort_sensitive boolean Sort case-sensitively.
--- @field sort_reverse boolean Display files in reverse order.
--- @field sort_dir_first boolean Display directories first.
--- @field sort_translit boolean Transliterate filenames for sorting.
--- @field linemode string Display information associated with the file on the right side of the file list row.
--- @field show_hidden true Show hidden files.

--- @see https://yazi-rs.github.io/docs/plugins/types#app-data.tab-folder
---
--- @class (exact) yazi.tab.Folder
---
--- Properties:
--- @field cwd yazi.Url The current working directory of this folder, which is a Url
--- @field offset integer The offset of this folder, which is an integer
--- @field cursor integer The cursor position of this folder, which is an integer
--- @field window yazi.File A table of File in the visible area of this folder
--- @field files yazi.fs.Files The fs::Files of this folder
--- @field hovered yazi.File The hovered File of this folder, or nil if there is no hovered file

--- @class (exact) yazi.tab.Selected
--- @field [number] yazi.Url
---
--- MetaMethods:
--- @metamethod __len()
--- @metamethod __pairs() Iterate over the selected Urls.

---
--- @class (exact) yazi.tab.Preview
---
--- Properties:
--- @field skip integer The number of units to skip. The units largely depend on your previewer, such as lines for code and percentages for videos.
--- @field folder yazi.tab.Folder The tab::Folder being previewed, or nil if this preview is not for folders
