--- @meta ui

--- @class yazi.Ui
---
--- @see https://yazi-rs.github.io/docs/plugins/layout

--- @class yazi.ui.RenderableElement
---
--- Methods:
--- @field area fun(self: self, rect: yazi.ui.Rect):self Changing the area of the line
--- @field area fun(self: self):yazi.ui.Rect Get the current area
--- @field style fun(self: self, style: yazi.ui.Style):self Set the style of the text
---
--- Text, List, Bar, Border, and Gauge are renderable elements; others need to be placed within any of them.

--- @class yazi.ui.TextBase
---
--- Base classes related to text type.

------------------------------------ Rect ------------------------------------

--- @class yazi.ui.Rect
--- @overload fun(attributes: self):self Create a Rect
---
--- Properties:
--- @field x integer x position
--- @field y integer y position
--- @field w integer width
--- @field h integer height
--- @field left integer left position
--- @field right integer right position
--- @field top integer top position
--- @field bottom integer bottom position
---
--- Methods:
--- @field pad fun(self: self, pad: yazi.ui.Pad):self Apply a Pad.
---
--- A Rect is represented an area within the terminal.
---
--- You can get a pre-computed Rect through ui.Layout().
---
--- Note:
--- if you intend to create a Rect yourself, ensure these values are calculated accurately; otherwise, it may cause Yazi to crash!
---
--- Examples:
--- ```lua
--- ui.Rect {
--- x = 10, -- x position
--- y = 10, -- y position
--- w = 20, -- width
--- h = 30, -- height
--- }
---
--- ui.Rect.default  -- Equal to `ui.Rect { x = 0, y = 0, w = 0, h = 0 }`
--- ```
---
--- @see https://yazi-rs.github.io/docs/plugins/layout#rect
ui.Rect = ...

------------------------------------ Pad ------------------------------------

--- @class yazi.ui.Pad
--- @overload fun(top: integer, right: integer, bottom: integer, left: integer):self
---
--- Properties:
--- @field left integer left padding
--- @field right integer right padding
--- @field top integer top padding
--- @field bottom integer bottom padding
---
--- Methods:
--- If you want to specify only one of them:
--- @field left fun(left: integer):self equal to ui.Pad(left, 0, 0, 0)
--- @field right fun(right: integer):self equal to ui.Pad(0, right, 0, 0)
--- @field top fun(top: integer):self equal to ui.Pad(0, 0, top, 0)
--- @field bottom fun(bottom: integer):self equal to ui.Pad(0, 0, 0, bottom)
---
--- Or specify a particular direction for them:
--- @field x fun(x: integer):self equal to ui.Pad(x, x, 0, 0)
--- @field y fun(y: integer): self equal to ui.Pad(0, 0, y, y)
--- @field xy fun(x: integer, y: integer):self equal to ui.Pad(x, x, y, y)
---
--- @see https://yazi-rs.github.io/docs/plugins/layout#pad
ui.Pad = ...

------------------------------------ Style ------------------------------------

--- @class yazi.ui.Style
--- @overload fun():self
---
--- Methods:
--- @field fg fun(self: self, color: yazi.Color):self Set the foreground color of the style
--- @field bg fun(self: self, color: yazi.Color):self Set the background color of the style
--- @field bold fun(self: self):self Set the style to bold
--- @field dim fun(self: self):self Set the style to dim
--- @field italic fun(self: self):self Set the style to italic
--- @field underline fun(self: self):self Set the style to underline
--- @field blink fun(self: self):self Set the style to blink
--- @field blink_rapid fun(self: self):self Set the style to blink rapidly
--- @field reverse fun(self: self):self Set the style to reverse
--- @field hidden fun(self: self):self Set the style to hidden
--- @field crossed fun(self: self):self Set the style to crossed
--- @field reset fun(self: self):self Reset the style
--- @field patch fun(self: self, style: yazi.ui.Style):self Patch the style with another Style
---
--- @see https://yazi-rs.github.io/docs/plugins/layout#style
ui.Style = ...

