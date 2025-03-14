--- @meta mgr

--- @see https://yazi-rs.github.io/docs/plugins/types#app-data.mgr-tabs
---
--- @class yazi.mgr.Tabs
---
--- Properties:
--- @field idx integer The index of the active tab
---
--- MetaMethods:
--- @metamethod __len()
--- @metamethod __index(idx) Access the tab::Tab by index

--- @see https://yazi-rs.github.io/docs/plugins/types#app-data.mgr-yanked
---
--- @class yazi.mgr.Yanked
--- @field [number] yazi.Url
---
--- Properties:
--- @field is_cut boolean Whether the yanked urls are cut.
---
--- MetaMethods:
--- @metamethod __len()
--- @metamethod __pairs() Iterate over the yanked Urls.
