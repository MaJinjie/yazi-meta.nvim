# yazi-meta.nvim

> [!WARNING]
> This plugin is currently under active development. Not all content from Yazi's documentation has been implemented yet.

<!--toc:start-->

- [yazi-meta.nvim](#yazi-metanvim)
  - [Features](#features)
  - [Requirements](#requirements)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Current Coverage](#current-coverage)
  <!--toc:end-->

yazi-meta.nvim is a Neovim plugin that provides metadata and type completion support for Yazi plugin development, helping developers write Yazi plugins more efficiently through enhanced IDE support.

## Features

- Type annotations for Yazi's plugin API
- Auto-completion for Yazi-specific global objects
- Hover documentation for API methods and types

## Requirements

- [yazi](https://github.com/sxyazi/yazi) 25.2.26 or later

## Installation

With [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
return {
  "MaJinjie/yazi-meta.nvim",
  lazy = true,
}
```

## Usage

With [lazydev.nvim](https://github.com/folke/lazydev.nvim).

```lua
return {
  "folke/lazydev.nvim",
  ft = "lua",
  cmd = "LazyDev",
  opts = {
    library = {
      { path = "yazi-meta.nvim", words = { "ya", "cx", ... } },
    },
  },
}
-- or using
---@module 'yazi-meta'
```

## Current Coverage

- [x] [Plugins/Types](https://yazi-rs.github.io/docs/plugins/types)
- [x] [Plugins/Layout](https://yazi-rs.github.io/docs/plugins/layout)
- [x] [Plugins/Utils](https://yazi-rs.github.io/docs/plugins/utils)

TODO:

- [Plugins/Config](https://yazi-rs.github.io/docs/plugins/config)
- `PluginSpec` The specification of the yazi plugin, which is the return value of the main.lua module.
  For example, the peek of the object, Seek method
- Some special objects related to yazi.
  For example: Status, Header

> [!NOTE]
> Most APIs currently implemented in this plugin have not been thoroughly validated through practical use.
> The documentation descriptions are primarily based on the [Yazi official documentation](https://yazi-rs.github.io/docs).
> Please feel free to submit corrections through issues or pull requests if you find any discrepancies.
