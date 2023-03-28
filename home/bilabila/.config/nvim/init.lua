local g = vim.g
local o = vim.o
o.dictionary = '/usr/share/dict/words'
g.kommentary_create_default_mappings = false
o.shell = '/bin/bash'
g.mapleader = ','
o.breakindent = true
o.hidden = true
o.cmdheight = 1
o.shortmess = vim.o.shortmess .. "c"
o.signcolumn = 'yes'
o.tgc = true
o.rulerformat = '%=%t'
o.statusline = '%=%=%t'
o.ls = 0
o.so = 7
o.ttm = 0
o.mouse = "a"
o.fencs = "ucs-bom,utf-8,gb2312,gb18030,gbk,cp936,default,latin1"
o.nf = vim.o.nf .. ",alpha"
o.sw = 2
o.ts = 2
o.nu = true
o.wrap = false
o.wb = false
o.swf = false
o.ic = true
o.scs = true
o.hls = true
o.is = true
o.lz = true
o.et = true
o.spell = false
o.spelllang = 'en_us,cjk'

local map = function(mode, lhs, rhs, opt)
  opt = opt or {noremap = true, silent = true}
  vim.api.nvim_set_keymap(mode, lhs, rhs, opt)
end

map('v', '<Tab>', '>gv')
map('v', '<S-Tab>', '<gv')
map('v', '>', '>gv')
map('v', '<', '<gv')

map('n', '<leader>d', 'mz"zyy"zp`zj', {noremap = false, silent = true})
map('v', '<leader>d', 'mz"zy"zP`z', {noremap = false, silent = true})
map('n', '<leader>D', 'mz"zY"zP`zk<leader>cc`z',
    {noremap = false, silent = true})
map('v', '<leader>D', 'mz"zy"zP`[v`]<leader>c`z',
    {noremap = false, silent = true})
map('n', '<leader>s',
    ':set spell!<cr>:if exists("g:syntax_on") <bar> syntax off <bar> else <bar> syntax enable <bar> endif<cr>')
map('n', '<c-l>', ':noh<cr>')

map('n', '<leader>t', '<esc>:set ft=', {noremap = true})
map('n', '0', '^')
map('c', '<c-a>', '<home>', {noremap = true})
map('c', '<c-k>', [[<C-\>e(strpart(getcmdline(), 0, getcmdpos() - 1))<cr>]],
    {noremap = true})
map('c', '<c-e>', '<end>', {noremap = true})
map('c', '<c-p>', '<up>', {noremap = true})
map('c', '<c-n>', '<down>', {noremap = true})
map('c', '<c-b>', '<left>', {noremap = true})
map('c', '<c-f>', '<right>', {noremap = true})
map('c', '<c-h>', '<backspace>', {noremap = true})