------------------------------------ Span ------------------------------------

--- @class yazi.ui.Span: yazi.ui.Style, yazi.ui.TextBase
--- @overload fun(text: string|yazi.ui.TextBase):self
---
--- Methods:
--- @field visible fun(self: self):boolean Whether the span is visible (includes any printable characters)
--- @field style fun(self: self, style: yazi.ui.Style):self Set the style of the span
---
--- Examples:
---
--- Applying the whole Style:
--- ```lua
--- local style = ui.Style():fg("white"):bg("black"):bold()
--- ui.Span("Hello world"):style(style)
--- ```
---
--- You can also call those methods of Style directly on it, which means:
--- ```lua
--- ui.Span("Hello world"):fg("white"):bg("black"):bold()
--- ```
---
--- @see https://yazi-rs.github.io/docs/plugins/layout#span
ui.Span = ...

------------------------------------ Line ------------------------------------

--- @alias yazi.ui.Line.alignment
--- | `ui.Line.LEFT`
--- | `ui.Line.RIGHT`
--- | `ui.Line.CENTER`

--- @class yazi.ui.Line: yazi.ui.Span
--- @overload fun(elem: string|yazi.ui.TextBase):self
--- @overload fun(elems: (string|yazi.ui.TextBase)[]):self
---
--- Properties:
--- @field LEFT ... Left align
--- @field RIGHT ... Right align
--- @field CENTER ... Center align
---
--- Methods:
--- @field area fun(self: self, rect: yazi.ui.Rect):self Changing the area of the line
--- @field area fun(self: self):yazi.ui.Rect Get the current area
--- @field width fun(self: self):integer Get the width of line
--- @field align fun(self: self, alignment: yazi.ui.Line.alignment) set the alignment of the line
---
--- Examples:
--- ui.Line represents a line, consisting of multiple ui.Spans, and it accepts a table of them:
--- ```lua
--- ui.Line { ui.Span("foo"), ui.Span("bar") }
--- ```
--- For convenience, the following types are also supported:
--- ```lua
--- -- string
--- ui.Line("foo")
---
--- -- ui.Span
--- ui.Line(ui.Span("bar"))
---
--- -- ui.Line itself
--- ui.Line(ui.Line("baz"))
---
--- -- Mixed table of string, ui.Span, ui.Line
--- ui.Line { "foo", ui.Span("bar"), ui.Line("baz") }
--- ```
---
--- @see https://yazi-rs.github.io/docs/plugins/layout#line
ui.Line = ...

------------------------------------ Text ------------------------------------

--- @alias yazi.ui.Text.alignment
--- |`ui.Text.LEFT`
--- |`ui.Text.RIGHT`
--- |`ui.Text.CENTER`

--- @alias yazi.ui.Text.wrap
--- |`ui.Text.WRAP_NO`
--- |`ui.Text.WRAP`
--- |`ui.Text.WRAP_TRIM`

--- @class yazi.ui.Text: yazi.ui.Style, yazi.ui.RenderableElement, yazi.ui.TextBase
--- @overload fun(elem: string|yazi.ui.TextBase):self
--- @overload fun(elems: (string|yazi.ui.TextBase)[]):self
---
--- Properties:
--- @field LEFT ... Left align
--- @field RIGHT ... Right align
--- @field CENTER ... Center align
---
--- @field WRAP_NO ... No Wrap
--- @field WRAP ... at the end of the line
--- @field WRAP_TRIM ... at the end of the line, and trim the leading whitespace
---
--- Methods:
--- @field parse fun(code: string):self Parse an ANSI escape sequence string into a text.
---
--- @field align fun(self: self, alignment: yazi.ui.Text.alignment):self Set the alignment of the text
--- @field wrap fun(self: self, wrap: yazi.ui.Text.wrap):self Set the wrap of the text
--- @field max_width fun(self: self):integer Get the maximum width of the text
---
--- Examples:
--- ui.Text is used to represent multi-line text, it takes a table of ui.Line:
--- ```lua
--- ui.Text { ui.Line("foo"), ui.Line("bar") }
--- ```
--- For convenience, the following types are also supported:
--- ```lua
--- -- string
--- ui.Text("foo\nbar")
---
--- -- ui.Line
--- ui.Text(ui.Line("foo"))
---
--- -- ui.Span
--- ui.Text(ui.Span("bar"))
---
--- -- Mixed table of string, ui.Line, ui.Span
--- ui.Text { "foo", ui.Line("bar"), ui.Span("baz") }
--- ```
---
--- @see https://yazi-rs.github.io/docs/plugins/layout#text
ui.Text = ...

