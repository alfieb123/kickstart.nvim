require('colorbuddy').colorscheme 'alfie_light_green_0'

local colorbuddy = require 'colorbuddy'
local Color = colorbuddy.Color
local Group = colorbuddy.Group
local c = colorbuddy.colors
local s = colorbuddy.styles

-- Background and UI
Color.new('background', '#f1fbf6') -- Very pale mint/tea green
Color.new('soft_shadow', '#e5f4ec') -- Gentle sage green accent
Color.new('ink', '#111c14') -- deepest green-black
Color.new('moss', '#1e3a2a') -- forest green
Color.new('pine', '#2c4f3a') -- deep pine
Color.new('fern', '#3e6548') -- fern
Color.new('olive', '#4e7c50') -- olive-toned green
Color.new('mint', '#629d6c') -- slightly bright highlight
Color.new('highlight_bg', '#c9f0dc')
Color.new('highlight_fg', '#193225')
Color.new('soft_white', '#f2f6ff')

-- Normal text and UI
Group.new('Normal', c.ink, c.background)
Group.new('CursorLine', nil, c.soft_shadow)
Group.new('CursorLineNr', c.mint, c.soft_shadow, s.bold)
Group.new('LineNr', c.fern, c.soft_shadow)
Group.new('Visual', nil, c.soft_shadow)

Group.new('TabLine', c.ink, c.soft_shadow)
Group.new('TabLineSel', c.mint, c.soft_shadow, s.bold)
Group.new('TabLineFill', c.soft_shadow, c.soft_shadow)
Group.new('StatusLine', c.ink, c.soft_shadow)
Group.new('VertSplit', c.soft_shadow, c.background)
Group.new('WinSeparator', c.soft_shadow, c.background)
Group.new('ColorColumn', nil, c.soft_shadow)

Group.new('LspReferenceText', c.highlight_fg, c.highlight_bg)
Group.new('LspReferenceRead', c.highlight_fg, c.highlight_bg)
Group.new('LspReferenceWrite', c.highlight_fg, c.highlight_bg, s.italic)

-- Tree-sitter
Group.new('@comment', c.fern:light(), nil, s.italic)
Group.new('@keyword', c.moss, nil, s.bold)
Group.new('@keyword.operator', c.olive, nil)
Group.new('@conditional', c.olive, nil, s.bold)
Group.new('@repeat', c.olive, nil, s.bold)
Group.new('@type', c.mint, nil, s.italic)
Group.new('@type.builtin', c.fern:light(), nil, s.italic)
Group.new('@variable', c.ink, nil)
Group.new('@variable.builtin', c.pine, nil, s.bold)
Group.new('@field', c.fern, nil)
Group.new('@property', c.fern:light(), nil)
Group.new('@constant', c.olive:light(), nil, s.bold)
Group.new('@function', c.mint:light(), nil, s.bold)
Group.new('@function.call', c.mint, nil)
Group.new('@function.builtin', c.moss:dark(), nil, s.italic)
Group.new('@parameter', c.ink, nil)
Group.new('@operator', c.fern, nil)
Group.new('@punctuation.delimiter', c.fern:light(), nil)
Group.new('@punctuation.bracket', c.fern:light(), nil)
Group.new('@number', c.olive:light(), nil)
Group.new('@boolean', c.olive, nil, s.bold)
Group.new('@string', c.pine:light(), nil)
Group.new('@label', c.mint, nil)
Group.new('@namespace', c.pine:dark(), nil)
Group.new('@note', c.mint, nil, s.italic)
Group.new('@debug', c.fern, nil)
Group.new('NonText', c.fern, c.background)
Group.new('Whitespace', c.soft_shadow:dark(), c.background)
Group.new('Todo', c.mint, nil, s.bold + s.italic)

Group.new('StatusLine', c.ink, c.soft_shadow)
Group.new('StatusLineNC', c.fern, c.soft_shadow)
Group.new('ModeMsg', c.moss, c.soft_shadow)
Group.new('MoreMsg', c.mint, c.soft_shadow)

Group.new('TodoFgNOTE', c.mint, nil, s.bold)
Group.new('TodoBgNOTE', nil, nil)
Group.new('TodoSignNOTE', c.mint, nil)
Group.new('TodoVirtTextNOTE', c.mint, nil)
