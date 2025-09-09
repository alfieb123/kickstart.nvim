require('colorbuddy').colorscheme 'alfie_light_blue_1'

local colorbuddy = require 'colorbuddy'
local Color = colorbuddy.Color
local Group = colorbuddy.Group
local c = colorbuddy.colors
local s = colorbuddy.styles

-- Background and UI
-- Background and UI (darker but still "light")
Color.new('background', '#d1e6f5') -- was #eaf6ff
Color.new('very_soft_shadow', '#c3d9eb') -- was #e0f0fb
Color.new('soft_shadow', '#b4c8d8') -- was #d1e0eb

-- Main palette
Color.new('ink', '#0a0e18') -- was #0c111c
Color.new('storm', '#192434') -- was #1e293b
Color.new('velvet', '#301b36') -- was #392040
Color.new('dusk', '#422f4a') -- was #503a5a
Color.new('indigo', '#4c3d72') -- was #5e4b8b
Color.new('wine', '#4c2537') -- was #5c2f45
Color.new('royal', '#262f66') -- was #2e3a7f
Color.new('shadow_purple', '#2a1f3d') -- was #33254c

-- Highlights and accents
Color.new('highlight_bg', '#91b9d5') -- was #aacdee
Color.new('highlight_fg', '#141d28') -- was #1a2633
Color.new('soft_white', '#e6f0fa') -- was #f2f6ff
Color.new('alert_red', '#ff3355') -- same or tweak as needed

-- Apply to floating windows
Group.new('NormalFloat', c.ink, c.soft_shadow)
Group.new('FloatBorder', c.float_border, c.velvet, s.bold)

-- Normal background & fallback
Group.new('Normal', c.ink, c.background)

-- Folded stuff
Group.new('Folded', c.ink, c.very_soft_shadow)
Group.new('FoldColumn', c.ink, c.very_soft_shadow)

-- Cursor & line markers
Group.new('CursorLine', nil, c.soft_shadow)
Group.new('CursorLineNr', c.indigo, c.very_soft_shadow, s.bold)
Group.new('LineNr', c.storm, c.very_soft_shadow)
Group.new('Visual', nil, c.soft_shadow)

-- Tabline and interface
Group.new('TabLine', c.ink, c.very_soft_shadow)
Group.new('TabLineSel', c.indigo, c.very_soft_shadow, s.bold)
Group.new('TabLineFill', c.very_soft_shadow, c.very_soft_shadow)
Group.new('StatusLine', c.ink, c.very_soft_shadow)
Group.new('VertSplit', c.very_soft_shadow, c.background)
Group.new('WinSeparator', c.alert_red, c.background, s.bold)
Group.new('ColorColumn', nil, c.very_soft_shadow)

-- LSP "word under cursor" highlights
Group.new('LspReferenceText', c.highlight_fg, c.highlight_bg)
Group.new('LspReferenceRead', c.highlight_fg, c.highlight_bg)
Group.new('LspReferenceWrite', c.highlight_fg, c.highlight_bg, s.italic)

-- Tree-sitter & semantic highlighting
Group.new('PreProc', c.wine:light(), nil)
Group.new('@comment', c.shadow_purple, nil, s.italic)
Group.new('@keyword', c.velvet, nil, s.bold)
Group.new('@keyword.operator', c.wine, nil)
Group.new('@conditional', c.wine, nil, s.bold)
Group.new('@repeat', c.wine, nil, s.bold)
Group.new('@type', c.indigo, nil, s.italic)
Group.new('@type.builtin', c.indigo:light(), nil, s.italic)

Group.new('@variable', c.ink, nil)
Group.new('@variable.builtin', c.dusk, nil, s.bold)
Group.new('@field', c.storm, nil)
Group.new('@property', c.storm:light(), nil)

Group.new('@constant', c.royal, nil, s.bold)
Group.new('@function', c.indigo:dark(), nil, s.bold)
Group.new('@function.call', c.indigo, nil)
Group.new('@function.builtin', c.dusk:dark(), nil, s.italic)
Group.new('@parameter', c.ink, nil)

Group.new('@operator', c.storm:light(), nil)
Group.new('@punctuation.delimiter', c.shadow_purple:light(), nil)
Group.new('@punctuation.bracket', c.shadow_purple:light(), nil)

Group.new('@number', c.royal:dark(), nil)
Group.new('@boolean', c.royal, nil, s.bold)
Group.new('@string', c.dusk:light(), nil)

Group.new('@label', c.indigo, nil)
Group.new('@namespace', c.storm:dark(), nil)

-- Optional tags
Group.new('@note', c.indigo, nil, s.italic)
Group.new('@debug', c.dusk, nil)

-- Default fallback
Group.new('NonText', c.storm, c.background)
Group.new('Whitespace', c.very_soft_shadow:dark(), c.background)
Group.new('Todo', c.indigo, nil, s.bold + s.italic)

Group.new('StatusLine', c.ink, c.very_soft_shadow)
Group.new('StatusLineNC', c.storm, c.very_soft_shadow)
Group.new('ModeMsg', c.velvet, c.very_soft_shadow)
Group.new('MoreMsg', c.indigo, c.very_soft_shadow)

Group.new('TodoFgNOTE', c.indigo, nil, s.bold)
Group.new('TodoBgNOTE', nil, nil)
Group.new('TodoSignNOTE', c.indigo, nil)
Group.new('TodoVirtTextNOTE', c.indigo, nil)
