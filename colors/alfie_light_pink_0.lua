require('colorbuddy').colorscheme 'alfie_light_pink_0'

local colorbuddy = require 'colorbuddy'
local Color = colorbuddy.Color
local Group = colorbuddy.Group
local c = colorbuddy.colors
local s = colorbuddy.styles

-- Background and UI
Color.new('background', '#fef5fb') -- Very pale blush pink
Color.new('soft_shadow', '#f8eaf4') -- Delicate rose tint
Color.new('ink', '#1c1216') -- deep text
Color.new('rose', '#421e2d') -- deep rose
Color.new('mauve', '#5e2c40') -- wine/maroon
Color.new('plum', '#704055') -- muted burgundy
Color.new('orchid', '#8a5170') -- dusty pink
Color.new('raspberry', '#a43c63') -- saturated pink-red
Color.new('highlight_bg', '#f4d4e6')
Color.new('highlight_fg', '#311c25')
Color.new('soft_white', '#f2f6ff')
Color.new('alert_red', '#ff3366') -- Or any red you like
Color.new('todo_error', '#d7263d') -- Warm rose red
Color.new('todo_warning', '#ff9f1c') -- Golden tangerine
Color.new('todo_info', '#6957e0') -- Orchid blue
Color.new('todo_hint', '#3eb489') -- Minty turquoise
Color.new('todo_default', '#a84dac') -- Fuchsia-violet
Color.new('todo_test', '#ff00ff')

-- for todos
Group.new('DiagnosticError', c.todo_error, nil, s.bold)
Group.new('DiagnosticWarn', c.todo_warning, nil)
Group.new('DiagnosticInfo', c.todo_info, nil)
Group.new('DiagnosticHint', c.todo_hint, nil)
Group.new('Identifier', c.todo_default, nil)

-- Folded stuff
Group.new('Folded', c.ink, c.soft_shadow)
Group.new('FoldColumn', c.ink, c.soft_shadow)

-- Normal text and UI
Group.new('Normal', c.ink, c.background)
Group.new('CursorLine', nil, c.soft_shadow)
Group.new('CursorLineNr', c.orchid, c.soft_shadow, s.bold)
Group.new('LineNr', c.plum, c.soft_shadow)
Group.new('Visual', nil, c.soft_shadow)

Group.new('TabLine', c.ink, c.soft_shadow)
Group.new('TabLineSel', c.orchid, c.soft_shadow, s.bold)
Group.new('TabLineFill', c.soft_shadow, c.soft_shadow)
Group.new('StatusLine', c.ink, c.soft_shadow)
Group.new('VertSplit', c.soft_shadow, c.background)
Group.new('WinSeparator', c.alert_red, c.background, s.bold)
Group.new('ColorColumn', nil, c.soft_shadow)

Group.new('LspReferenceText', c.highlight_fg, c.highlight_bg)
Group.new('LspReferenceRead', c.highlight_fg, c.highlight_bg)
Group.new('LspReferenceWrite', c.highlight_fg, c.highlight_bg, s.italic)

-- Tree-sitter
Group.new('@comment', c.plum:light(), nil, s.italic)
Group.new('@keyword', c.rose, nil, s.bold)
Group.new('@keyword.operator', c.raspberry, nil)
Group.new('@conditional', c.raspberry, nil, s.bold)
Group.new('@repeat', c.raspberry, nil, s.bold)
Group.new('@type', c.orchid, nil, s.italic)
Group.new('@type.builtin', c.plum:light(), nil, s.italic)
Group.new('@variable', c.ink, nil)
Group.new('@variable.builtin', c.mauve, nil, s.bold)
Group.new('@field', c.plum, nil)
Group.new('@property', c.plum:light(), nil)
Group.new('@constant', c.raspberry:light(), nil, s.bold)
Group.new('@function', c.orchid:light(), nil, s.bold)
Group.new('@function.call', c.orchid, nil)
Group.new('@function.builtin', c.rose:dark(), nil, s.italic)
Group.new('@parameter', c.ink, nil)
Group.new('@operator', c.plum, nil)
Group.new('@punctuation.delimiter', c.plum:light(), nil)
Group.new('@punctuation.bracket', c.plum:light(), nil)
Group.new('@number', c.raspberry:light(), nil)
Group.new('@boolean', c.raspberry, nil, s.bold)
Group.new('@string', c.mauve:light(), nil)
Group.new('@label', c.orchid, nil)
Group.new('@namespace', c.plum:dark(), nil)
Group.new('@note', c.orchid, nil, s.italic)
Group.new('@debug', c.plum, nil)
Group.new('NonText', c.plum, c.background)
Group.new('Whitespace', c.soft_shadow:dark(), c.background)
Group.new('Todo', c.orchid, nil, s.bold + s.italic)

Group.new('StatusLine', c.ink, c.soft_shadow)
Group.new('StatusLineNC', c.plum, c.soft_shadow)
Group.new('ModeMsg', c.rose, c.soft_shadow)
Group.new('MoreMsg', c.orchid, c.soft_shadow)

Group.new('TodoFgNOTE', c.orchid, nil, s.bold)
Group.new('TodoBgNOTE', nil, nil)
Group.new('TodoSignNOTE', c.orchid, nil)
Group.new('TodoVirtTextNOTE', c.orchid, nil)
