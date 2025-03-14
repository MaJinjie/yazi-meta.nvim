--- @meta cx

--- @see https://yazi-rs.github.io/docs/plugins/types#app-data
---
--- You can access all app data through the cx within Sync context.
---
--- @class YaziCx
--- @field active yazi.tab.Tab The active tab
--- @field tabs yazi.mgr.Tabs All of tabs
--- @field tasks yazi.tasks.Tasks All of tasks
--- @field yanked yazi.mgr.Yanked The yanked urls
_G.cx = ...