------------------------------------ Layout ------------------------------------

--- @alias yazi.ui.Layout.direction
--- |`ui.Layout.HORIZONTAL`
--- |`ui.Layout.VERTIACAL`

--- @class yazi.ui.Layout
--- @overload fun():self Create a layout
---
--- Properties:
--- @field HORIZONTAL ... horizontal direction
--- @field VERTIACAL ... vertical direction
---
--- Methods:
--- @field direction fun(self: self, direction: yazi.ui.Layout.direction):self Set the direction of the layout.
--- @field margin fun(self: self, margin: integer):self Set the margin of the layout.
--- @field margin_h fun(self: self, margin: integer):self Set the horizontal margin of the layout.
--- @field margin_v fun(self: self, margin: integer):self Set the vertical margin of the layout.
--- @field constraints fun(self: self, constraints: yazi.ui.Constraint[]):self Set the constraints of the layout.
--- @field split fun(self: self, rect: yazi.ui.Rect):yazi.ui.Rect[] split it into multiple |rect| according to the constraints.
---
--- Examples:
--- ```lua
--- local areas = ui.Layout()
--- :direction(ui.Layout.HORIZONTAL)
--- :constraints({ ui.Constraint.Percentage(50), ui.Constraint.Percentage(50) })
--- :split(area)
---
--- local left = areas[1] -- The first rect
--- local right = areas[2] -- The second rect
--- ```
--- @see https://yazi-rs.github.io/docs/plugins/layout#layout
ui.Layout = ...

------------------------------------ Constraint ------------------------------------

--- @class yazi.ui.Constraint
--- A constraint that defines the size of a layout element.
---
--- Constraints can be used to specify a fixed size, a percentage of the available space, a ratio of the available space,
--- a minimum or maximum size or a fill proportional value for a layout element.
---
--- Relative constraints (percentage, ratio) are calculated relative to the entire space being divided,
--- rather than the space available after applying more fixed constraints (min, max, length).
---
--- Constraints are prioritized in the following order:
--- |ui.Constraint.Min(min)|
--- |ui.Constraint.Max(max)|
--- |ui.Constraint.Length(len)|
--- |ui.Constraint.Percentage(p)|
--- |ui.Constraint.Ratio(num, den)|
--- |ui.Constraint.Fill(scale)|
---
--- @see https://docs.rs/ratatui/latest/ratatui/layout/enum.Constraint.html for more information.
ui.Constraint = ...

--- Applies a minimum size constraint to the element, The element size is set to at least the specified amount.
---
--- { Percentage(100), Min(20) }
--- ┌────────────────────────────┐┌──────────────────┐
--- │            30 px           ││       20 px      │
--- └────────────────────────────┘└──────────────────┘
---
--- { Percentage(100), Min(10) }
--- ┌──────────────────────────────────────┐┌────────┐
--- │                 40 px                ││  10 px │
--- └──────────────────────────────────────┘└────────┘
---
--- @param min integer
--- @return yazi.ui.Constraint
function ui.Constraint.Min(min) end

