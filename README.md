# yazi-meta.nvim

> [!WARNING]
> This plugin is currently under active development. Not all content from Yazi's documentation has been implemented yet.

<!--toc:start-->

- [yazi-meta.nvim](#yazi-metanvim)
  - [Features](#features)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Current Coverage](#current-coverage)
  <!--toc:end-->

yazi-meta.nvim is a Neovim plugin that provides metadata and type completion support for Yazi plugin development, helping developers write Yazi plugins more efficiently through enhanced IDE support.

## Features

- Type annotations for Yazi's plugin API
- Auto-completion for Yazi-specific global objects
- Hover documentation for API methods and types

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

- [x] Context APIs (cx object)
- [x] Core APIs (ya object)
