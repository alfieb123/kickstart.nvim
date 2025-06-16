--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

vim.opt.tabstop = 4 -- how many columns a tab counts for
vim.opt.shiftwidth = 4 -- how many spaces to use for autoindent
vim.opt.softtabstop = 4 -- how many spaces a <Tab> feels like
vim.opt.expandtab = true -- use spaces instead of tabs

vim.opt.laststatus = 3 -- this shows one status line, so  we can see things like horizontal splits

vim.opt.foldmethod = 'manual' -- set the default fold method to manual, this will not use treesitter, but we do in the folding keymaps

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.keymap.set('n', '<leader>ct', function()
  local wrap = vim.wo.wrap
  if wrap then
    vim.wo.wrap = false
    vim.wo.linebreak = false
    vim.wo.spell = false
    vim.notify('Wrap + spellcheck disabled', vim.log.levels.INFO)
  else
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.breakindent = true
    vim.wo.spell = true
    vim.notify('Word-aware wrap + spellcheck enabled', vim.log.levels.INFO)
  end
end, { desc = '[C]ode: Toggle word-wrap + spellcheck' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- ALFIE BASIC KEYMAPS
vim.keymap.set('n', '<leader>w', ':wa<CR>', { desc = 'Save all files' })
vim.keymap.set('n', '<leader>QQ', function()
  vim.cmd 'wa' -- Save all files
  vim.cmd 'SessionSave' -- Run :SessionSave (user-defined command)
  vim.cmd 'qa' -- Quit all
end, { desc = 'Save all, save session, quit' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']p', function()
  vim.cmd 'normal! ]m'
end, { desc = 'Go to next function' })

vim.keymap.set('n', '[p', function()
  vim.cmd 'normal! [m'
end, { desc = 'Go to previous function' })

vim.keymap.set('n', '<leader>fa', function()
  vim.cmd 'set foldmethod=expr'
  vim.cmd 'set foldexpr=nvim_treesitter#foldexpr()'
  vim.cmd 'normal! zM'
end, { desc = 'Fold all functions' })

vim.keymap.set('n', '<leader>fu', 'zR', { desc = 'Unfold all functions' })
-- vim.keymap.set('n', '<leader>kl', 'zO', { desc = 'Expand current fold recursively' })
vim.keymap.set('n', '<leader>ff', function()
  local fold_lvl = vim.fn.foldlevel '.'
  if fold_lvl <= 0 then
    vim.notify('No fold exists at this line', vim.log.levels.WARN, { title = 'Folds' })
    return
  end

  if vim.fn.foldclosed '.' ~= -1 then
    vim.cmd 'normal! zO' -- Open fold recursively
  else
    vim.cmd 'normal! zc' -- Close fold
  end
end, { desc = 'Toggle fold recursively' })

vim.keymap.set('n', '<leader>bod', ':%bd|e#|bd#<CR>', { desc = '[B]uffer [O]ther [D]elete' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- ALFIE AUTOCOMMANDS
-- set code files to not wrap, but other files to wrap
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp', 'lua', 'python', 'bash', 'vim', 'gdscript', 'godot_resource', 'gdshader', 'html', 'javascript', 'typescript' },
  callback = function()
    vim.opt.wrap = false
  end,
})
-- attempthing to force gdscript to always use spaces instead of tabs
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'gdscript',
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- automatically fold all gd files - NOTE: this will not work on restored sessions! just newly opened files
-- NOTE: alfie you have turned this off for now...it was getting on your tits
-- vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
--   pattern = '*.gd',
--   callback = function()
--     vim.opt.foldmethod = 'expr'
--     vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
--     vim.cmd 'normal! zM' -- Close all folds
--   end,
-- })
-- load the saved theme from the file
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    local saved = require 'saved_theme'
    local theme = saved.load()

    if theme then
      vim.cmd.colorscheme(theme)
    else
      vim.cmd.colorscheme 'catppuccin' -- fallback
    end
  end,
})
-- run session restore if there is a session!
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local session_dir = vim.fn.stdpath 'data' .. '/sessions/'
    local cwd = vim.fn.getcwd()
    local session_name = cwd:gsub('[/\\]', '%%') .. '.vim'
    local session_file = session_dir .. session_name

    -- Only restore if the session file exists
    if vim.fn.filereadable(session_file) == 1 then
      vim.schedule(function()
        vim.cmd 'SessionRestore'
      end)
    end
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local gdproject = io.open(vim.fn.getcwd() .. '/project.godot', 'r')
if gdproject then
  io.close(gdproject)
  vim.fn.serverstart './godothost'