--- Applies a maximum size constraint to the element, The element size is set to at most the specified amount.
---
--- { Percentage(0), Max(20) }
--- ┌────────────────────────────┐┌──────────────────┐
--- │            30 px           ││       20 px      │
--- └────────────────────────────┘└──────────────────┘
---
--- { Percentage(0), Max(10) }
--- ┌──────────────────────────────────────┐┌────────┐
--- │                 40 px                ││  10 px │
--- └──────────────────────────────────────┘└────────┘
---
--- @param max integer
--- @return yazi.ui.Constraint
function ui.Constraint.Max(max) end

--- Applies a length constraint to the element, The element size is set to the specified amount.
---
--- { Length(20), Length(20) }
--- ┌──────────────────┐┌──────────────────┐
--- │       20 px      ││       20 px      │
--- └──────────────────┘└──────────────────┘
---
--- { Length(20), Length(30) }
--- ┌──────────────────┐┌────────────────────────────┐
--- │       20 px      ││            30 px           │
--- └──────────────────┘└────────────────────────────┘
---
--- @param len integer
--- @return yazi.ui.Constraint
function ui.Constraint.Length(len) end

--- Applies a percentage of the available space to the element.
--- Converts the given percentage to a floating-point value and multiplies that with area.
--- This value is rounded back to an integer as part of the layout split calculation.
---
--- { Percentage(75), Fill(1) }
--- ┌────────────────────────────────────┐┌──────────┐
--- │                38 px               ││   12 px  │
--- └────────────────────────────────────┘└──────────┘
---
--- { Percentage(50), Fill(1) }
--- ┌───────────────────────┐┌───────────────────────┐
--- │         25 px         ││         25 px         │
--- └───────────────────────┘└───────────────────────┘
---
--- @param p integer
--- @return yazi.ui.Constraint
function ui.Constraint.Percentage(p) end

--- Applies a ratio of the available space to the element.
--- Converts the given ratio to a floating-point value and multiplies that with area.
--- This value is rounded back to an integer as part of the layout split calculation.
---
--- { Ratio(1, 2), Ratio(1, 2) }
--- ┌───────────────────────┐┌───────────────────────┐
--- │         25 px         ││         25 px         │
--- └───────────────────────┘└───────────────────────┘
---
--- { Ratio(1, 4), Ratio(1, 4), Ratio(1, 4), Ratio(1, 4) }
--- ┌───────────┐┌──────────┐┌───────────┐┌──────────┐
--- │   13 px   ││   12 px  ││   13 px   ││   12 px  │
-- └───────────┘└──────────┘└───────────┘└──────────┘
---
--- @param num integer
--- @param den integer
--- @return yazi.ui.Constraint
function ui.Constraint.Ratio(num, den) end

--- Applies the scaling factor proportional to all other Fill elements to fill excess space
--- The element will only expand or fill into excess available space, proportionally matching other Fill elements while satisfying all other constraints.
---
--- { Fill(1), Fill(2), Fill(3) }
--- ┌──────┐┌───────────────┐┌───────────────────────┐
--- │ 8 px ││     17 px     ││         25 px         │
--- └──────┘└───────────────┘└───────────────────────┘
---
--- { Fill(1), Percentage(50), Fill(1) }
--- ┌───────────┐┌───────────────────────┐┌──────────┐
--- │   13 px   ││         25 px         ││   12 px  │
--- └───────────┘└───────────────────────┘└──────────┘
---
--- @param scale integer
--- @return yazi.ui.Constraint
function ui.Constraint.Fill(scale) end

------------------------------------ List ------------------------------------

--- @class yazi.ui.List: yazi.ui.RenderableElement
--- @overload fun(list: (string|yazi.ui.TextBase)[]):self Create a List.
---
--- Examples:
---
--- Create a List that takes a table of ui.Text:
--- ```lua
--- ui.List { ui.Text("foo"), ui.Text("bar") }
--- ```
--- For convenience, the following types are also supported:
--- ```lua
--- -- Table of string
--- ui.List { "foo", "bar" }
---
--- -- Table of ui.Line
--- ui.List { ui.Line("foo"), ui.Line("bar") }
---
--- -- Table of ui.Span
--- ui.List { ui.Span("foo"), ui.Span("bar") }
---
--- -- Mixed table of string, ui.Line, ui.Span
--- ui.List { "foo", ui.Line("bar"), ui.Span("baz") }
--- ```
--- @see https://yazi-rs.github.io/docs/plugins/layout#list
ui.List = ...