map('n', '<leader>m', [[mmHmt:%s/<c-v><cr>//ge<cr>'tzt'm]], {noremap = true})
map('n', '<leader>r', ":so $MYVIMRC<cr>", {noremap = true})
map('v', '<leader>s', ":sort", {noremap = true})
map('v', '<leader>S', ":!sort", {noremap = true})
map('n', '<leader>e', ":e!<cr>", {noremap = true})
map('n', '<leader>w', ":w!<cr>", {noremap = true})
map('v', '<leader>w', "<esc>w!<cr>", {noremap = true})
map('n', '<leader>x', ":x!<cr>", {noremap = true})
map('v', '<leader>x', "<esc>:x!<cr>", {noremap = true})
map('n', '<leader>q', ":q!<cr>", {noremap = true})
map('v', '<leader>q', "<esc>:q!<cr>", {noremap = true})
map('v', 'p', "pgvy", {noremap = true})
map('n', '<leader>y', [[mzgv"+y`z]], {noremap = true})
map('n', '<leader>{', [[i{<esc>la}<esc>h]], {noremap = true})
map('n', '<leader>#', [[:g/^\(#\|$\)/d]], {noremap = true})
-- --remove multi sapce ,remove empty lines ,space end, space start
-- -- nm <silent> <leader>z :retab<cr>:%s/ +/ /eg<cr>:g/^\s*$/d<cr><leader>n:%s/^\s\+//e<cr>:v/^\[\d\+\]/norm kJ<cr>:noh<cr>
map('n', '<backspace>', [[:cal DeleteLeft()<cr>]])
map('n', '<cr>', "i<cr><esc>l")
map('v', '<cr>', '"_s<cr>')
map('v', '<backspace>', '"_d')
map('n', 'Q', "@q")
map('v', 'Q', ":norm @q<cr>")
map('n', '<leader>n', [[mz:retab<cr>:%s/\s\+$//e<cr>`z:noh<cr>]])
map('n', '<leader>a', ":set wrap!<cr>")
map('n', '<leader><space>', ":call Load()<cr>")
-- map('n', '<leader>c', [[mzgv"0y`z:call Yank(@0)<cr>]])
map('n', '<c-c>', [[mzV"0y`z:call Yank(@0)<cr>]])
map('v', '<c-c>', [["0y:call Yank(@0)<cr>]])
map('v', '<c-x>', [["0d:call Yank(@0)<cr>]])
map('n', '<c-b>', [[mzgg"+yG`z'"']])

map('v', 'n', [[<tab> >gv]], {noremap = true})
map('v', '<S-tab>', [[<gv]], {noremap = true})
map('n', 'j', [[v:count ? 'j' : 'gj']], {noremap = true, expr = true})
map('n', 'k', [[v:count ? 'k' : 'gk']], {noremap = true, expr = true})
map('v', 'j', [[v:count ? 'j' : 'gj']], {noremap = true, expr = true})
map('v', 'k', [[v:count ? 'k' : 'gk']], {noremap = true, expr = true})
map('n', '<c-J>', [[mz:m .+1<CR>`z]], {noremap = true})
map('n', '<c-K>', [[mz:m .-2<CR>`z]], {noremap = true})
map('v', '<c-J>', [[:m '>+1<CR>gv=gv]], {noremap = true})
map('v', '<c-K>', [[:m '<-2<CR>gv=gv]], {noremap = true})
map('n', '<c-z>', [[<Nop>]], {noremap = true})
map('n', '<c-q>', [[<Nop>]], {noremap = true})
map('n', '<c-s>', [[<Nop>]], {noremap = true})
map('n', '<F1>', [[<Nop>]], {noremap = true})
map('n', '<c-e>', [[<c-u>]], {noremap = true})
map('v', '<c-e>', [[<c-u>]], {noremap = true})
map('n', '<a-e>', [[<c-u>]], {noremap = true})
map('n', '<a-d>', [[<c-d>]], {noremap = true})

map('n', '/', [[ms/]], {noremap = true})
map('n', '?', [[ms?]], {noremap = true})
map('n', 'dj', [[<nop>]], {noremap = true})
map('n', 'dk', [[<nop>]], {noremap = true})

map('n', '<leader>i', [[:Autoformat<cr>]])
map('v', '<leader>i', [[:Autoformat<cr>]])
map('n', '<space>i', [[:Autoformat<cr>]])
map('v', '<space>i', [[:Autoformat<cr>]])

map('n', 'H', [[:tabp<cr>]])
map('n', 'L', [[:tabn<cr>]])
-- map('i', 'H', [[<esc>:tabp<cr>]])
-- map('i', 'L', [[<esc>:tabn<cr>]])

map('n', '<F5>', [[:wa!<cr>:silent ! tmux send -t {down-of} C-c up enter <cr>]])
map('n', '<space><space>', '<F5>', {noremap = false, silent = true})
map('v', '<space><space>', '<esc><F5>', {noremap = false, silent = true})
map('n', '<space>1',
    [[:wa!<cr>:silent ! tmux send -t {down-of} C-c up up enter <cr>]])
map('v', '<space>1',
    [[:wa!<cr>:silent ! tmux send -t {down-of} C-c up up enter <cr>]])

map('v', '<leader>C', ':! column -t')

map('n', '*', [[viwms:<c-u>cal VisualSelection('', '')<cr>/<c-r>=@/<cr><cr>]])
map('n', '#', [[viwms:<c-u>cal VisualSelection('', '')<cr>?<c-r>=@/<cr><cr>]])
map('v', '*', [[ms:<c-u>cal VisualSelection('', '')<cr>/<c-r>=@/<cr><cr>]])
map('v', '#', [[ms:<c-u>cal VisualSelection('', '')<cr>?<c-r>=@/<cr><cr>]])

vim.cmd([[
ca w!! w !sudo tee "%"
com! W w !sudo tee % > /dev/null
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
au FocusLost * silent! wa
fu! DeleteLeft()
  if col('.')==1 | exe "normal! kgJ" | else | exe "normal! \"_dh" |endif
endf
fu! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  exe "normal! vgvy"
  let l:pattern = escape(@", "\\/.*'$^~[]")
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'gv'
    cal CmdLine("Ack '" . l:pattern . "' " )
  elseif a:direction == 'replace'
    cal CmdLine("%s" . '/'. l:pattern . '/')
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endf
fu! Load()
  cal plug#load('fcitx.vim')
endf
fu! Yank(text) abort
  let escape = system('yank', a:text)
  if v:shell_error
    echo 1
  else
    call writefile([escape], '/dev/tty', 'b')
  endif
endf

autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd BufEnter */fontconfig/fonts.conf :setlocal filetype=xml
autocmd BufEnter * if &filetype == "" | setlocal ft=sh | endif
autocmd FileType xdefaults setlocal commentstring=!\ %s

au FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
if !exists('g:lasttab')
  let g:lasttab = 1
endif
nm <silent> <s-tab> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
filet plugin indent on
]])

local install_path = vim.fn.stdpath 'data' ..
                       '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
                   install_path)
end

-- vim.api.nvim_exec([[
--   augroup Packer
--     autocmd!
--     autocmd BufWritePost init.lua PackerCompile
--   augroup end
-- ]], false)

require('packer').startup(function()

  use 'wbthomason/packer.nvim'

  use {
    'lambdalisue/suda.vim',
    config = function() vim.g.suda_smart_edit = 1 end,
  }

  -- use 'ms-jpq/coq_nvim', {'branch': 'coq'}
  -- use 'tzachar/compe-tabnine', { run= './install.sh' }
  use 'andersevenrud/compe-tmux'
  use {'Gavinok/compe-look', requires = 'nvim-lua/plenary.nvim'}

  -- use 'hrsh7th/nvim-cmp'
  -- use 'hrsh7th/cmp-buffer'
  -- use 'hrsh7th/cmp-nvim-lsp'
  -- use 'hrsh7th/cmp-path'
  -- use 'hrsh7th/cmp-look'
  -- use 'octaltree/cmp-look'

  -- use 'kamykn/spelunker.vim'
  use 'nvim-treesitter/playground'
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = '0.5-compat',
    config = function()
      require'nvim-treesitter.configs'.setup {
        textobjects = {
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim 
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["ad"] = "@conditional.outer",
              ["id"] = "@conditional.inner",

              -- Or you can define your own textobjects like this
              ["iF"] = {
                python = "(function_definition) @function",
                cpp = "(function_definition) @function",
                c = "(function_definition) @function",
                java = "(method_declaration) @function",
              },
            },
          },
        },
      }

    end,
  }

  use {
    'ms-jpq/coq_nvim',
    config = function()
      vim.g.coq_settings = {["keymap.jump_to_mark"] = "<c-l>"}
    end,
    opt = true,
  }
  -- use 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

  use {
    'mcchrish/nnn.vim',
    config = function() vim.g["nnn#command"] = 'fish -c n' end,
    opt = true,
  }

  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end,
    config = function()

      -- " ==> config for 节点精灵
      -- function! s:IsFirenvimActive(event) abort
      --   if !exists('*nvim_get_chan_info')
      --     return 0
      --   endif
      --   let l:ui = nvim_get_chan_info(a:event.chan)
      --   return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
      --       \ l:ui.client.name =~? 'Firenvim'
      -- endfunction

      -- let g:firenvim_config = {
      --     \ 'globalSettings': {
      --         \ 'alt': 'all',
      --     \  },
      --     \ 'localSettings': {
      --         \ '.*': {
      --             \ 'cmdline': 'neovim',
      --             \ 'content': 'text',
      --             \ 'priority': 0,
      --             \ 'selector': 'textarea',
      --             \ 'takeover': 'never',
      --         \ },
      --         \ '.*192\.168.*': {
      --             \ 'cmdline': 'neovim',
      --             \ 'content': 'text',
      --             \ 'priority': 1,
      --             \ 'selector': '#container textarea',
      --             \ 'takeover': 'always',
      --         \ }
      --     \ }
      -- \ }
      -- if exists('g:started_by_firenvim')
      -- nn <silent> <F5> :Autoformat<cr>:wa<cr>:call firenvim#eval_js('document.querySelector("#save").click();document.querySelector("#run_or_run").click();')<cr>
      -- im <silent> <F5> <esc><F5>
      -- nn <silent> H :w<cr>:call firenvim#eval_js('document.querySelector("#nav > .nav-present").previousElementSibling.click()')<cr>
      -- nn <silent> L :w<cr>:call firenvim#eval_js('document.querySelector("#nav > .nav-present").nextElementSibling.click()')<cr>

      -- "au TextChanged * ++nested write
      -- "au TextChangedI * ++nested write
      -- nn <c-c> "+Y
      -- vn <c-c> "+y
      -- nn <space>v "+p
      -- nn <leader>v "+p
      -- function! OnUIEnter() abort
      -- set guifont=monospace:h20
      -- endfunction
      -- autocmd UIEnter * call OnUIEnter()
      -- endif
    end,
    opt = true,
  }

  use {
    'mg979/vim-visual-multi',
    config = function()
      vim.g.VM_Mono_hl = 'Visual'
      vim.g.VM_Extend_hl = 'Visual'
      vim.g.VM_Cursor_hl = 'Visual'
      vim.g.VM_Insert_hl = 'Visual'
      vim.g.VM_maps = {
        ["Add Cursor Down"] = '<c-j>',
        ["Add Cursor Up"] = '<c-k>',
        ["Undo"] = 'u',
        ["Redo"] = '<C-r>',
      }
      vim.g.VM_mouse_mappings = 1
    end,
  }

  use 'honza/vim-snippets'
  use {
    'SirVer/ultisnips',
    config = function()
      vim.g.UltiSnipsExpandTrigger = "<c-l>"
      vim.g.UltiSnipsJumpForwardTrigger = "<c-l>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<c-h>"
    end,
  }

  use {
    'Chiel92/vim-autoformat',
    config = function()
      vim.g.formatters_html = {'prettier'}
      vim.g.formatters_javascript = {'prettier'}
      vim.g.formatdef_lua = '"lua-format -c $HOME/.config/lua-format/config "'
      vim.g.formatters_lua = {'lua'}
      vim.g.formatters_python = {'black'}
      vim.g.formatdef_cpp = '"clang-format"'
      vim.g.formatters_cpp = {'cpp'}
      vim.g.formatters_cuda = {'cpp'}
      vim.g.formatdef_fish = '"fish_indent"'
      vim.g.formatters_fish = {'fish'}
      vim.g.formatters_cuda = {'cpp'}

      vim.g.autoformat_autoindent = 0
      vim.g.autoformat_retab = 0
      vim.g.autoformat_remove_trailing_spaces = 0
    end,
  }

  -- if executable('fcitx5')
  -- use 'lilydjwg/fcitx.vim', { 'on': []}
  -- else
  use {'lilydjwg/fcitx.vim', branch = 'fcitx4'}
  -- endif

  use 'michaeljsmith/vim-indent-object'

  use 'jeetsukumaran/vim-indentwise'

  use 'tpope/vim-surround'

  use {
    'christoomey/vim-tmux-navigator',
    config = function()
      vim.g.tmux_navigator_no_mappings = 1
      vim.api.nvim_set_keymap('n', '<a-h>', ':TmuxNavigateLeft<cr>',
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<a-j>', ':TmuxNavigateDown<cr>',
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<a-k>', ':TmuxNavigateUp<cr>',
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<a-l>', ':TmuxNavigateRight<cr>',
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<a-\\>', ':TmuxNavigatePrevious<cr>',
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<a-\\>', ':TmuxNavigatePrevious<cr>',
                              {noremap = true, silent = true})
    end,
  }

  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app & yarn install',
    config = function()
      vim.g.mkdp_open_to_the_world = 1
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_preview_options = {disable_sync_scroll = 0}
    end,
  }

  use 'google/vim-searchindex'

  use 'terryma/vim-expand-region'

  use {
    'junegunn/vim-easy-align',
    config = function()
      vim.api.nvim_set_keymap('v', 'ga', '<Plug>(EasyAlign)',
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)',
                              {noremap = true, silent = true})
    end,
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = "maintained",
        highlight = {enable = true},
        indent = {enable = true},
      }
    end,
  }

  use {
    'romgrk/nvim-treesitter-context',
    config = function()

      require'treesitter-context.config'.setup {enable = true}
    end,
  }

  use {
    'neovim/nvim-lspconfig',
    config = function()

      local nvim_lsp = require('lspconfig')

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)

        -- Enable completion triggered by <c-x><c-o>
        vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
        map = function(mode, lhs, rhs, opt)
          opt = opt or {noremap = true, silent = true}
          vim.api.nvim_set_keymap(mode, lhs, rhs, opt)
        end

        -- Mappings.
        local opts = map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
        map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
        map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
        map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
        map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
        map('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
        map('n', '<space>E',
            '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
        map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
        map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {'documentation', 'detail', 'additionalTextEdits'},
      }

      nvim_lsp.ccls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {debounce_text_changes = 150},
      }

      -- nvim_lsp.clangd.setup {
      --   capabilities = capabilities,
      --   on_attach = on_attach,
      --   flags = {debounce_text_changes = 150},
      -- }

      nvim_lsp.jedi_language_server.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {debounce_text_changes = 150},
      }

      nvim_lsp.bashls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {debounce_text_changes = 150},
      }

      local sumneko_root_path = "/usr/share/lua-language-server"
      local sumneko_binary = "lua-language-server"
      require'lspconfig'.sumneko_lua.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {debounce_text_changes = 150},
        cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
        settings = {
          Lua = {
            completion = {keywordSnippet = "Disable"},

            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              -- version = 'LuaJIT',
              -- Setup your lua path
              -- path = runtime_path,
              unicodeName = true,
            },

            diagnostics = {
              neededFileStatus = {

                ["lowercase-global"] = "None",
                ["undefined-global"] = "None",
              },
              -- Get the language server to recognize the `vim` global
              globals = {'vim'},
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false},
          },
        },
      }

    end,
  }

  use {
    'hrsh7th/nvim-compe',
    config = function()
      vim.o.completeopt = "menuone,noselect"
      require'compe'.setup {
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = 'enable',
        throttle_time = 80,
        source_timeout = 200,
        resolve_timeout = 800,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        documentation = true,
        {
          border = {'', '', '', ' ', '', '', '', ' '}, -- the border option is the same as `|help nvim_open_win|`
          winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
          max_width = 120,
          min_width = 60,
          max_height = math.floor(vim.o.lines * 0.3),
          min_height = 1,
        },

        default_pattern = [[\k\+]],

        source = {
          look = true,
          path = true,
          buffer = true,
          calc = true,
          nvim_lsp = true,
          tabnine = true,
          tmux = {all_panes = true},
          ultisnips = true,
          nvim_lua = false,
          vsnip = false,
          luasnip = false,
        },
      }

      local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
      end

      local check_back_space = function()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end

      _G.tab_complete = function()
        if vim.fn.pumvisible() == 1 then
          return t "<C-n>"
        elseif check_back_space() then
          return t "<Tab>"
        else
          return vim.fn['compe#complete']()
        end
      end
      _G.s_tab_complete = function()
        if vim.fn.pumvisible() == 1 then
          return t "<C-p>"
        else
          return t "<S-Tab>"
        end
      end

      vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()",
                              {noremap = true, expr = true})
      vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()",
                              {noremap = true, expr = true})
      vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()",
                              {noremap = true, expr = true})
      vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()",
                              {noremap = true, expr = true})

    end,
  }

  use {
    'kyazdani42/nvim-tree.lua',
    -- requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      -- require('nvim-tree.view').View.winopts.signcolumn = 'no'
      local tree_cb = require'nvim-tree.config'.nvim_tree_callback
      vim.g.nvim_tree_bindings = {
        -- ["I"]              = tree_cb("toggle_ignored"),
        -- ["H"] =               ":tabp<cr>",
        -- ["D"]              = tree_cb("toggle_dotfiles"),
      }

      vim.g.nvim_tree_side = 'left' -- left by default
      vim.g.nvim_tree_width = 30 -- 30 by default
      vim.g.nvim_tree_ignore = {'.git', 'node_modules', '.cache'} -- empty by default
      vim.g.nvim_tree_gitignore = 0 -- 0 by default
      vim.g.nvim_tree_auto_open = 1 -- 0 by default, opens the tree when typing `vim $DIR` or `vim`
      vim.g.nvim_tree_auto_close = 1 -- 0 by default, closes the tree when it's the last window
      vim.g.nvim_tree_auto_ignore_ft = {'startify', 'dashboard'} -- empty by default, don't auto open tree on specific filetypes.
      vim.g.nvim_tree_quit_on_open = 0 -- 0 by default, closes the tree when you open a file
      vim.g.nvim_tree_follow = 1 -- 0 by default, this option allows the cursor to be updated when entering a buffer
      vim.g.nvim_tree_indent_markers = 1 -- 0 by default, this option shows indent markers when folders are open
      vim.g.nvim_tree_hide_dotfiles = 0 -- 0 by default, this option hides files and folders starting with a dot `.`
      vim.g.nvim_tree_git_hl = 0 -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
      vim.g.nvim_tree_highlight_opened_files = 1 -- 0 by default, will enable folder and file icon highlight for opened files/directories.
      vim.g.nvim_tree_root_folder_modifier = ':~' -- This is the default. See :help filename-modifiers for more options
      vim.g.nvim_tree_tab_open = 0 -- 0 by default, will open the tree when entering a new tab and the tree was previously open
      vim.g.nvim_tree_width_allow_resize = 1 -- 0 by default, will not resize the tree when opening a file
      vim.g.nvim_tree_disable_netrw = 0 -- 1 by default, disables netrw
      vim.g.nvim_tree_hijack_netrw = 0 -- 1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
      vim.g.nvim_tree_add_trailing = 1 -- 0 by default, append a trailing slash to folder names
      vim.g.nvim_tree_group_empty = 1 -- 0 by default, compact folders that only contain a single folder into one node in the file tree
      vim.g.nvim_tree_lsp_diagnostics = 0 -- 0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
      vim.g.nvim_tree_disable_window_picker = 1 -- 0 by default, will disable the window picker.
      vim.g.nvim_tree_hijack_cursor = 0 -- 1 by default, when moving cursor in the tree, will position the cursor at the start of the file on the current line
      vim.g.nvim_tree_icon_padding = '' -- one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
      vim.g.nvim_tree_update_cwd = 1 -- 0 by default, will update the tree cwd when changing nvim's directory (DirChanged event). Behaves strangely with autochdir set.
      vim.g.nvim_tree_window_picker_exclude = {
        filetype = {'packer', 'qf'},
        buftype = {'terminal'},
      }
      -- Dictionary of buffer option names mapped to a list of option values that
      -- indicates to the window picker that the buffer's window should not be
      -- selectable.
      vim.g.nvim_tree_special_files = {'README.md', 'Makefile', 'MAKEFILE'} -- List of filenames that gets highlighted with NvimTreeSpecialFile
      vim.g.nvim_tree_show_icons = {
        git = 0,
        folders = 0,
        files = 0,
        folder_arrows = 0,
      }
      -- If 0, do not show the icons for one of 'git' 'folder' and 'files'
      -- 1 by default, notice that if 'files' is 1, it will only display
      -- if nvim-web-devicons is installed and on your runtimepath.
      -- if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
      -- but this will not work when you set indent_markers (because of ui conflict)

      -- default will show icon by default if no icon is provided
      -- default shows no icon by default

      vim.api.nvim_set_keymap('n', '<space>e', ':NvimTreeToggle<cr>',
                              {noremap = true, silent = true})
    end,
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end,
  }

  use 'suy/vim-context-commentstring'

  use {
    'tpope/vim-commentary',
    config = function()
      vim.api.nvim_set_keymap("v", "<leader>c", "<Plug>Commentary", {})
      vim.api.nvim_set_keymap("n", "<leader>c", "<Plug>Commentary", {})
      vim.api.nvim_set_keymap("o", "<leader>c", "<Plug>Commentary", {})
      vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>CommentaryLine", {})
    end,
    -- opt=true,
  }

  use {
    'scrooloose/nerdcommenter',
    config = function()
      vim.g.NERDCustomDelimiters = {
        text = {left = '#'},
        systemd = {left = '#'},
        rc = {left = '#'},
        fish = {left = '#'},
      }
      vim.g.NERDDefaultAlign = 'left'
    end,
    opt = true,
  }

  use {
    'b3nj5m1n/kommentary',
    config = function()
      vim.g.silent_unsupported = true
      vim.api.nvim_set_keymap("n", "<leader>c",
                              "<Plug>kommentary_motion_default", {})
      vim.api.nvim_set_keymap("n", "<leader>cc",
                              "<Plug>kommentary_line_default", {})
      vim.api.nvim_set_keymap("v", "<leader>c",
                              "<Plug>kommentary_visual_default<c-c>", {})

      require('kommentary.config').configure_language("default", {
        prefer_single_line_comments = true,
      })
    end,
    opt = true,
  }

  use {
    'marko-cerovac/material.nvim',
    config = function()
      vim.g.background = light
      vim.g.material_style = 'lighter'
      require('material').setup({
        italics = {
          comments = false, -- Enable italic comments
          keywords = false, -- Enable italic keywords
          functions = false, -- Enable italic functions
          strings = false, -- Enable italic strings
          variables = false, -- Enable italic variables
        },
        text_contrast = {lighter = false},
        custom_colors = {bg = "#FFFFFF", disabled = "#61747D"},
      })
      vim.cmd([[colorscheme material]])

      -- vim.defer_fn(function()
      -- vim.cmd([[
      --  highlight! link NvimTreeEmptyFolderName NvimTreeFolderName
      -- highlight TreesitterContext guibg=#eeeeee]])
      -- end, 50)
    end,
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()

      require('telescope').setup {
        defaults = {
          mappings = {
            i = {["<esc>"] = require('telescope.actions').close},
            n = {["<esc>"] = require('telescope.actions').close},
          },
        },
      }

      vim.api.nvim_set_keymap('n', '<space>f',
                              [[<Cmd>lua require('telescope.builtin').find_files()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>F',
                              [[<Cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>g',
                              [[<Cmd>lua require('telescope.builtin').live_grep()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>w',
                              [[<Cmd>lua require('telescope.builtin').grep_string()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>m',
                              [[<Cmd>lua require('telescope.builtin').oldfiles({cwd_only=true})<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>M',
                              [[<Cmd>lua require('telescope.builtin').oldfiles()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>a',
                              [[<Cmd>lua require('telescope.builtin').help_tags()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>q',
                              [[<Cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>s',
                              [[<Cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', 'gd',
                              [[<Cmd>lua require('telescope.builtin').lsp_definitions()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', 'gr',
                              [[<Cmd>lua require('telescope.builtin').lsp_references()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>r',
                              [[<Cmd>lua require('telescope.builtin').registers()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>n',
                              [[<Cmd>lua require('telescope.builtin').file_browser()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>p',
                              [[<Cmd>lua require('telescope.builtin').spell_suggest()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>k',
                              [[<Cmd>lua require('telescope.builtin').keymaps()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>x',
                              [[<Cmd>lua require('telescope.builtin').quickfix()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>b',
                              [[<Cmd>lua require('telescope.builtin').buffers()<cr>]],
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<space>a',
                              [[<Cmd>lua require('telescope.builtin').lsp_code_actions()<cr>]],
                              {noremap = true, silent = true})
    end,
  }

  use {
    'svermeulen/vim-yoink',
    config = function()
      vim.api.nvim_set_keymap('n', 'p',
                              "yoink#canSwap() ? '<plug>(YoinkPostPasteSwapBack)' : '<plug>(YoinkPaste_p)'",
                              {expr = true, silent = true})
      vim.api.nvim_set_keymap('n', 'P',
                              "yoink#canSwap() ? '<plug>(YoinkPostPasteSwapForward)' : '<plug>(YoinkPaste_P)'",
                              {expr = true, silent = true})
      vim.g.yoinkIncludeDeleteOperations = 1
      vim.g.yoinkSavePersistently = 1
    end,
  }

end)
