--- @meta ps

--- @class yazi.ps
---
--- @limit sync-context
--- Yazi's pub-sub system for cross-instance communication and state persistence.
--- Yazi's DDS (Data Distribution Service) uses a Lua-based publish-subscribe model as its carrier.
--- See [DDS](https://yazi-rs.github.io/docs/dds) for details.
---
--- @see https://yazi-rs.github.io/docs/plugins/utils#ps
_G.ps = ...

--- Publish a message to the current instance.
--- all plugins subscribed through sub() for this kind will receive it, achieving internal communication within the instance.
---
--- For examples:
--- ```lua
--- ps.pub("my-plugin-status", { progress = 75, msg = "Processing..." })
---
--- ps.pub("file-manager-delete", {
---   target = cx.active.current.hovered,
---   timestamp = ya.time()
--- })
--- ```
--- @param kind string the kind of the message, which is a string of alphanumeric with dashes, and cannot be built-in kinds.
---   Since the kind is used globally, to add the plugin name as the prefix is a best practice. For example, the combination of the plugin my-plugin and the kind event1 would be my-plugin-event1.
--- @param value yazi.SendableType Serializable data
---
--- @see https://yazi-rs.github.io/docs/plugins/utils#ps.pub
function ps.pub(kind, value) end

--- Publish a message to a specific instance with |receiver| as the ID:
---   - If the |receiver| is the current instance (local), and is subscribed to this |kind| through sub(), it will receive this |value|.
---   - If the |receiver| is not the current instance (remote), and is subscribed to this |kind| through sub_remote(), it will receive this |value|..
---
--- For examples:
--- ```lua
--- ps.pub_to(0, "global-sync", { version = "1.2.0" })
---
--- ps.pub_to(1711957283332834, "private-msg", {
---   from = ya.host_name(),
---   content = "Data ready for pickup"
--- })
--- ```
---
--- @param receiver integer ID of the remote instance. if it's 0 then broadcasting to all remote instances.
--- @param kind string The same as [pub](lua://ps.pub).
--- @param value yazi.SendableType The same as [pub](lua://ps.pub).
---
--- @see https://yazi-rs.github.io/docs/plugins/utils#ps.pub_to
function ps.pub_to(receiver, kind, value) end

--- Subscribe to local messages of |kind| and call the |callback| handler for it.
---
--- It runs in a sync context, so you can access app data via cx for the content of interest.
--- Note: No time-consuming operations should be done in the callback, and the same kind from the same plugin can only be subscribed once, re-subscribing (sub()) before unsubscribing (unsub()) will throw an error.
---
--- For examples:
--- ```lua
--- ps.sub("file-saved", function(body)
---   ya.notify { title = "Change detected", content = body.path }
---   cx.active.current:reload()
--- end)
--- ```
---
--- @param kind string The kind of the message
--- @param callback fun(body: any):nil Handler runs in sync context
---
--- @see https://yazi-rs.github.io/docs/plugins/utils#ps.sub
function ps.sub(kind, callback) end

--- Similar to sub(), but it subscribes to remote messages of this kind instead of local.
--- @param kind string
--- @param callback fun(body: any):nil
---
--- @see ps.sub
function ps.sub_remote(kind, callback) end

--- Unsubscribe from local messages of this |kind|.
---
--- For examples:
--- ```lua
--- function plugin.unload()
---   ps.unsub("my-plugin-events")
---   ps.unsub_remote("my-plugin-sync")
--- end
--- ```
--- @param kind string The kind of the message
---
--- @see ps.pub
function ps.unsub(kind) end

--- Unsubscribe from remote messages of this |kind|.
--- @param kind string The kind of the message
---
--- @see ps.pub
function ps.unsub_remote(kind) end