------------------------------------ Bar ------------------------------------

--- @alias yazi.ui.Bar.direction # The direction of the bar
--- |`ui.Bar.NONE`
--- |`ui.Bar.TOP`
--- |`ui.Bar.RIGHT`
--- |`ui.Bar.BOTTOM`
--- |`ui.Bar.LEFT`
--- |`ui.Bar.ALL`

--- @class yazi.ui.Bar: yazi.ui.RenderableElement
--- @overload fun(direction: yazi.ui.Bar.direction):self
---
--- Properties:
--- @field NONE ...
--- @field TOP ...
--- @field RIGHT ...
--- @field BOTTOM ...
--- @field LEFT ...
--- @field ALL ...
---
--- Methods:
--- @field symbol fun(self: self, symbol: string):self Specifying the symbol of the bar
---
--- @see https://yazi-rs.github.io/docs/plugins/layout#bar
ui.Bar = ...

------------------------------------ Border ------------------------------------

--- @alias yazi.ui.Border.position # The position of the border
--- |`ui.Border.NONE`
--- |`ui.Border.TOP`
--- |`ui.Border.RIGHT`
--- |`ui.Border.BOTTOM`
--- |`ui.Border.LEFT`
--- |`ui.Border.ALL`

--- @alias yazi.ui.Border.type # The type of athe border
--- |`ui.Border.PLAIN`
--- |`ui.Border.ROUNDED`
--- |`ui.Border.DOUBLE`
--- |`ui.Border.THICK`
--- |`ui.Border.QUADRANT_INSIDE`
--- |`ui.Border.QUADRANT_OUTSIDE`

--- @class yazi.ui.Border: yazi.ui.RenderableElement
--- @overload fun(position: yazi.ui.Border.position):self
---
--- Properties:
--- @field NONE ...
--- @field TOP ...
--- @field RIGHT ...
--- @field BOTTOM ...
--- @field LEFT ...
--- @field ALL ...
---
--- @field PLAIN ...
--- @field ROUNDED ...
--- @field DOUBLE ...
--- @field THICK ...
--- @field QUADRANT_INSIDE ...
--- @field QUADRANT_OUTSIDE ...
---
--- Methods:
--- @field type fun(self: self, type: yazi.ui.Border.type):self Specifying the type of the border
---
--- @see https://yazi-rs.github.io/docs/plugins/layout#border
ui.Border = ...

------------------------------------ Gauge ------------------------------------

--- @class yazi.ui.Gauge: yazi.ui.RenderableElement
--- @overload fun():self
---
--- Methods:
--- @field percent fun(self: self, percent: integer):self Set the percentage of the gauge
--- @field ratio fun(self: self, ratio: integer):self Set the ratio of the gauge
--- @field label fun(self: self, label: string):self Set the label of the gauge
--- @field gauge_style fun(self: self, style: yazi.ui.Style):self Set the style of the bar
---
--- @see https://yazi-rs.github.io/docs/plugins/layout#gauge
ui.Gauge = ...

------------------------------------ Clear ------------------------------------

--- @class yazi.ui.Clear: yazi.ui.RenderableElement
--- @overload fun(rect: yazi.ui.Rect):self
---
--- Clear the content of a specific area.
---
--- Examples:
--- Place it followed by the component that you want to clear:
--- ```lua
--- local components = {
--- ui.Text("..."):area(rect),
--- -- ...
---
--- ui.Clear(rect),
--- }
--- ```
---
--- @see https://yazi-rs.github.io/docs/plugins/layout#clear
ui.Clear = ...