end

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  -- 'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- If you prefer to call `setup` explicitly, use:
  --    {
  --        'lewis6991/gitsigns.nvim',
  --        config = function()
  --            require('gitsigns').setup({
  --                -- Your gitsigns configuration here
  --            })
  --        end,
  --    }
  --
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`.
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  {
    'rmagatti/auto-session',
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      enabled = true, -- Enables/disables auto creating, saving and restoring
      root_dir = vim.fn.stdpath 'data' .. '/sessions/', -- Root dir where sessions will be stored
      auto_save = true, -- Enables/disables auto saving session on exit
      auto_restore = true, -- Enables/disables auto restoring session on start
      auto_create = true, -- Enables/disables auto creating new session files. Can take a function that should return true/false if a new session file should be created or not
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/', '~/Desktop', '~/Downloads', '~/Library', '~/Music/', '~/Movies' }, -- Suppress session restore/create in certain directories
      allowed_dirs = nil, -- Allow session restore/create in certain directories
      auto_restore_last_session = false, -- On startup, loads the last saved session if session for cwd does not exist
      use_git_branch = false, -- Include git branch name in session name
      lazy_support = true, -- Automatically detect if Lazy.nvim is being used and wait until Lazy is done to make sure session is restored correctly. Does nothing if Lazy isn't being used. Can be disabled if a problem is suspected or for debugging
      bypass_save_filetypes = nil, -- List of filetypes to bypass auto save when the only buffer open is one of the file types listed, useful to ignore dashboards
      close_unsupported_windows = true, -- Close windows that aren't backed by normal file before autosaving a session
      args_allow_single_directory = true, -- Follow normal sesion save/load logic if launched with a single directory as the only argument
      args_allow_files_auto_save = false, -- Allow saving a session even when launched with a file argument (or multiple files/dirs). It does not load any existing session first. While you can just set this to true, you probably want to set it to a function that decides when to save a session when launched with file args. See documentation for more detail
      continue_restore_on_error = true, -- Keep loading the session even if there's an error
      show_auto_restore_notif = false, -- Whether to show a notification when auto-restoring
      cwd_change_handling = false, -- Follow cwd changes, saving a session before change and restoring after
      lsp_stop_on_restore = false, -- Should language servers be stopped when restoring a session. Can also be a function that will be called if set. Not called on autorestore from startup
      log_level = 'error', -- Sets the log level of the plugin (debug, info, warn, error).

      session_lens = {
        load_on_setup = true, -- Initialize on startup (requires Telescope)
        theme_conf = { -- Pass through for Telescope theme options
          -- layout_config = { -- As one example, can change width/height of picker
          --   width = 0.8,    -- percent of window
          --   height = 0.5,
          -- },
        },
        previewer = false, -- File preview for session picker

        mappings = {
          -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
          delete_session = { 'i', '<C-D>' },
          alternate_session = { 'i', '<C-S>' },
          copy_session = { 'i', '<C-Y>' },
        },

        session_control = {
          control_dir = vim.fn.stdpath 'data' .. '/auto_session/', -- Auto session control dir, for control files, like alternating between two sessions with session-lens
          control_filename = 'session_control.json', -- File name of the session control file
        },
      },
      -- log_level = 'debug',
    },
  },
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
      vim.keymap.set('x', 'x', 'd', { noremap = true, desc = 'Delete in visual mode' }) -- leap remaps x.. :(, put it back
    end,
  },

  -- {
  --   'folke/flash.nvim',
  --   event = 'VeryLazy',
  --   opts = {},
  --   keys = {
  --     {
  --       's',
  --       mode = { 'n', 'x', 'o' },
  --       function()
  --         require('flash').jump {
  --           search = {
  --             -- allow two characters for wider jump range
  --             max_length = 4,
  --           },
  --           label = {
  --             -- show labels after match is narrowed (fewer distractions early)
  --             after = true,
  --             before = true,
  --           },
  --           jump = {
  --             autojump = false, -- jump immediately if only one match
  --           },
  --         }
  --       end,
  --       desc = 'Flash Jump',
  --     },
  --     {
  --       'S',
  --       mode = { 'n', 'x', 'o' },
  --       function()
  --         require('flash').treesitter()
  --       end,
  --       desc = 'Flash Treesitter Jump',
  --     },
  --   },
  -- },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.opt.timeoutlen
      delay = 300,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          file_ignore_patterns = { '%.uid$' }, -- Ignore all .uid
          -- mappings = {
          --   i = { ['<c-enter>'] = 'to_fuzzy_refine' },
          -- },
        },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Lspsaga enhancements
          -- vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { buffer = event.buf, desc = 'LSP: Hover Doc' })
          -- vim.keymap.set('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', { buffer = event.buf, desc = 'LSP: Peek Definition' })
          -- vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', { buffer = event.buf, desc = 'LSP: Rename Symbol' })
          -- vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', { buffer = event.buf, desc = 'LSP: Code Action' })
          -- vim.keymap.set('n', 'gl', '<cmd>Lspsaga show_line_diagnostics<CR>', { buffer = event.buf, desc = 'LSP: Line Diagnostics' })
          -- vim.keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', { buffer = event.buf, desc = 'LSP: Prev Diagnostic' })
          -- vim.keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', { buffer = event.buf, desc = 'LSP: Next Diagnostic' })
          -- vim.keymap.set('n', '<leader>o', '<cmd>Lspsaga outline<CR>', { buffer = event.buf, desc = 'LSP: Outline Symbols' })
          -- vim.keymap.set('n', '<leader>f', '<cmd>Lspsaga finder<CR>', { buffer = event.buf, desc = 'LSP: Finder Panel' })

          -- vim.keymap.set('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', { desc = 'Peek function definition' })

          -- Find references for the word under your cursor.
          -- map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          -- map('gr', function()
          --   require('telescope.builtin').lsp_references {
          --     show_line = false, -- this is the line that stops the results showing both the filepath and the line its used.. we can look at the preview window for that!
          --     path_display = { 'smart' },
          --     layout_strategy = 'vertical',
          --     layout_config = {
          --       width = 0.9,
          --       height = 0.9,
          --       prompt_position = 'top',
          --       mirror = true,
          --     },
          --   }
          -- end, '[G]oto [R]eferences')
          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('pd', function()
            require('telescope.builtin').lsp_definitions {
              jump_type = 'never',
              layout_strategy = 'vertical',
              show_line = false,
              layout_config = {
                -- bottom_pane = {
                --   height = 5,
                --   preview_cutoff = 5,
                --   prompt_position = 'top',
                -- },
                -- center = {
                --   height = 0.1,
                --   preview_cutoff = 5,
                --   prompt_position = 'top',
                --   width = 0.5,
                -- },
                -- cursor = {
                --   height = 0.9,
                --   preview_cutoff = 40,
                --   width = 0.8,
                -- },
                -- horizontal = {
                --   height = 0.9,
                --   preview_cutoff = 120,
                --   prompt_position = 'bottom',
                --   width = 0.8,
                -- },
                vertical = { -- as our strategy is set to vertical, this is the config that matters! left the others here for reference for other stuff
                  height = 0.5,
                  preview_cutoff = 40,
                  prompt_position = 'bottom',
                  width = 0.5,
                  preview_height = 0.99,
                },
              },
              prompt_title = false,
            }
          end, '[P]eek [D]efinition ')

          map('gr', function()
            require('telescope.builtin').lsp_references {
              path_display = { 'smart' }, -- trims the paths if needed to show filename
              include_declaration = true,
              include_current_line = false,
              fname_width = 100, -- so we can see the damned thing
              show_line = false, -- this is the line that stops the results showing both the filepath and the line its used.. we can look at the preview window for that!
              trim_text = false,
            }
          end, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- map('<leader>tt', require('telescope.builtin').colorscheme, '[T]oggle [T]heme')

          map('<leader>tt', function()
            require('telescope.builtin').colorscheme {
              enable_preview = true,
              attach_mappings = function(_, map)
                map('i', '<CR>', function(prompt_bufnr)
                  local entry = require('telescope.actions.state').get_selected_entry()
                  local saved = require 'saved_theme'
                  saved.save(entry.value)
                  require('telescope.actions').close(prompt_bufnr)
                  -- Delay colorscheme a tiny bit to ensure clean redraw
                  vim.defer_fn(function()
                    vim.cmd.colorscheme(entry.value)
                    print('Theme set to: ' .. entry.value)
                  end, 10)
                end)
                return true
              end,
            }
          end, '[T]oggle [T]heme')

          -- Yank to system clipboard - alfie dont put these in map as map is not global
          vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
          vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Yank selection to system clipboard' })
          vim.keymap.set('n', '<leader>yy', '"+yy', { desc = 'Yank line to system clipboard' })

          -- Paste from system clipboard
          vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
          vim.keymap.set('v', '<leader>p', '"+p', { desc = 'Paste over selection from clipboard' })

          -- buffer stuff
          vim.keymap.set('n', '<F5>', ':bnext<CR>', { desc = 'Next buffer' })
          vim.keymap.set('n', '<F6>', ':bprevious<CR>', { desc = 'Previous buffer' })
          -- vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = 'Close buffer' })
          vim.keymap.set('n', '<leader>bd', function() -- this upgrade means that we will keep splits when closing buffers
            local current_buf = vim.api.nvim_get_current_buf()
            local buffers = vim.fn.getbufinfo { buflisted = 1 }

            if #buffers > 1 then
              vim.cmd 'bnext'
              vim.cmd('bdelete ' .. current_buf)
            else
              vim.cmd 'enew' -- create a new empty buffer
              vim.cmd('bdelete ' .. current_buf)
            end
          end, { desc = 'Smart close buffer without closing window' })

          -- leap.nvim stuff
          vim.keymap.set('n', 's', '<Plug>(leap-anywhere)')
          vim.keymap.set('x', 's', '<Plug>(leap)')
          vim.keymap.set('o', 's', '<Plug>(leap-forward)')
          vim.keymap.set('o', 'S', '<Plug>(leap-backward)')

          -- turn all the tabs to spaces in the current buffer
          vim.keymap.set('n', '<leader>cs', function()
            vim.cmd 'set expandtab'
            vim.cmd 'retab'
          end, { desc = '[C]ode tabs to [S]paces' })

          -- make going to the center of the document less pinky heavy
          vim.keymap.set('n', '<leader>cc', 'zz', { desc = '[C]enter [C]enter!' })

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', function()
            require('telescope.builtin').lsp_document_symbols {
              fname_width = 0, -- wider filename column, this doesnt apply to document symbols
              symbol_width = 70, -- optional: wider symbol name this is the fat symbol
              symbol_type_width = 12, -- optional: wider symbol type column this is the type the symbol is
              show_line = false, -- optional: show code line contents, we dont need to show this as we have a preview window
              symbols = { 'Function', 'Method' }, -- just show functions/methods... not variables etc. if you want that, maybe make another keymap
            }
          end, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      -- ALFIE SETTING UP GDSCRIPT STUFF
      require('lspconfig').gdscript.setup(capabilities)
      -- local lspconfig = require 'lspconfig'
      --
      -- lspconfig.gdscript.setup {
      --   cmd = { 'nc', '127.0.0.1', '6005' },
      --   filetypes = { 'gd', 'gdscript' },
      --   root_dir = lspconfig.util.root_pattern('project.godot', '.git'),
      -- }

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --

        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp-signature-help',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noselect' },
        preselect = cmp.PreselectMode.None,

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          -- ['<C-y>'] = cmp.mapping.confirm { select = true },
          -- ['<Tab>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          -- ['<CR>'] = cmp.mapping.confirm { select = true },
          -- ['<Tab>'] = cmp.mapping.select_next_item(),
          -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          -- ALFIE! YOU HAVE SET BOTH TAB AND ENTER TO COMPLETE HERE, cycle with up and down!
          -- NOTE: you have set select to false! this means that unless you have selected something from the completion list it wont populate it if you press tab or enter
          ['<CR>'] = cmp.mapping.confirm { select = false },
          ['<Tab>'] = cmp.mapping.confirm { select = false },
          -- ['<CR>'] = cmp.mapping.confirm { select = false },
          -- ['<Tab>'] = cmp.mapping(function(fallback)
          --   if cmp.visible() then
          --     cmp.select_next_item()
          --   else
          --     fallback()
          --   end
          -- end, { 'i', 's' }),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          -- { name = 'nvim_lsp_signature_help' }, -- ALFIE! YOU HAVE DISABLED THIS AS IT COMPLETES FUNCTION SIGNATUREES!
          { name = 'nvim_lsp_signature_help' },
        },
      }
    end,
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme 'tokyonight-night'
      -- vim.cmd.colorscheme 'tokyonight-storm'
      -- vim.cmd.colorscheme 'tokyonight-moon'
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('kanagawa').setup {
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
        theme = 'wave', -- Load "wave" theme
        background = { -- map the value of 'background' option to a theme
          dark = 'wave', -- try "dragon" !
          light = 'lotus',
        },
      }
      -- vim.cmd.colorscheme 'kanagawa-wave'
    end,
  },
  {
    'slugbyte/lackluster.nvim',
    priority = 1000,
  },
  {
    'navarasu/onedark.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('onedark').setup {
        -- Main options --
        style = 'deep', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = true, -- Show/hide background ALFIE! doing this so we can have a black background
        term_colors = true, -- Change terminal color as per the selected theme style
        ending_tildes = true, -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

        -- toggle theme style ---
        toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
        toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
        code_style = {
          comments = 'italic',
          keywords = 'bold',
          functions = 'none',
          strings = 'none',
          variables = 'none',
        },

        -- Lualine options --
        lualine = {
          transparent = false, -- lualine center bar transparency
        },

        -- Custom Highlights --
        colors = {}, -- Override default colors
        highlights = {
          WinSeparator = { fg = '#ffcc00', bg = 'NONE', bold = true }, -- bright yellow separator
        },

        -- Plugins Config --
        diagnostics = {
          darker = true, -- darker colors for diagnostic
          undercurl = true, -- use undercurl instead of underline for diagnostics
          background = true, -- use background color for virtual text
        },
      }
      -- vim.cmd.colorscheme 'onedark'
    end,
  },
  -- Catppuccin (Soft, modern, pastel)
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },

  -- Rose Pine (Elegant and warm)
  { 'rose-pine/neovim', name = 'rose-pine', priority = 1000 },

  -- Gruvbox (Classic contrast, warm colours)
  { 'ellisonleao/gruvbox.nvim', priority = 1000 },

  -- Solarized (Light & dark with low contrast)
  { 'maxmx03/solarized.nvim', priority = 1000 },

  -- Nightfox (Includes nordfox, duskfox, etc.)
  { 'EdenEast/nightfox.nvim', priority = 1000 },

  -- Dracula (Popular, vibrant dark theme)
  { 'Mofiqul/dracula.nvim', priority = 1000 },

  -- Nord (Cool and calming arctic feel)
  { 'shaunsingh/nord.nvim', priority = 1000 },

  -- Everforest (warm, forest-inspired, soft & readable)
  { 'sainnhe/everforest', priority = 1000 },

  -- Monokai Pro (classic, vibrant monokai with beautiful variants)
  { 'loctvl842/monokai-pro.nvim', priority = 1000 },

  -- Kanagawa Community Fork (more maintained with updates)
  { 'projekt0n/github-nvim-theme', priority = 1000 },

  -- Material (based on Material Design palette, lots of styles)
  { 'marko-cerovac/material.nvim', priority = 1000 },

  -- Oxocarbon (Carbon-inspired, sleek IBM-based palette)
  { 'nyoom-engineering/oxocarbon.nvim', priority = 1000 },

  -- Palenight (popular purple-toned theme, clean UI)
  { 'drewtempelmeyer/palenight.vim', priority = 1000 },

  -- Edge (dark and light minimal theme by the author of nightfox)
  { 'sainnhe/edge', priority = 1000 },

  { 'yasukotelin/shirotelin', priority = 1000 },
  -- -- TokyoNight Community Fork (extra variants and tweaks)
  -- { 'olimorris/onedarkpro.nvim', priority = 1000 },
  --
  { 'AlexvZyl/nordic.nvim', priority = 1000 },

  { 'datsfilipe/vesper.nvim', priority = 1000 },

  { 'scottmckendry/cyberdream.nvim', priority = 1000 },

  { 'ribru17/bamboo.nvim', priority = 1000 },

  { 'savq/melange-nvim', priority = 1000 },
  { 'NTBBloodbath/doom-one.nvim', priority = 1000 },
  { 'xero/miasma.nvim', priority = 1000 },
  { 'lalitmee/cobalt2.nvim', priority = 1000 },
  { 'kdheepak/monochrome.nvim', priority = 1000 },
  { 'idr4n/github-monochrome.nvim', priority = 1000 },
  { 'iagorrr/noctis-high-contrast.nvim', priority = 1000 },
  { 'gantoreno/nvim-gabriel', priority = 1000 },
  { 'kemiller/vim-ir_black', priority = 1000 },
  { 'wuelnerdotexe/vim-enfocado', priority = 1000 },
  { 'wuelnerdotexe/vim-enfocado', priority = 1000 },

  --- ALFIE COLORSCHEME ENDS HERE ------------------------
  ---
  -- {
  --   'nvimdev/lspsaga.nvim',
  --   event = 'LspAttach',
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter',
  --     'nvim-tree/nvim-web-devicons',
  --   },
  --   config = function()
  --     require('lspsaga').setup {
  --       outline = {
  --         win_width = 80,
  --         close_after_jump = true,
  --         layout = 'float',
  --         max_height = 0.7,
  --         left_width = 0.5,
  --         keys = {
  --           jump = '<CR>',
  --           quit = 'q',
  --           toggle_or_jump = 'o',
  --         },
  --       },
  --     }
  --   end,
  -- },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- {
  --   'folke/twilight.nvim',
  --   opts = {
  --     {
  --       dimming = {
  --         alpha = 0.25, -- amount of dimming
  --         -- we try to get the foreground from the highlight groups or fallback color
  --         color = { 'Normal', '#ffffff' },
  --         term_bg = '#000000', -- if guibg=NONE, this will be used to calculate text color
  --         inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
  --       },
  --       context = 16, -- amount of lines we will try to show around the current line
  --       treesitter = true, -- use treesitter when available for the filetype
  --       -- treesitter is used to automatically expand the visible text,
  --       -- but you can further control the types of nodes that should always be fully expanded
  --       expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
  --         'function',
  --         'method',
  --         'table',
  --         'if_statement',
  --       },
  --       exclude = {}, -- exclude these filetypes
  --     },
  --   },
  --   keys = {
  --     { '<leader>tw', '<cmd>Twilight<CR>', desc = 'Toggle Twilight' },
  --   },
  -- },

  {
    'folke/zen-mode.nvim',
    opts = {
      window = {
        width = 150, -- or e.g. .85 for 85% of screen width
        options = {
          number = true,
          relativenumber = true,
          signcolumn = 'yes',
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
        twilight = { enabled = true }, -- if you also use Twilight
        gitsigns = { enabled = false },
        -- this will change the font size on kitty when in zen mode
        -- to make this work, you need to set the following kitty options:
        -- - allow_remote_control socket-only
        -- - listen_on unix:/tmp/kitty
        kitty = {
          enabled = true,
          font = '+2', -- font size increment
        },
      },
    },
    keys = {
      { '<leader>z', '<cmd>ZenMode<CR>', desc = 'Toggle Zen Mode' },
    },
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'gdscript',
        'godot_resource',
        'gdshader',
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby', 'gdscript', 'godot_resource', 'gdshader' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  {
    'github/copilot.vim',
    config = function()
      -- NOTE: with the below config then we only get copilot suggesting when we hit ctrl and k (i chose this as its both middle fingers), and you accept with tab
      -- vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_enabled = false

      vim.keymap.set('i', '<C-k>', '<Plug>(copilot-suggest)', {
        desc = 'Manually trigger Copilot suggestion',
      })

      -- these are the keymaps that are set by default
      vim.keymap.set('n', '<leader>ce', ':Copilot enable<CR>', { desc = '[C]opilot [E]nable' })
      vim.keymap.set('n', '<leader>cd', ':Copilot disable<CR>', { desc = '[C]opilot [D]isable' })
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'VeryLazy',
    config = function()
      require('bufferline').setup {
        options = {
          mode = 'buffers', -- or "tabs"
          diagnostics = 'nvim_lsp',
          show_buffer_close_icons = false,
          show_close_icon = false,
          separator_style = 'thin',
          always_show_bufferline = true,
          show_buffer_icons = false,
        },
      }
    end,
  },

  { 'habamax/vim-godot', event = 'VimEnter' },

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- ALFIE SETTING CUSTOM FOLDING?
function HighlightedFoldtext()
  local pos = vim.v.foldstart
  local line = vim.api.nvim_buf_get_lines(0, pos - 1, pos, false)[1]

  local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
  local ok, parser = pcall(vim.treesitter.get_parser, 0, lang)
  if not ok or not parser then
    return vim.fn.foldtext()
  end

  local query = vim.treesitter.query.get(parser:lang(), 'highlights')
  if query == nil then
    return vim.fn.foldtext()
  end

  local tree = parser:parse({ pos - 1, pos })[1]
  local result = {}
  local line_pos = 0
  local prev_range = nil

  for id, node in query:iter_captures(tree:root(), 0, pos - 1, pos) do
    local name = query.captures[id]
    local start_row, start_col, end_row, end_col = node:range()
    if start_row == pos - 1 and end_row == pos - 1 then
      local range = { start_col, end_col }
      if start_col > line_pos then
        table.insert(result, { line:sub(line_pos + 1, start_col), 'Folded' })
      end
      line_pos = end_col
      local text = vim.treesitter.get_node_text(node, 0)
      if prev_range and range[1] == prev_range[1] and range[2] == prev_range[2] then
        result[#result] = { text, '@' .. name }
      else
        table.insert(result, { text, '@' .. name })
      end
      prev_range = range
    end
  end

  return result
end
-- function HighlightedFoldtext()
--   local pos = vim.v.foldstart
--   local line = vim.api.nvim_buf_get_lines(0, pos - 1, pos, false)[1]
--   local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
--   local parser = vim.treesitter.get_parser(0, lang)
--   local query = vim.treesitter.query.get(parser:lang(), 'highlights')
--
--   if query == nil then
--     return vim.fn.foldtext()
--   end
--
--   local tree = parser:parse({ pos - 1, pos })[1]
--   local result = {}
--
--   local line_pos = 0
--
--   local prev_range = nil
--
--   for id, node, _ in query:iter_captures(tree:root(), 0, pos - 1, pos) do
--     local name = query.captures[id]
--     local start_row, start_col, end_row, end_col = node:range()
--     if start_row == pos - 1 and end_row == pos - 1 then
--       local range = { start_col, end_col }
--       if start_col > line_pos then
--         table.insert(result, { line:sub(line_pos + 1, start_col), 'Folded' })
--       end
--       line_pos = end_col
--       local text = vim.treesitter.get_node_text(node, 0)
--       if prev_range ~= nil and range[1] == prev_range[1] and range[2] == prev_range[2] then
--         result[#result] = { text, '@' .. name }
--       else
--         table.insert(result, { text, '@' .. name })
--       end
--       prev_range = range
--     end
--   end
--
--   return result
-- end

local bg = vim.api.nvim_get_hl(0, { name = 'StatusLine' }).bg
local hl = vim.api.nvim_get_hl(0, { name = 'Folded' })
hl.bg = bg
-- ALFIE! IGNORE THE WARNING BELOW - IT STILL WORKS
vim.api.nvim_set_hl(0, 'Folded', hl)

vim.opt.foldtext = [[luaeval('HighlightedFoldtext')()]]

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
